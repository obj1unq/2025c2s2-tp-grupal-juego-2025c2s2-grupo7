import direcciones.*
import randomizer.*
import wollok.game.*
import factories.*
import drops.*

object ejercito{
    const enemigos = #{}

    method agregarEnemigo(tipoDeEnemigo){
        const enemigo = tipoDeEnemigo.crear(self)
        enemigos.add(enemigo)
        game.addVisual(enemigo)
        game.onCollideDo(enemigo, {objeto => objeto.colisionarCon(enemigo)})
    }

    method enemigosDanPaso(){
        game.onTick(200, "Enemigos dan paso", {enemigos.forEach({enemigo => enemigo.darPaso()})})
    }

    method enemigosPersiguen(personaje){
      game.onTick(500, "Enemigos persiguen a personaje.", {enemigos.forEach({enemigo => enemigo.perseguir(personaje)})})
    }

    method enemigoMurio(enemigo){
      enemigos.remove(enemigo)
      if (enemigos.isEmpty()){
        game.removeTickEvent("Enemigos dan paso")
        game.removeTickEvent("Enemigos persiguen a personaje.")
      }
    }

    method matarTodos(){
      enemigos.forEach({enemigo => enemigo.muerte()})
    }
}

class Enemigo {
  var estado
  var position 
  var vida 
  var posicionAnterior
  const ejercito

  method image(){
      return estado.image()
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
    drops.nuevoDropEn(self.position())
    game.removeVisual(self)
    ejercito.enemigoMurio(self)
  }

    method darPaso(){
        estado = estado.siguienteEstado()
    }
}

class Zombie inherits Enemigo(vida = 10, estado = zombiePasoDerecho){}

object zombiePasoDerecho{
  const image = "enemigoBasico1.png"
  const siguienteEstado = zombiePasoIzquierdo
  
  method image(){
    return image
  }

  method siguienteEstado(){
    return siguienteEstado
  }
}

object zombiePasoIzquierdo{
  const image = "enemigoBasico2.png"
  const siguienteEstado = zombiePasoDerecho
  
  method image(){
    return image
  }

  method siguienteEstado(){
    return siguienteEstado
  }
}

class Minotauro inherits Enemigo(vida = 20, estado = minotauroPasoDerecho){}

object minotauroPasoDerecho{
  const image = "enemigoMinotauro1.png"
  const siguienteEstado = minotauroPasoIzquierdo
  
  method image(){
    return image
  }

  method siguienteEstado(){
    return siguienteEstado
  }
}

object minotauroPasoIzquierdo{
  const image = "enemigoMinotauro2.png"
  const siguienteEstado = minotauroPasoDerecho
  
  method image(){
    return image
  }

  method siguienteEstado(){
    return siguienteEstado
  }
}

class Vampiro inherits Enemigo(vida = 10, estado = vampiroPasoDerecho){}

object vampiroPasoDerecho{
  const image = "enemigoVolador1.png"
  const siguienteEstado = vampiroPasoIzquierdo
  
  method image(){
    return image
  }

  method siguienteEstado(){
    return siguienteEstado
  }
}

object vampiroPasoIzquierdo{
  const image = "enemigoVolador2.png"
  const siguienteEstado = vampiroPasoDerecho
  
  method image(){
    return image
  }

  method siguienteEstado(){
    return siguienteEstado
  }
}


class Acorazado inherits Enemigo(vida = 20, estado = acorazadoPasoDerecho){}
   
  /* 
    REVISAR
   var property realizarTransformacion = true

    override method perseguir(personaje){
      
      if(not estado.estaTransformado()){
        super(personaje)
      }
      if(realizarTransformacion){
        self.programarTransformacion()
      }
    }

  method programarTransformacion(){
    realizarTransformacion = false
    game.schedule(10000, { self.transformacion() })
  }

  method transformacion(){
    estado = acorazadoTransformacionCompleta
    
  object acorazadoComienzaTransformacion {
  const image = "transformacionComienza.png"

  method image(){
    return image
   }

  method esUltimaEtapaDeTransformacion(){
      return false
  }

  method estaTransformado(){
    return true
  }
}

object acorazadoMediaTransformacion {
  const image = "transformacionMedia.png"

  method image(){
    return image
   }


  method esUltimaEtapaDeTransformacion(){
      return false
  }

  method estaTransformado(){
    return true
  }
}

object acorazadoTransformacionCompleta{
    const image = "transformacionCompleta.png"

  method image(){
    return image
   }

  method esUltimaEtapaDeTransformacion(){
      return true
  }

  method estaTransformado(){
    return true
  }
}
  }}
*/

object acorazadoPasoDerecho{
  const image = "enemigoAcorazado1.png"
  const siguienteEstado = acorazadoPasoIzquierdo
  
  method image(){
    return image
  }

  method siguienteEstado(){
    return siguienteEstado
  }

  method estaTransformado(){
    return false
  }
}

object acorazadoPasoIzquierdo{
  const image = "enemigoAcorazado2.png"
  const siguienteEstado = acorazadoPasoDerecho
  
  method image(){
    return image
  }

  method siguienteEstado(){
    return siguienteEstado
  }

  method estaTransformado(){
    return false
  }
}

