function [ rl ] = autocorrelation( data )

rl = conv( data, conj( data(end:-1:1) ) )./length(data);

end
