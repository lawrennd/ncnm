function [y, X, yTest, XTest] = ncnmLoadData(dataset)

% NCNMLOADDATA Load a dataset.

% NCNM


switch dataset
  case 'threeFive'
   
   load ../data/usps_train
   X = ALL_DATA;
   y = ALL_T;
   load ../data/usps_test
   XTest = ALL_DATA;
   yTest = ALL_T;
   classTrue = 3;
   for i = [0 1 2 4 6 7 8 9];
     index = find(y == i);
     X(index, :) = [];
     y(index, :) = [];
     index = find(yTest == i);
     XTest(index, :) = [];
     yTest(index, :) = [];
   end
   y = (y == classTrue)*2 - 1;
   yTest = (yTest == classTrue)*2 - 1;
  case 'fourNine'
   
   load ../data/usps_train
   X = ALL_DATA;
   y = ALL_T;
   load ../data/usps_test
   XTest = ALL_DATA;
   yTest = ALL_T;
   classTrue = 4;
   for i = [0 1 2 3 5 6 7 8];
     index = find(y == i);
     X(index, :) = [];
     y(index, :) = [];
     index = find(yTest == i);
     XTest(index, :) = [];
     yTest(index, :) = [];
   end
   y = (y == classTrue)*2 - 1;
   yTest = (yTest == classTrue)*2 - 1;
 case 'thorsten'
  [y, X] = svmlread('c:\datasets\thorsten\example2\train_transduction.dat');
  [yTest, XTest] = svmlread('c:\datasets\thorsten\example2\test.dat');

end
