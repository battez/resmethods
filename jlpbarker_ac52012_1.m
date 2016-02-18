% assignment 1 - Research Methods AC52012
% Student: John Luke Barker

% Import data from spreadsheet----------
% Script for importing data from the following (must be in path) Excel doc:
%
%    Workbook: StudentMarks.xls
%    Worksheet: Sheet

% Import the data
[~, ~, raw] = xlsread('StudentMarks.xls','Sheet1','A2:A82');

% store our data
marks = reshape([raw{:}],size(raw));

% Clear temporary variables / figures
clearvars raw;
close all; 

% for convenience: string separator
sep = {' '}; 

% our sample size
n = length(marks);

%
% 1 - plot histogram showing shape of dist. of 81 students.
% -- we will compare two histograms by overlaying
%
%  
figure;

% range chosen for simple divisibility and clarity and 
% including all data (i.e. outliers too)
% bin_width = (max(marks) - min(marks)) / 20


% NB use ceil to always have enough bins to include all data
hist_range = min(marks):5:max(marks);
bins = 1:20;
h = hist(marks, 5*bins)

return
set(h,'facecolor', [0 1 0], 'FaceAlpha', 0.9);


figure;
% alternative histogram bin choice, overlaid
% Freedman-Diaconis for normal dists and outlier-friendly:

bin_width = ceil(iqr(marks) / nthroot(n, 3))
% bin_width = 2*IQR(X(:))*numel(X)^(-1/3)
hist_range = min_range:bin_width:max_range;

j = histogram(marks, 'BinMethod','fd')
set(j,'facecolor',[0 0 1], 'FaceAlpha', 0.5);



% tidy up the display of the histogram:
title({'Distribution Shape for n=81,'; 'Sample of Student Marks'})
xlabel('Mark')
ylabel('Frequency')
ylim([0 20])

ax = gca;
ax.XTick = [0:5:100];


% 2 - summary statistics
% sample mean: sum(marks)/n
mean_value = mean(marks)

% sample variance: sum((marks-mean_value).^2 /(n-1))
variance = var(marks)

% sample std: sqrt(sum((marks-mean_value).^2 /(n-1)))
standard_deviation = std(marks)

% q3 - sampling
% take 1000 rand samples size 10 from sample
n_sub = 40; % number in each subsample
max_samples = 1000; % max number of samples to take
Means = []; % store our means here

% calculate mean of each
for times = 1:max_samples
    
    y = randsample(marks, n_sub, true);
    
    mu = mean(y);
  
    % append to our Means vector
    Means = [Means mu];

end;

% plot hist of this sampling distribution
figure;
title(strcat('Plotting subsamples of ', sep, num2str(n_sub)));
hsub = histogram(Means, 20);
set(hsub,'facecolor',[0 1 0]);

disp('exiting')
return

mumu = mean(Means)
stdmu = std(Means)
varmu = var(Means)

title( strcat( 'Mean of', SEP, num2str(m), SEP, ... 
    'sample means:', SEP, num2str(mumu) ) );

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