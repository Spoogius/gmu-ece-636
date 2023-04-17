function [ff,f] = periodogram( data, fs, window, do_plot )

    NFFT = size(data,1);
    f = [-fs/2:fs/NFFT:fs/2-(fs/NFFT)];
    w = (-pi:(2*pi/NFFT):(pi)-(2*pi/NFFT)).';

    % FFT using matlab function for error checking
    %ff = (fftshift( fft( data .* window(size(data)), NFFT ) ).^2)./NFFT;
    
    ff = zeros( NFFT, 1 );
    for wIdx = 1:NFFT
        ff(wIdx) = (sum( data .* window(size(data)).*exp(-1i.*w.*(wIdx-1))).^2)./NFFT;
    end
    ff = fftshift( ff );

    if( do_plot )
        figure()
        plot( f, mag2db( abs( ff ) ) );
        xlabel('Freq (Hz)');
        ylabel('dB' );
    end

end