# Les structures de contrôle

## Conditions

La syntaxe des conditions est similaire à celle du langage C ou de Javascript.

```java

if(<expression booléenne>){
    <instructions>
}

```

**Exemple**

```java
public static void main(String[] args) 
{
   int age = 17;

   if(age < 18){
       System.out.println("Vous êtes mineur");
   } else{
       System.out.println("Vous êtes majeur");
   }
}
```

### Les opérateurs de comparaison

| Opérateur | Signification       | Exemple (a = 10, b = 5) | Résultat |
|-----------|---------------------|-------------------------|----------|
| `==`      | Égal à              | `a == b`                | false    |
| `!=`      | Différent de        | `a != b`                | true     |
| `>`       | Supérieur à         | `a > b`                 | true     |
| `<`       | Inférieur à         | `a < b`                 | false    |
| `>=`      | Supérieur ou égal à | `a >= b`                | true     |
| `<=`      | Inférieur ou égal à | `a <= b`                | false    |

### La comparaison des objets

Avec les types référence (dont font partie les objets) la comparaison s'effectue sur les adresses mémoires.

```java
public class StringCompare {
    public static void main(String[] args) {
        String s1 = new String("Hello");
        String s2 = new String("Hello");

        // Affiche false
        System.out.println(s1 == s2);
    }
}
```

En revanche la comparaison suivante est true.
```java
public class StringCompare {
    public static void main(String[] args) {
        String s1 = "Hello";
        String s2 = "Hello";

        // Affiche true
        System.out.println(s1 == s2);
    }
}
```

> Java optimise la gestion des objets String en utilisant un pool de chaînes (String Pool), qui est une zone mémoire spéciale où les chaînes littérales sont stockées.

- `String s1 = "Hello";`

    Java ajoute "Hello" dans le String Pool.
    s1 référence "Hello" dans le pool.

- `String s2 = "Hello";`

    "Hello" existe déjà dans le pool.
    Java réutilise la même référence mémoire pour s2.

- `System.out.println(s1 == s2);`

    s1 et s2 pointent vers le même objet en mémoire.
    Résultat : true.

### Méthode de comparaison

Pour comparer les valeurs de deux objets, il faut utiliser les méthodes `equals` ou `compareTo`.

```java
public class StringCompare {
    public static void main(String[] args) {
        String s1 = new String("Hello");
        String s2 = new String("Hello");

        // Affiche true
        System.out.println(s1.equals(s2));
    }
}
```

La méthode `compareTo` retourne -1, 0 ou 1 selon que l'objet comparé et plus grand, égal ou plus petit.

```java
public class StringCompare {
    public static void main(String[] args) {
        String s1 = new String("Hello");
        String s2 = new String("Hello");

        // Affiche 0
        System.out.println(s1.compareTo(s2));
    }
}
```

### Structure ternaire
Java supporte l'opérateur ternaire pour simplifier les conditions.

```
condition ? valeur_si_vrai : valeur_si_faux;
```

```Java
int number = 10;

String result = (number % 2 == 0) ? "Pair" : "Impair";

System.out.println("Le nombre est " + result);
```

## Switch
Il s'agit d'une structure de contrôle permettant d'exécuter différentes instructions en fonction de la valeur d'une expression. Depuis Java 12 le switch a été amélioré pour être plus concis.

### Switch traditionnel

```Java
public class SwitchExample {
    public static void main(String[] args) {
        int day = 3;
        String dayName;

        switch (day) {
            case 1:
                dayName = "Lundi";
                break;
            case 2:
                dayName = "Mardi";
                break;
            case 3:
                dayName = "Mercredi";
                break;
            case 4:
                dayName = "Jeudi";
                break;
            case 5:
                dayName = "Vendredi";
                break;
            case 6:
                dayName = "Samedi";
                break;
            case 7:
                dayName = "Dimanche";
                break;
            default:
                dayName = "Jour inconnu";
        }

        System.out.println("Le jour est : " + dayName);
    }
}
```

### Switch amélioré (Java 12+)

```Java
public class SwitchExpressionExample {
    public static void main(String[] args) {
        int day = 3;

        String dayName = switch (day) {
            case 1 -> "Lundi";
            case 2 -> "Mardi";
            case 3 -> "Mercredi";
            case 4 -> "Jeudi";
            case 5 -> "Vendredi";
            case 6 -> "Samedi";
            case 7 -> "Dimanche";
            default -> "Jour inconnu";
        };

        System.out.println("Le jour est : " + dayName);
    }
}
```

- Plus concis grâce à l'opérateur ->.
- Pas besoin de break, chaque case retourne directement une valeur.

### Regroupement de case

Depuis Java 12, plusieurs cas peuvent être regroupés.

```Java
public class SwitchGroupingExample {
    public static void main(String[] args) {
        String fruit = "Pomme";

        String type = switch (fruit) {
            case "Pomme", "Poire", "Raisin" -> "Fruit à pépins";
            case "Banane", "Mangue", "Ananas" -> "Fruit tropical";
            default -> "Autre type de fruit";
        };

        System.out.println(fruit + " est un " + type);
    }
}
```

### Utilisation avec yield (Java 14+)

Si un case contient plusieurs instructions, on doit utiliser yield pour retourner une valeur.

```Java
public class SwitchYieldExample {
    public static void main(String[] args) {
        int grade = 2;

        String performance = switch (grade) {
            case 1 -> "Excellent";
            case 2 -> {
                System.out.println("Traitement du niveau 2...");
                yield "Très bien";
            }
            case 3 -> "Bien";
            default -> "Insuffisant";
        };

        System.out.println("Performance : " + performance);
    }
}
```

## Boucles

### La boucle for

La boucle for est utilisée lorsqu'on sait à l'avance combien de fois une action doit être répétée. Elle suit la syntaxe suivante :

```java
for (initialisation; condition; incrémentation) {
    // Bloc d'instructions
}
```

**Exemple**

```java
public class Test {
    public static void main(String[] args) {
        for (int i = 1; i <= 5; i++) {
            System.out.println("Itération n°" + i);
        }
    }
}
```

### La boucle while

La boucle while est utilisée lorsqu'on ne sait pas exactement combien de fois la boucle doit s'exécuter. La condition est testée avant d'exécuter le bloc de code.

```Java
public class Test {
    public static void main(String[] args) {
        int i = 1;

        while (i <= 5) {
            System.out.println("Itération n°" + i);
            i++;
        }
    }
}
```

Un autre exemple sans incrémentation

```Java

import java.util.Random;

public class WhileExample {
    public static void main(String[] args) {
        Random random = new Random();
        boolean condition = true;

        System.out.println("Lancement du programme...");

        while (condition) {
            // Génère un nombre entre 0 et 9
            int number = random.nextInt(10); 
            
            System.out.println("Nombre généré : " + number);

            // Condition pour arrêter la boucle
            if (number == 7) { 
                condition = false;
            }
        }

        System.out.println(
          "Le programme s'est arrêté car 7 a été généré."
        );
    }
}

```

### La boucle do-while

La boucle do-while est similaire à while, mais elle exécute au moins une fois le bloc de code avant de vérifier la condition.

```java
public class Test {
    public static void main(String[] args) {
        int i = 1;

        do {
            System.out.println("Itération n°" + i);
            i++;
        } while (i <= 5);
    }
}
```

### Instructions de contrôle des boucles

#### Break

Permet de sortir complètement d’une boucle lorsqu’une certaine condition est remplie.

```Java
public class Test {
    public static void main(String[] args) {
        for (int i = 1; i <= 5; i++) {
            if (i == 3) {
                break; // Sort de la boucle
            }
            System.out.println("Itération n°" + i);
        }
    }
}
```

#### Continue

Permet d’ignorer une itération et de passer directement à la suivante.

```java
public class Test {
    public static void main(String[] args) {
        for (int i = 1; i <= 5; i++) {
            if (i == 3) {
                continue; // Ignore cette itération
            }
            System.out.println("Itération n°" + i);
        }
    }
}
```