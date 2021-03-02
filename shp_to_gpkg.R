library(sf)
library(stringr)

# Fijamos las rutas
# entrada: Ahí residen nuestros '.shp'
# salida: Donde estarán los archivos '.gpkg'
shp_path <- "data/shp/"
gpkg_path <- "data/gpkg/"

# Seleccionamos todos los que tengan extensión '.shp'
archivos = list.files(path = shp_path, pattern = '.shp$')
# Les quitamos la extensión: '.shp'
nombres = str_remove(archivos, '.shp')

# Debido a que son varios archivos, los metemos en un for,
# así hacemos todo de un jalón.
for(i in 1:length(archivos)) {
  # Importante leer bajo la codificación 'WINDOWS-1252',
  # para evitar caracteres extraños en los nombres de los municipios
  # y localidades
  x = st_read(archivos[i], options ="ENCODING=WINDOWS-1252")
  # Pegamos la ruta y el nombre del archivo, sin extensión,
  # para agregarle la extensión '.gpkg'
  archivo_gpkg <- paste0(paste0(ruta,nombres[i]), '.gpkg')
  # Escribimos el archivo GPKG
  st_write(x, archivo_gpkg)
}

# Probamos la lectura con uno de los mapas. Ya no debería tener 
# caracteres raros, como "Amatl�n de Ca�as", ahora deberá aparecer
# como "Amatlán de Cañas", entre otros
