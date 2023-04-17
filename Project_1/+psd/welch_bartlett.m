function [ff, f] = welch_bartlett( data, fs, window, NFFT, overlap_stride, do_plot )
    % Input:
    %   data: Real or complex column vector of signal data
    %   fs: Sample rate of data in Hz
    %   window: Callable function to generate a window for data. Must take
    %       a single input, window(dim1)
    %   NFFT: FFT size. In the context of welch-bartlett this is the
    %       segment size.
    %   overlap_stride: Number of samples per overlap. Must be <= NFFT. Overlap
    %       ratio = overlap_stride/NFFT
    %   do_plot: Boolean flag to create plot or not

    assert( overlap_stride <= NFFT );
    numSegments = ceil((size(data,1) ./ (overlap_stride) ));

    % Zero pad data for last segment
    data_padded = complex(zeros( numSegments.*NFFT, 1 ));
    data_padded( 1:size(data,1)) = data;


    ff = zeros( NFFT, 1 );
    for segIdx = 0:numSegments-1
        [ ff_new, f ] = psd.periodogram(...
                            data_padded((segIdx.*overlap_stride) + [1:NFFT]),...
                            fs, window, false );
        ff = ff + ff_new;                
    end
    ff = ff./numSegments;

    if( do_plot )
        figure()
        plot( f, mag2db( abs( ff ) ) );
        xlabel('Freq (Hz)');
        ylabel('dB' );
    end

end

