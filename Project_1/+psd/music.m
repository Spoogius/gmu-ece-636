function [ff, f] = m2( data, fs, window_size, num_signals, do_plot )
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
    [ eVals, eIndex ] = sort( eVals, 'descend' );
    eVec = eVec(:,eIndex);

    eVec_signal = eVec(:, 1:num_signals);
    eVec_noise  = eVec(:, num_signals+1:end);

    NFFT = window_size;
    f = [-fs/2:fs/NFFT:fs/2-(fs/NFFT)];

    w_range = ([-pi:2*pi/NFFT:pi - (2*pi/NFFT)]);
    for wIdx = 1:length( w_range )
        v = exp(-1i.*w_range(wIdx).*((0:NFFT-1)));
        ff( wIdx ) = v*eVec_noise*(eVec_noise')*(v');
    end
    ff = (1./abs(ff));

    if( do_plot )
        figure()
        subplot(2,1,1)
        plot( f, mag2db( ff ) );
        xlabel('Freq (Hz)');
        ylabel('dB' );
        title(sprintf('Music M = %d P = %d', window_size, num_signals ));
        subplot(2,1,2)
        plot(  eVals, 'o' );
        xlabel("Eigen Value Number" );
        ylabel("Eigen Value" );
        title("Music Eigen Values" );
    end

end

