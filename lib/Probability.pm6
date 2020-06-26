module lib::Probability {

	my sub fac ( Int $n ) {
		[*] 1 .. $n
	};

	my sub combin ( $n, $x ) {
		return $n.&fac / ( $x.&fac * ( $n - $x ).&fac )
	}

	sub poisson( $lambda, int $numeroEstampas ) is export {
		my $rango = 1 .. $numeroEstampas;
		my @poisson;
		@poisson[0] = 0;
		for 1 .. $numeroEstampas {
			@poisson[$_] = ( exp($_) / ( fac($_) * ( 0 .. $numeroEstampas ).map({
				( exp($_, $lambda) ) / fac($_)
			}).sum ) ) + @poisson[$_ - 1];
		}
		return @poisson;
	}

	sub geometrica( int $numeroEstampas ,int $probabilidadExito ) is export {
		#falta volverla truncada
		my @geometrica;
		my $rango = 1 .. $numeroEstampas;
		@geometrica[0] = 0;
		for 1 ..^ $numeroEstampas -> $i {
			@geometrica[$i] = ( ( 1 - $probabilidadExito ) ** ( $i - 1 ) * $probabilidadExito ) + @geometrica[$i - 1];
		}
		@geometrica[$numeroEstampas] = 1;
		return @geometrica
	}
	#TODO Falta establecer el truncamiento
	sub uniforma( int $numeroEstamaps ) is export {
		my @uniforme;
		return ( 0 .. $numeroEstamaps ).map({ $_ / $numeroEstamaps });
	}

	sub binomial ( int $numeroEstampas, $probabilidadExito ) is export {
		my @binomial;
		@binomial[0] = ( 1 - $probabilidadExito ) ** $numeroEstampas;
		for 1 .. $numeroEstampas -> $i {
			@binomial[$i] = ( combin($numeroEstampas, $i) *
					$probabilidadExito ** $i *
					( 1 - $probabilidadExito ) ** ( $numeroEstampas - $i ) ) + @binomial[$i - 1];
		}
		@binomial
	}
}
