module lib::Probability {

	#Estoy generando el número equivocado de estampas :(
	my sub fac ( Int $n ) {
		[*] 1 .. $n
	};

	my sub combin ( $n, $x ) {
		return $n.&fac / ( $x.&fac * ( $n - $x ).&fac )
	}

	sub poisson( $lambda, int $numeroEstampas ) is export { # funciona!!!!!!!!!
		my $rango = 1 .. $numeroEstampas;
		my @poisson;
		@poisson[0] = 0;
		@poisson[0] = ( exp(0, $lambda) / ( fac(0) * ( 0 .. $numeroEstampas ).map({
			exp($_, $lambda)  / fac($_)
		}).sum ) );
		for 1 .. $numeroEstampas {
			@poisson[$_] = ( exp($_, $lambda) / ( fac($_) * ( 0 .. $numeroEstampas ).map({
				 exp($_, $lambda)  / fac($_)
			}).sum ) ) + @poisson[$_ - 1];
		}
		return @poisson;
	}

	sub geometrica( int $numeroEstampas , $probabilidadExito ) is export { # falta truncarlo
		#falta volverla truncada
		my @geometrica;
		my $rango = 1 .. $numeroEstampas;
		@geometrica[0] = 0;
		for 1 ..$numeroEstampas -> $i {
			@geometrica[$i] = ( ( 1 - $probabilidadExito ) ** ( $i - 1 ) * $probabilidadExito ) + @geometrica[$i - 1];
		}
		return @geometrica
	}

	sub uniforme( int $numeroEstamaps ) is export { # Obvio funciona :v, para uniforme se nescecita modificar gen rand
		my @uniforme;
		return ( 0 .. $numeroEstamaps ).map({ $_ / $numeroEstamaps });
	}

	sub binomial ( int $numeroEstampas, $probabilidadExito ) is export { # funciona!!!!!!
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
