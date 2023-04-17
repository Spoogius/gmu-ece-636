function [outputArg1,] = welch_bartlett( data, fs, window, NFFT, overlap, do_plot )
    % Input:
    %   data: Real or complex column vector of signal data
    %   fs: Sample rate of data in Hz
    %   window: Callable function to generate a window for data. Must take
    %       two inputs, window(dim1, dim2)
    %   NFFT: FFT size. In the context of welch-bartlett this is the
    %       segment size.
    %   overlap: Number of samples per overlap. Must be <= NFFT. Overlap
    %       ratio = overlap/NFFT
    %   do_plot: Boolean flag to create plot or not

    
end

