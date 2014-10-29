% Script for Project-03
% Author: Michèle Wyss, 10-104-123

%% 1.a)

clear all;
N = 16;

% Define function handle f. For a given k,
% f(k) is a function handle to the anonymous function
% @(x) (cos(...)). Like this, it's easy to bind k to a certain value.
f = @(k,x) (@(x)(cos(x * 2 * pi * k * 1/N)));

for k = 1:16
    % Bind f to the given k. fk is the function handle of f with fixed
    % value k.
    fk = f(k);
    
    %%%%%%%%%%%%%%%%
    % Generate plot 
    %%%%%%%%%%%%%%%%
    subplot(4,4,k);
    
    % "Continuous" function
    fplot(fk,[0 N]); 
    hold on; 
    
    % Sampled function
    stem(fk(1:N));
    
    % Indicate the value of k in the title
    title(['k = ', num2str(k)]);
end

%% 1.b)
% From the plots in a) we can see that f hits Nyquist frequency at k = 8
% and therefore at w0 = (2pi*8)/N = (16pi)/16 = pi
