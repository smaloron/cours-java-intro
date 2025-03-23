# Les fichiers

Pour lire et écrire dans des fichiers Java propose plusieurs solutions.

## Les méthodes classiques

### Écriture

La classe `FileWriter` permet d'écrire du texte dans un fichier.

```Java
import java.io.FileWriter;
import java.io.IOException;

public class FileWriteExample {
    public static void main(String[] args) {
        String filePath = "output.txt";
        
        try (FileWriter writer = new FileWriter(filePath)) {
            writer.write(
                "Bonjour, ceci est une ligne de texte.\n"
            );
            writer.write(
                "Écriture de plusieurs lignes dans un fichier."
            );
            
            System.out.println("Écriture terminée !");
            
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```

- Par défaut, le contenu précédent du fichier est écrasé.
- Ouvrir la ressource dans le `try` garantit la fermeture automatique du fichier (pas besoin de `finally`).

#### Écriture optimisée avec un tampon

La mise en tampon de l'écriture limite les accès disque et donc améliore la performance.

```java
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

public class BufferedWriteExample {
    public static void main(String[] args) {
        String filePath = "output.txt";
        try (
            BufferedWriter writer = new BufferedWriter(
                new FileWriter(filePath)
            )
        ) 
        {
            writer.write("Première ligne optimisée.\n");
            writer.write(
                "Deuxième ligne écrite avec BufferedWriter."
            );
            
            // Ajoute une nouvelle ligne
            writer.newLine();  
            
            System.out.println(
                "Écriture terminée avec BufferedWriter !"
            );
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```

#### Ajout à un fichier (append)

Il suffit de passer `true` en deuxième argument du constructeur de `FileWriter`.

```java
// true active le mode append
new FileWriter("output.txt", true); 
```

### Lecture de fichiers

#### Lecture caractère par caractère

```java
import java.io.FileReader;
import java.io.IOException;

public class FileReadExample {
    public static void main(String[] args) {
        String filePath = "output.txt";
        try (FileReader reader = new FileReader(filePath)) {
            int character;
            while ((character = reader.read()) != -1) {
                System.out.print((char) character);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```

#### Lecture avec un tampon

La classe `BufferedReader` permet de lire ligne par ligne, ce qui est plus efficace.

```java
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class BufferedReadExample {
    public static void main(String[] args) {
        String filePath = "output.txt";
        try (
            BufferedReader reader = new BufferedReader(
                new FileReader(filePath)
            )
        ) 
        {
            String line;
            while ((line = reader.readLine()) != null) {
                System.out.println(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```

## Les "nouvelles" méthodes

Depuis Java 7, il est possible de lire et d'écrire dans un fichier avec une syntaxe simplifiée en utilisant le package `nio` (new IO).

### Écriture {id="criture_1"}

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.charset.StandardCharsets;
import java.util.List;

public class FilesWriteExample {
    public static void main(String[] args) {
        String filePath = "output.txt";
        List<String> lines = List.of("Ligne 1", "Ligne 2", "Ligne 3");
        try {
            Files.write(
                Paths.get(filePath), 
                lines, 
                StandardCharsets.UTF_8
            );
            System.out.println("Écriture terminée avec Files.write() !");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```

### Lecture

Pour la lecture, `nio` permet le chargement de l'ensemble du fichier dans une liste de chaînes.

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

public class FilesReadExample {
    public static void main(String[] args) {
        String filePath = "output.txt";
        try {
            List<String> lines = Files.readAllLines(
                Paths.get(filePath)
            );
            for (String line : lines) {
                System.out.println(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```

## Les fichiers binaires
Pour lire ou écrire du contenu binaire, il faut utiliser les classe `FileInputStream` et `FileOutputStream`.

### Écriture de contenu binaire

```java
import java.io.FileOutputStream;
import java.io.IOException;

public class BinaryFileWrite {
    public static void main(String[] args) {
        String filePath = "binary.dat";
        byte[] data = {65, 66, 67, 68, 69}; // ASCII : A, B, C, D, E

        try (FileOutputStream fos = new FileOutputStream(filePath)) {
            fos.write(data);
            System.out.println("Fichier binaire écrit avec succès !");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```

Il est également possible d'ajouter un tampon pour améliorer la performance en utilisant la classe `BufferedOutputStream. L'écriture s'effectuera par bloc plutôt qu'octet par octet.

```java
import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class BufferedBinaryWrite {
    public static void main(String[] args) {
        String filePath = "binary.dat";
        byte[] data = {73, 74, 75}; // ASCII : I, J, K

        try (
            BufferedOutputStream bos = new BufferedOutputStream(
                new FileOutputStream(filePath, true)
            )
        ) 
        {
            bos.write(data);
            System.out.println("Écriture optimisée avec BufferedOutputStream !");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```

### Lecture de contenu binaire

```java
import java.io.FileInputStream;
import java.io.IOException;

public class BinaryReadExample {
    public static void main(String[] args) {
        String filePath = "binary.dat";
        try (FileInputStream fis = new FileInputStream(filePath)) {
            int byteData;
            while ((byteData = fis.read()) != -1) {
                System.out.print((char) byteData);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

```

Comme pour l'écriture, il est possible d'utiliser un tampon.

```java
import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;

public class BufferedBinaryRead {
    public static void main(String[] args) {
        String filePath = "binary.dat"; // Fichier binaire à lire

        try (
            BufferedInputStream bis = new BufferedInputStream(
                new FileInputStream(filePath)
            )
        ) 
        {
            int byteData;
            while ((byteData = bis.read()) != -1) {
                // Affiche chaque octet
                System.out.print(byteData + " "); 
            }
            System.out.println("\nLecture terminée !");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```

## Copie d'un fichier binaire ou texte 

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;

public class FilesCopyExample {
    public static void main(String[] args) {
        Path sourcePath = Path.of("source.txt");
        Path destinationPath = Path.of("destination.txt");

        try {
            Files.copy(
                sourcePath, 
                destinationPath, 
                StandardCopyOption.REPLACE_EXISTING
            );
            System.out.println("Fichier copié avec Files.copy() !");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```

<!--
```java
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class BinaryFileCopy {
    public static void main(String[] args) {
        String sourceFile = "image.jpg";
        String destinationFile = "copy_image.jpg";

        try (
               FileInputStream fis = new FileInputStream(sourceFile);
               FileOutputStream fos = new FileOutputStream
                  (destinationFile)
             ) 
         {

            // 1 Ko de buffer
            byte[] buffer = new byte[1024]; 
            int bytesRead;
            while ((bytesRead = fis.read(buffer)) != -1) {
                fos.write(buffer, 0, bytesRead);
            }
            System.out.println("Fichier binaire copié avec succès !");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

```
-->


