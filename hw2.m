% problem(b)
X = load('X');
y = load('y');


[error,b]= pgdGroupLasso(X,y,0,1,4);
[aerror,ab]= pgdGroupLasso(X,y,1,1,4);
[lerror,lb]= pgdGroupLasso(X,y,0,0,0.35);
[alerror,alb]= pgdGroupLasso(X,y,1,0,0.35);
figure 
plot(error(1:50));
hold on;
plot(aerror(1:50));
plot(lerror(1:50));
plot(alerror(1:50));
hold off;

%problem(c)

movieGroups = load('moviesGroups');
movieTrain = load('moviesTrain');
movieTest = load('moviesTest');

[e,beta] = pgd2(groupTitles, groupLabelsPerRating, trainRatings, trainLabels,0,5,1000);
[ae,abeta] = pgd2(groupTitles, groupLabelsPerRating, trainRatings, trainLabels,1,5,1000);
[backe,backbeta] = backtracking(groupTitles, groupLabelsPerRating, trainRatings, trainLabels,5,400);

plot(log(e));
hold on;
plot(log(ae));
plot(log(abs(backe(1:1000))));
hold off;

[error,maxind] = test(groupTitles,groupLabelsPerRating,testRatings,testLabels,abeta);
groupTitles(maxind(16:19));
