create schema ryu_technology;
use ryu_technology;

CREATE TABLE IF NOT EXISTS ryu_technology.categoria

/* La tabla categoría inserta dinamicamente en el menu de la web las categorías existentes
y las limita en las opciones del producto*/
(
id_categoria int auto_increment,
nombre_categoria varchar(20),
PRIMARY KEY (id_categoria)
);

CREATE TABLE IF NOT EXISTS ryu_technology.usuario

/* La tabla usuario contiene los datos del usuario para generar la factura y con su ID, consultar
a futuro todas las compras realizadas */
(
id_usuario int not null,
nombre varchar(20) not null,
apellido varchar(20) not null,
email varchar(20) not null,
direccion varchar(50) not null,
telefono int default 0,
PRIMARY KEY (id_usuario)
);

CREATE TABLE IF NOT EXISTS ryu_technology.producto

/* La tabla producto contiene el stock (inventario) de todos los productos de la tienda, de aqui se descuentan
la cantidad que haya sido comprada */
(
id_producto int auto_increment,
nombre varchar(20) not null,
marca varchar(20) not null,
tipo varchar (20) not null,
categoria varchar(20) not null,
precio int not null,
cantidad int default 0,
imagen varchar(20) not null,
id_categoria int,
id_compra int,
PRIMARY KEY (id_producto),
FOREIGN KEY (id_categoria) REFERENCES ryu_technology.categoria(id_categoria)
);

CREATE TABLE IF NOT EXISTS ryu_technology.wishlist

-- La tabla wishlist almacena productos que pueden ser agregados en un futuro al carrito
(
id_producto_wishlist int auto_increment,
nombre varchar(20) not null,
marca varchar(20) not null,
id_producto int,
PRIMARY KEY (id_producto_wishlist),
FOREIGN KEY (id_producto) REFERENCES ryu_technology.producto (id_producto)
);

CREATE TABLE IF NOT EXISTS ryu_technology.carrito

-- La tabla carrito contiene la informacion de los productos seleccionados por el usuario para ser comprados
(
id_producto_agregado int auto_increment,
nombre varchar(20) not null,
cantidad_agregada int not null, -- cantidad seleccionada por el usuario para comprar
cantidad_stock int not null, -- cantidad total de los productos en stock
precio int not null,
marca varchar(20),
categoria varchar(20),
id_producto int,
id_producto_wishlist int,
PRIMARY KEY (id_producto_agregado),
FOREIGN KEY (id_producto) REFERENCES ryu_technology.producto(id_producto),
FOREIGN KEY (id_producto_wishlist) REFERENCES ryu_technology.wishlist(id_producto_wishlist)
);

CREATE TABLE IF NOT EXISTS ryu_technology.compra

-- La tabla compra contiene el contenido de la compra final realizada por el usuario
(
id_compra int not null,
cantidad_comprada int not null,
cantidad_stock int not null, -- este dato menos la cantidad comprada actualizan el stock de productos
precio int not null,
marca int not null,
categoria int not null,
id_producto_agregado int,
id_producto int,
PRIMARY KEY (id_compra),
FOREIGN KEY (id_producto_agregado) REFERENCES ryu_technology.carrito(id_producto_agregado),
FOREIGN KEY (id_producto) REFERENCES ryu_technology.producto(id_producto)
);

CREATE TABLE IF NOT EXISTS ryu_technology.facturacion

-- La tabla facturacion posee todos los registro de compras realizados por usuario
(
id_facturacion int not null,
nombre varchar(20) not null,
apellido varchar(20) not null,
mail varchar(20) not null,
telefono int default 0,
fecha_compra datetime not null,
id_compra int,
id_usuario int,
PRIMARY KEY (id_facturacion),
FOREIGN KEY (id_compra) REFERENCES ryu_technology.compra(id_compra),
FOREIGN KEY (id_usuario) REFERENCES ryu_technology.usuario(id_usuario)
);