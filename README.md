# Documentacion
### Universidad Mariano Galvez de Guatemala
#### Compiladores
#### Seccion "A"

El proyecto usa un analizador sintactico para poder validar cadenas de texto, que, para este caso se validan numeros en notacion cientifica.

``` 
# Validos
3.14X^2 + 5X + 10 = 0
3X^2 + 4X - 5 = 0
-2X^2 + 6X + 10 = 0
1X^2 + 10X + 25
0.5X^2 - X + 7 = 0
2X^2 + 3X + 1

# Invalidos
3X + 5 = 0
2X + 3
2X^2 + X^ + 5 = 0
2X^2 3X + 1 = 0
holaX^2 + 2X + 3 = 0
```
## Como funciona?
El proyecto esta dividido de la siguiente manera
```
notacionCientifica
---.idea
---out
---src
------ecuaciones.flex
------EcuacionesLexer.java (archivo generado dinamicamente)
------Main (Clase Principal)
---.gitignore
---NotacionCientifica.iml
---README.md
```
[ecuaciones.flex](src/ecuaciones.flex) Es el archivo donde se tiene la logica para poder generar las reglas y las validaciones necesarias que se encargaran de validar en el archivo de entrada `txt` y poder retornar las coincidencias.

## Como genero la clase?
Para poder generar la clase [EcuacionesLexer.java](src/EcuacionesLexer.java) este es un archivo dinamico que se genera al realizar la compilacion del archivo `.flex`, para eso necesitamos el `jar` file de `jflex` [descargar jflex](https://jflex.de/download.html) para este ejemplo lo configuraremos usando el editor de codigo `intelliJ` para esto necesitamos seguir los siguientes pasos.
* Generar una nueva configuracion
  ![Captura de pantalla 2024-09-22 131741](https://github.com/user-attachments/assets/7d9bee9a-4cc5-47b4-8eb9-83f8a846d207)
  ---------------
  ![Captura de pantalla 2024-09-22 132203](https://github.com/user-attachments/assets/d587d9c3-d7f1-4d1c-b03d-857ab7a6d428)
  ---------------
  Para esta nueva configuracion necesitamos seleccionar `JAR Application`
  ---------------
  ![Captura de pantalla 2024-09-22 132321](https://github.com/user-attachments/assets/24f8a3ff-1a9c-4ec7-89ce-687d4f7dfe05)
  ---------------
  Debes rellenar los pasos siguientes.
  ---------------
  ![pasos](https://github.com/user-attachments/assets/bf8eecdd-1ae4-4a9d-8926-448bbd2ce065)
  ---------------
    * `Name` Este nombre es opcional, pero debe ser alguno descriptivo que te ayude a entender que es lo que hace para no confundirte con otras configuraciones.
    * `Path to JAR` Este campo si es necesario, es la ruta del archivo `.jar` de `jflex` donde sae que lo tengas descargado o guardado, ejemplo `C:\Users\test\test1\descarga\jflex-1.9.1\lib\jflex-full-1.9.1.jar`
    * `VM options` En algunos casos al tratar de compilar el archivo tendras un error de encoding, para solucionar esto debes agregar en esa opcion `-Dfile.encoding=UTF-8` para asegurarnos que sea un encoding valido.
    * `Program arguments` La ruta de tu archivo `.flex` debes de especificar el nombre del archivo para no tener errores, ejemplo: `./src/DateFlexer.flex`.
    * `Working directory` La ruta de tu proyecto para que la compilacion sea exitosa, tienes que indicarle en donde se podran encontrar los archivos que necesita, ejemplo `C:\Users\test\carpeta1\carpeta2\Carpetas\Proyecto_expresiones_regulares`
      Guarda los cambios y con esto deberias poder seleccionar la configuracion para poder generar la clase.

Es probable que necesites una configuracion adicional, para poder ejecutar la clase principal del proyecto.
![UIConfig](https://github.com/user-attachments/assets/e565f4ed-ae9a-4a23-add6-55791a4b8696)
Pero con las configuraciones por defecto deberia ser suficiente.


Una ves generada la clase correspondiente, deberias ser capas de instanciar la clase para poder usarla. :)











