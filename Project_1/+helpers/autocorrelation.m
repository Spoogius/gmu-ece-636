function [ Rx ] = autocorrelation( data, segment_size )

numSeg = floor( size(data,1)/segment_size );
assert( numSeg >= segment_size );

Rx = zeros( segment_size, segment_size );

for segIdx = 0:numSeg-1
  x = data( (segIdx*segment_size) + [1:segment_size] );
  Rx = Rx + ( (1/numSeg) * ( x * (x') ) );
end

end
