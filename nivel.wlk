import wollok.game.*
import factories.*
import enemigos.*
import personaje.*
import config.*
import drops.*
import muros.*
object reyDeLaPradera{
    var nivelActual =new Nivel(enemigosIniciales = [zmb,zmb,zmb,zmb], tiempoDeSpawn =350,ejercitoDeNivel = ejercito, murosDelNivel = muros, layout=[[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
                                                                                                                                                    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
                                                                                                                                                    [_,_,_,_,m,_,_,_,_,_,_,_,_,_,m,_,_,_,_,_],
                                                                                                                                                    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
                                                                                                                                                    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
                                                                                                                                                    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
                                                                                                                                                    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
                                                                                                                                                    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
                                                                                                                                                    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
                                                                                                                                                    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
                                                                                                                                                    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
                                                                                                                                                    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
                                                                                                                                                    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
                                                                                                                                                    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
                                                                                                                                                    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
                                                                                                                                                    [_,_,_,_,_,m,_,_,_,_,_,_,_,_,_,m,_,_,_,_],
                                                                                                                                                    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
                                                                                                                                                    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
                                                                                                                                                    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
                                                                                                                                                    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
                                                                                                                                                    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]].reverse())

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
        (0 .. layout.size() - 1).forEach({ y =>
            (0 .. layout.get(y).size() - 1).forEach({ x =>
                layout.get(y).get(x).crear(game.at(x, y), murosDelNivel)
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

object zmb{
    method crear(ejercito){
        return zombieFactory.crear(ejercito)
    }
}

object mtr{
    method crear(ejercito){
        return minotauroFactory.crear(ejercito)
    }
}

object _{
    method crear(posicion,muro){
    }
}

object m{
    method crear(posicion,muro) {
        const nuevoMuro = muroFactory.crear(posicion)
        muros.agregarMuro(nuevoMuro)
        game.addVisual(nuevoMuro) 
    }
}