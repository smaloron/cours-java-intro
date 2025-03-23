# Build et organisation du code

## Les packages

En Java, un package est un moyen d’organiser et de structurer les classes et interfaces en les regroupant sous un même espace de noms. Cela facilite la gestion des fichiers, évite les conflits de noms et améliore la réutilisabilité du code.

### Déclaration d'un package

Un package est défini en utilisant le mot-clé package au début d’un fichier source Java.

```java
// Définit le package
package com.exemple.util; 

public class MyClass {
    public void showMessage() {
        System.out.println("Hello from MyClass!");
    }
}
```

Ici, MyClass appartient au package com.exemple.util.

> Attention Java impose que les fichiers source soient stockés dans une arborescence correspondant à leur package
> ```
> com
>   exemple
>       util
>           Myclass.java
> ```


### Build d'une application utilisant des packages

**Soit l'application suivante**

```java
package fr.formation.util;

public class Calculator {
    public int add(int a, int b) {
        return a + b;
    }
}
```

```java
package fr.formation.app;

import fr.formation.util.Calculator;

public class Main {
    public static void main(String[] args) {
        Calculator calc = new Calculator();
        System.out.println(calc.add(10, 20));
    }
}
```

Pour compiler, il faudra indiquer le chemin de toutes les sources.

```
javac -d bin src/fr/formation/util/*.java src/fr/formation/app/*.java
```

> Attention : avec windows le séparateur de dossier est `\`, pas `/`

![CleanShot 2025-03-05 at 11.01.13@2x.png](CleanShot 2025-03-05 at 11.01.13@2x.png)

#### Compiler tous les packages

**Avec Linux ou Mac OS c'est assez simple**
```
javac -d bin $(find . -name "*.java") 
```

**Avec Windows**

Il faut d'abord créer un fichier texte contenant les noms et chemins de tous les fichiers java.

- `dir` : Liste les fichiers.
- `/b` : Affiche uniquement les noms de fichier sans détails supplémentaires.
- `/s` : Recherche récursivement dans tous les sous-dossiers

```
dir /s /b *.java > sources.txt
```

On passe ensuite ce fichier en argument au programme `javac`.

```
javac -d bin @sources.txt
```

#### Exécution du programme

```
cd bin

java fr.formation.app.Main
```

## Empaqueter une application

Une application peut contenir de nombreuses classes et également des ressources, telles que des images ou des textes. Java propose une solution pour empaqueter et compresser l'ensemble des fichiers d'une application au sein d'un fichier `.jar` pour Java archives.

Un fichier `.jar` peut être exécutable, dans ce cas, il s'agit d'une application.

S'il n'est pas exécutable, il peut être intégré comme bibliothèque au sein d'une application.

Avant de créer un fichier `.jar`, il faut avoir compilé l'application avec `javac`.

```
javac -d bin $(find . -name "*.java")
```

ou pour Windows

```
dir /s /b *.java > sources.txt
javac -d bin @sources.txt
```


### Création d'un jar exécutable

Il faut créer un fichier `manifest` qui indiquera la classe exécutable au sein du projet. Par convention ce fichier est nommé `MANIFEST.MF` et stocké dans un sous répertoire `META-INF` du dossier `src` du projet.

```
Manifest-Version: 1.0
Main-Class: fr.formation.app.Main
```

Ensuite il faut créer le fichier jar comme ceci

```
cd bin
jar cfm build/app.jar src/META-INF/MANIFEST.MF -C bin .
```

- `c` : création d'un jar
- `f` : pour définir le nom du fichier jar
- `m` : pour spécifier le manifeste

### Création d'une bibliothèque

Même opération que pour un jar exécutable, mais sans le manifeste.

```
jar cf build/app.jar -C bin .
```

Ou avec Windows

```
jar cf build/app.jar -C bin .
```

### Lire le contenu d'un jar

```
cd build
jar tf <fichier.jar>
```

### Exécuter un fichier jar

```
cd build
java -jar <fichier.jar>
```

### Script de build pour Linux et Mac OS

```shell
// build.sh pour Linux et Mac OS

# Compilation des sources
javac -d bin $(find . -name "*.java")

# Empaquetage dans un fichier jar
jar cfm build/app.jar src/META-INF/MANIFEST.MF -C bin .
```

Il faut rendre le fichier exécutable

```
chmod +x build.sh
```


### Script de build pour Windows

```
# build.bat

# Compilation des sources
dir /s /b *.java > sources.txt
javac -d bin @sources.txt

# Empaquetage dans un fichier jar
jar cfm build/app.jar src/META-INF/MANIFEST.MF -C bin .
```

### Ajouter des ressources au jar

On ajoute un dossier `assets`et un fichier `data.txt` dans ce dernier à la racine du projet.

On génère ensuite un ja en ajoutant le dossier `assets`.

```
jar cfm build/app.jar src/META-INF/MANIFEST.MF -C bin . -C assets .
```

Test du contenu du fichier jar

```
cd build

jar tf app.jar
```

## Build avec IntelliJ
<procedure>
<step>
Menu `File > Project Structure`
</step>
<step>

- Onglet `Artifacts`.
- Bouton `+` > `JAR` > `From modules with dependencies`.


![CleanShot 2025-03-05 at 18.54.40@2x.png](CleanShot 2025-03-05 at 18.54.40@2x.png)

</step>

<step>

Définir la Main class.

![CleanShot 2025-03-05 at 18.58.35@2x.png](CleanShot 2025-03-05 at 18.58.35@2x.png)

</step>

<step>

Renommer l'artéfact et le fichier jar.

![CleanShot 2025-03-05 at 18.59.48@2x.png](CleanShot 2025-03-05 at 18.59.48@2x.png)

</step>

<step>

Il est possible d'ajouter des dossiers ou des fichiers au build

![CleanShot 2025-03-05 at 16.37.54@2x.png](CleanShot 2025-03-05 at 16.37.54@2x.png)

</step>

<step>

Cocher la case "Include in project build".

![CleanShot 2025-03-05 at 20.02.32@2x.png](CleanShot 2025-03-05 at 20.02.32@2x.png)

</step>

<step>

Lancer le build et la construction du jar 

Menu `Build > build project`

Par défaut le build et l'artéfact se trouvent dans un dossier `out` à la racine du projet.

![CleanShot 2025-03-05 at 20.06.28@2x.png](CleanShot 2025-03-05 at 20.06.28@2x.png)

</step>
</procedure>





