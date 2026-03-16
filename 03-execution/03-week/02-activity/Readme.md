
# carro de compras

- herramienta de diseño para el mockup:  https://www.figma.com/design/SEEF1mlPbFqDsQDnMy7E01/Sin-t%C3%ADtulo?t=Wc4zS4r8jvy7Of7Z-1


## Usuarios :
- instructores.
- aprendices.

## Situación: 
Durante los recesos los usuarios disponen de poco tiempo para comprar alimentos. La cafetería presenta filas extensas y el personal no alcanza a atender a todos los clientes, por lo que varios aprendices regresan a clase sin poder realizar su compra.

## Problema identificado:
Existe un alto tiempo de espera en la cafetería debido al proceso de atención manual, lo cual afecta el aprovechamiento del receso y la satisfacción de los usuarios.

## solucion :
- se propone un sistema web de pedidos anticipados que permita visualizar y seleccionar productos disponibles, agregarlos a un carrito y confirmar el pedido antes de llegar a la cafeteria, permitiendo hacer pagos en linea o directamente a caja y sin hacer fila.
El usuario solo deberá acercarse a recoger el pedido o pagarlo en caja, reduciendo el tiempo de atención y las filas.

## Requerimientos :
### Funcionales :
El sistema debe permitir:
- Registrarse.
- Iniciar session.
- Visualizacion del catalogo de productos con su precio.
- Agregar productos al carrito.
- Poder modificar cantidades en el carrito.
- Eliminar articulos del carrito.
- Confirmar el pedido.
- Registrar el pedido en el sistema.
- Generar un comprobante de pedido.
- Gestión de productos por parte del administrador (crear, editar o desactivar productos).
- Ver lista de pedidos


### No funcionales :
- interfaz accesible desde computador o celular.
- base de datos persistente.
- autenticación. 
- disponibilidad durante el horario academico.

## MoSCoW

### MUST requerimientos no negociables:
Funcionalidades minimas para que el sistema exista.
- Login.
- Lista articulos, visualizacion de menu.
- Carrito de compras .
- Confirmacion de pedido.
- Registrar pedido en la base de datos.

### SHOULD. importante pero no critico

- Reducir la cantidad de articulos.
- Verificar el estado de el articulo.
- Modificar entidades.
- Generar comprobante de recogiida.

### COULD se implementan si sobra tiempo y recursos

- Historial de pedidos.
- Ver a detalle cada pedido.
- Buscador.
- Filtros.


### WONT . se evita para que el sistema no se descontrole 

- notificaciones.
- aplicacion movil
- pagos inmediatos desde la aplicacion.
- turnos de recogida