module lib::Probability {

	my sub fac ( Int $n ) {
		[*] 1 .. $n
	};

	sub poisson( $lambda, int $numeroEstampas, int $exclusion, int $truncada ) is export {
		my $rango = 1 .. $numeroEstampas;
		given $exclusion {
			when 0 { #exlusion de 0
				( $rango.map({ ( exp(-$lambda) * exp($_, $lambda) ) / ( fac($_) * ( 1 - exp(-$lambda) ) ) }) ).lazy;
			}
			when 1 { #truncada por la derecha
				( $rango.map({ exp($_) / ( fac($_) * ( 0 .. $truncada ).map({
					( exp($_, $lambda) ) / fac($_)
				}).sum ) }) ).lazy;
			}
			when 2 { #truncada por la izquierda
				( $rango.map({ exp($_) / ( fac($_) * ( $truncada .. $numeroEstampas ).map({
					( exp($_, $lambda) ) / fac($_)
				}).sum ) }) ).lazy;
			}
		}
	}

	sub geometrica( int $numeroEstampas ,int $probabilidadExito ) {
		my $rango = 1 .. $numeroEstampas;
		return ( $rango.map({ ( 1 - $probabilidadExito ) ** ( $_ - 1 ) * $probabilidadExito }) ).lazy
	}
	#TODO Falta establecer el truncamiento
	#hacer enum para truncamiento
	#Esta mal, esta la de densidad no la acumulada


}
