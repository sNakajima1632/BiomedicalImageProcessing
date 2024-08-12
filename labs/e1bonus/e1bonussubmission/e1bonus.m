Iorig = imread("US_contrast_agent.jpg");
I = imcrop(Iorig,[1 1 532 347]);

% resizes
Idown = imresize(I,1/4,"nearest");
Inear = imresize(Idown,16,"nearest");
Ibic = imresize(Idown,16,"bicubic");
Ilanc = imresize(Idown,16,"lanczos2");

% display on one figure
figure,subplot(231),imshow(I),title("original")
subplot(232),imshow(Idown),title("1/4")
subplot(234),imshow(Inear),title("nearest")
subplot(235),imshow(Ibic),title("bicubic")
hold on;
rectangle('Position', [1219 1083 178 119], 'EdgeColor','yellow')
annotation('textbox',[.5 .375 .1 .1],'String','Best','EdgeColor','none')
hold off;
subplot(236),imshow(Ilanc),title("lanczos2")

% accuracy check
Inear4 = imresize(Idown,4,"nearest");
Ibic4 = imresize(Idown,4,"bicubic");
Ilanc4 = imresize(Idown,4,"lanczos2");

% subtract from cropped image to get difference
Ineardiff = sum(I-Inear4,"all");
    % 814391
Ibicdiff = sum(I-Ibic4,"all");
    % 699565
Ilancdiff = sum(I-Ilanc4,"all");
    % 703585

figure,imshow(I-Ibic4),title("difference between original and bicubic interpolation")
