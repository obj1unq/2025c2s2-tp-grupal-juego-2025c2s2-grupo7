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
        game.onTick(150, "Enemigos dan paso", {enemigos.forEach({enemigo => enemigo.darPaso()})})
    }

    method enemigosPersiguen(personaje){
        game.onTick(300, "Enemigos persiguen a personaje.", {enemigos.forEach({enemigo => enemigo.perseguir(personaje)})}) // FALTA QUE CAMBIE LA FRECUENCIA DEL TICK DEPENDIENDO DEL ENEMIGO (algunos
    }                                                                                                                      // son más rapidos que otros.)

    method enemigoMurio(enemigo){
        game.removeVisual(self)
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
    const ejercito
    const tableroDeNivel = tablero

    method image(){
        return estado.image()
    }

    method position(){
        return position
    }

    method perseguir(personaje) {
        self.perseguirEntreSiguientesPosiciones(personaje, tableroDeNivel.posicionesLindantesVacias(position))
    }

    method perseguirEntreSiguientesPosiciones(personaje, posiciones){
        if (!posiciones.isEmpty()){
            position = posiciones.min({posicion => posicion.distance(personaje.position())})
        }
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
        ejercito.enemigoMurio(self)
    }

    method darPaso(){
        estado = estado.siguienteEstado()
    }
}

class EnemigoDeMovimientoLento inherits Enemigo{
    var ticksParaMoverse

    override method perseguir(personaje){
        if (ticksParaMoverse == 0){
            super(personaje)
            ticksParaMoverse = self.ticksParaMoverseIniciales()
        } else {
            ticksParaMoverse = ticksParaMoverse - 1
        }
    }

    method ticksParaMoverseIniciales()
}

class Zombie inherits EnemigoDeMovimientoLento(vida = 10, estado = zombiePasoDerecho, ticksParaMoverse = 1){

    override method aplicarDaño(_daño){
        self.muerte()
    }

    override method ticksParaMoverseIniciales(){
        return 1
    }
}

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

class Minotauro inherits EnemigoDeMovimientoLento(vida = 30, estado = minotauroPasoDerecho, ticksParaMoverse = 1){
    override method ticksParaMoverseIniciales(){
        return 1
    }
}

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

class Vampiro inherits Enemigo(vida = 10, estado = vampiroPasoDerecho){
    override method perseguir(personaje){
        self.perseguirEntreSiguientesPosiciones(personaje, tableroDeNivel.posicionesLindantesSinEnemigos(position))
    }
}

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