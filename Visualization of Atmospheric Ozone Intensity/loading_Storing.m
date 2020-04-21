%This is the main function which is responsible for reading the files,
%compiling them and also plotting the figures into the GUI that is being
%used.

%This function takes two arguments as inputs: 
%integer x which is the number for the .csv file to be read. The .csv file
%is the excel format file.
%integer colourblind which is the number which gives a colour blindness number.

%The output of this function is the figure which is being plotted.

%%

function loading_Storing(x,colourblind)
    %The Data variable just defines the file name from which the program is
    %going to get the data from
    Data = "o3_surface_20180701000000.nc";

    %Storing the longitude and latitude from the file read into a single
    %array
    longitude = ncread(Data, "lon");
    latitude = ncread(Data, "lat");
    
    %%
    %The code which is given below is taken from the website. However it is a modified version of it:
    %https://matlab.fandom.com/wiki/FAQ#How_can_I_process_a_sequence_of_files.3F
    %Specify the folder where the files live in order for it to be read.
    myFolder = 'C:\Users\171207\Downloads\Desktop\Visualization of Atmospheric Ozone Intensity\24Hour';
    
    
    % Checks to make sure that folder actually exists.  Warn user if it doesn't.
    if ~isfolder(myFolder)
        errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
        uiwait(warndlg(errorMessage));
        return;
    end
        
    if x == 26                          %Defining x to not go further than 25, since there are only 25 files to read from
        x = 1;
    else if x == 0                      %Defining x to not go below 0, since there are only the positive number of files
            x = 1;
        end
    end
    
    % Get a list of all files in the folder with the desired file name pattern.
    filePattern = fullfile(myFolder, '24HR_CBE_*.csv'); %Reading every file which starts with 24HR_CBE and 
                                                        %ends with any number and .csv
    theFiles = dir(filePattern);                        %Getting the directory where .csv files are and storing that directory
                                                        %as theFiles variable
    baseFileName = theFiles(x).name;                    %Reading the base of the file which is the number indicated by t
    fullFileName = fullfile(myFolder, baseFileName);    %Reading full file name which starts with 
                                                        %the 24HR_CBE and ends with the number
    fprintf(1, 'Now reading %s\n', fullFileName);       %Printing which file is being read
    
    %%
    
    %Plotting the figure
    ozone = readmatrix(fullFileName);   %Storing the .csv file values as a matrix - [398:698]
    ozone(400,:) = [0];                 %Adding 0's to the end of the columns, where there are no values (from 399-400)
    ozone(:,700) = [0];                 %Adding 0's to the end of the rows, where there are no values (from 699-700)
    mymap = pcolor(longitude, latitude, ozone); %Plotting the colored map using pcolor function and storing as mymap
    mymap.EdgeAlpha = 0;                        %Removing the grids from the created map - mymap
    
    if x<=9
        title (['S  H  O  W  I  N  G    H  O  U  R   0',num2str(x-1),':00 ']);%Defining the map title 00-09
    else
        title (['S  H  O  W  I  N  G    H  O  U  R   ',num2str(x-1),':00 ']); %Defining the map title for 10-25
    end
    
    %Colours for colour blind people website: http://colorbrewer2.org/#type=sequential&scheme=BuGn&n=3
    %If statements which check in what colour the map should be displayed
    
    if colourblind == 2
        colormap default; %For people with normal vision
        
    elseif colourblind == 3
        colormap gray;    %For people with complete colour blindness 
        
    elseif colourblind == 4
        cm_inferno=inferno();
        colormap (cm_inferno); %Changes the color of the map to be dark red + orange
        
     elseif colourblind == 5
        cm_magma=magma();
        colormap (cm_magma); %Changes the color of the map to be purple, red + blue
        
    elseif colourblind == 6
        cm_plasma=plasma();
        colormap (cm_plasma); %Changes the color of the map to be yellowish green
        
    elseif colourblind == 7
        cm_viridis=viridis();
        colormap (cm_viridis); %Changes the color of the map to be red + orange
        
    elseif colourblind == 8
        cm_fake=fake_parula();
        colormap (cm_fake()); %Changes the color of the map to be more realistic
        
    end
    
    load coast;                         %Loading the coast coordinates (longitude as long and latitude as lat)
    hold on;                            %Holding the map created so that other plots can be plotted in the same figure
    s = plot(long,lat,'k');             %Plotting in the mymap another plot which  is s, which displays the borders of the 
                                        %overall map
    set(gca,'visible','on')             
    set(gca,'xtick',[])                 %Removes the displayed values in x coordinates 
    set(gca,'ytick',[])                 %Removes the displayed values in y coordinates
    set(gcf,'color',[0.84 0.91 0.92]);  %Changing the background color of the guide
end
