img = tonemappedBilateral;
rectangleCenter = [660 410]
radius = 35;

figure; 
imshow(img); 
rectangle('Position',[rectangleCenter(1)-radius rectangleCenter(2)-radius 2*radius+1 2*radius+1], 'LineWidth',2, 'EdgeColor', [1 0 0]); 
hold on; %plot(rectangleCenter(1),rectangleCenter(2),'r.','MarkerSize',10)