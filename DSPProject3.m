# Michael Toon 10/15/24
# DSP Project #3 - Fall 2024

# This is a MATLAB/Octave based exercise. The objective of this exercise is to generate
# different digital signals and to investigate about their signal spectra and bandwidth using Discrete
# Fourier Transform.

clc; clear;

# SIGNAL 1 ---------------------------------------------------------------------------------------------------------------------------------------------

# Randomly generate white noise
x = 5*randn(1, 4096);  # Multiplying randn function by standard deviation of 5. Link: https://www.mathworks.com/help/matlab/math/random-numbers-with-specific-mean-and-variance.html

# Constants and variables needed
fs = 8000; ts = 1 / fs; N = 4096; n = [0:N-1]; t = ts*n; f = n * (fs/N);

# FFT of the generated signal
X = fft(x, N); magX = abs(X)/N;

# Plotting the signals
figure (1);
subplot(2,1,1);
stem([1:100], x([1:100])), xlabel('Sample'), ylabel('Amplitude'), title('Sampled Signal x(n) vs. n(stem)');
text(10, -10, sprintf('df = %f', f));
subplot(2,1,2);
plot(f,magX), xlabel('Frequency'), ylabel('Amplitude'), title('Frequency signals');

# Play a sound of the generated signal
sound(x/max(abs(x)),fs), pause(0.5);

# SIGNAL 2 ---------------------------------------------------------------------------------------------------------------------------------------------

# The following signals were given with the constraint of a time length of 1 second
t2 = [0:ts:1]; N2 = [1:30]; df=fs/(8000-1); # t2 is a vector of 0 to 1 but in units of the sampling time. The sampling frequency is still 8000 so no need to rewrite
                                            # Vector is established bc plot asks for first 30 samples

x2_1 = 5*cos(2*pi*500*t2);              # Note: 2pi is already removed from assigned signals to easily see frequency
x2_2 = 5*cos(2*pi*1200*t2+(0.25*pi));
x2_3 = 5*cos(2*pi*1800*t2+(0.5*pi));

sumx2 = x2_1+x2_2+x2_3;   # Sum of the three signals, jsut add

X2 = fft(sumx2); L2 = length(X2)-1; n = [0:L2]; magX2 = abs(X2/L2); f = n * (fs/N); # FFT and subsequent calculations, similar to some homework questions in CH 5

figure (2); # Plots (2 figures in total)
subplot(2,2,1);
plot(t2(N2),x2_1(N2)), xlabel('Time in sec'), ylabel('Amplitude'), title('x2_1 = 5*cos(2*pi*500*t)');
subplot(2,2,2);
plot(t2(N2),x2_2(N2)), xlabel('Time in sec'), ylabel('Amplitude'), title('x2_2 = 5*cos(2*pi*1200*t+.25*pi)');
subplot(2,2,3);
plot(t2(N2),x2_3(N2)), xlabel('Time in sec'), ylabel('Amplitude'), title('x2_3 = 5*cos(2*pi*1800*t+.5*pi)');
subplot(2,2,4);
plot(t2(N2),sumx2(N2)), xlabel('Time in sec'), ylabel('Amplitude'), title('Summation of the 3 Signals');

figure(3)
subplot(2,1,1);
stem(n, magX2), xlabel('k'), ylabel('Amplitude'), title('Amplitude Spectrum X(k)'); # Fix y-axis for both
subplot(2,1,2);
plot(n*df, magX2), xlabel('f'), ylabel('Amplitude'), title('Amplitude Spectrum X(f)');
text (2000, 2, sprintf('500Hz, 1.2kHz, and 1.8kHz'))
text (2000, 1.5, sprintf('8000 - 500 = 7.5kHz, 8000 - 1.2kHz = 6.8kHz, and 8000 - 1.8kHz = 6.2kHz'))

# Play the sounds, 4th sound are all three original signals at the same time
sound(x2_1/max(abs(x2_1)),fs), pause(0.5);
sound(x2_2/max(abs(x2_2)),fs), pause(0.5);
sound(x2_3/max(abs(x2_3)),fs), pause(0.5);
sound(sumx2/max(abs(sumx2)),fs), pause(0.5);

# SIGNAL 3 ---------------------------------------------------------------------------------------------------------------------------------------------

# You can't handle the truth
[x3, fs] = audioread('speech.wav'); # Found this online which helped. Link: https://www.mathworks.com/matlabcentral/answers/534213-time-frequency-analysis-using-wav-file
t = [0:length(x3)-1]/fs;

# FFT
X3=fft(x3);
L3=length(X3)-1; n=[0:L3]; df = fs/L3;
magX3=abs(X3/L3);

# Plotting
figure(4);
subplot(2,1,1);
plot(t, x3), xlabel('Time'), ylabel('speech.wav'), title('Speech Waveform and its Amplitude Spectrum');
subplot(2,1,2);
plot(n*df, magX3), xlabel('Frequency'), ylabel('Amplitude'), title('Amplitude of the Frequency Spectrum vs. Frequency in Hz');

# Sound
sound(x3/max(abs(x3)),fs), pause(0.5);





