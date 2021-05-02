function [] = integralSolver()
    global int;
    int.fig=figure('numbertitle','off','name','Integral Solver');
    int.bg = uibuttongroup('Visible','off', 'Position',[.02 .93 .7 .07],'SelectionChangedFcn',@bselection);
    int.singint=uicontrol(int.bg,'style','radiobutton','units','normalized','position',[.02 .1 5 1],'string','Single Integral','HandleVisibility','off');
    int.doubint=uicontrol(int.bg,'style','radiobutton','units','normalized','position',[.5 .1 5 1],'string','Double Integral','HandleVisibility','off');
    int.bg.Visible = 'on';
    
        %The above creates a button group of radio buttions that toggles between
        %single and double integrals and uses a callback to toggle the
        %necessary UI elements
    
    int.funclabel=uicontrol('style','text','units','normalized','position',[.035 .8 .06 .1],'string','f(x)=','horizontalalignment','right');
    int.func=uicontrol('style','edit','units','normalized','position',[.15 .85 .2 .05],'horizontalalignment','left');
    int.xmaxlabel=uicontrol('style','text','units','normalized','position',[.01 .7 .1 .1],'string','upper x bound:','horizontalalignment','right');
    int.xmax=uicontrol('style','edit','units','normalized','position',[.15 .75 .2 .05],'horizontalalignment','left');
    int.xminlabel=uicontrol('style','text','units','normalized','position',[.01 .6 .1 .1],'string','lower x bound:','horizontalalignment','right');
    int.xmin=uicontrol('style','edit','units','normalized','position',[.15 .65 .2 .05],'horizontalalignment','left');
    
        %The above inserts the input boxes and corresponding labels  for
        %single integrals
    
    int.solve=uicontrol('style','pushbutton','units','normalized','position',[.4 .7 .2 .2],'string','Solve','horizontalalignment','center','callback',{@solve,int.func,int.xmax,int.xmin,0,0}); 
    
        %above is creates a solve button that uses a callback to the solve
        %function
    
    help='Instructions: Functions (including bounds for double integrals if necessary) must be inputed as function handles. If the bound of the inner variable of a double integral is a function of the outer, include it in the y bounds as a function of x and switch the variables accordingly. (i.e. x must be the outer variable and must have constant bounds)';
    int.intructions=uicontrol('style','text','units','normalized','position',[.37 .2 .6 .5],'string',help,'horizontalalignment','left');
    
    int.num=1; % int.num switches between one and two for single and double integrals and is used for checking whether to use integral or integral2
end

function [] = bselection(source, event)
    global int;
    if event.NewValue.String == 'Double Integral'
        int.ymaxlabel=uicontrol('style','text','units','normalized','position',[.01 .5 .1 .1],'string','upper y bound:','horizontalalignment','right');
        int.ymax=uicontrol('style','edit','units','normalized','position',[.15 .55 .2 .05],'horizontalalignment','left');
        int.yminlabel=uicontrol('style','text','units','normalized','position',[.01 .4 .1 .1],'string','lower y bound:','horizontalalignment','right');
        int.ymin=uicontrol('style','edit','units','normalized','position',[.15 .45 .2 .05],'horizontalalignment','left');
        int.funclabel=uicontrol('style','text','units','normalized','position',[.035 .8 .06 .1],'string','f(x,y)=','horizontalalignment','right');
        int.solve=uicontrol('style','pushbutton','units','normalized','position',[.4 .7 .2 .2],'string','Solve','horizontalalignment','center','callback',{@solve,int.func,int.xmax,int.xmin,int.ymax,int.ymin});  
        
        int.num=2;        
    elseif event.NewValue.String == 'Single Integral'
        delete(int.ymaxlabel)
        delete(int.ymax)
        delete(int.yminlabel)
        delete(int.ymin)
        int.solve=uicontrol('style','pushbutton','units','normalized','position',[.4 .7 .2 .2],'string','Solve','horizontalalignment','center','callback',{@solve,int.func,int.xmax,int.xmin,0,0});
        int.funclabel=uicontrol('style','text','units','normalized','position',[.035 .8 .06 .1],'string','f(x)=','horizontalalignment','right');
        
        int.num=1;
    end   
    
    %The above if function checks whether Single Integral or Double
    %Integral is selected and inserts, removes, and changes the UI elements
    %accordingly
end

function [] = solve(source, event, fun, xmax, xmin, ymax, ymin)
    global int;
    
    if ymax ~= 0 % The below if statement calls a dot index that is only defined when solving a double intergal, same for ymin
        
        if isempty(regexp(ymax.String,'(x)', 'once'))
            ymax=str2double(ymax.String);
        elseif ~isempty(regexp(ymax.String,'(x)', 'once'))
            ymax=str2func(ymax.String);      
        end
        
        %The above if statemen checks if the y bound is a constant or a 
        %function and changes the data type accordingly, same for ymin
    end
    
    if ymin ~= 0
        
        if isempty(regexp(ymin.String,'(x)', 'once'))
            ymin=str2double(ymin.String);
        elseif ~isempty(regexp(ymin.String,'(x)', 'once'))
            ymin=str2func(ymin.String);
        end

    end

    if int.num == 1
        integral(str2func(fun.String),str2double(xmin.String),str2double(xmax.String))
    elseif int.num == 2
        integral2(str2func(fun.String),str2double(xmin.String),str2double(xmax.String),ymin,ymax)
    end
        
end

