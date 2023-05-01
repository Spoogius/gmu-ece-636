function [ff, f] = blackman_tukey( data, fs, window, do_plot )
    % Input:
    %   data: Real or complex column vector of signal data
    %   fs: Sample rate of data in Hz
    %   window: Callable function to generate a window for data. Must take
    %       a single input, window(dim1)
    %   do_plot: Boolean flag to create plot or not

    rl = helpers.autocorrelation( data );
    rl_windowed = rl.*window(size(rl,1));

    NFFT = length( rl_windowed );
    ff = abs( fftshift( fft( rl_windowed,NFFT) ) );
    f = [-fs/2:fs/NFFT:fs/2-(fs/NFFT)];

    if( do_plot )
        figure()
        plot( f, mag2db( ff./NFFT ) );
        xlabel('Freq (Hz)');
        ylabel('dB' );
    end

end

