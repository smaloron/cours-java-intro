# Les fonctions

En Java, une méthode (ou fonction) est un bloc d'instructions qui exécute une tâche spécifique.

### Déclaration d'une méthode

```java
modificateur_de_visibilité type_de_retour nomMéthode(paramètres) {
    
    // Corps de la méthode
    
    // si le type de retour n'est pas void
    return valeur; 
}
```

**Exemple**

```java
public int addition(int a, int b) { 
    return a + b; 
}
```

- `public` → Modificateur de visibilité (accessible partout)
- `int` → Type de retour (la méthode retourne un entier)
- `addition` → Nom de la méthode
- `(int a, int b)` → Paramètres (deux nombres entiers)
- `return a + b;` → Retourne la somme des deux nombres

### La visibilité

En Java, la visibilité des propriétés (attributs) et des méthodes d'une classe est contrôlée par des modificateurs d'accès. Voici les principaux :

- `public` → Accessible partout (dans toutes les classes et tous les packages).
- `private` → Accessible uniquement dans la même classe.
- `protected` → Accessible dans la même classe, les sous-classes (même hors du package) et les classes du même package.
- sans modificateur → Accessible dans le même package uniquement.

| Modificateur | Même classe | Même package | Sous-classes (hors package) | Partout |
|--------------|-------------|--------------|-----------------------------|---------|
| `public`     | ✅           | ✅            | ✅                           | ✅       |
| `protected`  | ✅           | ✅            | ✅                           | ❌       |
| `default`    | ✅           | ✅            | ❌                           | ❌       |
| `private`    | ✅           | ❌            | ❌                           | ❌       |

### Static

Une méthode `static` appartient à la classe et non à une instance.

```java
public class MathUtils {
    public static int product(int a, int b) {
        return a * b;
    }
}
```

```java
public class Main {
    public static void main(String[] args) {
        // Appel sans créer d'instance
        MathUtils.product(2,3);
    }
}
```

Si la méthode statique se trouve dans la même classe, il suffit de donner le nom de la méthode.

```java
public class TestStatic {
    public static void main(String[] args) {
        // Appel sans créer d'instance
        sayHello();
    }
    
    public static void sayHello(){
        System.out.println("Hello");
    }
}
```


