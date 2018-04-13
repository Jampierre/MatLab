clc;
clear;
close all;
load dados_prontos.mat

Inputs = Data(:,1:42)';
Targets = Data(:,end)';
