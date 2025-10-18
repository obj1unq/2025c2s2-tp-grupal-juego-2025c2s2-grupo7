import direcciones.*
import wollok.game.*


class Enemigo {
  var image 
  var position 
  var vida 
  var posicionAnterior
  var property daño

  method image(){
      return image
  }

  method position(){
      return position
  }

  method perseguir(personaje) {
    const distanciaHorizontal = (position.x() - personaje.position().x()).abs()
    const distanciaVertical = (position.y() - personaje.position().y()).abs()
    if (distanciaHorizontal >= distanciaVertical) {
      posicionAnterior = position
      self.perseguirHorizontal(personaje)
    } else {
      posicionAnterior = position
      self.perseguirVertical(personaje)
    }
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
  
  method colisionarCon(objeto){
    position = posicionAnterior
  }

  method aplicarDaño(_daño){
   if(vida > _daño){
    vida = vida - _daño
   }else {
    self.muerte()
   }
  }

  method muerte (){
    game.removeVisual(self)
  }

    method darPaso(){
        if (image == "enemigoBasico1.png"){
            image = "enemigoBasico2.png"
        } else {
            image = "enemigoBasico1.png"
        }
    }
}

class Zombie inherits Enemigo {

}

class Minotauro inherits Enemigo {

  override method darPaso(){
        if (image == "enemigoMinotauro1.png"){
            image = "enemigoMinotauro2.png"
        } else {
            image = "enemigoMinotauro1.png"
        }
    } 
}

const basico = new Zombie(image = "enemigoBasico1.png",position = game.at(1,1),vida = 10,posicionAnterior = game.at(1,1),daño=10)

const basico2 = new Zombie(image = "enemigoBasico1.png",position = game.at(7,14),vida = 10,posicionAnterior = game.at(7,14),daño=10)

const basico3 = new Minotauro(image = "enemigoMinotauro1.png",position = game.at(7,0),vida = 20,posicionAnterior= game.at(7,0),daño=20)

const basico4 = new Minotauro(image = "enemigoMinotauro1.png",position = game.at(0, 7),vida = 20,posicionAnterior= game.at(0,7),daño=20)

