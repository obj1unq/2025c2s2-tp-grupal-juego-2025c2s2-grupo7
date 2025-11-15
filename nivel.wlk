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
    const limiteDeEnemigosEnMapa = 5
    const property siguienteNivel
    const juego = reyDeLaPradera
    const imagenDeFondo
    const fondoDelJuego = fondo

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
        fondoDelJuego.cambiarFondo(imagenDeFondo)
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
layout = [[c,c,c,c,c,c,c,_,_,_,c,c,c,c,c,c,c],
          [c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c],
          [c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c],
          [c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c],
          [c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c],
          [c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c],
          [c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c],
          [c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c],
          [c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c],
          [c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c],
          [c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c],
          [c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c],
          [c,c,c,c,c,c,c,_,_,_,c,c,c,c,c,c,c]].reverse(),
enemigosIniciales = [zmb, zmb],
siguienteNivel = segundoNivel, imagenDeFondo = "fondo_nivel1.png")

const segundoNivel = new Nivel(
layout = [[c,c,c,c,c,c,c,_,_,_,c,c,c,c,c,c,c],
          [c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c],
          [c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c],
          [c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c],
          [c,_,_,_,m,m,m,_,_,_,m,m,m,_,_,_,c],
          [c,_,_,_,m,_,_,_,_,_,_,_,m,_,_,_,c],
          [c,_,_,_,m,_,_,_,_,_,_,_,m,_,_,_,c],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [c,_,_,_,m,_,_,_,_,_,_,_,m,_,_,_,c],
          [c,_,_,_,m,_,_,_,_,_,_,_,m,_,_,_,c],
          [c,_,_,_,m,m,m,_,_,_,m,m,m,_,_,_,c],
          [c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c],
          [c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c],
          [c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c],
          [c,c,c,c,c,c,c,_,_,_,c,c,c,c,c,c,c]].reverse(),
enemigosIniciales = [zmb, zmb],
siguienteNivel = tercerNivel, imagenDeFondo = "fondo_nivel2.png")

const tercerNivel = new Nivel(
layout = [[a,a,a,a,a,a,a,_,_,_,a,a,a,a,a,a,a],
          [a,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,a],
          [a,_,_,_,_,_,_,_,_,_,_,a,_,_,_,_,a],
          [a,_,a,_,_,_,_,_,_,_,_,_,_,_,_,_,a],
          [a,_,_,a,_,_,_,_,_,_,_,_,_,_,_,_,a],
          [a,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,a],
          [a,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,a],
          [_,_,_,_,_,_,_,_,_,_,a,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,t,_,_,_,_,_,_],
          [a,_,_,_,_,t,_,_,_,_,a,_,_,_,_,_,a],
          [a,_,_,_,_,_,_,_,_,_,_,_,_,a,_,_,a],
          [a,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,a],
          [a,_,_,t,_,_,_,_,_,_,t,_,_,a,_,_,a],
          [a,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,a],
          [a,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,a],
          [a,a,a,a,a,a,a,_,_,_,a,a,a,a,a,a,a]].reverse(),
enemigosIniciales = [zmb, zmb],
siguienteNivel = cuartoNivel, imagenDeFondo = "fondo_nivel3.png")

const cuartoNivel = new Nivel(
layout = [[s,s,s,s,s,s,s,_,_,_,s,s,s,s,s,s,s],
          [s,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,s],
          [s,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,s],
          [s,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,s],
          [s,_,_,_,s,s,_,_,_,_,s,_,s,_,_,_,s],
          [s,_,_,_,s,s,_,_,_,_,s,_,s,_,_,_,s],
          [s,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,s],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [s,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,s],
          [s,_,_,_,s,s,_,_,_,_,s,_,s,_,_,_,s],
          [s,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,s],
          [s,_,_,_,s,s,_,_,_,_,s,_,s,_,_,_,s],
          [s,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,s],
          [s,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,s],
          [s,s,s,s,s,s,s,_,_,_,s,s,s,s,s,s,s]].reverse(),
enemigosIniciales = [zmb, zmb],
siguienteNivel = nivelFinal, imagenDeFondo = "fondo_nivel4.png")

// NIVEL FINAL (JEFE)

object nivelFinal inherits Nivel(
layout = [[c,c,c,c,c,c,c,_,_,_,c,c,c,c,c,c,c],
          [c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c],
          [c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c],
          [c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c],
          [c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c],
          [c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c],
          [c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c],
          [c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c],
          [c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c],
          [c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c],
          [c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c],
          [c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c],
          [c,c,c,c,c,c,c,_,_,_,c,c,c,c,c,c,c]].reverse(),
enemigosIniciales = [],
siguienteNivel = self, imagenDeFondo = "fondo_nivelFinal.png")
{

}

object fondo{
    var image = "fondo_nivel1.png"
    const property position = game.origin()

    method agregarFondo(){
        game.addVisual(self)
    }

    method cambiarFondo(fondo){
        image = fondo
    }

    method image(){
        return image
    }
}