# Intégration de jar externes


### Compilation

```
javac -d bin -cp "lib/*:src" src/fr/formation/app/*.java
```

- `javac` : Le compilateur Java.
- `-d bin` : Spécifie le répertoire de destination (bin) où les fichiers .class compilés seront placés.
- `-cp "lib/*:src"` :
Définit le classpath, c'est-à-dire les chemins où Java doit chercher les classes nécessaires à la compilation.
    - `"lib/*"` : Inclut tous les fichiers .jar du dossier lib.
    - `src` : Ajoute également src dans le classpath, ce qui permet de résoudre les dépendances entre les fichiers source.
> Attention : Sous Windows, il faut utiliser ; au lieu de : comme séparateur dans le classpath.

- `src/fr/formation/app/*.java` : Spécifie les fichiers source à compiler.

### Création du manifeste

```
Manifest-Version: 1.0
Main-Class: fr.formation.app.Main
Class-Path: lib/utils.jar
```

> Pourquoi faut-il redéclarer les dépendances dans le manifeste ?
> Lors de la compilation, l'option -cp permet au compilateur javac de savoir où trouver les classes nécessaires pour générer les fichiers .class.
Lors de l'exécution, l'interpréteur Java (java) a besoin de retrouver ces classes, mais il ne sait pas automatiquement où elles se trouvent si elles ne sont pas dans le JAR principal.

> Note : s'il y a plus d'une dépendance, il faut toutes les indiquer dans `Class-Path` en les séparant par un espace.
> `Class-Path: lib/dep1.jar lib/dep2.jar`

### Création du fichier jar

```
jar cfm build/app.jar src/META-INF/MANIFEST.MF -C bin .
```

Copier le dossier `lib` dans le dossier `build` et tester avec

```
cd build
java -jar app.jar
```