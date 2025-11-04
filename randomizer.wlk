import wollok.game.*

object randomizer {
	method position() {
		return 	game.at( 
					(0 .. game.width() - 1 ).anyOne(),
					(0..  game.height() - 1).anyOne()
		) 
	}
	
	method emptyPosition() {
		const position = self.position()
		if(game.getObjectsIn(position).isEmpty()) { // Esto tal vez hay que cambiarlo para evitar usar metodos de game.
			return position	
		}
		else {
			return self.emptyPosition()
		}
	}

	method posicionVaciaCentral(){
		const position = self.posicionParaEnemigo()
		if(game.getObjectsIn(position).isEmpty()) { // Esto tal vez hay que cambiarlo para evitar usar metodos de game.
			return position	
		}
		else {
			return self.posicionVaciaCentral()
		}
	}

	method posicionParaEnemigo(){
		const anchoYAlto = game.width()-1 // Para que esto funcione bien, en la config del juego width == height
		const mitadAnchoYAlto = anchoYAlto.div(2)
		return 	[game.at([mitadAnchoYAlto - 1, mitadAnchoYAlto, mitadAnchoYAlto + 1].anyOne(), [0, anchoYAlto].anyOne()),
				 game.at([0, anchoYAlto].anyOne(), [mitadAnchoYAlto - 1, mitadAnchoYAlto, mitadAnchoYAlto + 1].anyOne())].anyOne()
	}
}