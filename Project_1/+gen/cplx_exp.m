function [signal, time] = cplx_exp( freqs, phases, amps, fs, duration, noise_variance )

    % Define time vector
    time = (0:duration*fs-1).'./fs;

    % Compute signal as sum of complex expontentials
    signal = sum( amps.*exp( j*2*pi*freqs.*time + phases ),2 );

    % Add complex noise
    signal = signal + gen.cwgn(0, noise_variance, length(signal), 1 );
end

