function [signal, times] = cplx_exp(freqs, phases, amps, fs, duration )
    
    times = (0:(duration*fs)-1).'/fs;
    signal = sum( amps.*exp(j*2*pi.*freqs.*times + phases ), 2);

end