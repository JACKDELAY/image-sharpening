%彩色图像的锐化处理
clc;
clear all;
close all;
addpath(fullfile('G:/stego of me/strict','JPEG_Toolbox'));
%f=imread('0.jpg'); 	%加载原图像
%f=imread('G:/stego of me/strict','tiger1', '1.jpg');
filepaths=dir(fullfile('G:/stego of me/strict', 'tiger1', '*.jpg'));  

for i=1:600
    
inputPath=fullfile('G:/stego of me/strict', 'tiger1',filepaths(i).name);    %确认输入路径
strictPath=fullfile('G:/stego of me/strict', 'tiger1strict',filepaths(i).name);    %确认输出路径
%path=filepaths(i).name;
%disp(inputPath)
f=imread(inputPath);                      %读入原图
%imshow(f);
%figure;imshow(f);title('原始图像');
fb=tofloat(f);  	%将图像转化为浮点型
%imshow(fb);
lapmask=[1 1 1;1 -8 1;1 1 1]; 	%拉普拉斯滤波模板
fen=fb-imfilter(fb,lapmask,'replicate');

imwrite(fen,strictPath)                    %输出瑞锐化图片
%figure;imshow(fen);title('增强后');
end
function [out,revertclass] = tofloat(inputimage)
%Copy the book of Gonzales
identify = @(x) x;
tosingle = @im2single;
table = {'uint8',tosingle,@im2uint8 
         'uint16',tosingle,@im2uint16 
         'logical',tosingle,@logical
         'double',identify,identify
         'single',identify,identify};
classIndex = find(strcmp(class(inputimage),table(:,1)));
if isempty(classIndex)                                  %空返回1，非空返回0
    error('不支持的图像类型');
end
out = table{classIndex,2}(inputimage);
revertclass = table{classIndex,3};
end
