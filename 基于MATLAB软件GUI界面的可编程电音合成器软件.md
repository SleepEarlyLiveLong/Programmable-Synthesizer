
# <center><font face="宋体"> 基于MATLAB软件GUI界面的可编程电音合成器软件 </font></center>

*<center><font face="Times New Roman" size = 3> Author：[chentianyang](https://github.com/chentianyangWHU) &emsp;&emsp; E-mail：tychen@whu.edu.cn &emsp;&emsp; [Link]()</center>*

**概要：** <font face="宋体" size = 3> 本文基于MATLAB及其GUI界面设计了一个基可编程电音合成器软件。利用MATLAB的GUI控件及相关算法，实现了多种音色电子音的合成，做到了音长、音色、音调可控和显示的多样化。基本音调包含了钢琴88键的频率，音色可选范围有正弦、方波、锯齿波、四段包络的正弦波、KarplusStrong合成波等。另外，软件还实现了midi文件的编解码，用户可通过对midi数组的编程自行设计电音曲目。</font>

**关键字：** <font face="宋体" size = 3 >电音合成器；MATLAB; 可编程</font>

# <font face="宋体"> 1 总体设计 </font>

## <font face="宋体"> 1.1 设计思路</font>

&emsp;&emsp; <font face="宋体">软件首先设计了Synthesizer界面，将音频的音频显示坐标、频域显示坐标、数据输入输出界面集成到一起，实现电音合成与播放的基本功能；再设计子界面mymidi，通过该界面读取midi文件并播放。用户可以自行设计midi矩阵以实现个性化的设计。</font>

## <font face="宋体"> 1.2 软件运行</font>

&emsp;&emsp; <font face="宋体">本软件运行在MATLAB上，打开MATLAB，在工作路径下粘贴本软件源代码、和一个音频信号作为提示音，点击运行即可出现用户交互界面。通过操作界面内一系列按钮以及快捷键即可使用本软件。</font>

# <font face="宋体"> 2 软件功能说明 </font>

## <font face="宋体"> 2.1 软件界面</font>

&emsp;&emsp; <font face="宋体">设计了如图1和图2所示的显示界面：</font>

<center><img src="https://img-blog.csdn.net/20181018191215969?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2N0eXF5MjAxNTMwMTIwMDA3OQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70" width="75%">  </center><center><font face="宋体" size=2 > 图 1 软件显示界面(1) </font> </center>

<center><img src="https://img-blog.csdn.net/20181018191511819?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2N0eXF5MjAxNTMwMTIwMDA3OQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70" width="75%">  </center><center><font face="宋体" size=2 > 图2 软件显示界面(2) </font> </center>

### <font face="宋体" size = 4>2.1.1 菜单栏</font>

&emsp;&emsp; <font face="宋体">界面Synthesizer有6个下拉菜单</font>

&emsp;&emsp; <font face="宋体">“开始”菜单有2个子菜单，分别为“读取midi文件”和“创作midi文件”。点击“读取midi文件”后，弹出mymidi界面；点击“创作midi文件”后，显示出“创作一”和“创作二”子文件，分别对应另个midi曲目。如图3所示。</font>

<center><img src="https://img-blog.csdn.net/20181018191838722?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2N0eXF5MjAxNTMwMTIwMDA3OQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70" width="25%">  </center><center><font face="宋体" size=2 > 图3 “开始”菜单 </font> </center>

&nbsp;
&emsp;&emsp; <font face="宋体">“显示”菜单有8个子菜单，分别为“色彩”、“线型”、“线宽”、“标记点型”、“标记点边缘色”、“标记点表面色”、“标记点尺寸”和“恢复默认”。它们各自都有若干子菜单，作用是设置对应的图像属性。如图4所示。</font>

<table>
   <tr>
        <td ><center><img src="https://img-blog.csdn.net/20181018192313654?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2N0eXF5MjAxNTMwMTIwMDA3OQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70"  width="85%"> <font face="Times New Roman" size = 2> &ensp;&ensp;&ensp;&ensp;&ensp;&ensp;图4 （1） </font></center></td>
        <td ><center><img src="https://img-blog.csdn.net/20181018192352543?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2N0eXF5MjAxNTMwMTIwMDA3OQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70"  width="85%"><font face="Times New Roman" size = 2>&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;图4 （2） </font></center></td>
        <td ><center><img src="https://img-blog.csdn.net/20181018192416422?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2N0eXF5MjAxNTMwMTIwMDA3OQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70"  width="85%"><font face="Times New Roman" size = 2>&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;图4 （3） </font></center></td>
	</tr>
</table>

<table>
   <tr>
        <td ><center><img src="https://img-blog.csdn.net/20181018192516583?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2N0eXF5MjAxNTMwMTIwMDA3OQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70"  width="85%"> <font face="Times New Roman" size = 2> &ensp;&ensp;&ensp;&ensp;&ensp;&ensp;图4 （4） </font></center></td>
        <td ><center><img src="https://img-blog.csdn.net/20181018192543976?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2N0eXF5MjAxNTMwMTIwMDA3OQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70"  width="85%"><font face="Times New Roman" size = 2>&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;图4 （5） </font></center></td>
        <td ><center><img src="https://img-blog.csdn.net/20181018192605965?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2N0eXF5MjAxNTMwMTIwMDA3OQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70"  width="85%"><font face="Times New Roman" size = 2>&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;图4 （6） </font></center></td>
	</tr>
</table>

<table>
   <tr>
        <td ><center><img src="https://img-blog.csdn.net/20181018192647520?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2N0eXF5MjAxNTMwMTIwMDA3OQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70"  width="60%"> <font face="Times New Roman" size = 2> &ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;图4 （7） </font></center></td>
        <td ><center><img src="https://img-blog.csdn.net/2018101819270744?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2N0eXF5MjAxNTMwMTIwMDA3OQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70"  width="60%"><font face="Times New Roman" size = 2>    &ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;图4 （8） </font></center></td>
	</tr>
</table>

<center><font face="Times New Roman" size = 2>图4 “显示”菜单的8个子菜单</font></center>

&nbsp;
&emsp;&emsp; <font face="宋体">“音色”菜单设置所合成的单音音色，有5个子菜单，分别为“无包络锯齿波”、“无包络方波”、“无包络正弦”、“四段包络正弦”、“KarplusStrong合成”。如图5所示。</font>

<center><img src="https://img-blog.csdn.net/2018101819334188?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2N0eXF5MjAxNTMwMTIwMDA3OQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70" width="25%">  </center><center><font face="宋体" size=2 > 图5 “音色”菜单 </font> </center>

&nbsp;
&emsp;&emsp; <font face="宋体">“音高”菜单设置所合成的单音的音高，按照钢琴键盘的分类，将音高分为以下9个音组，也就是对应的子菜单，分别为：“大字二组”、“大字一组”、“大字组”、“小字组”、“小字一组”、“小字二组”、“小字三组”、“小字四组”、“小字五组”。如图6所示。</font>

<center><img src="https://img-blog.csdn.net/20181018193524965?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2N0eXF5MjAxNTMwMTIwMDA3OQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70" width="25%">  </center><center><font face="宋体" size=2 > 图6 “音高”菜单 </font> </center>

&nbsp;
&emsp;&emsp; <font face="宋体">“音长”菜单设置所合成的单音的音长，默认每个单音音符0.6s，每次改变0.1s，或增加或减少。如图7所示。</font>

<center><img src="https://img-blog.csdn.net/20181018193643626?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2N0eXF5MjAxNTMwMTIwMDA3OQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70" width="25%">  </center><center><font face="宋体" size=2 > 图7 “音长”菜单 </font> </center>

&nbsp;
&emsp;&emsp; <font face="宋体">“帮助”菜单有2个子文件夹，分别为“版本说明”和“使用说明”，分别介绍软件的基本情况。如图8所示。</font>

<center><img src="https://img-blog.csdn.net/20181018193758600?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2N0eXF5MjAxNTMwMTIwMDA3OQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70" width="25%">  </center><center><font face="宋体" size=2 > 图8 “帮助”菜单 </font> </center>

### <font face="宋体" size = 4>2.1.2 工具栏</font>

&emsp;&emsp; <font face="宋体">GUI的工具栏内有11个工具，它们从左到右依次是：“显示网格线”、“放大”、“缩小”、“数据游标”、“增加线宽”、“减小线宽”、“增加标记点尺寸”、“减小标记点尺寸”、“增加单音节时长”、“缩短单音节时长”和“恢复默认”。如图9所示。</font>

<center><img src="https://img-blog.csdn.net/20181018193948826?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2N0eXF5MjAxNTMwMTIwMDA3OQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70" width="25%">  </center><center><font face="宋体" size=2 > 图9 工具栏 </font> </center>

&nbsp;
&emsp;&emsp; <font face="宋体">“显示网格线”工具的功能是在时域频域图中显示或隐藏网格线；</font>

&emsp;&emsp; <font face="宋体">“放大”、“缩小”工具的功能是缩放图像。</font>

&emsp;&emsp; <font face="宋体">“数据游标”工具的功能是显示波形图中各点的横纵坐标。</font>

&emsp;&emsp; <font face="宋体">“增加线宽”、“减小线宽”、“增加标记点尺寸”、“减小标记点尺寸”、“增加单音节时长”、“缩短单音节时长”和“恢复默认”工具的功能对应的菜单功能相同。</font>

### <font face="宋体" size = 4>2.1.3 MySynthesizer界面</font>

&emsp;&emsp; <font face="宋体">MySynthesizer界面有2个坐标轴，一个参数显示框和一组单音节键盘框，2个坐标轴分别显示当前合成的单音的时域、频域波形；参数显示框显示当前合成的单音的频率值、所属音组、音色、音长、显示线宽和标记点尺寸等参数；单音组键盘有12个按键可选，表示待合成的按键音。通过对音色、音长等参数的选择，可以合成多音色、多频率、多音长的单音，还可以通过对显示参数的选择从多角度观察信号。其中，KarplusStrong合成算法对高频音的合成效果不佳，因此，当选择此音色时，设置高频音组“小字三组”、“小字四组”和“小字五组”为无效。由于KarplusStrong合成算法的特殊性，对于同一音符会有多种频谱，但是其基音频率都是相同的。</font>

### <font face="宋体" size = 4>2.1.4 mymidi界面</font>

&emsp;&emsp; <font face="宋体">点击“开始”->“读取midi文件”之后会弹出mymidi界面。</font>

&emsp;&emsp; <font face="宋体">mymidi界面有2个菜单、2个工具和2张坐标。</font>

&emsp;&emsp; <font face="宋体">“打开”菜单为读取.mid文件，并将其解码为一个一维数组，并包含有音轨、声道、采样率等基本音频信息。同时，解码得到的信号将在第一张坐标（上侧）上显示，在第二张坐标（下侧）上显示其对应的自动打孔纸卷图，颜色代表了每个音符的响度。</font>

&emsp;&emsp; <font face="宋体">“合成音色”有5个子菜单，设置读取并解码的音频文件的合成音色。如图10所示。</font>

<center><img src="https://img-blog.csdn.net/20181018194459654?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2N0eXF5MjAxNTMwMTIwMDA3OQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70" width="25%">  </center><center><font face="宋体" size=2 > 图10 mymidi界面的“合成音色”菜单 </font> </center>

&nbsp;
&emsp;&emsp; <font face="宋体">工具栏中有2个工具，分别为“保存音频”和“播放”。其中“保存音频”工具将读取的.mid文件保存为一般音频文件.wav格式，“播放”工具用以播放解码后的音频。</font>

## <font face="宋体"> 2.2 所需文件</font>

&emsp;&emsp; <font face="宋体">运行本软件需要至少18个文件：15个源代码文件，2个GUI图形界面文件和至少1个midi文件。如图11所示：</font>

<center><img src="https://img-blog.csdn.net/20181018194739368?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2N0eXF5MjAxNTMwMTIwMDA3OQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70" width="25%">  </center><center><font face="宋体" size=2 > 图11 软件运行所需文件 </font> </center>

&nbsp;
&emsp;&emsp; <font face="宋体">其中，.m文件是源代码文件，.fig文件是图形界面文件，.mid是midi文件。</font>

## <font face="宋体"> 2.3 软件运行效果</font>

&emsp;&emsp; <font face="宋体">软件可调参数丰富，包括音长、音高、音色和多样化的显示参数。下面将作简要演示。</font>

### <font face="宋体" size = 4>2.3.1 单音合成效果</font>

&emsp;&emsp; <font face="宋体">图12到图15展示的是在不同音长、音色、音高和不同显示模式下的单音的时域频域图像。</font>

&emsp;&emsp; <font face="宋体">图12：音长1.2s，四段包络正弦波，小字一组c1键（261.626Hz），波形蓝色，线宽0.5；无标记点；</font>

&emsp;&emsp; <font face="宋体">图13：音长0.2s，四段包络正弦波，大字一组C1键（32.703Hz），波形蓝色，线宽1.5；有标记点，标记点型为向上的三角，尺寸为4，色彩为蓝色；</font>

<center><img src="https://img-blog.csdn.net/20181018195053397?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2N0eXF5MjAxNTMwMTIwMDA3OQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70" width="75%">  </center><center><font face="宋体" size=2 > 图12 </font> </center>

<center><img src="https://img-blog.csdn.net/20181018195155435?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2N0eXF5MjAxNTMwMTIwMDA3OQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70" width="75%">  </center><center><font face="宋体" size=2 > 图13 </font> </center>

&nbsp;
&emsp;&emsp; <font face="宋体">图14：音长0.5s，KarplusStrong合成，大字一组E1键（41.203Hz），波形红色，线宽0.5，有标记点，标记点型为圆圈，尺寸为2，色彩为蓝色；</font>

&emsp;&emsp; <font face="宋体">图15：音长0.2s，无包络方波，大字组F键（87.307Hz），波形红色，线宽0.5，有标记点，标记点型为空心五角星，尺寸为8，色彩为蓝色；</font>

<center><img src="https://img-blog.csdn.net/20181018195350426?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2N0eXF5MjAxNTMwMTIwMDA3OQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70" width="75%">  </center><center><font face="宋体" size=2 > 图14 </font> </center>

<center><img src="https://img-blog.csdn.net/2018101819543235?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2N0eXF5MjAxNTMwMTIwMDA3OQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70" width="75%">  </center><center><font face="宋体" size=2 > 图15 </font> </center>

### <font face="宋体" size = 4>2.3.2 读取midi文件</font>

&emsp;&emsp; <font face="宋体">图16展示的是读取midi文件之后的时域图和自动打孔纸卷图。</font>

&emsp;&emsp; <font face="宋体">图16（1）：时域图。读入“jesu.mid”，音色为KarplusStrong。</font>

&emsp;&emsp; <font face="宋体">图16（2）：自动打孔纸卷图。读入“jesu.mid”，音色为KarplusStrong。</font>

<center><img src="https://img-blog.csdn.net/20181018195629586?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2N0eXF5MjAxNTMwMTIwMDA3OQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70" width="75%">  </center><center><font face="宋体" size=2 > 图16 (1) </font> </center>

<center><img src="https://img-blog.csdn.net/20181018195712124?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2N0eXF5MjAxNTMwMTIwMDA3OQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70" width="75%">  </center><center><font face="宋体" size=2 > 图16 (2) </font> </center>

### <font face="宋体" size = 4>2.3.3 设计个性化曲目</font>

&emsp;&emsp; <font face="宋体">用户可以通过写一特定矩阵实现个性化的编曲，用户需要输入的信息包括音符数目、每一个音符的编号、响度、音轨、声道、开始时间和结束时间。</font>

&emsp;&emsp; <font face="宋体">如，编写曲目为：</font>

> N = 21;          <font color=#32CD32>% 音符数目</font>
M = zeros(N,6);
M(:,1) = 1;          <font color=#32CD32>% 音轨1</font>
M(:,2) = 1;          <font color=#32CD32>% 声道1</font>
M(:,3) = (70:90)';   <font color=#32CD32>% 音符(只能取0-127)中央C：第60号</font>
M(:,4) = round(linspace(60,120,N))';  <font color=#32CD32>% 设置每个音符的响度：80->120</font>
M(:,5) = (0.5:0.5:10.5)';  <font color=#32CD32>% 每个音符的开始时间</font>
M(:,6) = M(:,5) + 1.5;    <font color=#32CD32>% 每个音符的结束时间</font>

&emsp;&emsp; <font face="宋体">则表示：产生21个音符，所有音符在1号音轨，在1号声道输出，取编号为70-90的21个音符，响度设置为在60-120区间线性分布，每个音符的开始时间相隔0.5s，每个音符延续1.5秒。</font>

&emsp;&emsp; <font face="宋体">则在不同的音色选择下，会出现多种音频曲线，其产生的人耳听觉效应也不同。图17(1)-(5)分别表示在5中不同音色下的音频曲线。</font>

&emsp;&emsp; <font face="宋体">图17(1):无包络锯齿波；图17(2):无包络方波；图17(3):无包络正弦波；图17(4):四段包络正弦波；图17(5):KarplusStrong合成。</font>

<table>
   <tr>
        <td ><center><img src="https://img-blog.csdn.net/20181018200357875?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2N0eXF5MjAxNTMwMTIwMDA3OQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70"  width="85%"> <font face="Times New Roman" size = 2> &ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;图17 （1） </font></center></td>
        <td ><center><img src="https://img-blog.csdn.net/20181018200511722?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2N0eXF5MjAxNTMwMTIwMDA3OQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70"  width="85%"><font face="Times New Roman" size = 2>    &ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;图17 （2） </font></center></td>
	</tr>
</table>

<table>
   <tr>
        <td ><center><img src="https://img-blog.csdn.net/20181018200748508?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2N0eXF5MjAxNTMwMTIwMDA3OQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70"  width="85%"> <font face="Times New Roman" size = 2> &ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;图17 （3） </font></center></td>
        <td ><center><img src="https://img-blog.csdn.net/20181018200815479?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2N0eXF5MjAxNTMwMTIwMDA3OQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70"  width="85%"><font face="Times New Roman" size = 2>    &ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;图17 （4） </font></center></td>
	</tr>
</table>

<table>
    <tr>
        <td><center>
        <img src="https://img-blog.csdn.net/20181018200912563?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2N0eXF5MjAxNTMwMTIwMDA3OQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70" width="45%">
        </center>
        <center>
       <font face="宋体" size=2>图17 (5) </font>
        </center></td> 
    <tr>
</table>

<center><font face="宋体" size=2>图17&ensp;同一曲调5种不同音色下的音频曲线</font></center>

&nbsp;
&emsp;&emsp; <font face="宋体">图18所示为该曲目的自动打孔纸卷图。</font>

<center><img src="https://img-blog.csdn.net/2018101820161464?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2N0eXF5MjAxNTMwMTIwMDA3OQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70" width="75%">  </center><center><font face="宋体" size=2 > 图18  该曲目对应的自动打孔纸卷</font> </center>

&nbsp;
&emsp;&emsp; <font face="宋体">用户也可按此方法设计自己的个性化曲目。</font>

# <font face="宋体"> 3 后记 </font>

&emsp;&emsp; <font face="宋体">这是我大三下学期做的项目，前前后后花了大约一周时间。说来有趣，某一天我在整理MATLAB目录时发现了大一暑期做的一个名为“基于MATLAB软件GUI界面的自制简单电子琴”的课程设计，（相关内容已经整理到了[我的SCDN博客](https://blog.csdn.net/ctyqy2015301200079)上，点击[链接](https://blog.csdn.net/ctyqy2015301200079/article/details/83115703)即可查看），一看才发现当年做的项目真是相当简陋，于是我对它进行了一些改进。总地来说在原来的基础上变得更加美观、功能也更加丰富了。</font>

&emsp;&emsp; <font face="宋体">本项目中midi编解码的部分主要参考了Ken Schutte的工作，相关代码见其[个人网页](http://kenschutte.com/midi)。

&emsp;&emsp; <font face="宋体">此处仅分享此项目中我个人贡献的代码。读者可根据上文中图11的描述从两处找全所有的文件并成功运行程序。

&emsp;&emsp; <font face="宋体">本文为原创文章，转载或引用务必注明来源及作者。</font>