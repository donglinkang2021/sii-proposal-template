# 上海创智学院博士研究生开题报告 LaTeX 模板

依据本目录的 DOCX 制作，保留 `ctexart`、字体回退和 XeLaTeX + latexmk。默认输出四页空白模板：封面、填写说明、学位论文提纲、实践成果提纲。封面使用 `figures/sii_logo.pdf`。

## 编译与预览

在项目根目录执行：

```sh
latexmk -xelatex main.tex       # 用户报告 -> output/main.pdf
latexmk -xelatex example.tex    # 独立科研示例 -> output/example.pdf
```

需要 XeLaTeX、latexmk、Biber，以及 `ctex`、`biblatex`、`biblatex-gb7714-2015`、`amsmath`、`booktabs`、`caption`、`subcaption`、`longtable` 等宏包（本机 TeX Live 2025 已安装）。latexmk 自动运行 XeLaTeX、Biber 和必要的重复编译；不要手动运行 BibTeX，也不要混入其他模板的参考文献配置。第一次编译出现“请运行 Biber”或未解析引用提示属于中间轮次，最终日志应已消除这些提示。

PDF、SyncTeX 和辅助文件统一生成在 `output/`。两入口使用各自的文件名，编译示例不会覆盖主报告。排查缓存问题时可执行 `latexmk -C main.tex` 后重编译（该命令会删除主报告的生成文件）。

用 VS Code 打开整个 `proposal` 文件夹。项目级 `.vscode/settings.json` 沿用已有 `xelatex-latexmk` recipe，不修改用户全局设置。另一台电脑需配置同名 recipe，命令为 `latexmk -xelatex -synctex=1 -outdir=%OUTDIR% %DOC%`，或选择等价的 XeLaTeX + latexmk recipe。

- 保存文件后沿用 LaTeX Workshop 的文件变化自动编译，也可使用 **Build LaTeX project**（macOS 默认 `⌥⌘B`）。
- **View LaTeX PDF file**（`⌥⌘V`）打开 PDF；双击 PDF 返回源码，源码跳转 PDF 使用 **SyncTeX from cursor**（`⌥⌘J`）。封面字段由宏排版，定位可能落到样式宏。
- 用户正文与 `metadata.tex` 的 `% !TeX root` 指向 `main.tex`。`example.tex` 明确指向自身，`examples/` 中的示例子文件指向它；编译示例时打开 `example.tex`。

## 切换模式

编辑 `metadata.tex` 中已有设置，不要重复定义同一个选项。

| 设置或行为 | `template`（默认） | `report`（正式撰写） |
| --- | --- | --- |
| `\ProposalMode` | `all`、`thesis`、`practice` | 必须为 `thesis` 或 `practice` |
| `\ProposalType` | 留空不勾选，或独立指定封面类型 | 留空自动跟随正文；显式冲突会报错 |
| 填写说明、正文外框 | 保留 | 隐藏 |
| `\TemplateBlanks` | 控制填写留白 | 自动关闭 |
| 目录 | 不输出 | 两级标题和参考文献 |
| 页码 | 不显示 | 封面无页码；目录罗马数字；正文从 1 开始 |
| 正文分页 | 外框可跨页 | 七章分别另起一页，单面排版，无奇偶页留白 |

正式学位论文配置：

```tex
\renewcommand{\ProposalLayout}{report}
\renewcommand{\ProposalMode}{thesis}
\renewcommand{\ProposalType}{}
```

正式实践成果配置：

```tex
\renewcommand{\ProposalLayout}{report}
\renewcommand{\ProposalMode}{practice}
\renewcommand{\ProposalType}{}
```

恢复原始四页空白模板：

```tex
\renewcommand{\ProposalLayout}{template}
\renewcommand{\ProposalMode}{all}
\renewcommand{\ProposalType}{}
\TemplateBlankstrue
```

在 `metadata.tex` 填写姓名、学号、导师组、题目、专业和日期。正式版顺序为封面、目录、所选正文、参考文献，不包含填写说明或摘要；未引用文献时不生成文献页。两种正文均保留原七项提纲。

## 正文与标题

在 `sections/thesis.tex` 或 `sections/practice.tex` 的标题后写正文，段落间留空行。`\WritingSpace` 在正式模式中不起作用，可以保留。

```tex
\ProposalSection{研究目标与关键科学问题}\label{sec:goals}
在这里阐明研究目标。

\subsection{关键科学问题}\label{subsec:question}
正文可引用第\ref{sec:goals}章和第\ref{subsec:question}节。

\subsubsection{问题的验证条件}\label{subsubsec:conditions}
三级标题自动编号为 1.1.1，可交叉引用，但不进入两级目录。
```

`\ProposalSection` 在模板模式中保留原提纲外观，在正式模式中显示居中的“第1章　标题”，先排完上一章的浮动图表，再另起一页，生成目录项和 PDF 书签。仍以 `ctexart` 的 `section` 计数，不需要改用 `\chapter`；`\ref` 继续返回数字。每个 `proposalbody` 从 1 开始编号；两个模板提纲各自编号 1–7。旧入口 `\ProposalHeading{3}{标题}` 仍可使用，编号须为整数，后续自动编号从这里继续。二、三级标题分别使用 `\subsection`、`\subsubsection`，标签紧跟标题。正文中 `&`、`%`、`_` 应写作 `\&`、`\%`、`\_`。

## 参考文献

使用 **GB/T 7714—2015 顺序编码制**，正文标准 `\cite` 为行内 `[1]`，按首次引用顺序编号；重复引用保持编号，多篇引用自动排序、压缩。具体页码按国标样式放在引文方括号后上标。

用户文献存入 UTF-8 文件 `references.bib`，该文件默认只有说明，不包含示例条目。示例使用独立的 `examples/references.bib`。请核实实际引用文献的作者、题名、版本、出版信息和页码。

以下是真实书目的可复制写法（仅在需要引用时添加）：

```bibtex
@book{li2019statistical,
  author    = {李航},
  title     = {统计学习方法},
  edition   = {2},
  location  = {北京},
  publisher = {清华大学出版社},
  date      = {2019},
  isbn      = {9787302517276}
}
```

```tex
统计学习基础可参见\cite{li2019statistical}。
关于模型评估的讨论见\cite[19--24]{li2019statistical}。
% 多篇引用：先在 references.bib 中添加相应条目，再引用：
% \cite{key1,key2}
```

主入口已加载文献库并在正文后调用 `\printproposalbibliography`。文献列表在正式模式中单独起页并进入目录，中英文条目共用列表。不需要手写编号、`thebibliography` 或 `\bibliographystyle`；未引用条目不会出现。添加或修改引用后仍只运行原来的 latexmk 命令。

## 图表与公式

正式模式使用标准浮动体；`\label` 放在 `\caption` 后。图、表、公式各自连续编号，引用可点击跳转。

正式版图题放在图下，表题放在表上；主题注为 11 bp，子图题注为 10.5 bp。`table` 中默认使用 11 bp、16 bp 行距；表头需要黑体时，在各表头单元格开头加 `\ProposalHei`，如独立示例所示。普通表格的表头内容由作者指定，模板不自动猜测哪一行是表头。

```tex
\begin{figure}[htbp]
  \centering
  \includegraphics[width=.45\linewidth]{figures/sii_logo.pdf}
  \caption{示例插图}\label{fig:sample}
\end{figure}
如图\ref{fig:sample}所示。

\begin{table}[htbp]
  \centering
  \caption{演示数据}\label{tab:sample}
  \begin{tabular}{lrr}
    \toprule
    方法 & 样本数 & 得分\\
    \midrule
    基线 & 100 & 0.72\\
    \bottomrule
  \end{tabular}
\end{table}
见表\ref{tab:sample}。
```

子图使用 `subcaption` 的 `subfigure` 环境；可复制 `examples/research.tex` 中完整的双子图示例。浮动体由 LaTeX 安排位置，不保证紧贴源码所在段落。

```tex
行内公式：$y=f_\theta(x)$。
\begin{equation}\label{eq:loss}
  \mathcal{L}(\theta)=\frac{1}{n}\sum_{i=1}^{n}(f_\theta(x_i)-y_i)^2.
\end{equation}
\begin{align}
  g_t &= \nabla_\theta\mathcal{L}(\theta_t),\label{eq:grad}\\
  \theta_{t+1} &= \theta_t-\eta_t g_t.\label{eq:step}
\end{align}
目标函数见式\eqref{eq:loss}，更新见式\eqref{eq:step}。
```

模板模式的外框内不能使用普通 `figure`、`table` 浮动体。使用非浮动内容与 `\captionof`，较短内容可放在 `minipage` 中以避免图片和题注分离：

```tex
\noindent\begin{minipage}{\linewidth}
  \centering
  \includegraphics[width=.35\linewidth]{figures/sii_logo.pdf}
  \captionof{figure}{非浮动插图}\label{fig:boxed}
\end{minipage}

\noindent\begin{minipage}{\linewidth}
  \centering
  \captionof{table}{非浮动表格}\label{tab:boxed}
  \begin{tabular}{lr}
    \toprule
    方法 & 得分\\\midrule
    基线 & 0.72\\\bottomrule
  \end{tabular}
\end{minipage}
```

`minipage` 不跨页，图片或表格总高度须小于一页。较长正式内容建议切换 `report` 模式。

## 研究进度

两种模式均复用相同接口：

```tex
\begin{proposalschedule}
  \ScheduleRow{2026.10--12}{调研相关工作、明确问题。}{文献综述与问题清单。}
  \ScheduleRow{2027.01--03}{完成基线实现与对照实验。}{实验记录和阶段报告。}
\end{proposalschedule}
```

正式模式使用 `longtable`，行间可自然分页，续页重复表头；不要将它放入 `table`、`minipage` 或其他外框中。模板模式保持原三列网格和空白行高度，续页不重复表头。两种模式的单行均不能在行内分页，超过一页的阶段须拆成多行。

## 独立示例与文件结构

`example.tex` 不读取用户元数据或正文，使用正式学位论文模式，包含七项提纲、中英文文献、重复及多篇引用、页码引文、插图和子图、三线表、行内及多行公式、标题引用，以及支持跨页的进度表。当前示例的 15 行进度表可排在一页；增加行数时会自然跨页并重复表头。所有数值和研究安排均明确标为演示。示意图由项目内 TikZ 源码生成，无下载步骤。

示例书目核对来源：[清华大学出版社《统计学习方法》第 2 版](https://www.tup.tsinghua.edu.cn/bookscenter/book_08132901.html)、[CVF 原始论文出版页](https://www.cv-foundation.org/openaccess/content_cvpr_2016/html/He_Deep_Residual_Learning_CVPR_2016_paper.html)。书目文件顺序特意与引用顺序不同，可观察按首次引用编号的效果。

```text
proposal/
├── main.tex                 # 用户报告入口
├── metadata.tex             # 封面信息、版式及正文类型
├── references.bib           # 用户文献库，默认无条目
├── sii-proposal.sty          # 共享版式、字体及科研写作支持
├── sections/                # 用户正文及原填写说明
├── example.tex              # 独立示例入口
├── examples/                # 示例正文、文献及矢量示意图
├── figures/sii_logo.pdf      # 校徽
├── .latexmkrc               # XeLaTeX + 自动 Biber，输出到 output/
└── output/                  # main.pdf、example.pdf 及各自辅助文件
```

## 字体与版式

两种模式均使用 A4，上下页边距 2.54 cm、左右 3.175 cm，与项目内原始 DOCX 一致。西文优先 Times New Roman，缺失时使用 TeX Gyre Termes。

`template` 保留原四页表单：封面标题 24 bp、封面信息 12 bp 楷体、填写说明 12 bp 仿宋，正文 12 bp、15.6 bp 行距，无页眉页码。

`report` 使用独立的论文章节式样式，不改变原始表单：

| 元素 | 字号与行距 | 格式与间距 |
| --- | --- | --- |
| 正文 | 12 / 20 bp | 宋体，首行缩进两字，段间不额外留白 |
| 一级章标题 | 16 / 24 bp | 黑体居中，章前清页；段前 6 bp、段后 18 bp |
| 二级标题 | 14 / 20 bp | 黑体左对齐，1.1 编号；段前 24 bp、段后 8 bp |
| 三级标题 | 12 / 18 bp | 黑体左对齐，1.1.1 编号；段前 16 bp、段后 6 bp |
| 目录与参考文献标题 | 16 / 24 bp | 黑体居中，单独起页 |
| 目录条目 | 12 / 18 bp | 章条目黑体、节条目宋体；统一点引导线，页码右对齐 |
| 图表主题注 | 11 / 15 bp | 编号与文字间空一字，题注与图表间距 6 bp |
| 子图题注 | 10.5 / 14 bp | 保留 (a)、(b) 标签 |
| 表格正文 | 11 / 16 bp | 普通表头可用 `\ProposalHei`；进度表自动使用黑体表头 |
| 参考文献条目 | 10.5 / 15 bp | 条目间距 4 bp，保持原国标著录样式 |
| 页眉与页脚 | 9 bp / 10.5 bp | 居中学院报告名称、0.4 pt 横线；页码居中 |
| 正式封面 | 标题 26 / 36 bp；信息 13 / 18 bp | 信息栏楷体，填写内容居中，导师组标签左对齐，长题目自然换行 |

正式版各章另起一页，不插入奇偶空白页。示例内容较短，因此部分章页留白较多；实际正文可自然延续到后续页。章间自动排完浮动体，避免上一章图片进入下一章，但不会强制图片紧贴源码。浮动体与正文间距为 12 bp（可伸缩 2 bp），浮动体之间为 10 bp（可伸缩 2 bp）；公式上下间距为 10 bp，短行公式间距为 6 bp。进度表扣除列间距和边线后，三列内容宽度按 18%／34%／48% 分配，保留网格和续页表头。

中文优先 SimSun、KaiTi 和 FangSong，依次回退到 macOS 字体和 TeX Live 自带 Fandol。正式版黑体单独按 SimHei → Heiti SC → FandolHei 回退，不用加粗宋体代替。本机正文使用 Songti SC，标题使用 Heiti SC，封面信息使用 KaiTi。换电脑后的字体回退可能改变字形、换行及分页，严格复现需安装相同字体。样式集中在 `sii-proposal.sty`，日常写作只需修改元数据、所选正文和用户文献库。
