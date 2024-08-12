%% load image
I0 = imread("Cancer_cells.jpg");

%% load image R, G, B
IR = I0(:,:,1);
IG = I0(:,:,2);
IB = I0(:,:,3);

%% display RGB channels
figure, subplot(131), imshow(IR);
subplot(132), imshow(IG);
subplot(133), imshow(IB);

%% run myfirstimage function
myfirstimage("Dividing_cancer_cell.jpg", "gray");

%% myfirstimage function
function I1 = myfirstimage(filename, format)
    I1 = imread(filename);
    figure;
    if format == "bw"
        I1 = im2bw(I1);
        imshow(I1);
    elseif format == "ind"
        [I1, map] = rgb2ind(I1, 8);
        imshow(I1, map);
    elseif format == "gray"
        I1 = rgb2gray(I1);
        imshow(I1);
    else
        fprintf("unavailable");
    end
end