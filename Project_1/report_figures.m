clear; clc;
%% Figure 1
fs = 100; % Hz
duration = 20; % Seconds
[x,t] = gen.cplx_exp( [ 5, 10, -25 ], [0,0,0], [1,1,1], fs, duration );
NFFT = length( x );

f = (-fs/2:fs/NFFT:fs/2-fs/NFFT);
ff = fftshift( fft( x, NFFT ) );

figure()
subplot( 2,1,1)
plot( t, [real(x), imag(x)] );
xlabel('Time (s)' );
title( 'x[n]' )
subplot(2,1,2)
plot( f, mag2db( abs( ff ) ) );
ylabel('dB');
xlabel('Frequency (Hz)' );
title( 'fft(x[n]))' )

%% Figure 2
fs = 100; % Hz
duration = 20; % Seconds
x = gen.cwgn( 0, 10, fs*duration, 1);
NFFT = length( x );

f = (-fs/2:fs/NFFT:fs/2-fs/NFFT);
ff = fftshift( fft( x, NFFT ) );

figure()
subplot( 2,1,1)
plot( t, [real(x), imag(x)] );
xlabel('Time (s)' );
title( 'x[n]' )
subplot(2,1,2)
plot( f, mag2db( abs( ff ) ) );
ylabel('dB');
xlabel('Frequency (Hz)' );
title( 'fft(x[n]))' )

%% Figure 3
fs = 100; % Hz
duration = 20; % Seconds
[x,t] = gen.cplx_exp( [ 5, 10, -25 ], [0,0,0], [1,1,1], fs, duration);
x =  x + gen.cwgn( 0, 10, fs*duration, 1);

NFFT = length( x );

f = (-fs/2:fs/NFFT:fs/2-fs/NFFT);
ff = fftshift( fft( x, NFFT ) );

figure()
subplot( 2,1,1)
plot( t, [real(x), imag(x)] );
xlabel('Time (s)' );
title( 'x[n]' )
subplot(2,1,2)
plot( f, mag2db( abs( ff ) ) );
ylabel('dB');
xlabel('Frequency (Hz)' );
title( 'fft(x[n]))' )

%% Figure 4
fs = 100; % Hz
duration = 20; % Seconds
[x,t] = gen.cplx_exp( [ 5, 10, -25 ], [0,0,0], [1,1,1], fs, duration );
x =  x + gen.cwgn( 0, 10, fs*duration, 1);
psd.periodogram(x, fs, @windows.ones, true );

%% Figure 5
fs = 100; % Hz
duration = 20; % Seconds
[x,t] = gen.cplx_exp( [ 10, 10.1 ], [0,0], [1,1], fs, duration);
x =  x + gen.cwgn( 0, 10, fs*duration, 1);
psd.periodogram(x, fs, @windows.ones, true );
xlim([8,12])

%% Figure 4
fs = 100; % Hz
duration = 20; % Seconds
[x,t] = gen.cplx_exp( [ 5, 10, -25 ], [0,0,0], [1,1,1], fs, duration);
x =  x + gen.cwgn( 0, 10, fs*duration, 1);
psd.welch_bartlett(x, fs, @windows.ones,256, 128, true );
