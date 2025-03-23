# Premiers pas

## Hello World

<procedure>
<step>

Ouvrir son IDE et créer un projet vide.
</step>
<step>

Créer un fichier `Hello.java` dans un dossier `src`.
</step>
<step>
Écrire le code suivant :

```java
public class Hello {
    public static void main(String[] args) {
        System.out.println("Hello World");
    }
}
```
</step>

<step>

Dans un terminal, compiler le programme. 

```shell
javac -d bin ./src/Hello.java
```

> `-d` indique au compilateur où placer les fichiers compilés
</step>

<step>

Tester le programme avec la commande `java`.

```shell
cd bin
java Hello
```
</step>
</procedure>

### Anatomie de ce programme

- Le programme contient une classe `Hello`(même nom que le fichier).
- Cette classe contient une méthode publique nommée `main`.
- `static` indique que cette méthode n'a pas besoin d'une instance.
- `void` indique que la méthode `main` ne retourne rien.
- `String[] args` indique que la méthode `main` peut recevoir des arguments sous la forme d'un tableau de chaîne de caractères.

### Modification du programme

```java
public class Hello {
    public static void main(String[] args) {
        System.out.println("Hello " + args[0]);
    }
}
```

1. Refaire une compilation.
2. Tester avec `java Hello Sophie`.

## Conclusions

1. Il faut compiler avant de tester un programme Java.
2. Un programme Java contient au moins une classe.
3. Cette classe doit contenir une méthode `public static void main(String[] args)` chargée de lancer le programme.
4. Les instructions se terminent impérativement par un `;`.