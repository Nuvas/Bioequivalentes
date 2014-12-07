library(jsonlite)

licitacion <- c("359-71-LE14", "621-468-LP13")
orden.compra <- c("359-1479-SE14", "621-28-SE14")
ticket <- "F8537A18-6766-4DEF-9E59-426B4FEE2844"
nombre.proveedor <- c()
nombre.comprador <- c()
fecha.aceptacion <- c()
producto <- c()
precio.neto <- c()


for(oc in orden.compra) {
	url <- sprintf("http://api.mercadopublico.cl/servicios/v1/publico/ordenesdecompra.json?codigo=%s&ticket=%s", oc, ticket)
	json.data <- fromJSON(url)

    nombre.proveedor <- c(nombre.proveedor, json.data$Listado$Proveedor$Nombre)
    nombre.comprador <- c(nombre.comprador, json.data$Listado$Comprador$NombreOrganismo)
    fecha.aceptacion <- c(fecha.aceptacion, json.data$Listado$Fechas$FechaAceptacion)
    producto <- c(producto, json.data$Listado$Items$Listado[[1]]$Producto)
    precio.neto <- c(precio.neto, json.data$Listado$Items$Listado[[1]]$PrecioNeto)
}

df = data.frame(producto, precio.neto, fecha.aceptacion, nombre.proveedor, nombre.comprador, orden.compra, licitacion)
names(df) <- c("Producto", "Precio_Neto", "Fecha_Aceptacion", "Nombre_Proveedor", "Nombre_Comprador", "Orden_Compra"," Licitacion")
write.table(df, file="precios_compra.txt")
