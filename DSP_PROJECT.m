clc;
clear all;
close all;
fprintf('1 = Drum\n2 = Guitar\n3 = Piano\n4 = Violin\n5 = Tabla\n');
I = input('Enter the value of I :');
if I < 6
    [a,fs]=audioread('filename.wav');                %To read the Audio signal
    Length_audio=length(a);                          %To find out the length of Audio
    df=fs/Length_audio;                      
    frequency_audio=-fs/2:df:fs/2-df;
    %To convert our signal from time domain to frequency domain.
    FFT_audio_in=fftshift(fft(a))/length(fft(a));    
    figure
    plot(frequency_audio,abs(FFT_audio_in));
    title('FFT of input Audio');                     %For Title
    xlabel('Frequency(Hz)');                         %For X-axis labeling 
    ylabel('Amplitude');                             %For Y-axis labeling
    fft_out=zeros([Length_audio 2]);
    if I == 1
        for i=1:Length_audio
            for j=1:2
                if abs(frequency_audio(i))>=0 && abs(frequency_audio(i))<=210
                    fft_out(i,j)=FFT_audio_in(i,j);  %Filter operation
                end
            end
        end
    elseif I == 2
        for i=1:Length_audio
            for j=1:2
                if abs(frequency_audio(i))>=400 && abs(frequency_audio(i))<=1200
                    fft_out(i,j)=FFT_audio_in(i,j);  %Filter operation
                end
            end
        end
    elseif I == 3
        for i=1:Length_audio
            for j=1:2
                if abs(frequency_audio(i))>=1200 && abs(frequency_audio(i))<=2000
                    fft_out(i,j)=FFT_audio_in(i,j);  %Filter operation
                end
            end
        end
    elseif I == 4
        for i=1:Length_audio
            for j=1:2
                if abs(frequency_audio(i))>=350 && abs(frequency_audio(i))<=660
                    fft_out(i,j)=FFT_audio_in(i,j);  %Filter operation
                end
            end
        end
        elseif I == 5
        for i=1:Length_audio
            for j=1:2
                if abs(frequency_audio(i))>=3000 && abs(frequency_audio(i))<=4000
                    fft_out(i,j)=FFT_audio_in(i,j);  %Filter operation
                end
            end
        end
    end
    figure
    plot(frequency_audio,abs(fft_out));
    title('FFT of output Audio');
    xlabel('Frequency(Hz)');
    ylabel('Amplitude');
    voice_fft=fftshift(fft_out)*length(fft(a));
    %To convert our signal from frequency domain to time domain.
    signal_out=ifft(voice_fft);
    figure
    plot(frequency_audio,signal_out);
else
    fprintf('Enter the appropriate value of I');
end