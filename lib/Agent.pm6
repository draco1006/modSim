use Coleccion;

class lib::Agent {
	my int $.contador;

	has Coleccion $.chocolatinas is rw;
	has $!identidad;
	has Agent @!amigos;
	has @.probabilityTable;

	submethod TWEAK() {
		$!identidad = $.contador++;
	}

	method perceive(Agent \amigo) {
		append @!amigos, amigo;
	}

	method action() {
		for @!amigos -> $amigo {
			my $meFaltan = $amigo.chocolatinas.sobran (&) self.chocolatinas.faltan;
			if $meFaltan.elems > 0 {
				my $meSobran = $amigo.chocolatinas.faltan (&) self.chocolatinas.sobran;
				for ($meFaltan Z=> $meSobran) -> $intercambiamos {
					#aqui el intercambio de estampas
					$amigo.chocolatinas.add($intercambiamos.values);
					self.chocolatinas.remover($intercambiamos.values);
					#ahora el me da :v
					self.chocolatinas.add($intercambiamos.keys);
					$amigo.chocolatinas.remover($intercambiamos.keys);
				}
			}
		}
	}

	#`[TODO: i) Mediante una tabla y/o (ii) Mediante la especificación de una familia paramétrica
	(p.e. Geométrica truncada, Uniforme, Binomial, Poisson truncada, etc.).]

	method turno() {#modificar
		my $aleatorio = rand();
		for ^(@.probabilityTable.elems) -> $i {
			if @.probabilityTable[$i] > $aleatorio {
				$!chocolatinas.add($i)
			}
		}
	}

}