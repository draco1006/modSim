module lib::Probability {

	my sub fac ( Int $n ) {
		[*] 1 .. $n
	};

	sub poisson( $lambda, int $numeroEstampas) is export {#falta volverla acumulativa
		my $rango = 1 .. $numeroEstampas;
		my @poisson;
		@poisson[0] = 0;
		for 1..$numeroEstampas {
			@poisson[$_] = ( exp($_) / ( fac($_) * ( 0 .. $numeroEstampas ).map({
				( exp($_, $lambda) ) / fac($_)
			}).sum ) )+ @poisson[$_-1];
		}

	}

	sub geometrica( int $numeroEstampas ,int $probabilidadExito ) {#falta volverla acumulativa
		my @geometrica;
		my $rango = 1 .. $numeroEstampas;
		@geometrica[0] = 0;
		for 1..^$numeroEstampas -> $i {
			@geometrica[$i] = (( 1 - $probabilidadExito ) ** ( $i - 1 ) * $probabilidadExito) + @geometrica[$i-1];
		}
		@geometrica[$numeroEstampas] = 1;
		return @geometrica
	}
	#TODO Falta establecer el truncamiento
	#hacer enum para truncamiento
	#Esta mal, esta la de densidad no la acumulada


}
