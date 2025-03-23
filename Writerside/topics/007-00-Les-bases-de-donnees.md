# Les bases de données

## JDBC

JDBC (Java Database Connectivity) est une API Java qui permet aux applications Java d'interagir avec des bases de données relationnelles. Il sert d'interface entre une application Java et un système de gestion de base de données (SGBD) en fournissant des classes et des méthodes pour établir des connexions, exécuter des requêtes SQL et traiter les résultats.

Pour utiliser JDBC, il faut télécharger le connecteur correspondant au SGBD que l'on souhaite exploiter. Ce connecteur est une bibliothèque compilée sous la forme d'un fichier `.jar`.

### Le connecteur MariaDB

[](https://mariadb.com/downloads/connectors/)

![CleanShot 2025-03-06 at 14.50.30@2x.png](CleanShot 2025-03-06 at 14.50.30@2x.png)

Télécharger le fichier `.jar` et le placer dans un dossier `lib` dans votre projet.

> Attention : A la compilation, il faudra ajouter le dossier `lib` au classpath (voir le chapitre sur le build).

### Avec Maven

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.example</groupId>
    <artifactId>mariadb-fatjar</artifactId>
    <version>1.0.0</version>
    <packaging>jar</packaging>

    <properties>
        <java.version>23</java.version>
        <main.class>DataBaseTest</main.class>
    </properties>

    <dependencies>
        <!-- MariaDB JDBC Driver -->
        <dependency>
            <groupId>org.mariadb.jdbc</groupId>
            <artifactId>mariadb-java-client</artifactId>
            <version>3.1.4</version>
        </dependency>
    </dependencies>

    <build>
        <finalName>database-app</finalName>
        <plugins>
            <!-- Shade Plugin pour créer un Fat JAR avec un manifeste -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-shade-plugin</artifactId>
                <version>3.4.1</version>
                <executions>
                    <execution>
                        <phase>package</phase>
                        <goals>
                            <goal>shade</goal>
                        </goals>
                        <configuration>
                            <transformers>
                                <transformer implementation="org.apache.maven.plugins.shade.resource.ManifestResourceTransformer">
                                    <mainClass>${main.class}</mainClass>
                                </transformer>
                            </transformers>
                        </configuration>
                    </execution>
                </executions>
            </plugin>

            <!-- Compiler Plugin pour Java 17 -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <configuration>
                    <source>${java.version}</source>
                    <target>${java.version}</target>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>
```

### Le fichier docker compose 

```yaml
services:
  mariadb:
    image: mariadb:latest
    container_name: mariadb_container
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: 123
      MYSQL_DATABASE: formation
    ports:
      - "3306:3306"
    volumes:
      - mariadb_data:/var/lib/mysql
    networks:
      - mariadb_network

volumes:
  mariadb_data:

networks:
  mariadb_network:

```

```
CREATE TABLE users(
    id INT UNSIGNED AUTO_INCREMENT,
    username VARCHAR(20) NOT NULL,
    PRIMARY KEY(id)
);

INSERT INTO users (username) VALUES 
('Jane user'), ('Amina admin') ('joe user'), ('Jack admin');
```

### Définir une connexion

```
// Imports au début du fichier
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

// Création de la connexion

try {

    Connection connection = DriverManager.getConnection(
        <URL>, <USER>, <PASSWORD>
    );
    
} catch (SQLException e) {

    System.err.println(
        "Erreur de connexion : " + e.getMessage()
    );
    
}

```

### Une classe de connexion

Cette classe expose une connection à la base de données par le biais d'une méthode statique. La connexion est stockée dans une variable également statique ce qui permet toujours retourner la même instance (pattern Singleton).

```java
package fr.formation.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // Informations de connexion
    private static final String URL = "jdbc:mariadb://localhost:3306/formation";
    private static final String USER = "root";
    private static final String PASSWORD = "123";
    
    // Connexion unique (singleton)
    private static Connection connection = null;

    // Méthode pour obtenir la connexion
    public static Connection getConnection() {
        try {
            if (connection == null || connection.isClosed()) {
                connection = DriverManager.getConnection(
                    URL, USER, PASSWORD
                );
                System.out.println("Connexion réussie à MariaDB !");
            }
        } catch (SQLException e) {
            System.err.println(
                "Erreur de connexion : " + e.getMessage()
            );
        }
        return connection;
    }

    // Méthode pour fermer la connexion
    public static void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                System.out.println("Connexion fermée.");
            }
        } catch (SQLException e) {
            System.err.println(
                "Erreur lors de la fermeture : " + e.getMessage()
            );
        }
    }
}
```

### Utilisation de la connexion

Une fois la connexion établie, il faut créer un `statement`

```java
Connection conn = DBConnection.getConnection();
Statement stmt = conn.createStatement();
```

Il faut ensuite exécuter une requête SQL sur ce `Statement` avec l'une des méthodes suivantes.

- `executeQuery(String sql)` : 

| Méthode                     | Description                                                                                                                                                                                  |
|-----------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `executeQuery(String sql)`  | Exécute une requête SQL de type `SELECT` et retourne un `ResultSet` contenant les résultats.                                                                                                 |
| `executeUpdate(String sql)` | Exécute une requête SQL de type `INSERT`, `UPDATE`, `DELETE` ou `DDL` (`CREATE`, `DROP`, etc.) et retourne un int indiquant le nombre de lignes affectées.                                   |
| `execute(String sql)`       | Exécute une requête SQL qui peut être de n'importe quel type (`SELECT`, `INSERT`, `UPDATE`, `DELETE, etc.). Retourne un boolean : true si le premier résultat est un ResultSet, false sinon. |

### Exploitation du ResultSet

Un objet `ResultSet` représente le résultat d'une requête SQL. Il inclut un curseur qui permet de naviguer au sein des lignes retournées par la requête. 

À la création du `ResultSet` ce curseur est positionné juste avant la première ligne.

| Méthode                      | Description                                                           |
|------------------------------|-----------------------------------------------------------------------|
| `boolean next()`             | Avance d'une ligne, retourne `true` si une ligne existe.              |
| `boolean previous()`         | Recule d'une ligne, retourne `true` si une ligne existe.              |
| `boolean first()`            | Se place sur la première ligne du `ResultSet`.                        |
| `boolean last()`             | Se place sur la dernière ligne du `ResultSet`.                        |
| `boolean absolute(int row)`  | Va directement à la ligne `row` (indice 1 pour la première ligne) .   |
| `boolean relative(int rows)` | Déplace le curseur de `rows` lignes (+ pour avancer, - pour reculer). |
| `boolean isBeforeFirst()`    | Vérifie si le curseur est avant la première ligne.                    |
| `boolean isAfterLast()`      | Vérifie si le curseur est après la dernière ligne.                    |
| `boolean isFirst()`          | Vérifie si le curseur est sur la première ligne.                      |
| `boolean isLast()`           | Vérifie si le curseur est sur la dernière ligne.                      |
| `int getRow()`               | Retourne le numéro de la ligne actuelle.                              |

### Récupération des données

Les méthodes suivantes permettent de récupérer les données d'une colonne au sein de la ligne en cours.

| Méthode                                           | Type de retour | Description                                            |
|---------------------------------------------------|----------------|--------------------------------------------------------|
| `int getInt(String columnLabel)`                  | `int`          | Récupère une valeur entière.                           |
| `int getInt(int columnIndex)`                     | `int`          | Récupère une valeur entière via l'index de la colonne. |
| `String getString(String columnLabel)`            | `String`       | Récupère une chaîne de caractères.                     |
| `String getString(int columnIndex)`               | `String`       | Récupère une chaîne de caractères via l'index.         |
| `double getDouble(String columnLabel)`            | `double`       | Récupère une valeur décimale.                          |
| `double getDouble(int columnIndex)`               | `double`       | Récupère une valeur décimale via l'index.              |
| `boolean getBoolean(String columnLabel)`          | `boolean`      | Récupère un booléen.                                   |
| `boolean getBoolean(int columnIndex)`             | `boolean`      | Récupère un booléen via l'index.                       |
| `Date getDate(String columnLabel)`                | `Date`         | Récupère une date SQL.                                 |
| `Date getDate(int columnIndex)`                   | `Date`         | Récupère une date SQL via l'index.                     |
| `Timestamp getTimestamp(String columnLabel)`      | `Timestamp`    | Récupère un timestamp SQL.                             |
| `Timestamp getTimestamp(int columnIndex)`         | `Timestamp`    | Récupère un timestamp SQL via l'index.                 |
| `Object getObject(String columnLabel)`            | `Object`       | Récupère un objet générique.                           |
| `Object getObject(int columnIndex)`               | `Object`       | Récupère un objet via l'index.                         |
| `InputStream getBinaryStream(String columnLabel)` | `InputStream`  | Récupère un flux binaire (ex: fichier).                |
| `InputStream getBinaryStream(int columnIndex)`    | `InputStream`  | Récupère un flux binaire via l'index.                  |
| `Blob getBlob(String columnLabel)`                | `Blob`         | Récupère un objet BLOB (Binary Large Object).          |
| `Blob getBlob(int columnIndex)`                   | `Blob`         | Récupère un objet BLOB via l'index.                    |
| `Clob getClob(String columnLabel)`                | `Clob`         | Récupère un objet CLOB (Character Large Object).       |
| `Clob getClob(int columnIndex)`                   | `Clob`         | Récupère un objet CLOB via l'index.                    |
| `BigDecimal getBigDecimal(String columnLabel)`    | `BigDecimal`   | Récupère un nombre décimal de grande précision.        |
| `BigDecimal getBigDecimal(int columnIndex)`       | `BigDecimal`   | Récupère un nombre décimal via l'index.                |

**Remarques :**

- columnLabel correspond au nom de la colonne dans la base de données.
- columnIndex commence à 1 et non 0.
- Il existe aussi des variantes comme getFloat(), getShort(), getLong(), etc.

### Exécution d'une requête de sélection

```java
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class UserSelect {

    public static void main(String[] args) {
     
       try {
           // Récupérer la connexion
           Connection conn = DBConnection.getConnection();
           // Exécuter une requête SQL
           String sql = "SELECT * FROM users";
           Statement stmt = conn.createStatement();
           ResultSet rs = stmt.executeQuery(sql);

           // Boucle sur le resultSet
           while (rs.next()) {
               System.out.println(
                   "User: " + rs.getString("username")
               );
           }

           // Fermer les ressources
           rs.close();
           stmt.close();
           DatabaseConnection.closeConnection();
       } catch (SQLException e) {
           e.printStackTrace();
       }
        
    }
}
```

## Les requêtes préparées

L'objet `PreparedStatement` compile une requête avec des espaces réservés (placeholders) pour les variables. Les valeurs seront passées lors de l'exécution de la requête.

**Intérêts :**
- Protection contre les injections SQL
- Possibilité d'exécuter plusieurs fois la même requête compilée avec des paramètres différents.

### Fonctionnement

Dans la requête, les paramètres variables sont remplacés par des `?`.

On instancie ensuite la classe `PreparedStatement` en lui passant la requête SQL en argument.

La valorisation des paramètres s'effectue avec l'appel à une méthode setter qui admet deux arguments :

- la position du placeholder (le premier est 1)
- la valeur du paramètre

**Les méthodes `setter` de `PreparedStatement`**


| Méthode                                                      | Type de données attendu |
|--------------------------------------------------------------|-------------------------|
| `setInt(int parameterIndex, int value)`                      | `int`                   |
| `setLong(int parameterIndex, long value)`                    | `long`                  |
| `setFloat(int parameterIndex, float value)`                  | `float`                 |
| `setDouble(int parameterIndex, double value)`                | `double`                |
| `setBigDecimal(int parameterIndex, BigDecimal value)`        | `BigDecimal`            |
| `setString(int parameterIndex, String value)`                | `String`                |
| `setBoolean(int parameterIndex, boolean value)`              | `boolean`               |
| `setByte(int parameterIndex, byte value)`                    | `byte`                  |
| `setBytes(int parameterIndex, byte[] value)`                 | `byte[]`                |
| `setDate(int parameterIndex, java.sql.Date value)`           | `java.sql.Date`         |
| `setTime(int parameterIndex, java.sql.Time value)`           | `java.sql.Time`         |
| `setTimestamp(int parameterIndex, java.sql.Timestamp value)` | `java.sql.Timestamp`    |
| `setObject(int parameterIndex, Object value)`                | `Object` (générique)    |
| `setNull(int parameterIndex, int sqlType)`                   | Valeur `NULL`           |


### Un exemple avec SELECT

```java
String sql = "SELECT id, name, email FROM users WHERE email = ?";
try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
    pstmt.setString(1, "alice@example.com");

    try (ResultSet rs = pstmt.executeQuery()) {
        while (rs.next()) {
            int id = rs.getInt("id");
            String name = rs.getString("name");
            String email = rs.getString("email");
            System.out.println(id + " - " + name + " - " + email);
        }
    }
}
```

### Un exemple avec INSERT

```java
import java.sql.*;

public class JDBCExample {
    public static void main(String[] args) {
        // Paramètres de connexion
        String url = "jdbc:mysql://localhost:3306/mydatabase";
        String user = "root";
        String password = "password";

        // Requête SQL avec des paramètres
        String sql = "INSERT INTO users (name, email) VALUES (?, ?)";

        try (
            Connection conn = DriverManager.getConnection(url, user, password);
            PreparedStatement pstmt = conn.prepareStatement(sql);
        ) {
            // Remplacement des paramètres
            pstmt.setString(1, "Alice");
            pstmt.setString(2, "alice@example.com");

            // Exécution de la requête
            int rowsInserted = pstmt.executeUpdate();
            System.out.println(rowsInserted + " ligne(s) insérée(s).");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
```

## Gestion des variables d'environnement

Utiliser des variables d'environnement pour stocker les informations sensibles d'une application est une très bonne idée. Sur le serveur de production, l'application utilisera donc ses variables, sur le poste du développeur, celle-ci seront simulés au sein d'un fichier `.env`.

Il faut donc un moyen pour charger ses données, soit depuis un fichier soit depuis les variables d'environnement. La bibliothèque `java-dotenv` a justement été conçue pour ça.

Elle est distribuée sous la forme d'un fichier jar qu'il faut [télécharger](https://jar-download.com/artifact-search/java-dotenv)

Il faudra ensuite ajouter ce fichier aux dépendances du projet.

### Installation avec Maven

```xml
<dependency>
    <groupId>io.github.cdimascio</groupId>
    <artifactId>dotenv-java</artifactId>
    <version>3.2.0</version>
</dependency>
```

### Utilisation

Par défaut `java-dotenv` recherche un fichier `.env` à la racine du projet.

S'il existe une variable d'environnement du même nom, elle aura priorité sur la variable définie dans `.env`.

```
# fichier .env

# Utilisateur pour la connexion à la base de données
DB_USER=root
DB_PASS=123
DB_URL=jdbc:mariadb://localhost:3306/formation
```

```java
// chargement du fichier
Dotenv dotenv = Dotenv.load();

// Récupération d'une variable
String user = dotenv.get("DB_USER")
```

#### Valeur par défaut

```java
// Récupération d'une variable
// Le deuxième argument est la valeur par défaut
// si la clef est absente dans .env
String user = dotenv.get("DB_USER", "web_user")
```

#### Chemin du fichier .env

```java
Dotenv dotenv = Dotenv.configure()
                      .directory("/env")
                      .filename(".env-dev")
                      .load();
```