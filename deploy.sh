#!/bin/bash

# Nombre del proyecto y archivos
PROJECT_NAME="familia_huecas"
TAR_NAME="${PROJECT_NAME}_mysql_image.tar"
ZIP_NAME="${PROJECT_NAME}_project_images.zip"

# Navegar al directorio de la base de datos
cd ~/familiahuecas/database

# Descargar la imagen de MySQL y levantar el contenedor con Docker Compose
echo "Levantando contenedor de MySQL con Docker Compose..."
docker-compose up -d

# Guardar la imagen como archivo .tar
echo "Guardando imagen de MySQL como $TAR_NAME..."
docker save -o $TAR_NAME mysql:8.0

# Comprimir la imagen en un archivo .zip
if [ -f "$ZIP_NAME" ]; then
    echo "Añadiendo $TAR_NAME al archivo $ZIP_NAME..."
    zip -u $ZIP_NAME $TAR_NAME
else
    echo "Creando archivo $ZIP_NAME con $TAR_NAME..."
    zip $ZIP_NAME $TAR_NAME
fi

# Limpiar el archivo .tar
rm $TAR_NAME

echo "Proceso completado. La imagen de MySQL ha sido comprimida en $ZIP_NAME."
