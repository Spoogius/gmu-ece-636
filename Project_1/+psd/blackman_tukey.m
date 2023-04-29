function [ff, f] = blackman_tukey( data, fs, window, window_size, do_plot )
    % Input:
    %   data: Real or complex column vector of signal data
    %   fs: Sample rate of data in Hz
    %   window: Callable function to generate a window for data. Must take
    %       a single input, window(dim1)
    %   window_size: Number of samples to use per window when computing the
    %   auto correlation
    %   do_plot: Boolean flag to create plot or not

    Rx = helpers.autocorrelation( data, window_size );
    Rx_windowed = Rx.*window(window_size);

    NFFT = window_size;
    ff = mean( abs( fftshift( fft( Rx_windowed,NFFT) ) ), 2 );
    f = [-fs/2:fs/NFFT:fs/2-(fs/NFFT)];

    if( do_plot )
        figure()
        plot( f, mag2db( ff./NFFT ) );
        xlabel('Freq (Hz)');
        ylabel('dB' );
    end

end

