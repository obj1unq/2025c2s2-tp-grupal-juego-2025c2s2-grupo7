import movimiento.*
import randomizer.*
import wollok.game.*
import factories.*
import drops.*
import elementosDelMapa.*

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
        game.onTick(500, "Enemigos persiguen a personaje.", {enemigos.forEach({enemigo => enemigo.perseguir(personaje)})}) // FALTA QUE CAMBIE LA FRECUENCIA DEL TICK DEPENDIENDO DEL ENEMIGO (algunos
    }                                                                                                                      // son más rapidos que otros.)

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

    method hayEnemigoAca(position){
        return enemigos.any({enemigo => enemigo.position() == position})
    }
}

class Enemigo {
  var estado
  var position 
  var vida 
  var posicionAnterior
  const ejercito
  const elementos = elementosDelMapa

    method image(){
        return estado.image()
    }

    method position(){
        return position
    }

    method perseguir(personaje) {
        const posicionesLindantesVacias = self.posicionesLindantes().filter({posicion => !ejercito.hayEnemigoAca(posicion) and !elementos.hayElementoAca(posicion)})
        if (!posicionesLindantesVacias.isEmpty()){
            position = posicionesLindantesVacias.min({posicion => posicion.distance(personaje.position())}) // La base del nuevo perseguir de los enemigos es esta, falta aplicar buenas practicas
        }                                                                                                   // y pasar responsabilidas a otros objetos.
    }

    method posicionesLindantes(){ // Esto deberia ser responsabilidad de otro objeto.
        return #{position.left(1), position.right(1), position.up(1), position.down(1)}
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

