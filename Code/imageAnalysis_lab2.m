%% Question 01:

%Creating lowpass/smoothing and highpass/sharpening filters
smoothing_filter3 = fspecial('average',3);
smoothing_filter7 = fspecial('average',7);
smoothing_filter31 = fspecial('average',31);
sharpening_filter3 = fspecial('log',3,0.5);
sharpening_filter7 = fspecial('log',7,0.5);
sharpening_filter31 = fspecial('log',31,0.5);

%Resulting images from convolving the different filters with the original
cameraMan_original = imread('images/cameraman.png');

cameraMan_smooth3 = imfilter(cameraMan_original,smoothing_filter3);
cameraMan_smooth7 = imfilter(cameraMan_original,smoothing_filter7);
cameraMan_smooth31 = imfilter(cameraMan_original,smoothing_filter31);

cameraMan_sharp3 = imfilter(cameraMan_original,sharpening_filter3);
cameraMan_sharp7 = imfilter(cameraMan_original,sharpening_filter7);
cameraMan_sharp31 = imfilter(cameraMan_original,sharpening_filter31);

%Plotting results
figure
subplot(1,3,1), imshow(cameraMan_original);title('Original Image');
subplot(1,3,2), imshow(cameraMan_smooth7);title('Smoothed Image');
subplot(1,3,3), imshow(cameraMan_sharp7);title('Sharpened Image');

figure
subplot(1,3,1), imshow(cameraMan_smooth3);title('3x3 Average Filter');
subplot(1,3,2), imshow(cameraMan_smooth7);title('7x7 Average Filter');
subplot(1,3,3), imshow(cameraMan_smooth31);title('31x31 Average Filter');

figure
subplot(1,3,1), imshow(cameraMan_sharp3);title('3x3 Log Filter');
subplot(1,3,2), imshow(cameraMan_sharp7);title('7x7 Log Filter');
subplot(1,3,9), imshow(cameraMan_sharp31);title('31x31 Log Filter');

%% Question 02:

%Creating 3 examples of low-pass/smoothing filters
smoothing_filter_average = fspecial('average',5);
smoothing_filter_disk = fspecial('disk',5);
smoothing_filter_gaussian = fspecial('gaussian',10,1.5);

%Original image
cameraMan_original = imread('images/cameraman.png');

%Resulting images from convolving the different filters with the original
cameraMan_smooth_average = imfilter(cameraMan_original,smoothing_filter_average);
cameraMan_smooth_disk = imfilter(cameraMan_original,smoothing_filter_disk);
cameraMan_smooth_gaussian = imfilter(cameraMan_original,smoothing_filter_gaussian);

%Plotting results
figure
subplot(2,2,1), imshow(cameraMan_original);title('Original Image');
subplot(2,2,2), imshow(cameraMan_smooth_average);title('Average Filter');
subplot(2,2,3), imshow(cameraMan_smooth_disk);title('Disk Filter');
subplot(2,2,4), imshow(cameraMan_smooth_gaussian);title('Gaussian Filter');

%% Question 3

%Original image.
cameraMan_original = imread('images/cameraman.png');

%Using the Average filter as the foundation to synthesize low-pass,
%band-pass and high-pass filtered images.
smoothing_filter_average = fspecial('average',5);
smoothing_filter_average2 = fspecial('average',50);

%Low-pass filtered image can be synthesized by filtering the image directly
%with the low-pass Average filters.
cameraMan_lowpass = imfilter(cameraMan_original,smoothing_filter_average);
cameraMan_lowpass2 = imfilter(cameraMan_original,smoothing_filter_average2);

%High-pass filtered image can be synthesized by subtracting the low-frequencies
%from the original image. This can be achieved by subtracting the
%cameraMan_lowpass image from the original image, remaining with high
%frequencies.
cameraMan_highpass = cameraMan_original - cameraMan_lowpass;

%Band-pass filtered image can be synthesized by subtracting the low and
%high frequencies from the original image. Note that two different sizes of
%smoothing filtering were utilised to get a difference
cameraMan_bandpass = (cameraMan_original- cameraMan_lowpass2 - cameraMan_highpass);

figure
subplot(1,3,1), imshow(cameraMan_lowpass); title('Low-pass Image');
subplot(1,3,2), imshow(cameraMan_bandpass); title('Band-pass Image');
subplot(1,3,3), imshow(cameraMan_highpass); title('High-pass Image');

%% Quesiton 4

%Original image
cameraMan_original = imread('images/cameraman.png');
wagon_original = imread('images/wagon.png');

%Creating the four variations of Sobel filter
sobel_horizontal_top = fspecial('sobel');
sobel_horizontal_bottom = rot90(sobel_horizontal_top,2);
sobel_vertical_left = sobel_horizontal_top';
sobel_vertical_right = sobel_horizontal_bottom';

resul_ht = imfilter(cameraMan_original,sobel_horizontal_top);
resul_hb = imfilter(cameraMan_original,sobel_horizontal_bottom);
resul_vl = imfilter(cameraMan_original,sobel_vertical_left);
resul_vr = imfilter(cameraMan_original,sobel_vertical_right);

resul2_ht = imfilter(wagon_original,sobel_horizontal_top);
resul2_hb = imfilter(wagon_original,sobel_horizontal_bottom);
resul2_vl = imfilter(wagon_original,sobel_vertical_left);
resul2_vr = imfilter(wagon_original,sobel_vertical_right);

figure
subplot(2,2,1), imshow(resul_ht); title('Sobel Horizontal-Top');
subplot(2,2,2), imshow(resul_hb); title('Sobel Horizontal-Bottom');
subplot(2,2,3), imshow(resul_vl); title('Sobel Vertical-Left');
subplot(2,2,4), imshow(resul_vr); title('Sobel Vertical-Right');

final_cameraman = resul_ht + resul_hb + resul_vl + resul_vr;
figure
imshow(final_cameraman); title('Summation of Sobel-filtered Images');

figure
subplot(2,2,1), imshow(resul2_ht); title('Sobel Horizontal-Top');
subplot(2,2,2), imshow(resul2_hb); title('Sobel Horizontal-Bottom');
subplot(2,2,3), imshow(resul2_vl); title('Sobel Vertical-Left');
subplot(2,2,4), imshow(resul2_vr); title('Sobel Vertical-Right');

final_wagon = resul2_ht + resul2_hb + resul2_vl + resul2_vr;
figure
imshow(final_wagon); title('Summation of Sobel-filtered Images');

%% Question 05:
wagon_shot_noise_original = imread('images/wagon_shot_noise.png');
wagon_shot_noise_m3 = medfilt2(wagon_shot_noise_original);
wagon_shot_noise_m7 = medfilt2(wagon_shot_noise_original,[7 7]);
wagon_shot_noise_m11 = medfilt2(wagon_shot_noise_original, [11 11]);

figure
subplot(2,2,1), imshow(wagon_shot_noise_original);title('Original Image');
subplot(2,2,2), imshow(wagon_shot_noise_m3);title('Median 3x3');
subplot(2,2,3), imshow(wagon_shot_noise_m7);title('Median 7x7');
subplot(2,2,4), imshow(wagon_shot_noise_m11);title('Median 11x11');

%% Question 06:
smoothing_filter_average = fspecial('average',5);
smoothing_filter_gaussian = fspecial('gaussian',5,0.83);

wagon_shot_noise_original = imread('images/wagon_shot_noise.png');
wagon_shot_noise_gaussian = imfilter(wagon_shot_noise_original,smoothing_filter_gaussian);
wagon_shot_noise_average = imfilter(wagon_shot_noise_original,smoothing_filter_average);
wagon_shot_noise_median = medfilt2(wagon_shot_noise_original, [5 5]);

figure
subplot(2,2,1), imshow(wagon_shot_noise_original);title('Original Image');
subplot(2,2,2), imshow(wagon_shot_noise_median);title('Median 5x5');
subplot(2,2,3), imshow(wagon_shot_noise_average);title('Mean 5x5');
subplot(2,2,4), imshow(wagon_shot_noise_gaussian);title('Gaussian 5x5');

%% Question 07:
wagon_shot_noise_original = imread('images/wagon_shot_noise.png');

smoothing_filter_average = fspecial('average',9);

start_time_average = tic;
a = imfilter(wagon_shot_noise_original,smoothing_filter_average);
elapsed_time_average = toc(start_time_average);

start_time_median = tic;
b = medfilt2(wagon_shot_noise_original,[9 9]);
elapsed_time_median = toc(start_time_median);

str1 = sprintf('The time taken for convolving the Average filter was %0.5e',elapsed_time_average);
str2 = sprintf('The time taken for convolving the Median filter was %0.5e\n',elapsed_time_median);

disp(str1)
disp(str2)

%% Question 09:
wagon_shot_noise_original = imread('images/wagon_shot_noise.png');

gaussian_filter_25_1 = fspecial('gaussian',25,1);
gaussian_filter_25_4 = fspecial('gaussian',25,4);
gaussian_filter_3_3 = fspecial('gaussian',3,3);
gaussian_filter_19_3 = fspecial('gaussian',19,3);

gaussian_25_1 = imfilter(wagon_shot_noise_original,gaussian_filter_25_1);
gaussian_25_4 = imfilter(wagon_shot_noise_original,gaussian_filter_25_4);
gaussian_3_3 = imfilter(wagon_shot_noise_original,gaussian_filter_3_3);
gaussian_19_3 = imfilter(wagon_shot_noise_original,gaussian_filter_19_3);

figure
subplot(2,2,1), imshow(gaussian_25_1);title('Gaussian 25x25 sig = 1');
subplot(2,2,2), imshow(gaussian_25_4);title('Gaussian 25x25 sig = 4');
subplot(2,2,3), imshow(gaussian_3_3);title('Gaussian 3x3 sig = 3');
subplot(2,2,4), imshow(gaussian_19_3);title('Gaussian 19x19 sig = 3');

%% Question 10
lines_original = imread('images/lines.png');
cameraman_original = imread('images/cameraman.png');
circle_original = imread('images/circle.png');
rectangle_original = imread('images/rectangle.png');

lines_transform = log(abs(fftshift(fft2(double(lines_original)))));
cameraman_transform = log(abs(fftshift(fft2(double(cameraman_original)))));
circle_transform = log(abs(fftshift(fft2(double(circle_original)))));
rectangle_transform = log(abs(fftshift(fft2(double(rectangle_original)))));

figure
subplot(1,2,1), imshow(lines_original); title('Original Lines.png');
subplot(1,2,2), imagesc(lines_transform); title('DFT Lines.png');

figure
subplot(1,2,1), imshow(cameraman_original); title('Original CameraMan.png');
subplot(1,2,2), imagesc(cameraman_transform); title('DFT CameraMan.png');

figure
subplot(1,2,1), imshow(circle_original); title('Original Circle.png');
subplot(1,2,2), imagesc(circle_transform); title('DFT Circle.png');

figure
subplot(1,2,1), imshow(rectangle_original); title('Original Rectangle.png');
subplot(1,2,2), imagesc(rectangle_transform); title('DFT Rectangle.png');

%% Question 11
frequency_odd_signal = fftshift(fft2(rand(1,5)));
frequency_even_signal = fftshift(fft2(rand(1,6)));

disp('Shifted odd frequency signal of size 5 before filtering:')
disp(frequency_odd_signal)
disp('Shifted even frequency signal of size 6 before filtering:')
disp(frequency_even_signal)

% Do filter here
frequency_odd_signal(1) = 0; frequency_odd_signal(5) = 0;
frequency_even_signal(2) = 0; frequency_even_signal(6) = 0;

% Transfer back to spatial domain from frequency domain
spatial_odd_signal = ifft2(ifftshift(frequency_odd_signal));
spatial_even_signal = ifft2(ifftshift(frequency_even_signal));

disp('Inverse Fourier transformed odd signal after filtering:')
disp(spatial_odd_signal)
disp('Inverse Fourier transformed even signal after filtering:')
disp(spatial_even_signal)

%% Question 12

cameraman_original = imread('images/cameraman.png'); %Original image spatial domain representation
original_shifted_freq_signal = fftshift(fft2(cameraman_original)); %Fourier Transform
highpass_shifted_freq_signal = original_shifted_freq_signal; %Create a copy of Fourier Transform result

[nrows, ncols] = size(highpass_shifted_freq_signal); %Compute size of the Fourier Transform matrix

%The next conditional block computes the middle row and column
if mod(nrows, ncols) == 0
    central_r = nrows/2 + 1;
    central_c = ncols/2 + 1;
else
    central_r = nrows/2;
    central_c = ncols/2;
end

highpass_shifted_freq_signal(central_r-20:central_r+20, central_c-20:central_c+20) = 0; %Highpass filtering
lowpass_shifted_freq_signal = original_shifted_freq_signal - highpass_shifted_freq_signal; %Lowpass by simple arithmetics
output_image = ifft2(ifftshift(lowpass_shifted_freq_signal)); %Inverse Fourier Transform back to spatial domain

imshow(uint8(output_image)) %Show result

%% Question 13

freqdist_original = imread('images/freqdist.png'); %Original image spatial domain representation
original_shifted_freq_signal = fftshift(fft2(freqdist_original)); %Fourier Transform
filtered = original_shifted_freq_signal;
[nrows, ncols] = size(original_shifted_freq_signal); %Compute size of the Fourier Transform matrix


for r = 1:nrows
    for c = 1:ncols
        if abs(original_shifted_freq_signal(r,c)) > 100000
            filtered(r,c) = 0;
        end
    end
end

output_image = ifft2(ifftshift(filtered));
imshow(uint8(output_image))