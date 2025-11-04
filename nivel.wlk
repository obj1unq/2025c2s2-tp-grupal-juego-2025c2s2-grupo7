import wollok.game.*
import enemigos.*
import personaje.*
import config.*
import drops.*
import elementosDelMapa.*

object reyDeLaPradera{
    var nivelActual =new Nivel(enemigosIniciales = [zmb,zmb,zmb,zmb], tiempoDeSpawn =350,ejercitoDeNivel = ejercito, elementosEnNivel = elementosDelMapa, layout = [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
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
    const enemigosIniciales // Un set de los enemigos que se van a spawnear en un nivel. (No se le deben eliminar o agregar elementos).
    const ejercitoDeNivel   // Un set de los enemigos que aun no se han spawneado durante la ejecución de un nivel.
    const tiempoDeSpawn
    const elementosEnNivel // Son los objetos que habra en el mapa, es decir, cajas, barriles, arbustos, etc, etc.

    method crearNivel(){
        (0 .. layout.size() - 1).forEach({ y =>
            (0 .. layout.get(y).size() - 1).forEach({ x =>
                layout.get(y).get(x).crear(game.at(x, y), elementosEnNivel)
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