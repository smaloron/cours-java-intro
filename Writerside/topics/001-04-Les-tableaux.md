# Les tableaux


Les tableaux en Java (arrays) sont des structures de données permettant de stocker plusieurs valeurs de même type sous une seule variable. Ils sont très utilisés pour gérer des collections d’éléments et offrent un accès rapide aux données via un index.

## Déclaration et Initialisation d’un Tableau en Java

### Déclaration d’un tableau

Un tableau se déclare en spécifiant le type des éléments et en ajoutant des crochets `[]`.

```java
int[] tableau;  // Déclaration d’un tableau d'entiers
String[] noms;  // Déclaration d’un tableau de chaînes de caractères
```

### Allocation mémoire (Instanciation)

Après la déclaration, on doit allouer de l’espace mémoire à ce tableau en spécifiant sa taille :

```java
// Création d'un tableau de 5 entiers
tableau = new int[5];  
```

⚠️ **Une fois la taille définie, elle ne peut pas être modifiée.**

### Déclaration et Initialisation en une seule ligne

```java
// Tableau de 3 cases initialisées à 0 
// (valeur par défaut des int)
int[] nombres = new int[3];  

// Initialisation directe
// notez l'utilisation des accolades 
// là ou Javascript utilise des crochets 
String[] fruits = {"Pomme", "Banane", "Orange"}; 

```

## Accès aux Éléments d’un Tableau

Les valeurs d'un tableau sont accessibles par le biais de leur indice numérique. La première position est à l'indice 0.

```Java
int[] nombres = {10, 20, 30, 40, 50};

// Affiche 10
System.out.println(nombres[0]); 

// Affiche 40
System.out.println(nombres[3]); 

```

### Obtenir la taille d'un tableau

```Java
int[] nombres = {10, 20, 30, 40, 50};

// Affiche 5
System.out.println(nombres.length); 
```

### Parcourir un tableau

**Avec une boucle incrémentée**
```java
int[] nombres = {10, 20, 30, 40, 50};

for (int i = 0; i < nombres.length; i++) {
    System.out.println(nombres[i]);
}
```

**Avec une boucle foreach**

La syntaxe est plus simple, mais il est **impossible de modifier** les valeurs du tableau.
```java
for (int nombre : nombres) {
    System.out.println(nombre);
}
```

## Tableau à deux dimensions

```java
int[][] matrice = {
    {1, 2, 3},
    {4, 5, 6},
    {7, 8, 9}
};

// Affiche 6 (ligne 1, colonne 2)
System.out.println(matrice[1][2]); 

// Parcour du tableau
for (int i = 0; i < matrice.length; i++) {
    for (int j = 0; j < matrice[i].length; j++) {
        System.out.print(matrice[i][j] + " ");
    }
    System.out.println();
}
```

## Quelques méthodes de l'objet Arrays

| Méthode                                              | Description                                                    |
|------------------------------------------------------|----------------------------------------------------------------|
| `Arrays.asList(T... a)`                              | Convertit un tableau en `List<T>` (taille fixe).               |
| `Arrays.toString(T[] a)`                             | Retourne une représentation sous forme de `String` du tableau. |
| `Arrays.deepToString(Object[] a)`                    | Comme `toString()`, mais pour les tableaux multidimensionnels. |
| `Arrays.copyOf(T[] original, int newLength)`         | Copie un tableau en changeant sa taille.                       |
| `Arrays.copyOfRange(T[] original, int from, int to)` | Copie une plage spécifique d'un tableau.                       |
| `Arrays.fill(T[] a, T value)`                        | Remplit tout un tableau avec une valeur donnée.                |
| `Arrays.sort(T[] a)`                                 | Trie le tableau en ordre croissant (utilise `Comparable`).     |
| `Arrays.sort(T[] a, Comparator<? super T> c)`        | Trie un tableau avec un comparateur personnalisé.              |
| `Arrays.binarySearch(T[] a, T key)`                  | Recherche un élément (le tableau doit être trié).              |
| `Arrays.equals(T[] a, T[] b)`                        | Compare deux tableaux (élément par élément).                   |
| `Arrays.deepEquals(Object[] a, Object[] b)`          | Compare deux tableaux multidimensionnels.                      |


### Conversion en String

Indispensable pour afficher facilement le contenu d'un tableau.

```java
import java.util.Arrays;

public class ArrayToString {
    public static void main(String[] args) {
        int[] numbers = {10, 20, 30, 40};
        
        // Affiche [10, 20, 30, 40]
        System.out.println(Arrays.toString(numbers)); 
    }
}
```

### Copie d'un tableau

Effectue une copie d'un tableau à une dimension et peut augmenter sa taille.

```java
int[] original = {1, 2, 3};

// Augmente la taille à 5
int[] copy = Arrays.copyOf(original, 5); 

 // Affiche [1, 2, 3, 0, 0]
System.out.println(Arrays.toString(copy));
```

### Remplissage d'un tableau

```java
import java.util.Arrays;

public class ArrayFill {
    public static void main(String[] args) {
        // Tableau de taille 5
        int[] numbers = new int[5];
        
        // Remplit tout le tableau avec 7
        Arrays.fill(numbers, 7); 
        
        // Résultat : [7, 7, 7, 7, 7]
        System.out.println(Arrays.toString(numbers));  
    }
}

```

**Remplissage partiel**

```java
import java.util.Arrays;

public class PartialArrayFill {
    public static void main(String[] args) {
        int[] numbers = {1, 2, 3, 4, 5};
        
        // Remplit de l'index 1 à 3 avec 9
        // Attention : L'index de fin (toIndex) est exclu.
        Arrays.fill(numbers, 1, 4, 9); 
        
        // Résultat : [1, 9, 9, 9, 5]
        System.out.println(Arrays.toString(numbers));
        
    }
}

```

### Tri simple (ordre croissant)

```java
String[] fruits = {"Pomme", "Ananas", "Brugnon"};
Arrays.sort(fruits);

// [Ananas, Brugnon, Pomme]
System.out.println(Arrays.toString(fruits)); 

```

### Tri par ordre décroissant

> Attention, ne fonctionne pas avec les types primitifs, il faut un tableau de wrapper class.

```java
import java.util.Arrays;
import java.util.Comparator;

public class DescendingOrderSort {
    public static void main(String[] args) {
        Integer[] numbers = {5, 2, 9, 1, 7};
        
        Arrays.sort(numbers, Comparator.reverseOrder());

        // Résultat : [9, 7, 5, 2, 1]
        System.out.println(Arrays.toString(numbers));  
    }
}

```

### Trier un tableau de String selon leur longueur

```java
import java.util.Arrays;
import java.util.Comparator;

public class Main {
    public static void main(String[] args) {
        String[] words = {"banana", "apple", "kiwi", "cherry"};
        
        Arrays.sort(words, Comparator.comparingInt(String::length));
        
        // Résultat : [kiwi, apple, banana, cherry] 
        // (ordre croissant de longueur)
        System.out.println(Arrays.toString(words)); 
        
    }
}
```

> Le symbole :: en Java est appelé "référence de méthode" (method reference). Ce n'est pas la même chose que . utilisé pour appeler une méthode sur un objet.
>
> 
>Dans le cas de String::length, il s'agit d'une référence de méthode statique qui permet de passer la méthode length() comme un paramètre à une autre méthode, sans l’appeler immédiatement.

Pour trier par ordre décroissant, il faut ajouter `.reversed()`.

```java
Arrays.sort(
    words, 
    Comparator.comparingInt(String::length)
              .reversed()
);
```

### Trier des objets selon un attribut

```java
class Person {
    String name;
    int age;

    Person(String name, int age) {
        this.name = name;
        this.age = age;
    }

    @Override
    public String toString() {
        return name + " (" + age + ")";
    }
}
```

```java
import java.util.Arrays;
import java.util.Comparator;

public class Main {
    public static void main(String[] args) {
        Person[] people = {
            new Person("Alice", 25),
            new Person("Bob", 20),
            new Person("Charlie", 30)
        };

        Arrays.sort(
            people, 
            Comparator.comparing(person -> person.name)
        );

        // Résultat : [Alice (25), Bob (20), Charlie (30)]
        System.out.println(Arrays.toString(people));
        
    }
}
```

> L'expression person -> person.name est une expression lambda en Java. Elle signifie que pour chaque objet person, on retourne sa propriété name. Si la propriété avait été privée, il aurait fallu appeler un getter (`getName()`).
> On aurait pu également utiliser `Person::getName()` pour référencer la méthode chargée de retourner la valeur comparée.

## Exercices

### **Exercice 1 : Somme des éléments d’un tableau**

**Énoncé**
Écrire un programme qui calcule la somme des éléments d’un tableau d’entiers.

### **Solution** {collapsible="true"}
```java
public class SumArray {
    public static void main(String[] args) {
        int[] numbers = {5, 10, 15, 20};
        int sum = 0;

        for (int num : numbers) {
            sum += num;
        }

        System.out.println("Somme : " + sum);
    }
}
```

---

### Exercice 2 : Recherche d’un élément

**Énoncé**
Écrire un programme qui vérifie si un élément donné est présent dans un tableau.

### **Solution** {collapsible="true" id="solution_1"}
```java
public class SearchElement {
    public static void main(String[] args) {
        int[] numbers = {1, 3, 7, 9, 11};
        int target = 7;
        boolean found = false;

        for (int num : numbers) {
            if (num == target) {
                found = true;
                break;
            }
        }

        if (found) {
            System.out.println(
                "L'élément " + target + " est présent."
            );
        } else {
            System.out.println(
                "L'élément " + target + " n'est pas présent."
            );
        }
    }
}
```

---

### Exercice 3 : Inversion d’un tableau

**Énoncé**
Écrire un programme qui inverse l’ordre des éléments d’un tableau.

> Pour afficher le tableau utilisez `Arrays.toString(variable)`
> il faut au début du fichier importer cette classe comme ceci
> `import java.util.Arrays`

### **Solution** {collapsible="true" id="solution_2"}
```java
import java.util.Arrays;

public class ReverseArray {
    public static void main(String[] args) {
        int[] numbers = {2, 4, 6, 8, 10};
        int n = numbers.length;
        int[] reversed = new int[n];

        for (int i = 0; i < n; i++) {
            reversed[i] = numbers[n - 1 - i];
        }

        System.out.println(
            "Tableau inversé : " + Arrays.toString(reversed)
        );
    }
}
```

---

### Exercice 4 : Trouver le plus grand et le plus petit élément

**Énoncé**
Trouver le plus grand et le plus petit élément


### **Solution** {collapsible="true" id="solution_3"}
```java
public class MinMaxArray {
    public static void main(String[] args) {
        int[] numbers = {12, 5, 23, 9, 30};
        int min = numbers[0], max = numbers[0];

        for (int num : numbers) {
            if (num < min) min = num;
            if (num > max) max = num;
        }

        System.out.println("Le plus petit élément est : " + min);
        System.out.println("Le plus grand élément est : " + max);
    }
}
```

---

### Exercice 5 : Suppression d’un élément

**Énoncé**
Écrire un programme qui supprime un élément d’un tableau.


### **Solution** {collapsible="true" id="solution_4"}
```java
import java.util.Arrays;

public class RemoveElement {
    public static void main(String[] args) {
        int[] numbers = {4, 7, 1, 9, 12};
        int target = 7;
        int n = numbers.length;
        int[] newArray = new int[n - 1];
        int index = 0;

        for (int num : numbers) {
            if (num != target) {
                newArray[index++] = num;
            }
        }

        System.out.println("Tableau après suppression : " + Arrays.toString(newArray));
    }
}
```

---
