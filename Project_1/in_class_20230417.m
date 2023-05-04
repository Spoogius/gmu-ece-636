clear; clc;
% Music estimater

fs = 1000;

% Segment period cant be multiple of period of complex sinusoids
N = 52;

t0 = ( 0:1/fs:2000-1/fs);
t1 = ( 2000:1/fs:4000-1/fs);

% Signals should not have the same phase
sig = exp( j.*2.*pi.*t0.*300).';
sig = [sig; exp( j.*2.*pi.*t1.*360 + (pi/5)).'];
sig = sig + gen.cwgn( 0, 0.5, size(sig,1), 1 );

Rx = helpers.autocorrelation( sig, N);

[ eVec, eVal ] = eig( Rx );
eVals = diag( eVal );
[ eVals, eIndex ] = sort( eVals );

numSignals = 2;

w = (0:2*pi/N:2*pi-(2*pi/N) );

for wIdx = 1:N
    v = exp(1i.*w(wIdx).*((0:N-1)));
    ff( 1:N, wIdx ) = v*eVec(:,1:end-numSignals)*eVec(:,1:end-numSignals)'*v';
end
%ff = fftshift( fft( eVec(:, eIndex(end-(numSignals-1):end) ) ) );

NFFT = N;
f = (-fs/2:fs/NFFT:fs/2-fs/NFFT);
plot( f, mag2db( abs( 1./mean(ff,1) )) );