# Les streams

Pour chainer des méthodes et transformer une collection, il faut utiliser les streams, exactement comme avec Javascript.

Un Stream est une séquence d'éléments qui peut être manipulée avec des opérations fonctionnelles.

Les Streams sont consommables une seule fois. Une fois un Stream traité, il ne peut pas être réutilisé.

**Les méthodes principales de manipulation de stream**

| Fonction      | Description                                                       |
|---------------|-------------------------------------------------------------------|
| `stream()`    | Convertit une collection en flux (Stream).                        |
| `filter()`    | Filtre les éléments selon un prédicat.                            |
| `map()`       | Transforme chaque élément selon une fonction.                     |
| `flatMap()`   | Aplatie et transforme les éléments en un seul flux.               |
| `distinct()`  | Supprime les doublons.                                            |
| `sorted()`    | Trie les éléments du flux.                                        |
| `peek()`      | Exécute une action intermédiaire sur chaque élément.              |
| `limit()`     | Limite le nombre d'éléments du flux.                              |
| `skip()`      | Ignore les premiers éléments.                                     |
| `forEach()`   | Exécute une action sur chaque élément.                            |
| `collect()`   | Convertit un flux en une collection ou un autre type de résultat. |
| `reduce()`    | Combine les éléments en un seul résultat.                         |
| `count()`     | Retourne le nombre d’éléments du flux.                            |
| `anyMatch()`  | Vérifie si au moins un élément satisfait un prédicat.             |
| `allMatch()`  | Vérifie si tous les éléments satisfont un prédicat.               |
| `noneMatch()` | Vérifie si aucun élément ne satisfait un prédicat.                |
| `findFirst()` | Retourne le premier élément du flux.                              |
| `findAny()`   | Retourne un élément arbitraire du flux.                           |
| `toArray()`   | Convertit le flux en un tableau.                                  |


### Filtrer

```java
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = List.of("Alice", "Bob", "Charlie");

        // Utilisation de forEach avec un Stream
        names.stream()
             .filter(name -> name.startsWith("A"))
             .forEach(name -> System.out.println(
                "Hello, " + name)
              );
    }
}
```

### Transformer les éléments

```java
import java.util.List;
import java.util.stream.Collectors;

public class StreamMapExample {
    public static void main(String[] args) {
        List<String> names = List.of(
          "Alice", "Bob", "Charlie"
        );

        // Transformer chaque nom en majuscules
        List<String> upperNames = names.stream()
            .map(String::toUpperCase)
            .collect(Collectors.toList());

        // [ALICE, BOB, CHARLIE]
        System.out.println(upperNames); 
    }
}
```

### Transformer avec `flatMap`

```java
import java.util.List;
import java.util.stream.Collectors;

public class StreamFlatMapExample {
    public static void main(String[] args) {
        
        // Une liste de liste
        List<List<Integer>> listOfLists = List.of(
            List.of(1, 2), 
            List.of(3, 4), 
            List.of(5, 6)
        );
        
        // Applatissement de la liste
        List<Integer> flattened = listOfLists.stream()
          .flatMap(List::stream)
          .collect(Collectors.toList());

        // [1,2,3,4,5,6]
        System.out.println(flattened); 
    }
}
```

### Filtrer avec `distinct`

```java
import java.util.List;
import java.util.stream.Collectors;

public class StreamDistinctExample {
    public static void main(String[] args) {
        
        List<Integer> numbers = List.of(1, 2, 2, 3, 4, 4, 5);
        List<Integer> uniqueNumbers = numbers.stream()
            .distinct()
            .collect(Collectors.toList());

        // [1,2,3,4,5]
        System.out.println(uniqueNumbers); 
    }
}
```

### Transformer avec map

```Java
import java.util.List;
import java.util.stream.Collectors;

public class MapExample {
    public static void main(String[] args) {
        List<Integer> numbers = List.of(1, 2, 3, 4, 5);

        // Multiplier chaque élément par 2
        List<Integer> doubled = numbers.stream()
            .map(n -> n * 2)
            .collect(Collectors.toList());

        System.out.println(doubled); // [2, 4, 6, 8, 10]
    }
}
```

### Reduce pour totaliser

```Java
import java.util.List;

public class ReduceExample {
    public static void main(String[] args) {
        List<Integer> numbers = List.of(1, 2, 3, 4, 5);

        // Calculer la somme avec reduce
        int sum = numbers.stream()
            .reduce(0, (a, b) -> a + b);

        System.out.println(sum); // 15
    }
}
```

### Combinaison de filer, map et collect

```java
import java.util.List;
import java.util.stream.Collectors;

public class CombinedExample {
    public static void main(String[] args) {
        List<String> names = List.of("Alice", "Bob", "Charlie", "David");

        // Obtenir la longueur des noms de plus de 3 lettres
        List<Integer> lengths = names.stream()
            .filter(name -> name.length() > 3)
            .map(String::length)
            .collect(Collectors.toList());

        System.out.println(lengths); // [5, 7, 5]
    }
}
```

### Tester avec allMatch

```java
import java.util.List;

public class AllMatchExample1 {
    public static void main(String[] args) {
        List<Integer> numbers = List.of(3, 7, 1, 9);

        // Vérifie si tous les éléments sont positifs
        boolean allPositive = numbers.stream()
            .allMatch(n -> n > 0);

        System.out.println(allPositive); // true
    }
}
```

### Chercher avec findAny

**Recherche fructueuse**
```Java
import java.util.List;
import java.util.Optional;

public class FindAnyExample1 {
    public static void main(String[] args) {
        List<String> names = List.of("Alice", "Bob", "Anna", "Charlie");

        // Trouver un nom qui commence par "A"
        Optional<String> result = names.stream()
            .filter(name -> name.startsWith("A"))
            .findAny();

        // Affichage si présent
        result.ifPresent(System.out::println); // Alice ou Anna (au hasard)
    }
}

```

**Recherche infructueuse**

```Java
import java.util.List;
import java.util.Optional;

public class FindAnyExample2 {
    public static void main(String[] args) {
        List<String> names = List.of("Bob", "Charlie");

        // Aucun nom ne commence par "A"
        Optional<String> result = names.stream()
            .filter(name -> name.startsWith("A"))
            .findAny();

        System.out.println(result.isPresent()); // false
    }
}
```
