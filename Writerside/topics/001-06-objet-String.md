# Le traitement des chaînes de caractères

L’objet **String** en Java est une classe immuable (immutable) utilisée pour manipuler des chaînes de caractères.

---

## **Méthodes de base**
### `length()`

Renvoie la longueur de la chaîne.

**Exemple :**
  ```java
  String s = "Hello";
  int len = s.length(); // len = 5
  ```

### `charAt(int index)`

Retourne le caractère à la position spécifiée.

**Exemple :**
  ```java
  char c = "Java".charAt(1); // 'a'
  ```

---

## **Manipulation de chaînes**
### `concat(String s)`

Concatène une autre chaîne à la fin.

**Exemple :**
  ```java
  String s = "Hello".concat(" World"); // "Hello World"
  ```

### `toUpperCase()` / `toLowerCase()`

Convertit la chaîne en majuscules ou en minuscules.

**Exemple :**
  ```java
  String s = "Java".toUpperCase(); // "JAVA"
  ```

### `trim()`

Supprime les espaces au début et à la fin.

**Exemple :**
  ```java
  String s = "  Java  ".trim(); // "Java"
  ```

---

## **Comparaison et recherche**

### `equals(String s)` / `equalsIgnoreCase(String s)`

Compare deux chaînes avec ou sans tenir compte de la casse.

**Exemple :**
  ```java
  boolean b = "Java".equals("java"); // false
  boolean b2 = "Java".equalsIgnoreCase("java"); // true
  ```

### `compareTo(String s)`

Compare lexicographiquement (`0` si égales, `< 0` si inférieure, `> 0` sinon).

**Exemple :**
  ```java
  int cmp = "Apple".compareTo("Banana"); // -1
  ```

### `contains(String s)`

Vérifie si une chaîne est contenue dans une autre.

**Exemple :**
  ```java
  boolean b = "Java Programming".contains("Java"); // true
  ```

### `startsWith(String prefix)` / `endsWith(String suffix)`

Vérifie si la chaîne commence ou finit par un certain motif.

**Exemple :**
  ```java
  boolean b = "Hello".startsWith("He"); // true
  boolean b2 = "Hello".endsWith("lo"); // true
  ```

---

## **Extraction et découpage**
### `substring(int beginIndex)` / `substring(int begin, int end)`

Extrait une sous-chaîne.

**Exemple :**
  ```java
  String s = "Java".substring(1, 3); // "av"
  ```

### `split(String regex)`

Découpe une chaîne selon un délimiteur.

**Exemple :**
  ```java
  String[] words = "one,two,three".split(",");
  ```

---

## **Remplacement**
### `replace(char oldChar, char newChar)`

Remplace un caractère par un autre.

**Exemple :**
  ```java
  String s = "Java".replace('a', 'o'); // "Jovo"
  ```

### `replaceAll(String regex, String replacement)`

Remplace un motif avec une expression régulière.

**Exemple :**
  ```java
  String s = "Java 123".replaceAll("\\d", "X"); // "Java XXX"
  ```

---

## **Conversion**
### `valueOf(int i)` (et autres types)

Convertit un entier, un double, etc., en chaîne.

**Exemple :**
  ```java
  String s = String.valueOf(123); // "123"
  ```

### `toCharArray()`

Convertit en tableau de caractères.

**Exemple :**
  ```java
  char[] chars = "Java".toCharArray();
  ```

---

## **Méthodes statiques**
### `String.join(CharSequence delimiter, CharSequence... elements)`

Joint plusieurs éléments avec un séparateur.

**Exemple :**
  ```java
  String s = String.join(", ", "Apple", "Banana", "Cherry");
  // "Apple, Banana, Cherry"
  ```

## Exercices

### Exercice 1 : Compter les voyelles

Écrivez une méthode qui prend en paramètre une chaîne de caractères et retourne le nombre de voyelles (a, e, i, o, u, y) présentes dans la chaîne.

#### Solution {collapsible="true"}

```java
public class StringExercise1 {
    public static int countVowels(String str) {
        str = str.toLowerCase(); // Convertir en minuscules
        int count = 0;
        String vowels = "aeiouy";

        for (int i = 0; i < str.length(); i++) {
            if (vowels.indexOf(str.charAt(i)) != -1) {
                count++;
            }
        }
        return count;
    }

    public static void main(String[] args) {
        System.out.println(countVowels("Hello World")); // 3
    }
}

```

---

### Exercice 2 : Vérifier si une chaîne est un palindrome

**Énoncé :**
Écrivez une méthode qui vérifie si une chaîne de caractères est un palindrome (se lit de la même manière dans les deux sens, comme "radar" ou "kayak").

### solution {collapsible="true" id="solution_1"}

```java
public class StringExercise {
    public static boolean isPalindrome(String str) {
    
        // Ignorer les espaces et la casse
        str = str.toLowerCase().replaceAll("\\s", ""); 
        int n = str.length();

        for (int i = 0; i < n / 2; i++) {
            if (str.charAt(i) != str.charAt(n - 1 - i)) {
                return false;
            }
        }
        return true;
    }

    public static void main(String[] args) {
        System.out.println(isPalindrome("Radar")); // true
        System.out.println(isPalindrome("Hello")); // false
    }
}
```

---

### **Exercice 3 : Inverser une chaîne**
**Énoncé :**
Écrivez une méthode qui prend une chaîne et retourne une nouvelle chaîne avec les caractères inversés.

#### **Solution :** {collapsible="true" id="solution_2"}
```java
public class StringExercise {
    public static String reverseString(String str) {
        StringBuilder sb = new StringBuilder(str);
        return sb.reverse().toString();
    }

    public static void main(String[] args) {
        System.out.println(reverseString("Java")); // "avaJ"
    }
}
```

---

### **Exercice 4 : Compter les occurrences d’un caractère**
**Énoncé :**
Écrivez une méthode qui compte le nombre de fois où un caractère donné apparaît dans une chaîne.

#### **Solution :** {collapsible="true" id="solution_3"}
```java
public class StringExercise {
    public static int countCharOccurrences(String str, char c) {
        int count = 0;
        str = str.toLowerCase(); // Ignorer la casse
        c = Character.toLowerCase(c);

        for (int i = 0; i < str.length(); i++) {
            if (str.charAt(i) == c) {
                count++;
            }
        }
        return count;
    }

    public static void main(String[] args) {
        System.out.println(
            countCharOccurrences("Programming", 'g')
        );
    }
}
```

---

### **Exercice 5 : Remplacer un mot dans une phrase**
**Énoncé :**
Écrivez une méthode qui remplace un mot spécifique dans une phrase par un autre mot.

#### **Solution :** {collapsible="true" id="solution_4"}
```java
public class StringExercise {
    public static String replaceWord(
        String sentence, 
        String oldWord, 
        String newWord
    ) 
    {
        return sentence.replaceAll(oldWord, newWord);
    }

    public static void main(String[] args) {
        System.out.println(
            replaceWord("I love Java", "Java", "Python")
        ); 
    }
}
```

