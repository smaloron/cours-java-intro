# Les fichiers json

Pour gérer les fichiers json, il existe quantité de Bibliothèque. 
L'une des plus simple des plus populaires et Jackson.

### Installation

Comme il s'agit d'une bibliothèque externe, il faut utiliser un outil tel que Maven pour l'installer.

```xml
<!-- dans pom.xml -->
<dependency>
  <groupId>com.fasterxml.jackson.core</groupId>
  <artifactId>jackson-databind</artifactId>
  <version>2.18.3</version>
</dependency>
```

## Exemple simple d'utilisation

### Écriture d'une classe simple

L'objectif de l'écriture de contenu json et de sérialiser un objet dans ce format particulier. 
Pour cela, il faut instancier un `ObjectMapper` qui sera chargé de cette opération.

**Une classe simple à sérialiser**
```java
// Classe représentant une personne
public class Person {
    public String name;
    public int age;

    // Constructeurs nécessaires pour Jackson
    public Person() {}
    public Person(String name, int age) {
        this.name = name;
        this.age = age;
    }
}
```

**La séralisation**
```java
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.File;

public class WriteJsonExample {
    public static void main(String[] args) {
        try {
            Person person = new Person("Alice", 30);
            
            ObjectMapper mapper = new ObjectMapper();

            // Écriture dans un fichier JSON
            mapper.writeValue(new File("person.json"), person);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
```

### Lecture d'un contenu json simple

La lecture obéit au même principe.

```java
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.File;

public class ReadJsonExample {
    public static void main(String[] args) {
        try {
            ObjectMapper mapper = new ObjectMapper();

            // Lecture à partir d’un fichier JSON
            Person person = mapper.readValue(new File("person.json"),
                                             Person.class
            );
            System.out.println("Nom : " + person.name);
            System.out.println("Âge : " + person.age);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
```

>Jackson gère automatiquement les objets imbriqués et même les collections d'objets imbriqués

## Utilisation sans fichier

### Sérialisation et dé-sérialisation dans une variable

Il est possible de sérialiser dans une variable sans enregistrer dans un fichier.
Cette fonction est utile pour enregistrer le contenu dans une base de données par exemple.

```java
Person person = new Person("Alice", 28);
ObjectMapper mapper = new ObjectMapper();
String json = mapper.writeValueAsString(person);
System.out.println(json);
```
De même, il est possible de dé-sérialiser à partir d'une variable.

```java
String json = "{\"name\":\"Alice\",\"age\":28}";
Person person = mapper.readValue(json, Person.class);
```

Et enfin, il est également possible de se passer totalement de classe et de lire le contenu json directement.

```java
JsonNode node = mapper.readTree(new File("person.json"));
String name = node.get("name").asText();
int age = node.get("age").asInt();
```

## Utilisation avec une collection

Plutôt qu'un objet, il est possible de travailler avec une collection telle qu'un Map ou une list.

### Avec un Map

***La structure json**
```json
{
  "name": "Alice",
  "age": 30,
  "address": {
    "city": "Paris",
    "zipcode": "75001"
  }
}

```

#### Écriture de json à partir d'un Map

```java
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

public class WriteJsonWithMap {
    public static void main(String[] args) throws Exception {
        ObjectMapper mapper = new ObjectMapper();
        mapper.enable(SerializationFeature.INDENT_OUTPUT);

        Map<String, Object> data = new HashMap<>();
        data.put("name", "Alice");
        data.put("age", 30);

        Map<String, String> address = new HashMap<>();
        address.put("city", "Paris");
        address.put("zipcode", "75001");

        data.put("address", address);

        mapper.writeValue(new File("map_output.json"), data);
        System.out.println("JSON écrit avec succès !");
    }
}
```

#### Lecture de json dans un Map

```java
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.File;
import java.util.Map;

public class ReadJsonWithMap {
    public static void main(String[] args) throws Exception {
        ObjectMapper mapper = new ObjectMapper();

        Map<String, Object> data = mapper.readValue(
            new File("map_output.json"),
            new TypeReference<Map<String, Object>>() {}
        );

        System.out.println("Nom : " + data.get("name"));
        System.out.println("Âge : " + data.get("age"));

        // On doit caster pour accéder à la sous-map
        Map<String, String> address = (Map<String, String>) data.get("address");
        System.out.println("Ville : " + address.get("city"));
        System.out.println("Code postal : " + address.get("zipcode"));
    }
}
```

### Avec une List

**La structure json**

```json
[
  {
    "name": "Alice",
    "age": 30
  },
  {
    "name": "Bob",
    "age": 25
  }
]
```

#### Écriture de contenu json à partir d'une List

```java
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;

import java.io.File;
import java.util.*;

public class WriteListOfMaps {
    public static void main(String[] args) throws Exception {
        ObjectMapper mapper = new ObjectMapper();
        mapper.enable(SerializationFeature.INDENT_OUTPUT);

        List<Map<String, Object>> people = new ArrayList<>();

        Map<String, Object> person1 = new HashMap<>();
        person1.put("name", "Alice");
        person1.put("age", 30);

        Map<String, Object> person2 = new HashMap<>();
        person2.put("name", "Bob");
        person2.put("age", 25);

        people.add(person1);
        people.add(person2);

        mapper.writeValue(new File("people_list.json"), people);
        System.out.println("JSON écrit avec succès !");
    }
}
```

#### Lecture de contenu json dans une List

```java
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.File;
import java.util.*;

public class ReadListOfMaps {
    public static void main(String[] args) throws Exception {
        ObjectMapper mapper = new ObjectMapper();

        List<Map<String, Object>> people = mapper.readValue(
            new File("people_list.json"),
            new TypeReference<List<Map<String, Object>>>() {}
        );

        for (Map<String, Object> person : people) {
            System.out.println("Nom : " + person.get("name"));
            System.out.println("Âge : " + person.get("age"));
            System.out.println("-----");
        }
    }
}
```

Sur le même principe, il est également possible d'utiliser une List d'objets (`List<Person>`).

## Configuration

### Indenter le JSON

```java
mapper.enable(SerializationFeature.INDENT_OUTPUT);
```

### Ignorer les champs inconnus à la lecture

```java
mapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
```

### Ne pas inclure les champs null

```java
mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
```

**Autres options**

- `JsonInclude.Include.NON_EMPTY` : exclut les listes ou chaînes vides

- `JsonInclude.Include.NON_DEFAULT` : exclut les valeurs par défaut

### Formatage des dates

```java
mapper.setDateFormat(new SimpleDateFormat("yyyy-MM-dd"));
```

### Pretty printer

La méthode `mapper.writerWithDefaultPrettyPrinter()` dans Jackson permet de produire un JSON joliment indenté (pretty-printed), ce qui le rend beaucoup plus lisible pour les humains.

```java
mapper.writerWithDefaultPrettyPrinter()
      .writeValue(new File("fichier.json"), person);
```

<!--
## Les annotations

Une partie de la configuration peut être déportée dans la classe sous la forme d'annotations

-->

## Exercices


### Exercice 1 : Sérialisation d'un objet simple

Sérialiser cet objet dans un fichier json

```java
public class Book {
    public String title;
    public String author;
    public int year;

    public Book() {}
    public Book(String title, String author, int year) {
        this.title = title;
        this.author = author;
        this.year = year;
    }
}
```

#### Correction exercice 1 {collapsible="true"}

```java
ObjectMapper mapper = new ObjectMapper();
mapper.enable(SerializationFeature.INDENT_OUTPUT);

Book book = new Book("1984", "George Orwell", 1949);
mapper.writeValue(new File("book.json"), book);
```

### Exercice 2 : Dé-sérialiser une liste

Soit le contenu suivant dans un fichier `books.json`, dé-sérialiser et afficher le contenu dans la console.

```json
[
  { "title": "1984", "author": "George Orwell", "year": 1949 },
  { "title": "Dune", "author": "Frank Herbert", "year": 1965 }
]
```

#### Correction exercice 2 {collapsible="true"}

```java
List<Book> books = mapper.readValue(
    new File("books.json"),
    new TypeReference<List<Book>>() {}
);

for (Book b : books) {
    System.out.println(b.title + " - " + b.author);
}
```










