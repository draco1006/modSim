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


}
