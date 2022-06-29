function [results,rho,per] = fbcca_v2(eeg, list_freqs, fs, num_harms, num_fbs)
% Steady-state visual evoked potentials (SSVEPs) detection using the filter
% bank canonical correlation analysis (FBCCA)-based method [1].
%
% function results = test_fbcca(eeg, list_freqs, fs, num_harms, num_fbs)
%
% Input:
%   eeg             : Input eeg data
%                     (# of targets, # of channels, Data length [sample])
%   list_freqs      : List for stimulus frequencies
%   fs              : Sampling frequency
%   num_harms       : # of harmonics
%   num_fbs         : # of filters in filterbank analysis
%
% Output:
%   results         : The target estimated by this method
%
% Reference:
%   [1] X. Chen, Y. Wang, S. Gao, T. -P. Jung and X. Gao,
%       "Filter bank canonical correlation analysis for implementing a
%        high-speed SSVEP-based brain-computer interface",
%       J. Neural Eng., vol.12, 046008, 2015.
%
% Masaki Nakanishi, 22-Dec-2017
% Swartz Center for Computational Neuroscience, Institute for Neural
% Computation, University of California San Diego
% E-mail: masaki@sccn.ucsd.edu

if nargin < 3
    error('stats:test_fbcca:LackOfInput', 'Not enough input arguments.');
end

if ~exist('num_harms', 'var') || isempty(num_harms), num_harms = 3; end

if ~exist('num_fbs', 'var') || isempty(num_fbs), num_fbs = 5; end

fb_coefs = [1:num_fbs].^(-1.25)+0.25;

[ ~, num_smpls] = size(eeg);
y_ref = cca_reference(list_freqs, fs, num_smpls, num_harms);

for fb_i = 1:1:num_fbs
    testdata = FilterBank(eeg, fs, fb_i);
    for class_i = 1:1:length(list_freqs)
        refdata = squeeze(y_ref(class_i, :, :));
        [~,~,r_tmp] = canoncorr(testdata', refdata');
        r(fb_i, class_i) = r_tmp(1,1);
    end % class_i
end % fb_i
rho = fb_coefs*r;
[~, tau] = max(rho);
sort_rho = sort(rho);
per = sort_rho(7)/sort_rho(8);
results = tau;

