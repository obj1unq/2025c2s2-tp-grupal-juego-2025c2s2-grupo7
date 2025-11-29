import wollok.game.*
import personaje.*
import elementosDelMapa.*
import enemigos.*
import juego.*
import tableroYRepresentaciones.*
import imagenesEnPantalla.*
import config.*

class Nivel{
    const layout
    const property siguienteNivel
    const imagenDeFondo
    const enemigosASpawnearIniciales // Un set de los enemigos que se van a spawnear en un nivel. (No se le deben eliminar o agregar elementos).
    var enemigosASpawnear = enemigosASpawnearIniciales.copy() // Un set de los enemigos que aun no se han spawneado durante la ejecución de un nivel.
    const enemigosEnNivel = enemigos
    const tiempoDeSpawn = 500
    const limiteDeEnemigosEnMapa = 5
    const juego = reyDeLaPradera
    const fondoDelNivel = fondo
    const jugador = personaje
    const property cancion = game.sound("_cancion_nivel.mp3")
    const tableroDelJuego = tablero

    method spawnearEnemigos(){
        game.onTick(tiempoDeSpawn, "Spawn de enemigos del nivel", {self. spawnearSiguienteEnemigo()})
    }

    method spawnearSiguienteEnemigo(){
        if (!enemigosASpawnear.isEmpty()){
            if (self.hayEspacioParaSpawnearEnemigo()){
                const enemigoASpawnear = enemigosASpawnear.anyOne()
                enemigosEnNivel.agregarEnemigo(enemigoASpawnear)
                enemigosASpawnear.remove(enemigoASpawnear)
            }
        } else {
            self.esperarFinalDelNivel()
        }
    }

    method esperarFinalDelNivel(){
        game.removeTickEvent("Spawn de enemigos del nivel")
        game.onTick(3000, "Chequeo final del nivel", {self.terminarNivel()})
    }

    method terminarNivel(){
        self.validarPuedeTerminarseNivel()
        game.removeTickEvent("Chequeo final del nivel")
        juego.pasarASiguienteNivel()
    }

    method validarPuedeTerminarseNivel(){
        if (enemigosEnNivel.cantidadDeEnemigosEnMapa() != 0){
            self.error("")
        }
    }

    method hayEspacioParaSpawnearEnemigo(){
        return limiteDeEnemigosEnMapa > enemigosEnNivel.cantidadDeEnemigosEnMapa()
    }

    method jugarNivel(){
        fondoDelNivel.image(imagenDeFondo)
        tableroDelJuego.crearNivel(layout)
        enemigosASpawnear = enemigosASpawnearIniciales.copy()
        self.inicializarEnemigos()
    }

    method reiniciarEnemigos(){
        enemigosEnNivel.matarTodos()
        enemigosASpawnear = enemigosASpawnearIniciales.copy()
        self.inicializarEnemigos()
    }

    method inicializarEnemigos(){
        self.spawnearEnemigos()
        enemigosEnNivel.enemigosDanPaso()
        enemigosEnNivel.enemigosPersiguen(jugador)
    }
}

object menu{
    const siguienteNivel = nivelTutorial
    const fondoDelJuego = fondo
    const property cancion = game.sound("_cancion_menu.mp3")
    const imagenDeMenu = "menu_fondo2.png"

    method jugarNivel(){
        fondoDelJuego.image(imagenDeMenu)
    }

    method siguienteNivel(){
        keyboard.enter().onPressDo({})
        return siguienteNivel
    }
}

// NIVELES

object nivelTutorial inherits Nivel(
layout = [[b,b,b,b,b,b,b,_,_,_,b,b,b,b,b,b,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,b,b,b,b,b,b,_,_,_,b,b,b,b,b,b,b]].reverse(),
enemigosASpawnearIniciales = [ttr, ttr, ttr, ttr],
siguienteNivel = primerNivel, imagenDeFondo = "fondo_nivel1.png"){
    const configuracionDelJuego = configuracion

    override method jugarNivel(){
        configuracionDelJuego.configVisualesEmpezarJuego()
        super()
    }
}

const primerNivel = new Nivel(
layout = [[b,b,b,b,b,b,b,_,_,_,b,b,b,b,b,b,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,b,b,b,b,b,b,_,_,_,b,b,b,b,b,b,b]].reverse(),
enemigosASpawnearIniciales = [zmb, zmb, zmb, zmb, zmb,
                              zmb, zmb, zmb, zmb, zmb,
                              zmb, zmb, zmb, zmb, zmb],
siguienteNivel = segundoNivel, imagenDeFondo = "fondo_nivel1.png")

const segundoNivel = new Nivel(
layout = [[b,b,b,b,b,b,b,_,_,_,b,b,b,b,b,b,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,m,m,m,_,_,_,m,m,m,_,_,_,b],
          [b,_,_,_,m,_,_,_,_,_,_,_,m,_,_,_,b],
          [b,_,_,_,m,_,_,_,_,_,_,_,m,_,_,_,b],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [b,_,_,_,m,_,_,_,_,_,_,_,m,_,_,_,b],
          [b,_,_,_,m,_,_,_,_,_,_,_,m,_,_,_,b],
          [b,_,_,_,m,m,m,_,_,_,m,m,m,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,b,b,b,b,b,b,_,_,_,b,b,b,b,b,b,b]].reverse(),
enemigosASpawnearIniciales = [zmb, zmb],
siguienteNivel = tercerNivel, imagenDeFondo = "fondo_nivel2.png")

const tercerNivel = new Nivel(
layout = [[b,b,b,b,b,b,b,_,_,_,b,b,b,b,b,b,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,a,_,_,_,_,b],
          [b,_,a,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,a,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [_,_,_,_,_,_,_,_,_,_,a,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,t,_,_,_,_,_,_],
          [b,_,_,_,_,t,_,_,_,_,a,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,a,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,t,_,_,_,_,_,_,t,_,_,a,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,b,b,b,b,b,b,_,_,_,b,b,b,b,b,b,b]].reverse(),
enemigosASpawnearIniciales = [zmb, zmb],
siguienteNivel = cuartoNivel, imagenDeFondo = "fondo_nivel3.png")

const cuartoNivel = new Nivel(
layout = [[b,b,b,b,b,b,b,_,_,_,b,b,b,b,b,b,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,s,s,_,_,_,_,s,_,s,_,_,_,b],
          [b,_,_,_,s,s,_,_,_,_,s,_,s,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,s,s,_,_,_,_,s,_,s,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,s,s,_,_,_,_,s,_,s,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,b,b,b,b,b,b,_,_,_,b,b,b,b,b,b,b]].reverse(),
enemigosASpawnearIniciales = [zmb, zmb],
siguienteNivel = nivelFinal, imagenDeFondo = "fondo_nivel4.png")

// NIVEL FINAL (JEFE)

object nivelFinal inherits Nivel(
layout = [[b,b,b,b,b,b,b,_,_,_,b,b,b,b,b,b,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
          [b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b]].reverse(),
enemigosASpawnearIniciales = [],
siguienteNivel = self, imagenDeFondo = "fondo_nivelFinal.png")
{

}