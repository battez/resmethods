% assignment 1 - Research Methods AC52012
% Student: John Luke Barker

% Import data from spreadsheet----------
% Script for importing data from the following (must be in path) Excel doc:
%
%    Workbook: StudentMarks.xls
%    Worksheet: Sheet

%
% Import the data
[~, ~, raw] = xlsread('StudentMarks.xls','Sheet1','A2:A82');

% store our data
marks = reshape([raw{:}],size(raw));

% Clear  variables / figures
clearvars raw;
close all; 

% for convenience: string separator
sep = {' '}; 

% our sample size
n = length(marks);

%
% 1 - plot histogram showing shape of dist. of 81 students.
% -- we will compare two histograms with subplot.
figure;
subplot(1, 2, 1)

% range chosen for simple divisibility, clarity and 
% including all data (i.e. outliers as well); bin width = 5.
hist_range = min(marks):5:100; % set upper range as 100 for divisibility
h = histogram(marks, hist_range);

% tidy up the display of the figure:
title({'Distribution Shape,'; 'Sample of 81 Students'})
xlabel('Marks'); ylabel('No. Students'); ylim([0 30]);
set(h, 'facecolor', [0 1 0]);

% alternative histogram bin choice
% Scott method: 3.5*std(marks(:))*n^(-1/3).
subplot(1, 2, 2)
j = histogram(marks, 'BinMethod', 'scott');

% tidy up the display of the figure:
title({'With Bin Range Of Scott Method,'; 'Sample of 81 Students'})
xlabel('Marks'); ylabel('No. Students'); ylim([0 30]);
set(j, 'facecolor', [0 0 1]);




% 2 - summary statistics
% sample mean: sum(marks)/n
mu = mean(marks)

% sample variance: sum((marks-mean_value).^2 /(n-1))
variance = var(marks)

% sample std: sqrt(sum((marks-mean_value).^2 /(n-1)))
standard_deviation = std(marks)



% 3 - Random Sampling Means
% take 1000 rand samples size 10 from sample
n_sub = 10; % number in each subsample
random_sets = 3000; % max number of samples to take
Means = []; % store our means here

% calculate mean of each
for times = 1:random_sets
    
    y = randsample(marks, n_sub, true);
    
    mu = mean(y);
   
    Means = [Means mu];

end;

% plot histogram of this sampling distribution
figure;

% common histogram parameters:
xlimit = [45 90];
num_bins = 15;

% we will compare two histograms:
subplot(1, 2, 1)

hist_sub = histogram(Means, num_bins);
xlabel('Means');ylabel('Frequency');
xlim(xlimit);
set(hist_sub, 'facecolor', [1 1 0]);

m_var = var(Means);
dim = [.15 .6 .3 .3];
str = strcat('Variance', sep, num2str(m_var));
annotation('textbox',dim,'String',str,'FitBoxToText','on');

title(strcat('Sampling Distribution: ', sep, ...
    num2str(random_sets), ' Random Samples of', ...
    sep, num2str(n_sub)));

%
% 4 - repeat step 3 with larger sample
%
n_sub = 40; 
More_Means = [];

% calculate mean of each
for times = 1:random_sets
        
    y = randsample(marks, n_sub, true);
    
    mu = mean(y);
  
    More_Means = [More_Means mu];

end;

subplot(1, 2, 2)
hold on;

hist_sub_more = histogram(More_Means, num_bins);
xlabel('Means');ylabel('Frequency');
xlim(xlimit);
set(hist_sub_more, 'facecolor', [0 1 1]);

mm_var = var(More_Means);
dim = [.8 .6 .3 .3];
str = strcat('Variance', sep, num2str(mm_var));
annotation('textbox',dim,'String',str,'FitBoxToText','on');

title(strcat('Sampling Distribution: ', sep, ...
    num2str(random_sets), ' Random Samples of', ...
    sep, num2str(n_sub)));
plot([mean(More_Means) mean(More_Means)], get(gca,'ylim'));
hold off;
disp('exiting')
return

%%%HANDY!!!
% ax = gca;
% ax.XTick = [0:4:100];




% Q6: calculate n
N = 2000;
e = 0.03;
p = 0.3;
z = 1.96; % 5% conf on two tail test


% Q 7:
disp('bigger value')
e = 0.05

disp('smaller margin error')
e = 0.01