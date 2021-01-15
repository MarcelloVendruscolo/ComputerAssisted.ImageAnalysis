%% Question 1
NapoleonImage = imread('images/napoleon.png');

%imtool(NapoleonImage)
graylevel_value = NapoleonImage(1,1);
disp(graylevel_value)

%% Question 2
NapoleonImage_light = imread('images/napoleon_light.png');
NapoleonImage_dark = imread('images/napoleon_dark.png');

[counts,binLocations] = imhist(NapoleonImage);
[counts_light,binLocations_light] = imhist(NapoleonImage_light);
[counts_dark,binLocations_dark] = imhist(NapoleonImage_dark);

plot(binLocations, counts, 'r-');
hold on;
plot(binLocations_light, counts_light, 'b-');
plot(binLocations_dark, counts_dark, 'g-');
grid on;
legend_original = 'NapoleonImage Original';
legend_light = 'NapoleonImage Light';
legend_dark = 'NapoleonImage Dark';
legend({legend_original,legend_light,legend_dark});

%% Question 6
g_double = 2;
g_half = 0.5;
gammaDouble = double(NapoleonImage).^g_double;
gammaHalf = double(NapoleonImage).^g_half;
napoleon_gammaDouble = uint8(L .* (255/max(max(gammaDouble))));
napoleon_gammaHalf = uint8(L .* (255/max(max(gammaHalf))));

[counts,binLocations] = imhist(NapoleonImage);
[counts_doube,binLocations_double] = imhist(napoleon_gammaDouble);
[counts_half,binLocations_half] = imhist(napoleon_gammaHalf);

plot(binLocations, counts, 'r-');
hold on;
plot(binLocations_double, counts_doube, 'b-');
plot(binLocations_half, counts_half, 'g-');
grid on;
legend_original = 'Original';
legend_double = 'Gamma = 2';
legend_half = 'Gamma = 0.5';
legend({legend_original,legend_double,legend_half});

%% Question 8
I = imread('images/cameraman.png');
Jnf = imresize(I, [78 78], 'nearest', 'antialiasing', false);
Jnt = imresize(I, [78 78], 'nearest', 'antialiasing', true);
Jbf = imresize(I, [78 78], 'bilinear', 'antialiasing', false);
Jbt = imresize(I, [78 78], 'bilinear', 'antialiasing', true);

subplot(1,4,1), imshow(Jnf); title('nearest,false');
subplot(1,4,2), imshow(Jnt); title('nearest,true');
subplot(1,4,3), imshow(Jbf); title('biliean,false');
subplot(1,4,4), imshow(Jbt); title('bilinear,true');

%% Question 10
Brain_One = imread('images/brain1.png');
Brain_Two = imread('images/brain2.png');

number_images = 2;
Standard_Brain = (1/number_images)*(single(Brain_One)+single(Brain_Two))/255;

Brain_Three = imread('images/brain3.png');
Brain_result = (single(Brain_Three)/255) - Standard_Brain;

subplot(1,3,1), imshow(Brain_One); title('brain1.png');
subplot(1,3,2), imshow(Brain_Two); title('brain2.png');
subplot(1,3,3), imshow(Standard_Brain); title('Mean image');

%% Question 13

wrench_orginal = imread('images/wrench.png');
wrench_rotated_interpolation = imrotate(wrench_orginal,20,'bilinear');
wrench_rotated_no_interpolation = imrotate(wrench_orginal,20);
subplot(1,3,1), imshow(wrench_orginal); title('Original Image');
subplot(1,3,2), imshow(wrench_rotated_interpolation); title('Bilinear Interpolation');
subplot(1,3,3), imshow(wrench_rotated_no_interpolation); title('Nearest Neighbour Interpolation');

%% Question 14
wrench_orginal = imread('images/wrench.png');
tstart1 = tic;
wrench_rotated_angle90 = imrotate(wrench_orginal,90,'bilinear');
telapsed1 = toc(tstart1);

tstart2 = tic;
wrench_rotated_angle137 = imrotate(wrench_orginal,137,'bilinear');
telapsed2 = toc(tstart2);

str1 = sprintf('The time taken for rotating image in 90 degrees was %0.5e',telapsed1);
str2 = sprintf('The time taken for rotating image in 137 degrees was %0.5e\n',telapsed2);

disp(str1)
disp(str2)

%% Question 15
original_tomo = imread('images/Tomo.jpg');
greyscale_tomo = rgb2gray(original_tomo);
resized_tomo = imresize(greyscale_tomo, [128 128], 'nearest', 'antialiasing', true);
resized_tomo = (single(resized_tomo))/255;
filtered_tomo = zeros(128,128);
filtered_tomo = single(filtered_tomo);

nrows = 128;
ncols = 128;

for x = 1:nrows
    for y = 1:ncols
        
        min_xk = x - 2;
        max_xk = x + 2;
        min_yk = y - 2;
        max_yk = y + 2;
        
        if min_xk < 1
            min_xk = 1;
        end
        if min_yk < 1
            min_yk = 1;
        end
        if max_xk > 128
            max_xk = 128;
        end
        if max_yk > 128
            max_yk = 128;
        end
        kernel_average = 0;
        for xk = min_xk:max_xk
            for yk = min_yk:max_yk
                kernel_average = kernel_average + (resized_tomo(xk,yk)/25);
            end
        end
        
        filtered_tomo(x,y) = kernel_average;
    end
end

difference_tomo = filtered_tomo - resized_tomo;

subplot(1,3,1),
imshow(resized_tomo);
title('Original Image');
subplot(1,3,2),
imshow(filtered_tomo);
title('Filtered Image');
subplot(1,3,3),
imshow(difference_tomo);
title('Subtracted Image');

%% Question 16

original_tomo = imread('images/Tomo.jpg');
greyscale_tomo = rgb2gray(original_tomo);
resized_tomo = imresize(greyscale_tomo, [516, 516], 'nearest', 'antialiasing', true);

equalised_image = histogram_equalise_8bits(resized_tomo);

subplot(1,3,1),
imshow(resized_tomo);
title('Original Image');
subplot(1,3,2),
imshow(equalised_image);
title('Equalised Image');
subplot(1,3,3),
histeq(resized_tomo);
title('MATLAB-equalised Image');