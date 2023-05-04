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

%% Figure 6
fs = 100; % Hz
duration = 20; % Seconds
[x,t] = gen.cplx_exp( [ 5, 10, -25 ], [0,0,0], [1,1,1], fs, duration);
x =  x + gen.cwgn( 0, 10, fs*duration, 1);
[ff_rect, f_rect ] = psd.welch_bartlett(x, fs, @windows.ones,128, 128, false );
[ff_hann, f_hann ] = psd.welch_bartlett(x, fs, @hanning, 128, 64, false );

figure()
subplot( 2,1,1 )
plot( f_rect, mag2db(ff_rect) );
xlabel("Frequency (Hz)")
ylabel("dB" )
title("Welch-Bartlett Rectangle Window" )

subplot( 2,1,2 )
plot( f_hann, mag2db(ff_hann) );
xlabel("Frequency (Hz)")
ylabel("dB" )
title("Welch-Bartlett Hanning Window" )

%% Figure 7
fs = 100; % Hz
duration = 20; % Seconds
[x,t] = gen.cplx_exp( [ 10, 10.1 ], [0,0], [1,1], fs, duration);
x =  x + gen.cwgn( 0, 10, fs*duration, 1);
psd.welch_bartlett(x, fs, @windows.ones, 128, 64, true );
xlim([8,12])

%% Figure 8
fs = 100; % Hz
duration = 2000; % Seconds
x =  gen.cwgn( 0, 1, fs*duration, 1);
[ff_p, f_p ] = psd.periodogram(x, fs, @windows.ones, false );
[ff_wb, f_wb ] = psd.welch_bartlett(x, fs, @windows.ones, 128, 64, false );

figure()
subplot( 2,1,1 )
plot( f_p, mag2db(ff_p) );
xlabel("Frequency (Hz)")
ylabel("dB" )
title("Periodogram" )
ylim([ -10+min( mag2db( ff_p )), 10+max( mag2db( ff_p ))]);

subplot( 2,1,2 )
plot( f_wb, mag2db(ff_wb) );
xlabel("Frequency (Hz)")
ylabel("dB" )
title("Welch-Bartlett Rectangle Window" )
ylim([ -10+min( mag2db( ff_wb )), 10+max( mag2db( ff_wb ))]);

%% Figure 9
fs = 100; % Hz
duration = 2000; % Seconds
x =  gen.cwgn( 0, 1, fs*duration, 1);
[ff_p, f_p ] = psd.periodogram(x, fs, @windows.ones, false );
[ff_wb, f_wb ] = psd.welch_bartlett(x, fs, @windows.ones, 128, 64, false );
[ff_c, f_c ] = psd.capon(x, fs, 128, false );

figure()
subplot( 3,1,1 )
plot( f_p, mag2db(ff_p) );
xlabel("Frequency (Hz)")
ylabel("dB" )
title("Periodogram" )
ylim([ -10+min( mag2db( ff_p )), 10+max( mag2db( ff_p ))]);

subplot( 3,1,2 )
plot( f_wb, mag2db(ff_wb) );
xlabel("Frequency (Hz)")
ylabel("dB" )
title("Welch-Bartlett Rectangle Window" )
ylim([ -10+min( mag2db( ff_wb )), 10+max( mag2db( ff_wb ))]);

subplot( 3,1,3 )
plot( f_c, mag2db(ff_c) );
xlabel("Frequency (Hz)")
ylabel("dB" )
title("Capon Window" )
ylim([ -10+min( mag2db( ff_c )), 10+max( mag2db( ff_c ))]);
