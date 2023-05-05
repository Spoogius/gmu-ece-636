function [ff, f] = capon( data, fs, window_size, do_plot )
    % Input:
    %   data: Real or complex column vector of signal data
    %   fs: Sample rate of data in Hz
    %   window_size: Number of samples to use per window when computing the
    %   auto correlation
    %   do_plot: Boolean flag to create plot or not

    Rx = helpers.autocorrelation_matrix( data, window_size );

    NFFT = window_size;
    ff = zeros(NFFT,1);
    f = [-fs/2:fs/NFFT:fs/2-(fs/NFFT)];

    w_range = fftshift([0:2*pi/NFFT:2*pi - (2*pi/NFFT)]);
    for wIdx = 1:length( w_range )
        v = exp( j*w_range(wIdx)*[0:NFFT-1]).';
        ff( wIdx ) = NFFT/(v'*inv(Rx)*v);
    end
    ff = (abs(ff));

    if( do_plot )
        figure()
        plot( f, mag2db( ff ) );
        xlabel('Freq (Hz)');
        ylabel('dB' );
        title('Capon');
    end

end

