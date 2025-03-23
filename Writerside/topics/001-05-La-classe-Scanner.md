# La classe Scanner

La classe Scanner fait partie du package java.util, elle est utilisée pour lire l'entrée à partir de différentes sources, telles que la console, les fichiers et les chaînes de caractères. Elle est très utile pour l'interaction avec l'utilisateur et le traitement des entrées textuelles.

## Utilisation

Avant d'utiliser Scanner, il faut l'importer dans le programme

```Java
import java.util.Scanner;
```

Puis il faut créer une instance de Scanner en indiquant la source de lecture, ici une entrée du clavier.

```java
Scanner scanner = new Scanner(System.in);
```

### Lecture

#### Lire une ligne

> `nextLine()`, lit toute la ligne jusqu'au retour à la ligne (\n).

```java
System.out.println("Entrez une phrase :");
String ligne = scanner.nextLine();
System.out.println("Vous avez saisi : " + ligne);
```

### Les méthodes de lecture

| Méthode                        | Description                                            |
|--------------------------------|--------------------------------------------------------|
| `next()`                       | Lit un mot (jusqu'à un espace) sous forme de `String`. |
| `nextLine()`                   | Lit une ligne entière sous forme de `String`.          |
| `nextInt()`                    | Lit un entier (`int`).                                 |
| `nextDouble()`                 | Lit un nombre décimal (`double`).                      |
| `nextFloat()`                  | Lit un nombre décimal (`float`).                       |
| `nextLong()`                   | Lit un entier long (`long`).                           |
| `nextShort()`                  | Lit un entier court (`short`).                         |
| `nextByte()`                   | Lit un octet (`byte`).                                 |
| `nextBoolean()`                | Lit un booléen (`true` ou `false`).                    |
| `hasNext()`                    | Vérifie s'il reste un élément à lire (`boolean`).      |
| `hasNextInt()`                 | Vérifie si le prochain élément est un `int`.           |
| `hasNextDouble()`              | Vérifie si le prochain élément est un `double`.        |
| `hasNextFloat()`               | Vérifie si le prochain élément est un `float`.         |
| `hasNextLong()`                | Vérifie si le prochain élément est un `long`.          |
| `hasNextShort()`               | Vérifie si le prochain élément est un `short`.         |
| `hasNextByte()`                | Vérifie si le prochain élément est un `byte`.          |
| `hasNextBoolean()`             | Vérifie si le prochain élément est un `boolean`.       |
| `useDelimiter(String pattern)` | Définit un séparateur personnalisé pour la lecture.    |
| `reset()`                      | Réinitialise le `Scanner`.                             |
| `close()`                      | Ferme le `Scanner` pour libérer les ressources.        |

### useDelimiter

```java
import java.util.Scanner;

public class ScannerDelimiterExample {
    public static void main(String[] args) {
        // Création d'une chaîne 
        // avec des nombres séparés par des virgules
        String data = "10,20,30,40,50";

        // Création du Scanner avec la chaîne en entrée
        Scanner scanner = new Scanner(data);

        // Définition du délimiteur comme étant la virgule
        scanner.useDelimiter(",");

        // Lecture des valeurs
        while (scanner.hasNextInt()) {
            int number = scanner.nextInt();
            System.out.println("Nombre lu : " + number);
        }

        // Fermeture du Scanner
        scanner.close();
    }
}
```

### Routage avec la classe Scanner

```java
package fr.formation.app;

import java.util.Scanner;

public class ScannerRouter {
    private static Scanner scanner;
    
    // Démarre le routeur avec boucle infinie
    public static void start() {
        String input;

        while (true) {
            // Affiche le menu après chaque action
            showMenu(); 
            System.out.print("Votre choix : ");
            input = scanner.nextLine().trim().toLowerCase();

            switch (input) {
                case "1", "home" -> home();
                case "2", "about" -> about();
                case "3", "contact" -> contact();
                case "4", "exit" -> {
                    System.out.println("\nFermeture de l'application...");
                    scanner.close();
                    // Sortie propre de la boucle et fin du programme
                    return; 
                }

                default -> System.out.println("Route inconnue. Essayez encore.");
            }
        }
    }

    // Affiche le menu des options
    private static void showMenu() {
        System.out.println("\n--- Menu ---");
        System.out.println("1. home - Page d'accueil");
        System.out.println("2. about - À propos");
        System.out.println("3. contact - Contact");
        System.out.println("4. exit - Quitter");
    }

    // Route : Accueil
    private static void home() {
        System.out.println("\n--- Page d'Accueil ---");
        System.out.println("Bienvenue sur la page principale.");
    }

    // Route : À propos
    private static void about() {
        System.out.println("\n--- À Propos ---");
        System.out.println("Ceci est une application de démonstration du routing en Java.");
    }

    // Route : Contact
    private static void contact() {
        System.out.println("\n--- Contact ---");
        System.out.println("Envoyez-nous un email à contact@example.com");
    }

    public static void main(String[] args) {
        scanner = new Scanner(System.in);
        start();
    }
}
```

## Exercices

### Somme des entiers

Écrivez un programme qui demande la saisie d'un entier et continue de la faire tant que l'utilisateur continue de saisir des entiers. Dès qu'une valeur non entière a été saisie le programme affiche le total des entiers et s'arrête.

#### Correction {collapsible="true"}

```Java
import java.util.Scanner;

public class SumAllIntegers {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int sum = 0;

        System.out.println("Entrez des nombres entiers (tapez autre chose pour arrêter) :");

        // Boucle infinie, on s'arrête si l'entrée n'est pas un entier
        while (scanner.hasNextInt()) {
            int number = scanner.nextInt();
            sum += number;
        }

        // Affiche la somme des nombres saisis
        System.out.println("La somme des nombres saisis est : " + sum);

        scanner.close();
    }
}
```

### Fiche signalétique

Écrire un programme qui demande à l'utilisateur :
- son prénom
- son age
- sa profession

Afficher l'ensemble des saisies dans le terminal comme suit :

`"Bonjour <prenom> vous êtes <profession> et vous avez <age> ans"`

### Deviner un nombre

`random.nextInt(100) + 1` pour obtenir un nombre aléatoire en 1 et 100
Il faut importer `java.util.Random`.

#### Correction {collapsible="true" id="correction_1"}
```java
import java.util.Scanner;
import java.util.Random;

public class GuessNumberGame {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        Random random = new Random();

        // Génère un nombre aléatoire entre 1 et 100
        int targetNumber = random.nextInt(100) + 1;
        int guess;
        int attempts = 0;

        System.out.println("Devinez le nombre entre 1 et 100 :");

        do {
            System.out.print("Entrez votre proposition : ");
            
            // Vérifie si l'entrée est un entier
            while (!scanner.hasNextInt()) {
                System.out.println("Veuillez entrer un nombre valide !");
                scanner.next(); // Supprime l'entrée invalide
            }
            
            guess = scanner.nextInt();
            attempts++;

            if (guess < targetNumber) {
                System.out.println("C'est plus !");
            } else if (guess > targetNumber) {
                System.out.println("C'est moins !");
            } else {
                System.out.println("Bravo ! Vous avez trouvé en " + attempts + " essais.");
            }

        } while (guess != targetNumber);

        scanner.close();
    }
}
```



