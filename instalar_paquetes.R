'
!Hola¡ El siguiente código instala los paquetes para nuestra próxima sesión.
Cualquier duda que tengas escríbeme a carlos.castillo@lytica.ai

Pude haber puesto veces el siguiente código para instalar y cargar paquetes en R:
install.packages("plotly")
install.packages("shiny")
install.packages("shinydashboard")
install.packages("tidyverse")
install.packages("RMySQL")

library("plotly")
library("shiny")
library("shinydashboard")
library("tidyverse")
library("RMySQL")

Sin embargo, ¿te imaginas lo extenso que sería el código si en lugar de 5,
tuvieras 20 paquetes a instalar?

Me gusta que cuando vean mi código, la gente diga: "que elegancia la de Francia".
(Me baso en la notación que puedes 
checar en: https://www.r-bloggers.com/2018/09/r-code-best-practices/)
Por eso, vamos a crear una función que revise si los paquetes en una lista ya
están instalados y si no, los instale. Posteriormente los cargamos.
'

# hacemos una lista de los paquetes que queremos instalar
requiredPackages <- c('plotly', 'shiny', 'shinydashboard', 'tidyverse', 'RMySQL')

# creamos la función ipak que recibe como argumento un(os) paquete(s)
ipak <- function(pkg){
  
  'La siguiente linea revisa cuáles paquetes del argumento que recibe
  la función aún NO han sido instalados y los guarda en otra lista
  que se llama new.pkg.'
  
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  
  'Las siguientes dos líneas de código son un condicional. 
  Si la sentencia anterior new.pkg guardó algo, 
  entonces va a instalar el o los paquetes y sus dependencias.
  Como dato, en R hay multiples formas de hacer un "if". 
  Esta pregunta de stackoverflow te puede dar ideas de cómo 
  hacerlo en distintas maneras: https://stackoverflow.com/questions/15586566/if-statement-in-r-can-only-have-one-line'
  
  if (length(new.pkg))
    install.packages(new.pkg, dependencies = TRUE)
  
  'La función sapply recibe una lista como argumento y te regresa otra lista.
  Es muy útil para evitar el uso de "for" en tu código (puedes agrupar varias
  líneas de código en una sola usando sapply). 
  Aquí explican más a detalle la aplicación de ésta función:
  https://r-coder.com/funcion-sapply-en-r/
  
  La función recibe como argumento la lista de paquetes
  que declaraste en el inicio del código,
  los carga con la función "require()" (recordemos que
  para cargar un paquete también puedes usar "library()".
  Si quieres saber por qué prefiero usar "require()" revisa:
  https://www.r-bloggers.com/2016/12/difference-between-library-and-require-in-r/)
  El argumento "character.only" te evitará errores en la función.
  Te invito a googlear cuándo y por qué usarlo.
  '
  sapply(pkg, require, character.only = TRUE)
  
}

# Finalmente llamas a la función que creaste arriba y estás listo para seguir tu código. !Suerte!
ipak(requiredPackages)