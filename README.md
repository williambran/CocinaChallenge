    
# CocinaChallenge

Es un projecto que realizado con lenguage swift utilizando una arquitectura VIPER, y swift UIkit, el uso de constraint y un desacople entre sus diferentes capas. 
Se tomo la decision de usar esta arquitectura ya que nos permite tener un mayor orden y desacople entre los diferentes componentes, un mejor manejo entre la 
navegacion y escalabilidad.

Este desarrollo inluye ademas animaciones.

## Acerca de la app
Es una aplicacion con topic de recetas de cocina, el cual cuenta con un cosumo de servidios y navegacion entre las distintas pnatallas, donde podremos ver una 
lista de platillos, de los cuales podremos dar clik y nos mostrara los detalles de ese platillo, nomre, ingredientes, y una pequena receta para su elaboracion. 
Podremos ver la hubicacion del origen de los platillos 😋


## Installation

Para la ejecucion se require de ios >13, siendo la verrsion 15 que mas aprovecha sus componentes visuales.

```bash
 
```
    
## Flujos de la aplicacion
La aplicacion cuenta con 3 pantallas principales :

+ Home
+ Detalles
+ Mapa

Algunos mas tambien como: Detalle del origen de las receta.


## arquitectura

Esta appa ocupa la arquitectura viper, unas de las mejores para el desarrollo en ambientes Movimes, especificamente en ios, nos permite tener una separacion de 
resposabilidades entre los diferentes flujos, facilidad de pruebas unitarias, flexibilidad, reutilizacion de codigo, falicidad en comprension para el resto del 
equipo lo que influye en la velocidad y calidad de codigo.


## Vistas
Como se menciono, se ocupo lalibreri de desarollo uikit, esto por su alta confiabilidad y su alto grado de colaboradores,seguridad y facilidad de uso. En este 
projecto hacemos uso de animaciones ala hora de cars de vistas y de apariciones. 🤓


## Unit Test
Cuenta tambien con algunas pruebas unitarias a a capa de datos, donde de usa XCTest para poder realizar la s pruebas, mocks y XCTestCase


## Diseno
El diseno es muy atractivo, con el uso experto de contraint las pantallas se pueden renderizar a diferentes tipos de pantallas y recrearse con un diseno distinto 
al aplicar una rotacion del dispositivo.
👯‍♀️ 



