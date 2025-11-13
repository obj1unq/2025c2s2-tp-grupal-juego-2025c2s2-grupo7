import wollok.game.*
import personaje.*
import elementosDelMapa.*
import enemigos.*
import juego.*

class Nivel{
    const layout
    var enemigos = enemigosIniciales.copy() // Un set de los enemigos que aun no se han spawneado durante la ejecución de un nivel.
    const enemigosIniciales // Un set de los enemigos que se van a spawnear en un nivel. (No se le deben eliminar o agregar elementos).
    const ejercitoDeNivel = ejercito
    const tiempoDeSpawn = 500
    const elementosEnNivel = elementosDelMapa
    const limiteDeEnemigosEnMapa = 4
    const property siguienteNivel
    const juego = reyDeLaPradera
    const fondo

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
            if (self.hayEspacioParaSpawnearEnemigo()){
                const enemigoASpawnear = enemigos.anyOne()
                ejercitoDeNivel.agregarEnemigo(enemigoASpawnear)
                enemigos.remove(enemigoASpawnear)
            }
        } else {
            self.esperarFinalDelNivel()
        }
    }

    method esperarFinalDelNivel(){
        game.removeTickEvent("Spawn de enemigos del nivel")
        game.onTick(3000, "chequeoFinalNivel", {self.terminarNivelSiSePuede()})
    }

    method terminarNivelSiSePuede(){
        if (ejercitoDeNivel.cantidadDeEnemigosEnMapa() == 0){
            game.removeTickEvent("chequeoFinalNivel")
            juego.terminarNivel()
        }
    }

    method hayEspacioParaSpawnearEnemigo(){
        return limiteDeEnemigosEnMapa > ejercitoDeNivel.cantidadDeEnemigosEnMapa()
    }

    method jugarNivel(){
        game.boardGround(fondo)
        self.crearNivel()
        enemigos = enemigosIniciales.copy()
        self.spawnearEnemigos()
        ejercitoDeNivel.enemigosDanPaso()
        ejercitoDeNivel.enemigosPersiguen(personaje) // Hay que cambiar esto, para no usar la referencia global de personaje
    }

    method reiniciarNivel(){
        ejercitoDeNivel.matarTodos()
        enemigos = enemigosIniciales.copy()
        self.spawnearEnemigos()
        ejercitoDeNivel.enemigosDanPaso()
        ejercitoDeNivel.enemigosPersiguen(personaje)
    }
}

// NIVELES

const primerNivel = new Nivel(
layout = [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]].reverse(),
enemigosIniciales = [zmb, zmb],
siguienteNivel = segundoNivel, fondo = "fondo_nivel.png", limiteDeEnemigosEnMapa = 3)

const segundoNivel = new Nivel(
layout = [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,m,m,m,_,_,_,_,_,m,m,m,_,_,_,_,_],
          [_,_,_,_,_,m,_,_,_,_,_,_,_,_,_,m,_,_,_,_,_],
          [_,_,_,_,_,m,_,_,_,_,_,_,_,_,_,m,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,m,_,_,_,_,_,_,_,_,_,m,_,_,_,_,_],
          [_,_,_,_,_,m,_,_,_,_,_,_,_,_,_,m,_,_,_,_,_],
          [_,_,_,_,_,m,m,m,_,_,_,_,_,m,m,m,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]].reverse(),
enemigosIniciales = [zmb, zmb, zmb, zmb,
                     zmb, zmb, zmb, zmb,
                     acz, vmp, vmp, acz,
                     zmb, zmb, zmb, zmb,
                     zmb, zmb, zmb, zmb],
siguienteNivel = tercerNivel, fondo = "fondo_nivelprueba.png")

const tercerNivel = new Nivel(
layout = [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,m,_,_,_,_,_,m,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,m,_,_,_,_,_,m,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,m,_,_,_,_,_,m,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,m,_,_,_,_,_,m,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,m,_,_,_,_,_,m,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,m,_,_,_,_,_,m,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,m,m,m,m,m,m,m,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]].reverse(),
enemigosIniciales = [zmb, zmb, zmb, zmb,
                     zmb, zmb, zmb, zmb,
                     acz, vmp, vmp, acz,
                     zmb, zmb, zmb, zmb,
                     zmb, zmb, zmb, zmb],
siguienteNivel = cuartoNivel, fondo = "fondo_nivel.png")

const cuartoNivel = new Nivel(
layout = [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,m,m,m,m,m,_,m,m,m,m,m,_,_,_,_,_],
          [_,_,_,_,_,m,_,_,_,_,_,_,_,_,_,m,_,_,_,_,_],
          [_,_,_,_,_,m,_,_,_,_,_,_,_,_,_,m,_,_,_,_,_],
          [_,_,_,_,_,m,_,_,_,_,_,_,_,_,_,m,_,_,_,_,_],
          [_,_,_,_,_,m,_,_,_,_,_,_,_,_,_,m,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,m,_,_,_,_,_,_,_,_,_,m,_,_,_,_,_],
          [_,_,_,_,_,m,_,_,_,_,_,_,_,_,_,m,_,_,_,_,_],
          [_,_,_,_,_,m,_,_,_,_,_,_,_,_,_,m,_,_,_,_,_],
          [_,_,_,_,_,m,_,_,_,_,_,_,_,_,_,m,_,_,_,_,_],
          [_,_,_,_,_,m,m,m,m,m,_,m,m,m,m,m,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]].reverse(),
enemigosIniciales = [zmb, zmb, zmb, zmb,
                     zmb, zmb, zmb, zmb,
                     acz, vmp, vmp, acz,
                     zmb, zmb, zmb, zmb,
                     zmb, zmb, zmb, zmb],
siguienteNivel = nivelFinal, fondo = "fondo_nivel.png")

// NIVEL FINAL (JEFE)

object nivelFinal inherits Nivel(
layout = [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]].reverse(),
enemigosIniciales = [],
siguienteNivel = self, fondo = "fondo_nivel.png")
{

}