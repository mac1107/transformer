%%
plot(x,y1,'-*',x,y2, '--*',x,y3,':*');
xlabel('线饼编号');
ylabel('电容/pF');
legend('无径向变形','存在一侧45度变形','存在两侧45度变形');
grid on;
%%
plot(x,y1,'-*',x,y2, '--*',x,y4,':*');
xlabel('线饼编号');
ylabel('电容/pF');
legend('无径向变形','存在一   侧45度变形','存在一侧60度变形');
grid on;