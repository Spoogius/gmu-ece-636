function [ff,f] = periodogram( data, fs, window, do_plot )
    % Input:
    %   data: Real or complex column vector of signal data
    %   fs: Sample rate of data in Hz
    %   window: Callable function to generate a window for data. Must take
    %       a signle input, window(dim1)
    %   do_plot: Boolean flag to create plot or not

    NFFT = size(data,1);
    f = [-fs/2:fs/NFFT:fs/2-(fs/NFFT)];
    w = (-pi:(2*pi/NFFT):(pi)-(2*pi/NFFT)).';

    % FFT using matlab function for error checking
    %ff = (fftshift( fft( data .* window(size(data)), NFFT ) ).^2)./NFFT;
    
    ff = zeros( NFFT, 1 );
    for wIdx = 1:NFFT
        ff(wIdx) = (sum( data .* window(size(data,1)).*exp(-1i.*w.*(wIdx-1))).^2)./NFFT;
    end
    ff = abs( fftshift( ff ) );

    if( do_plot )
        figure()
        plot( f, mag2db( ff ) );
        xlabel('Freq (Hz)');
        ylabel('dB' );
    end

end