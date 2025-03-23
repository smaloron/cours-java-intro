# Les exceptions

La gestion des exceptions est un mécanisme qui permet de gérer les erreurs de manière contrôlée afin d'éviter des arrêts brutaux du programme. Java propose une structure basée sur les mots-clés `try`, `catch`, `finally`, et `throw` pour capturer et traiter les exceptions.

### Qu'est-ce qu'une exception en Java ?

Une exception est un événement anormal qui interrompt le flot normal d'exécution d'un programme. Elle peut être causée par :

- Une entrée utilisateur invalide (ex. : division par zéro).
- Une tentative d'accès à un tableau hors limites.
- Un fichier introuvable lors de la lecture.
- Une connexion réseau interrompue, etc.

En Java, toutes les exceptions sont des objets dérivant de la classe Throwable.

```
java.lang.Throwable
 ├── java.lang.Error
 └── java.lang.Exception
     ├── java.lang.RuntimeException
     └── Autres exceptions vérifiées

```

#### Error
Désigne des erreurs graves que l'application ne devrait pas intercepter (ex : `OutOfMemoryError`, `StackOverflowError`).
Ce sont des erreurs de JVM et non des exceptions "normales".

#### Exception
Contient les erreurs qu'un programme peut et doit gérer.

##### Exceptions Vérifiées (Checked Exceptions)

Le compilateur force le programmeur à les traiter (impossible de compiler si on ne traite pas ces exceptions).

**Exemples :**
- `IOException` (erreur d'entrée/sortie),
- `SQLException` (erreur de base de données),
- `FileNotFoundException` (fichier non trouvé).

##### Exceptions Non Vérifiées (Unchecked Exceptions)

- Héritent de RuntimeException.
- Le compilateur ne force pas leur traitement.

- **Exemples :**
- `NullPointerException` (accès à un objet null),
- `ArrayIndexOutOfBoundsException` (accès hors limites d'un tableau),
- `ArithmeticException` (ex. : division par zéro).

## La gestion des exceptions

Si le code est encadré dans un bloc `try`, il est possible de capturer les exceptions générées par ce dernier dans un bloc `catch`.

```Java
try {
    // Code susceptible de générer une exception
} catch (TypeException e) {
    // Traitement de l'exception
} finally {
    // Bloc exécuté systématiquement (optionnel)
}
```

### Exemple simple : division par zéro

- Le bloc `try` tente d'exécuter le code.
- Si une exception ArithmeticException est levée, le bloc `catch` l'intercepte et affiche un message.
- Le bloc `finally` s'exécute toujours, qu'il y ait une exception ou non.

```java
public class ExceptionExample {
    public static void main(String[] args) {
        try {
            int a = 10, b = 0;
            int result = a / b; // Provoque ArithmeticException
            System.out.println("Résultat : " + result);
        } catch (ArithmeticException e) {
            System.out.println("Erreur : Division par zéro !");
        } finally {
            System.out.println("Fin du programme.");
        }
    }
}
```

## Lancer et propager une exception

### Lancer une exception

- l'instruction `throw` permet de générer une exception manuellement.
- Ici, si l'âge est < 18, une IllegalArgumentException est levée.

```java
public class ThrowExample {
    static void checkAge(int age) {
        if (age < 18) {
            throw new IllegalArgumentException("Âge insuffisant !");
        }
        System.out.println("Accès autorisé.");
    }

    public static void main(String[] args) {
        checkAge(15); // Provoque IllegalArgumentException
    }
}
```

### Propager une exception

- `throws` signale que readFile() peut lever une exception IOException.
- Le bloc `try` dans `main()` gère cette exception.

```java
public class ThrowsExample {
    static void readFile() throws IOException {
        throw new IOException("Fichier introuvable !");
    }

    public static void main(String[] args) {
        try {
            readFile();
        } catch (IOException e) {
            System.out.println("Erreur : " + e.getMessage());
        }
    }
}
```
