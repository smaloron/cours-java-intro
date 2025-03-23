# La classe StringBuilder

StringBuilder est une classe en Java qui permet de manipuler des chaînes de caractères de manière efficace. Contrairement à String, qui est immuable (immutable), StringBuilder permet de modifier son contenu sans créer un nouvel objet à chaque modification.

## Utilisation de StringBuilder

### Instanciation

```java
// Créer un StringBuilder vide
StringBuilder sb = new StringBuilder();

// Créer un StringBuilder avec une chaîne initiale
StringBuilder sb2 = new StringBuilder("Hello");
```

### Méthodes principales

| Méthode                                   | Description                            |
|-------------------------------------------|----------------------------------------|
| `append(String str)`                      | Ajoute une chaîne à la fin             |
| `insert(int offset, String str)`          | Insère une chaîne à un index donné     |
| `replace(int start, int end, String str)` | Remplace une portion de la chaîne      |
| `delete(int start, int end)`              | Supprime une portion de la chaîne      |
| `deleteCharAt(int index)`                 | Supprime un caractère à un index donné |
| `reverse()`                               | Inverse le contenu du StringBuilder    |
| `length()`                                | Retourne la longueur de la chaîne      |
| `charAt(int index)`                       | Retourne le caractère à un index donné |
| `substring(int start, int end)`           | Extrait une portion de la chaîne       |


### Exemple d'utilisation

```java
public class StringBuilderExample {
    public static void main(String[] args) {
        StringBuilder sb = new StringBuilder("Hello");

        // Ajouter du texte
        sb.append(" World!");
        System.out.println(sb); // Hello World!

        // Insérer du texte
        sb.insert(5, " Beautiful");
        System.out.println(sb); // Hello Beautiful World!

        // Remplacer une partie de la chaîne
        sb.replace(6, 15, "Awesome");
        System.out.println(sb); // Hello Awesome World!

        // Supprimer une portion de la chaîne
        sb.delete(6, 13);
        System.out.println(sb); // Hello World!

        // Inverser la chaîne
        sb.reverse();
        System.out.println(sb); // !dlroW olleH

        // Longueur de la chaîne
        System.out.println("Length: " + sb.length()); // 12
        
        // Conversion du StringBuilder en chaîne
        String greeting = sb.toString();
    }
}

```

### Pourquoi utiliser StringBuilder au lieu de String ?

- String est immuable → Chaque modification crée un nouvel objet en mémoire.
- StringBuilder est mutable → Les modifications sont faites en place, ce qui évite une surcharge mémoire.
- StringBuilder est plus rapide dans les opérations de concaténation et de modification de chaînes.

## Exercices

---

### **Exercice 1 : Conversion de snake case à camel case**
**Énoncé :**
Écrivez une méthode qui convertit un mot de snake_case vers camelCase.

#### **Solution :** {collapsible="true" id="solution_4"}
```java
public class StringUtils {

    /**
     * Convertit une chaîne en snake_case vers camelCase.
     * @param snakeCase La chaîne en snake_case.
     * @return La chaîne convertie en camelCase.
     */
    public static String snakeToCamel(String snakeCase) {
        String[] parts = snakeCase.split("_");
        StringBuilder camelCase = new StringBuilder(parts[0]);

        for (int i = 1; i < parts.length; i++) {
            camelCase.append(parts[i].substring(0, 1).toUpperCase())
                     .append(parts[i].substring(1));
        }

        return camelCase.toString();
    }

    public static void main(String[] args) {
        // Test de la fonction
        String snake = "hello_world_example";
        String camel = snakeToCamel(snake);
        System.out.println("Snake Case : " + snake);
        System.out.println("Camel Case : " + camel);
    }
}
```

### **Exercice 2 : Conversion de camel case vers snake case**
**Énoncé :**
Écrivez une méthode qui convertit un mot de camelCase vers snake_case.

#### **Solution :** {collapsible="true" id="solution_5"}

**Avec une expression régulière**
```java
public class StringUtils {

    /**
     * Convertit une chaîne en camelCase vers snake_case.
     * @param camelCase La chaîne en camelCase.
     * @return La chaîne convertie en snake_case.
     */
    public static String camelToSnake(String camelCase) {
        return camelCase.replaceAll("([a-z])([A-Z])", "$1_$2").toLowerCase();
    }

    public static void main(String[] args) {
        // Test de la fonction
        String camel = "helloWorldExample";
        String snake = camelToSnake(camel);
        System.out.println("Camel Case : " + camel);
        System.out.println("Snake Case : " + snake);
    }
}
```

**Sans expression régulière**

```java
public class StringConverter {

    /**
     * Convertit une chaîne en camelCase vers snake_case.
     * @param camelCase La chaîne en camelCase.
     * @return La chaîne convertie en snake_case.
     */
    public static String camelToSnake(String camelCase) {
        StringBuilder snakeCase = new StringBuilder();

        for (char c : camelCase.toCharArray()) {
            if (Character.isUpperCase(c)) {
                // Ajoute un underscore avant la majuscule 
                // (sauf au début)
                if (snakeCase.length() > 0) {
                    snakeCase.append("_");
                }
                // Convertit en minuscule
                snakeCase.append(Character.toLowerCase(c));
            } else {
                snakeCase.append(c);
            }
        }

        return snakeCase.toString();
    }

    public static void main(String[] args) {
        // Test de la fonction
        String camel = "helloWorldExample";
        String snake = camelToSnake(camel);
        System.out.println("Camel Case : " + camel);
        System.out.println("Snake Case : " + snake);
    }
}
```

