% Code adapted from:
% Salakhutdinov, R. and Hinton, G. Deep Boltzmann Machines. AISTATS, 2009.


function  [temp_h1, temp_h2] = ...
   mf_class(data,vishid,hidbiases,visbiases,hidpen,penbiases);

[numdim numhid]=size(vishid);
[numhid numpen]=size(hidpen);

  numcases = size(data,1);
  bias_hid= repmat(hidbiases,numcases,1);
  bias_pen = repmat(penbiases,numcases,1);
  big_bias =  data*vishid; 

 temp_h1 = 1./(1 + exp(-data*(2*vishid) - repmat(hidbiases,numcases,1)));
 temp_h2 = 1./(1 + exp(-temp_h1*hidpen - bias_pen));

 for ii= 1:50 
   totin_h1 = big_bias + bias_hid + (temp_h2*hidpen');
   temp_h1_new = 1./(1 + exp(-totin_h1));

   totin_h2 =  (temp_h1_new*hidpen + bias_pen);
   temp_h2_new = 1./(1 + exp(-totin_h2));

   diff_h1 = sum(sum(abs(temp_h1_new - temp_h1),2))/(numcases*numhid);
   diff_h2 = sum(sum(abs(temp_h2_new - temp_h2),2))/(numcases*numpen);
%     fprintf(1,'\t\t\t\tii=%d h1=%f h2=%f\r',ii,diff_h1,diff_h2);
     if (diff_h1 < 0.0000001 & diff_h2 < 0.0000001)
       break;
     end
   temp_h1 = temp_h1_new;
   temp_h2 = temp_h2_new;
 end

   temp_h1 = temp_h1_new;
   temp_h2 = temp_h2_new;



