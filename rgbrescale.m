%rescales RGB image between 1% and 99% preserving hue
NAME='New Code Processed Images Stage1';
f = dir(fullfile(NAME,'*.tiff'));
num_files = length(f);
upper=[];
lower=[];
gfp_files=struct('name',{},'date',{},'bytes',{},'isdir',{},'datenum',{});
mor1_files=struct('name',{},'date',{},'bytes',{},'isdir',{},'datenum',{});
cd11_files=struct('name',{},'date',{},'bytes',{},'isdir',{},'datenum',{});

mkdir('Strio4 Rescaled Images 5'); %creates a new folder for processed images (used later)


for n=1:num_files
    g=strfind(f(n).name,'GFP');
    if ~isempty(g)
        gfp_files=[gfp_files;f(n)];
    end
    m=strfind(f(n).name,'MOR1');
    if ~isempty(m)
        mor1_files=[mor1_files;f(n)];
    end
    c=strfind(f(n).name,'CD11');
    if ~isempty(c)
        cd11_files=[cd11_files;f(n)];
    end
end
num_files=length(cd11_files);

%_______________gfp________________%
if ~isempty(gfp_files)
    num_files=length(gfp_files);
    for k = 1:num_files
        filename = gfp_files(k).name;
        img_rgb = imread(fullfile(NAME,filename));
        img_rgb = img_rgb(:,:,1:3);
        img = rgb2gray(img_rgb);    
        img_double = im2double(img);

        img_sort = sort(img_double(:));
        img_sort(find(img_sort==0)) = [];
        img_sort(find(img_sort==1)) = [];
        upper = [upper; img_sort(round(length(img_sort)))];
        lower = [lower; img_sort(1)];    
    end

    u=sort(upper);
    lower=sort(lower);
    highest = u(length(upper))
    lowest = lower(1)

    for j = 1:num_files
        filename = gfp_files(j).name;
        img_rgb = imread(fullfile(NAME,filename));
        img_rgb = img_rgb(:,:,1:3);
        img_rescaled = imadjust(img_rgb,[lowest; highest], [0; 1]);
        newname = strrep(filename, '.tiff','_rescaled.tiff');
        imwrite(img_rescaled,['Strio4 Rescaled Images 5/', newname], 'tiff');
    end
end

%__________________cd11_______________%
if ~isempty(cd11_files)
    upper=[];
    lower=[];

    for k = 1:num_files
        filename = cd11_files(k).name;
        img_rgb = imread(fullfile(NAME,filename));
        img_rgb = img_rgb(:,:,1:3);
        img = rgb2gray(img_rgb);    
        img_double = im2double(img);

        img_sort = sort(img_double(:));
        img_sort(find(img_sort==0)) = [];
        img_sort(find(img_sort==1)) = [];
        upper = [upper; img_sort(round(length(img_sort)))];
        lower = [lower; img_sort(1)];    
    end

    u=sort(upper);
    lower=sort(lower);
    highest = u(length(upper))
    lowest = lower(1)

    for j = 1:num_files
        filename = cd11_files(j).name;
        img_rgb = imread(fullfile(NAME,filename));
        img_rgb = img_rgb(:,:,1:3);
        img_rescaled = imadjust(img_rgb,[lowest; highest], [0; 1]);
        newname = strrep(filename, '.tiff','_rescaled.tiff');
        imwrite(img_rescaled,['Strio4 Rescaled Images 5/', newname], 'tiff');
    end
end

%__________________mor1________________%
if ~isempty(mor1_files)
    upper=[];
    lower=[];

    for k = 1:num_files
        filename = mor1_files(k).name;
        img_rgb = imread(fullfile(NAME,filename));
        img_rgb = img_rgb(:,:,1:3);
        img = rgb2gray(img_rgb);    
        img_double = im2double(img);

        img_sort = sort(img_double(:));
        img_sort(find(img_sort==0)) = [];
        img_sort(find(img_sort==1)) = [];
        upper = [upper; img_sort(round(length(img_sort)))];
        lower = [lower; img_sort(round(1))];    
    end

    u=sort(upper);
    lower=sort(lower);
    highest = u(length(upper))
    lowest = lower(1)

    for j = 1:num_files
        filename = mor1_files(j).name;
        img_rgb = imread(fullfile(NAME,filename));
        img_rgb = img_rgb(:,:,1:3);
        img_rescaled = imadjust(img_rgb,[lowest; highest], [0; 1]);
        newname = strrep(filename, '.tiff','_rescaled.tiff');
        imwrite(img_rescaled,['Strio4 Rescaled Images 5/', newname], 'tiff');
    end
end
