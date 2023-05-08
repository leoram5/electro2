function [I] = escalar(I,r)
mini = min(min((I)));
maxi = max(max(I));
I = ((I-mini)./(maxi-mini))*r;
I = round(I);
end