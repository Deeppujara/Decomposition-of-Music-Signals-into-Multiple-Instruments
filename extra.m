clc;
clear all;               
close all;
S = input('Enter the name of song :');              
[y, fs] = audioread(S);                             %To read the Audio signal
[M, N] = size(y);                                   %To find out the length of Audio

if N == 1
    error('The music is not stereo');
elseif N > 2
    error('The audio has more than 2 channels');
end
%processingunvoiced_music
left_channel = y(:,1);                              %Output of left channel
right_channel = y(:,2);                             %Output of right channel
unvoiced_music = left_channel- right_channel;       %Output without voculs
for i=1:2
    U(:,i) = unvoiced_music(:,1);
end
filename = 'filename.wav'
audiowrite(filename,U,fs)

[a,fs]=audioread('filename.wav');                %To read the Audio signal
Length_audio=length(a);                          %To find out the length of Audio
df=fs/Length_audio;                      
frequency_audio=-fs/2:df:fs/2-df;
%To convert our signal from time domain to frequency domain.
FFT_audio_in=fftshift(fft(a))/length(fft(a)); 
fft_out=zeros([Length_audio 2]);
for i=1:Length_audio
    for j=1:2
        if abs(frequency_audio(i))>350 && abs(frequency_audio(i))<=1500
            fft_out(i,j)=FFT_audio_in(i,j);  %Filter operation
        end
    end
end
voice_fft=fftshift(fft_out)*length(fft(a));
%To convert our signal from frequency domain to time domain.
signal_out=ifft(voice_fft);

%plot
figure
plot(y); title('Normal music');
figure
plot(left_channel); title('Left Channel Output');
figure
plot(right_channel); title('Right Channel Output');
figure
plot(unvoiced_music); title('Unvoiced music');