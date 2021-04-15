/*Requerimientos:

- Conocer el precio de venta de una prenda ----> prenda.precio()
- Conocer el tipo de prenda de una prenda ----> prenda.tipo()
- Guardar las ventas de las prendas ----> macowins.registrarVenta(venta)
- Conocer las ganancias de un determinado dia ----> macowins.gananciasEnFecha(fecha)*/

class Prenda{
    var precio
    var estado
    const property tipo

    method precio() = estado.calcularPrecio(precio)
}

/*Utilizo composicion porque los estados de las prendas pueden cambiar, tambien tienen comportamientos distintos ante el mismo mensaje (polimorfismo) */
class Nueva{
    method calcularPrecio(precio) = precio
}

class Promocion{
	const valorPromocion
    method calcularPrecio(precio) = precio - valorPromocion
}

class Liquidacion{
    method calcularPrecio(precio) = precio * 0.5
}

class Macowins{
    const property ventasRegistradas = []
    method registrarVenta(venta){
        ventasRegistradas.add(venta)
    }
    method ventasEnFecha(fecha) = ventasRegistradas.filter({venta => venta.tenesEstaFecha(fecha)})

    method gananciasEnFecha(fecha) = self.ventasEnFecha(fecha).sum({venta => venta.total()})
}

class Venta{
    const fecha
  	const items = []
    var formaPago
    method agregarPrenda(unaPrenda, unaCantidad){
        items.add(new Item(prenda = unaPrenda, cantidad = unaCantidad))
    }
    method total() = formaPago.calcularTotal(self)
    
    method subTotal() = items.sum({item => (item.precioTotalItem())})

	method sumaPrecioPrendaIndividual() = items.sum({item => (item.precioIndividual())})
	
	method tenesEstaFecha(unaFecha) = fecha == unaFecha
}

class Item{
    const prenda
    const cantidad
    method precioTotalItem() = self.precioIndividual() * cantidad
    
    method precioIndividual() = prenda.precio()
}
class Efectivo{
	method calcularTotal(venta) =  venta.subTotal()
}

class Tarjeta{
    var cantidadCuotas
    const coeficienteFijo
    const porcentajeTarjeta = 0.01
    method calcularTotal(venta) = venta.subTotal() + cantidadCuotas * coeficienteFijo + porcentajeTarjeta * venta.sumaPrecioPrendaIndividual()

}