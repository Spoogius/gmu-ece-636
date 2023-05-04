function [ff, f] = music( data, fs, window_size, num_signals, do_plot )
    % Input:
    %   data: Real or complex column vector of signal data
    %   fs: Sample rate of data in Hz
    %   window_size: Number of samples to use per window when computing the
    %   auto correlation
    %   num_signals: The number of complex tones present in data
    %   do_plot: Boolean flag to create plot or not

    Rx = helpers.autocorrelation_matrix( data, window_size );
    [ eVec, eVal ] = eig( Rx );
    eVals = diag( eVal );
    [ eVals, eIndex ] = sort( eVals );

    NFFT = window_size;
    ff = zeros(NFFT,NFFT);
    f = [-fs/2:fs/NFFT:fs/2-(fs/NFFT)];

    w_range = [-pi:2*pi/NFFT:pi - (2*pi/NFFT)];
    for wIdx = 1:length( w_range )
        v = exp(1i.*w_range(wIdx).*((0:NFFT-1)));
        ff( 1:NFFT, wIdx ) = v*eVec(:,1:end-num_signals)*eVec(:,1:end-num_signals)'*v';
    end
    ff = fftshift( abs( 1./mean(ff,1) ) );

    if( do_plot )
        figure()
        plot( f, mag2db( ff ) );
        xlabel('Freq (Hz)');
        ylabel('dB' );
        title('Music');
    end

end

