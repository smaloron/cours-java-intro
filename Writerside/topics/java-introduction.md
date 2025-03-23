# Java Introduction

## Historique

Java est un langage de programmation orienté objet, polyvalent et portable, conçu pour être utilisé sur une grande variété de plateformes. Il a été créé par **James Gosling** et son équipe chez **Sun Microsystems** en **1995**. Aujourd’hui, il est maintenu par **Oracle Corporation**.

## Caractéristiques principales

- **Orienté objet**
Tout en Java repose sur la programmation orientée objet (POO), qui permet de structurer le code autour d'objets et de classes.

- **Compilé**
Le code Java doit être compilé avec son exécution, ce qui permet de capturer un certain nombre d'erreurs avant la mise en production.

- **Portable (WORA - Write Once, Run Anywhere)**
Grâce à la JVM (Java Virtual Machine), un programme écrit en Java peut être exécuté sur n'importe quel système d'exploitation sans modification.

- **Sécurisé**
Java dispose d’un modèle de sécurité robuste, utilisé notamment dans les applications web et d’entreprise.

- **Multi-threading**
Il prend en charge le multitâche (plusieurs tâches en parallèle), ce qui améliore la performance des applications.

- **Garbage Collection**
Java gère automatiquement la mémoire et libère les ressources inutilisées grâce à son ramasse-miettes (Garbage Collector).

- **Grande communauté et bibliothèques**
Java dispose d’une vaste communauté et d’un écosystème de frameworks (Spring, Hibernate) et de bibliothèques.

### Comment fonctionne Java

1. Écriture du code dans un fichier texte `.java`.
2. Compilation avec la commande `javac <fichier>`. Transforme le code en bytecode (fichier `.class`)
3. Exécution du programme avec la commande java. 

### Les concepts clés

![image_3.png](image_3.png)

1. **JVM (Java Virtual Machine) – La Machine Virtuelle Java**
   - C'est un programme qui exécute les applications Java.
   - Il traduit le bytecode (code intermédiaire généré par la compilation Java) en instructions compréhensibles par le processeur de l'ordinateur.
   - La JVM assure aussi la gestion de la mémoire et l'exécution sécurisée du code.
   Elle est spécifique à chaque système d'exploitation (Windows, Mac, Linux, etc.), mais permet à Java d'être "Write Once, Run Anywhere".
   
2. **JRE (Java Runtime Environment) – L'Environnement d'Exécution Java**
   - Contient tout ce qui est nécessaire pour exécuter une application Java, y compris la JVM et les bibliothèques standard.
   - Il permet aux utilisateurs de lancer des programmes Java mais ne contient pas d'outils pour les développer.
   - Indispensable pour exécuter une application Java.

3. **JDK (Java Development Kit) – Le Kit de Développement Java**
   - Inclut le JRE (donc la JVM et les bibliothèques standard), ainsi que des outils pour développer et compiler du code Java (ex : javac pour la compilation).
   - Contient aussi des outils de débogage et d'autres utilitaires.
   - Indispensable pour les développeurs Java.


### Où est utilisé Java ?

- Développement d’applications d’entreprise (Spring, Java EE)
- Développement Android (via Kotlin et Java)
- Applications web et serveurs
- Jeux vidéo (Minecraft est écrit en Java)
- Intelligence artificielle et Big Data (via Apache Spark)
- ETL (Talend par exemple)

## Installation

Pour compiler et tester, il faut donc installer le JDK.

[](https://www.oracle.com/fr/java/technologies/downloads/)

### IDE

- IntelliJ IDEA en version payante ou gratuite (CE)
- Vs Code
