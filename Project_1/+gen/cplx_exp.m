function [signal, times] = cplx_exp(freqs, phases, amps, fs, duration )
    
    % Define time vector
    times = (0:(duration*fs)-1).'/fs;
    
    % Compute signal as sum of complex expontentials
    signal = sum( amps.*exp(j*2*pi.*freqs.*times + phases ), 2);

end
