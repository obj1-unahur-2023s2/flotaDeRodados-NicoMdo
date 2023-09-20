import rodados.*
import pedidos.*

class Dependencia{
  var property cantidadEmpleado = 0
  const rodados = []
  const pedidos = []


  method capacidadDeLaFlota(){
    return rodados.sum({r=>r.capacidad()})
  }

  method agregarAFlota(rodado){
    rodados.add(rodado)
  }

  method quitarDeAFlota(rodado){
    rodados.remove(rodado) 
  }

  method pesoTotalFlota(){
    return rodados.sum({rodado => rodado.peso()})
  }

  method todosSuperanXVelocidad(velocidad){
    return rodados.all({r=>r.velocidad()>=velocidad})
  }

  method estaBienEquipada(){
    return rodados.size() >= 3 && self.todosSuperanXVelocidad(100)
  }

  method rodadosDeUnColor(color){
    return rodados.filter({r=>r.color() == color})
  }

  method capacidadTotalEnColor(color){
    return self.rodadosDeUnColor(color).sum({r=>r.capacidad()})
  }

  method colorDelRodadoMasRapido(){
    return self.rodadoMasRapido().color()
  }

  method rodadoMasRapido(){
    if (rodados.isEmpty()){
      self.error("No se puede en listaq vacia")
      }
    return rodados.max({r=>r.velocidad()})
  }

  method capacidadFaltante(){
    return 0.max(cantidadEmpleado - self.capacidadDeLaFlota())
  }

  method esGrande(){
    return cantidadEmpleado > 40 and rodados.size() >= 5
  }
  
  method ningunoSatisface(pedido){
  	// return rodados.all(r => not pedido.puedeSerSatisfechoPor(r))    <--- otra alternativa
  	return rodados.any({r => pedido.puedeSerSatisfechoPor(r)})
  }
  method pedidosInsatisfechos(pedido){
  	return pedidos.filter({p => self.ningunoSatisface(p)})
  }


}

