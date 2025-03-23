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