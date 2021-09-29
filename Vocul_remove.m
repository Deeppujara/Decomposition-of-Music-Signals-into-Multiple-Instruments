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

%plot
figure
plot(y); title('Normal music');
figure
plot(left_channel); title('Left Channel Output');
figure
plot(right_channel); title('Right Channel Output');
figure
plot(unvoiced_music); title('Unvoiced music');