function [genNoise] = wgn(mean, var, dim1, dim2 )
    genNoise = mean + (sqrt(var).*randn(dim1,dim2));
end