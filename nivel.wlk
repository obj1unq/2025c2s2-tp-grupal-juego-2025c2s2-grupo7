import wollok.game.*
import factories.*
import enemigos.*
import personaje.*
import config.*

object reyDeLaPradera{
    var nivelActual =new Nivel(enemigosIniciales = [z,z,z,z], tiempoDeSpawn =350,ejercitoDeNivel = ejercito,layout=[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                                                                    _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                                                                    _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                                                                    _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                                                                    _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                                                                    _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                                                                    _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                                                                    _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                                                                    _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                                                                    _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                                                                    _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                                                                    _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                                                                    _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                                                                    _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                                                                    _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                                                                    _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                                                                    _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                                                                    _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                                                                    _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                                                                    _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_ ])

    method empezarJuego(){
        configuracion.configEscenario()
        configuracion.configPersonaje()
        configuracion.configVisuales()
        configuracion.configDropeo()
        nivelActual.jugarNivel()
        game.start()
    }

    method terminoNivel(){
        nivelActual = nivelActual.siguienteNivel()
        nivelActual.jugarNivel()
    }

    method reiniciarNivel(){
        nivelActual.reiniciarNivel()
    }

    method perderJuego(){
        game.stop()
    }
}

class Nivel{
    const layout
    var enemigos = enemigosIniciales.copy()
    const enemigosIniciales
    const ejercitoDeNivel
    const tiempoDeSpawn

    method crearNivel(){
        layout.forEach({elementoDeNivel => elementoDeNivel.crear()})
    }

    method spawnearEnemigos(){
        game.onTick(tiempoDeSpawn, "Spawn de enemigos del nivel", {self. spawnearSiguienteEnemigo()})
    }

    method spawnearSiguienteEnemigo(){
        if (!enemigos.isEmpty()){
            ejercitoDeNivel.agregarEnemigo(enemigos.first())
            enemigos = enemigos.drop(1)
        } else {
            game.removeTickEvent("Spawn de enemigos del nivel")
        }
    }

    method jugarNivel(){
        game.height(21)
        game.width(21)
        game.cellSize(48)
        game.boardGround("nivel.png")
        self.crearNivel()
        enemigos = enemigosIniciales
        self.spawnearEnemigos()
        ejercitoDeNivel.enemigosDanPaso()
        ejercitoDeNivel.enemigosPersiguen(personaje) // Hay que cambiar esto, para no usar la referencia global de personaje
    }

    method reiniciarNivel(){
        ejercitoDeNivel.matarTodos()
        enemigos = enemigosIniciales
        self.spawnearEnemigos()
        ejercitoDeNivel.enemigosDanPaso()
        ejercitoDeNivel.enemigosPersiguen(personaje)
    }

    method siguienteNivel(){
        return self
    }
}

object z{
    method crear(ejercito){
        return zombieFactory.crear(ejercito)
    }
}

object m{
    method crear(ejercito){
        return minotauroFactory.crear(ejercito)
    }
}

object _{
    method crear(){}
}