class lib::Coleccion {
	has SetHash $.faltan;
	has BagHash $.sobran;

	multi method new(int \numeroEstampillas) {
		$.faltan .= new(1..numeroEstampillas);
		self.bless
	}
	method add(int \numeroEstampa) {
		when $!faltan.EXISTS-KEY(\numeroEstampa) {
			$!faltan{\numeroEstampa} = False
		}
		$!sobran{\numeroEstampa}++
	}

	method remover(int \numeroEstampa) {
		$!sobran{numeroEstampa}--;
	}
}
