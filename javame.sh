#!/bin/bash
# Stan javame

if [ $# -eq 0 ]
then
  echo "Usage : javame <options> <sources>" 1>&2
  echo "missing arguments" 1>&2
  echo "missing sources" 1>&2
  echo "more -h, --help" 1>&2
elif [ $1 == "new" ] && [ $# -gt 2 ]
then
  mkdir $2 $2/src $2/bin
  # création de .classpath
  echo '<?xml version="1.0" encoding="UTF-8"?>' >> $2/.classpath
  echo '<classpath>' >> $2/.classpath
  echo '	<classpathentry kind="con" path="org.eclipse.jdt.launching.JRE_CONTAINER"/>' >> $2/.classpath
  echo '	<classpathentry kind="src" path="src"/>' >> $2/.classpath
  echo '	<classpathentry kind="output" path="bin"/>' >> $2/.classpath
  echo '</classpath>' >> $2/.classpath

  # création de .project
  echo '<?xml version="1.0" encoding="UTF-8"?>' >> $2/.project
  echo '<projectDescription>' >> $2/.project
  echo "	<name>$2</name>" >> $2/.project
  echo '	<comment></comment>' >> $2/.project
  echo '	<projects>' >> $2/.project
  echo '	</projects>' >> $2/.project
  echo '	<buildSpec>' >> $2/.project
  echo '		<buildCommand>' >> $2/.project
  echo '			<name>org.eclipse.jdt.core.javabuilder</name>' >> $2/.project
  echo '			<arguments>' >> $2/.project
  echo '			</arguments>' >> $2/.project
  echo '		</buildCommand>' >> $2/.project
  echo '	</buildSpec>' >> $2/.project
  echo '	<natures>' >> $2/.project
  echo '		<nature>org.eclipse.jdt.core.javanature</nature>' >> $2/.project
  echo '	</natures>' >> $2/.project
  echo '</projectDescription>' >> $2/.project

  echo "" >> $2/src/$3.java
  echo "import java.util.*;" >> $2/src/$3.java
  echo "" >> $2/src/$3.java
  echo "//---------------------------" >> $2/src/$3.java
  echo "// Author" >> $2/src/$3.java
  echo "//---------------------------" >> $2/src/$3.java
  echo "" >> $2/src/$3.java
  echo "public class $3" >> $2/src/$3.java
  echo "{" >> $2/src/$3.java
  echo "  public static void main(String[] args)" >> $2/src/$3.java
  echo "  {" >> $2/src/$3.java
  echo '    System.out.println("Hello, world!");' >> $2/src/$3.java
  echo "  }" >> $2/src/$3.java
  echo "}" >> $2/src/$3.java
  echo '  Created Eclipse Java Project "'$2'"'
  echo "  Created class src/$3.java"
elif [ $1 == "build" ]
then
  javac.exe -d bin/ src/*.java
elif [ $1 == "run" ] && [ -z "$2" ]
then
  javac.exe -d bin/ src/*.java && java.exe -cp bin/ $(cd bin ; ls | cut -d "." -f1)
  # avoir le nom de la classe principale en retirant le .java
elif [ $1 == "run" ] && [ "$2" != "." ]
then
  javac.exe -d bin/ src/*.java && java.exe -cp bin/ $2
elif [ $1 == "-h" ] || [ $1 == "--help" ]
then
  echo "Usage: javame <options> <sources>"
  echo "new         Create a new java package"
  echo "            Note: javame new dir class[no .java])"
  echo "build       Compile the current package"
  echo "            Note: no arg needed"
  echo "run         Build and execute src/main_class.java"
  echo "            Note: javame run [class] Builds and executes target"
  echo "-h, --help  Show help"
else
  echo "Usage : javame <command> <args>" 1>&2
  echo "missing argument(s)" 1>&2
fi
