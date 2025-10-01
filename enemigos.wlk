import direcciones.*
import wollok.game.*

object acorazado {
    var vida = 10
    var image = "acorazado.png"
    var property position = game.at(9,9)
    var property danio = 1


   
    method mover(direccion) {
      position = direccion.siguiente(position) 
    }
    method image(){
		return image
	}

  method perseguirHorizontal(personaje){
  if (position.x() < personaje.position().x()){
    position = derecha.siguiente(position)
  }  else {
    position = izquierda.siguiente(position)
  } 
  }
  method perseguirVertical(personaje){
  if (position.y() < personaje.position().y()){
    position = arriba.siguiente(position)
  }  else {
    position = abajo.siguiente(position)
  } 
  }

  method perseguir(personaje){
    if (position.y()== personaje.position().y()){
      self.perseguirHorizontal(personaje)
    }else{
      self.perseguirVertical(personaje)
    }
  }

  method colisionarCon(bala){
    game.removeVisual(self)
  }
}

object enemigo{
  var image = "Baddy1.png"
  var property position = game.at(0, 4)
  var property danio = 1


    method mover(direccion) {
      position = direccion.siguiente(position) 
    }
    method image(){
		return image
	}

   method perseguirHorizontal(personaje){
  if (position.x() < personaje.position().x()){
    position = derecha.siguiente(position)
  }  else {
    position = izquierda.siguiente(position)
  } 
  }
  method perseguirVertical(personaje){
  if (position.y() < personaje.position().y()){
    position = arriba.siguiente(position)
  }  else {
    position = abajo.siguiente(position)
  } 
  }

  method perseguir(personaje){
    if (position.x()== personaje.position().x()){
      self.perseguirVertical(personaje)
    }else{
      self.perseguirHorizontal(personaje)
    }
  }

  method colisionarCon(bala){
    game.removeVisual(self)
  }
}