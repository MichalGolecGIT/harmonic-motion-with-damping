function mygui2
    clear variables;
    clc;
    close all;
    global h;
    colorHELP = [1 0.8 0.2]; % taki ładny pomarańcz
    colorBUTTON = [0.9 0.5 0.85]; % kolor guzików
    colorTEXT = [75/255 155/255 236/255]; % buckgroung napisów
    colorTITTLE = [75/255 236/255 155/255]; % kolor tytułu 


%tworzenie okna

    hight = 650;
    width = 800;
set(gcf, 'Position',  [100, 100, width, hight], 'Resize',"off");
fig = gcf;
fig.Name = 'Harmonic Motion with Damping by Golec and Kowal';
    % utworzenie pustego wykresu oraz wyświetlenie informacji

    h.a1 = axes('Units',"pixels",'Position',[60,60,600,500]); 
    h.author = uicontrol('Style','text','String',['          Author:' ...  
        '          Michal Golec 401013 Bartlomiej Kowal 407360 '], ...
        'Position',[670,40,120,60]);
    h.tittle = uicontrol('Style','text','String','Harmonic Motion with Damping', ...
        'Position', [60,590,600,50], 'FontSize',25, 'FontWeight','bold',FontAngle='italic',BackgroundColor=colorTITTLE);

    %wczytanie i wyswietlenie obrazka

    [x,map]=imread('obrazek1.png');
    image_height = 240;
    image_width = 120;
    I2=imresize(x, [image_height ,image_width]);
    f2=figure;
    imagesc(x);
    set(gca,'units','normalized','position',[0 0 1 1]);
    set(gcf,'units','pixels','position',[100 100 image_width image_height]); 
    I2=getframe(gca);
    I2=I2.cdata;
    close(f2)
    h.image=uicontrol('units','pixels','position',[670 420 image_width image_height],'cdata',I2);

    % wczytanie danych
    % text_x -> wyświetlanie tekstu dotyczacego zmiennej x
    % ed_x -> wczytanie zmiennej dotyczacej zmiennej x
    button_width = 120;


    h.text_m = uicontrol('Style','text','String','Mass value:', ...
        'Position',[670,380,button_width,20],'BackgroundColor',colorTEXT);
    h.ed_m = uicontrol('Style','Edit','String','25', ...
        'Position',[670,360,button_width,20],'Callback', ...
        'h.ed_m=str2num(get(gco,''String''));');
    h.text_b=uicontrol('Style','text','String','b value:', ...
        'Position',[670,340,button_width,20],'BackgroundColor',colorTEXT);
    h.ed_b = uicontrol('Style','Edit','String','1', ...
        'Position',[670,320,button_width,20],'Callback', ...
        'h.ed_b=str2num(get(gco,''String''));');   
    h.text_k=uicontrol('Style','text','String','k value:', ...
        'Position',[670,300,button_width,20],'BackgroundColor',colorTEXT);
    h.ed_k = uicontrol('Style','Edit','String','1', ...
        'Position',[670,280,button_width,20],'Callback', ...
        'h.ed_k=str2num(get(gco,''String''));'); 
    h.text_f=uicontrol('Style','text','String','f value:', ...
        'Position',[670,260,button_width,20],'BackgroundColor',colorTEXT);
    h.ed_f = uicontrol('Style','Edit','String','10', ...
        'Position',[670,240,button_width,20],'Callback', ...
        'h.ed_f=str2num(get(gco,''String''));'); 
    h.text_Tmax=uicontrol('Style','text','String','max time:', ...
        'Position',[670,220,button_width,20],'BackgroundColor',colorTEXT);
    h.ed_Tmax = uicontrol('Style','Edit','String','300', ...
        'Position',[670,200,button_width,20],'Callback', ...
        'h.ed_Tmax=str2num(get(gco,''String''));'); 

    % stworzenie button'ów/guzików

    h.pb1 = uicontrol('Style','Pushbutton','Position',[670,100,button_width,20], ...  guzik do wyświetlenia pomocy
        'String','HELP','Callback',@pomocy_ja_nie_chce_umierac, ...
        'BackgroundColor',colorBUTTON);
    h.pb2 = uicontrol('Style','Pushbutton','Position',[670,140,button_width,20], ...    guzik pozwalający rysować wykres ciężarka
        'String','DRAW','Callback',@plotki,'BackgroundColor',colorBUTTON);
    h.tb1 = uicontrol('Style','togglebutton','Position',[670,120,button_width,20], ...wyświetlanie siatki
        'String','GRID (ON/OFF)','Callback',@plotki,'BackgroundColor',colorBUTTON);

   


    function plotki(~,~)
        dane.m=str2num(get(h.ed_m,'String'));
        dane.b=str2num(get(h.ed_b,'String'));
        dane.f=str2num(get(h.ed_f,'String'));
        dane.k=str2num(get(h.ed_k,'String'));
        dane.Tmax=str2num(get(h.ed_Tmax,'String'));


        %dane testowe
        % dane.m=10;
        % dane.b=1;
        % dane.f=100;
        % dane.k=1;
        % dane.Tmax=750;

        





        result = main_projeckt_ciezarek(dane.m,dane.b,dane.k,dane.f,dane.Tmax);
        plot(result(:,1),result(:,2));

        if h.tb1.Value == true
            grid on;
        else
            grid off;
        end

    title("Displacement in Z direction");
    xlabel("Time [s]");
    ylabel("Displacement [m]");

    end
    function pomocy_ja_nie_chce_umierac(~,~)
        hight_help = 260;
        width_help = 400;
        figure2 = figure;

        set(figure2, 'Position',  [150, 150, width_help, hight_help], 'Resize',"off");
        
        uicontrol('Style','text', 'HorizontalAlignment','left',...
            'String',[newline,' In every edit text bar you need ' ...
            ' to put proper value to each variable',newline, ...
            ' for m ==> mass value',newline, ...
            ' for f ==> force value ',newline, ...
            ' for k ==> spring rate value',newline, ...
            ' for b ==> damping constant value',newline, ...
            ' for Tmax ==> max time value', newline,newline, ...
            ' and it is all, after it push button "DRAW" to draw a plot for yours parametters.', newline,newline ...
            ' If you want to show/hide grid push button "GRID ON/OFF" and it will happend.',newline,newline, ...
            ' Now have fun and draw nice plot!', newline, ...
            ' Good luck!'], ...
        'Position',[15,40,370,205],'BackgroundColor',colorHELP);
        



        close_button = uicontrol('Style','Pushbutton','Position',[150,10,100,20], ...    guzik pozwalający zamknąć okno pomocy
        'String','CLOSE','Callback',@close_Help,'BackgroundColor',colorBUTTON);    
        function close_Help(~,~)
            close(figure2);
        end
    end

end