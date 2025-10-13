import wollok.game.*
import factories.*
import enemigos.*
import personaje.*
import config.*
import drops.*
import muros.*
object reyDeLaPradera{
    var nivelActual =new Nivel(enemigosIniciales = [z,z,z,z], tiempoDeSpawn =350,ejercitoDeNivel = ejercito,murosDelNivel = muros,layout=[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                                                                    _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                                                                    _,_,_,_,mr,_,_,_,_,_,_,_,_,_,mr,_,_,_,_,_,
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
                                                                                                                    _,_,_,_,_,mr,_,_,_,_,_,_,_,_,_,mr,_,_,_,_,
                                                                                                                    _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                                                                    _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                                                                    _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                                                                    _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_ ].reverse())

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
        drops.borrarDrops()
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
    const murosDelNivel

    method crearNivel(){
        //layout.forEach({elementoDeNivel => elementoDeNivel.crear(murosDelNivel)})
    
        //game.height(layout.size()) //configuro el alto segun la cantidad de filas del dibujo
       // game.width(layout.anyOne().size()) //configuro el ancho segun la cantidad de columnas del dibujo
        //itero por el ancho y luego por el alto.
        (0 .. game.width() - 1).forEach({ x => 
            (0 .. game.height() - 1).forEach({y => 
                layout.get(y).get(x).crear(game.at(x,y),murosDelNivel)  //obtengo el dibujante de la cordenada que corresponde a la iteracion y le pido que dibuje en esa cordenada
            })
        })
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
    method crear(posicion,muro){
    }
}

object mr{
    method crear(posicion,muro) {
        const nuevoMuro = muroFactory.crear(posicion)
        muros.agregarMuro(nuevoMuro)
        game.addVisual(nuevoMuro) 
    }
}