import direcciones.*
import wollok.game.*


class Enemigo {
  var property vida = 10
  var property daño = 1
  var property image = "Baddy1.png"
  var property position = game.at(9,9)

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
  method recibirDaño(_daño){
    game.removeVisual(self)
  }

}

const acorazado = new Enemigo(image = "acorazado.png",position = game.at(1,1))

const basico = new Enemigo()

const basico2 = new Enemigo(position = game.at(1,3))
