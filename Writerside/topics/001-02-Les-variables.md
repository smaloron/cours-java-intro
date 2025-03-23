# Les variables

Avec Java, il est impératif de déclarer le type des variables. On parle ici de typage statique fort.

- Le type est déterminé à la compilation.
- Le type ne peut changer pendant l'exécution du programme.

**Initialisation d'une variable**

```
<type> <nom de la variable>
```

**Initialisation et affectation d'une variable**

```
<type> <nom de la variable> = <valeur>
```

## Les types primitifs

**Les 8 types primitifs en Java**

| Type      | Taille  | Valeurs possibles        | Exemple                     |
|-----------|---------|--------------------------|-----------------------------|
| `byte`    | 8 bits  | -128 à 127               | `byte b = 100;`             |
| `short`   | 16 bits | -32 768 à 32 767         | `short s = 20000;`          |
| `int`     | 32 bits | `-2^31` à `2^31 -1`      | `int i = 150000;`           |
| `long`    | 64 bits | `-2^63` à `2^63 -1`      | `long l = 15000000000L;`    |
| `float`   | 32 bits | Nombre flottant (simple) | `float f = 10.5f;`          |
| `double`  | 64 bits | Nombre flottant (double) | `double d = 99.99;`         |
| `char`    | 16 bits | Un caractère Unicode     | `char c = 'A';`             |
| `boolean` | 1 bit   | `true` ou `false`        | `boolean isJavaFun = true;` |

Les types primitifs sont passés par valeur dans les arguments des fonctions ou dans les affectations.

```java
// Déclaration et affectation
int age = 18;

// Copie de la valeur de age dans age2
int age2 = age;

// Modification
age = 22;

// Affiche l'ancienne valeur de age
System.out.println(age2);
```

### Immutabilité
Un type primitif en Java est non modifiable (immutable), une fois une valeur attribuée à une variable primitive, cette valeur ne peut pas être modifiée en mémoire. Toute modification entraîne la création d'une nouvelle valeur stockée dans une nouvelle zone mémoire.

L'ancienne valeur n'étant plus liée à une variable, son espace mémoire sera libéré lors du prochain passage du ramasse-miettes (garbage collector).

## Les types référence

Les types référence stockent l'adresse mémoire d'un objet, plutôt que sa valeur directement.


| Type        | Description                                     |
|-------------|-------------------------------------------------|
| `String`    | Une chaîne de caractères (texte)                |
| `Array`     | Un tableau (collection d'éléments du même type) |
| `Class`     | Une classe                                      |
| `Interface` | Une interface                                   |

```java
String name = "Arya Stark";

// Copie la référence dans une autre variable
String anotherName = name;

name = "Sensa Stark"

// Affiche Sensa Stark
System.out.println(anotherName);

```

### Différences entre types primitifs et types référence

| Caractéristique   | Types primitifs        | Types référence                        |
|-------------------|------------------------|----------------------------------------|
| Stockage          | Directement en mémoire | Stocke une adresse mémoire             |
| Valeur par défaut | `0`, `false`, `\u0000` | `null`                                 |
| Modifiable ?      | Non (valeurs fixes)    | Oui (les objets peuvent être modifiés) |
| Exemple           | `int age = 25;`        | `String name = "Alice";`               |

> L'objet String est également immuable, tout comme un type primitif.

## Les Wrapper Classes

Les Wrapper classes permettent de traiter un type primitif comme un objet.

| Type primitif | Wrapper Class |
|---------------|---------------|
| `byte`        | `Byte`        |
| `short`       | `Short`       |
| `int`         | `Integer`     |
| `long`        | `Long`        |
| `float`       | `Float`       |
| `double`      | `Double`      |
| `char`        | `Character`   |
| `boolean`     | `Boolean`     |

### Pourquoi utiliser les Wrapper Classes ?
Les types primitifs (int, double, boolean, etc.) ne sont pas des objets, donc ils :

- Ne peuvent pas être utilisés directement avec des méthodes qui attendent un objet (ArrayList, HashMap, etc.).
- Ne possèdent pas de méthodes (contrairement aux objets).

Les Wrapper Classes permettent donc de transformer un type primitif en objet pour pouvoir l'utiliser dans des situations où les objets sont requis.

#### Création d'un objet wrapper

```java
public class WrapperExample {
    public static void main(String[] args) {
        // Convertir int → Integer
        Integer intObj = Integer.valueOf(42); 
        
        // Convertir double → Double 
        Double doubleObj = Double.valueOf(3.14);
        
        // Convertir boolean → Boolean 
        Boolean boolObj = Boolean.valueOf(true); 

        System.out.println(intObj);   // 42
        System.out.println(doubleObj); // 3.14
        System.out.println(boolObj);   // true
    }
}
```

#### Conversion d'un wrapper en type primitif (unboxing)

```java
public class UnboxingExample {
    public static void main(String[] args) {
        Integer intObj = Integer.valueOf(100);
        
        // Conversion Integer → int
        int primitiveInt = intObj.intValue(); 

        System.out.println(primitiveInt); // 100
    }
}
```

#### Auto-boxing et Unboxing (conversion automatique)

Depuis la version 5, Java permet l’auto-boxing et l’unboxing :

- Auto-boxing : conversion automatique d’un type primitif en Wrapper.
- Unboxing : conversion automatique d’un Wrapper en type primitif.

```java
public class AutoBoxingUnboxingExample {
    public static void main(String[] args) {
        Integer obj = 10; // Auto-boxing : int → Integer
        int num = obj;    // Unboxing : Integer → int

        System.out.println(obj); // 10
        System.out.println(num); // 10
    }
}
```

## Transtypage

Le transtypage consiste à convertir le type d'une variable. Cette opération peut être automatique (implicite) lorsque la conversion s'effectue vers un type plus large. 

### Conversion implicite

**Exemple de conversion lors d'une affectation**

```Java
public class ImplicitConversionExample {

    public static void main(String[] args) {
        byte b = 10;    // byte (8 bits)
        short s = b;    // byte → short (16 bits)
        int i = s;      // short → int (32 bits)
        long l = i;     // int → long (64 bits)
        float f = l;    // long → float (32 bits)
        double d = f;   // float → double (64 bits)

        System.out.println("byte : " + b);
        System.out.println("short : " + s);
        System.out.println("int : " + i);
        System.out.println("long : " + l);
        System.out.println("float : " + f);
        System.out.println("double : " + d);
    }
}
```

> La conversion implicite de `long` vers `float` peut paraitre étrange puisque le premier est codé sur 64 bits et le second seulement sur 32 bits. Cependant, ces deux types ne représentent pas les nombres de la même façon et le type float est donc capable de couvrir une plage de nombres plus large au prix d'une perte de précision.
> [voir la norme IEEE754 sur les nombres à virgule flottante](https://fr.wikipedia.org/wiki/IEEE_754)

**Exemple de conversion d'un char en int**

```Java
public class CharToInt {
    public static void main(String[] args) {
        char letter = 'A';  // Valeur Unicode de 'A' = 65
        int asciiValue = letter; // char → int

        System.out.println("Caractère : " + letter);
        System.out.println("Valeur ASCII : " + asciiValue);
    }
}
```

#### Récapitulatif des conversions implicites en Java

| **De (type source)** | **Vers (type cible)**                     |
|----------------------|-------------------------------------------|
| `byte`               | `short`, `int`, `long`, `float`, `double` |
| `short`              | `int`, `long`, `float`, `double`          |
| `char`               | `int`, `long`, `float`, `double`          |
| `int`                | `long`, `float`, `double`                 |
| `long`               | `float`, `double`                         |
| `float`              | `double`                                  |


#### Règles importantes :
- **Une conversion implicite se fait seulement si aucune perte de données n'est possible.**
- **Utilisé dans les affectations et opérations mathématiques.**
- **Si une perte de précision est possible (ex. `int` → `byte`), Java ne fait PAS de conversion implicite.**

### La conversion explicite (type casting)

En Java, une conversion explicite (aussi appelée type casting) est nécessaire pour convertir un type plus grand vers un type plus petit ou un type flottant vers un type entier.

Contrairement à la conversion implicite, la conversion explicite peut entraîner une perte de données.

**Syntaxe du casting en Java :**

```java
type_cible variable = (type_cible) valeur_source;
```

```java
public class ExplicitConversion {
    public static void main(String[] args) {
        double pi = 3.14159;
        
        // Casting explicite : perte de la partie décimale
        int intPi = (int) pi; 

         // 3.14159
        System.out.println("Double : " + pi); 
        
        // 3 (partie décimale supprimée)
        System.out.println("Int    : " + intPi); 
    }
}
```

### Conversion en chaine de caractères

Pour convertir un type en string, il faut utiliser la méthode `toString` de la wrapper class correspondant au type.

Dans la fonction `System.out.println` l'appel à `toString` est automatique, ce n'est pas le cas d'autres opérations comme l'écriture dans un fichier ou l'affichage dans un composant graphique qui tous deux exigent un argument de type String.

```java
// conversion depuis un type primitif
int age = 18;

String ageString = Integer.toString(age);
```

```java
// conversion depuis une classe
Integer age = 18;

String ageString = age.toString();
```

### Conversion depuis une chaine

```java
// Conversion en type Integer
String age = "42";

int newAge = Integer.valueOf(age) + 1;

// Affichage du type de la variable
System.out.println(newAge.getClass().getSimpleName())
```

```java
// Conversion en type primitif int
String age = "42";

int newAge = Integer.parseInt(age) + 1;

// Affichage du type de la variable
// (Object) convertit newAge en objet
// afin de pouvoir utiliser la méthode getClass
System.out.println( (Object) newAge.getClass().getSimpleName())
```

Il existe des méthodes `valueOf` et `parse<Type>` pour toutes les wrapper classes (exemple : `parseFloat`, `parseDouble`, `parseBoolean`).

| Type Source | Type Cible | Méthode/Fonction                                                        |
|-------------|------------|-------------------------------------------------------------------------|
| `int`       | `String`   | `String.valueOf(intValue)` ou `Integer.toString(intValue)`              |
| `String`    | `int`      | `Integer.parseInt(stringValue)`                                         |
| `double`    | `String`   | `String.valueOf(doubleValue)` ou `Double.toString(doubleValue)`         |
| `String`    | `double`   | `Double.parseDouble(stringValue)`                                       |
| `float`     | `String`   | `String.valueOf(floatValue)` ou `Float.toString(floatValue)`            |
| `String`    | `float`    | `Float.parseFloat(stringValue)`                                         |
| `long`      | `String`   | `String.valueOf(longValue)` ou `Long.toString(longValue)`               |
| `String`    | `long`     | `Long.parseLong(stringValue)`                                           |
| `boolean`   | `String`   | `String.valueOf(booleanValue)` ou `Boolean.toString(booleanValue)`      |
| `String`    | `boolean`  | `Boolean.parseBoolean(stringValue)`                                     |
| `char`      | `String`   | `String.valueOf(charValue)` ou `Character.toString(charValue)`          |
| `String`    | `char`     | `stringValue.charAt(0)` (si la chaîne a au moins un caractère)          |
| `int`       | `double`   | `(double) intValue`                                                     |
| `double`    | `int`      | `(int) doubleValue`                                                     |
| `int`       | `float`    | `(float) intValue`                                                      |
| `float`     | `int`      | `(int) floatValue`                                                      |
| `int`       | `long`     | `(long) intValue`                                                       |
| `long`      | `int`      | `(int) longValue`                                                       |
| `int`       | `byte`     | `(byte) intValue`                                                       |
| `byte`      | `int`      | `(int) byteValue`                                                       |
| `int`       | `short`    | `(short) intValue`                                                      |
| `short`     | `int`      | `(int) shortValue`                                                      |
| `Object`    | `String`   | `String.valueOf(objectValue)` ou `objectValue.toString()` (si non null) |
| `String`    | `Object`   | `new String(stringValue)` (crée une nouvelle instance)                  |
