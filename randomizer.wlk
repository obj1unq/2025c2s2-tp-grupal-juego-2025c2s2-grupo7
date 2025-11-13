import wollok.game.*
import elementosDelMapa.*

object randomizer {
	const tableroDelJuego = tablero

	method posicion() {
		return 	game.at( 
					(0 .. tableroDelJuego.width() - 1 ).anyOne(),
					(0..  tableroDelJuego.height() - 1).anyOne()
		) 
	}
	
	method posicionVacia() {
		const position = self.posicion()
		if(!tableroDelJuego.hayAlgoAca(position)) {
			return position	
		}
		else {
			return self.posicionVacia()
		}
	}

	method posicionVaciaCentral(){
		const position = self.posicionParaEnemigo()
		if(!tableroDelJuego.hayAlgoAca(position)) {
			return position	
		}
		else {
			return self.posicionVaciaCentral()
		}
	}

	method posicionParaEnemigo(){
		const anchoYAlto = game.width()-1 // Para que esto funcione bien, en el juego width == height
		const mitadAnchoYAlto = anchoYAlto.div(2)
		return 	[game.at([mitadAnchoYAlto - 1, mitadAnchoYAlto, mitadAnchoYAlto + 1].anyOne(), [0, anchoYAlto].anyOne()),
				 game.at([0, anchoYAlto].anyOne(), [mitadAnchoYAlto - 1, mitadAnchoYAlto, mitadAnchoYAlto + 1].anyOne())].anyOne()
	}
}