FROM openjdk

COPY . /usr/apps/syncher
WORKDIR /usr/apps/syncher

# 2 Possibilities:
## 1. Compiling sources locally
## RUN javac Main.java
## CMD ["java", "Main"] <--- this Main == Main.class
## 2. Using pre-compiled sources
## CMD ["java", "-jar", "HelloWorld.jar"]   <--- this is a .jar!
CMD ["java", "-jar", "HelloWorld/out/artifacts/HelloWorld_jarHelloWorld.jar"]
# Real solution
#CMD ["java", "-jar", "usr/apps/syncher/out/artifacts/why_investigator_jar/why_investigator.jar"]
