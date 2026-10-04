# 上海创智学院博士研究生开题报告 LaTeX 模板

依据当前文件夹的 DOCX 制作。默认输出四页：封面、填写说明、学位论文提纲、实践成果提纲。封面直接使用 `figures/sii_logo.pdf`。

## 在 VS Code / LaTeX Workshop 中编辑和预览

用 VS Code 打开整个 `proposal` 文件夹。项目沿用用户设置中已有的 `xelatex-latexmk` recipe，使用 XeLaTeX 和 latexmk 自动完成需要的编译轮次；用户级 `settings.json` 无需修改。

1. 编辑 `metadata.tex` 填写封面，编辑 `sections/thesis.tex` 或 `sections/practice.tex` 撰写报告。
2. 保存文件后，沿用 LaTeX Workshop 默认的文件变化自动编译。也可点击编辑器右上角的 **Build LaTeX project**（macOS 默认 `⌥⌘B`）。
3. 点击 **View LaTeX PDF file**（`⌥⌘V`）打开右侧内置 PDF 预览。编译成功后预览自动刷新。
4. 沿用你设置的 **双击 PDF** 返回对应源码；从源码跳到 PDF 使用 **SyncTeX from cursor**（`⌥⌘J`）。封面的信息由宏生成，定位可能落到封面排版宏，而非 `metadata.tex` 字段；正文可直接定位到对应章节。

所有子文件已声明 `% !TeX root`，在章节文件中点击编译也会构建 `main.tex`。PDF、SyncTeX 和辅助文件统一生成在 `output/`；资源管理器保留 PDF，隐藏辅助文件及内部检查目录。

项目级 `.vscode/settings.json` 指定现有 recipe 名称，没有复制或覆盖你的工具列表。如果换到另一台电脑，需要同名 recipe（`latexmk -xelatex -synctex=1 -outdir=%OUTDIR% %DOC%`），或者在工作区设置中改选等价的 XeLaTeX + latexmk recipe。

## 命令行编译

在本目录执行：

```sh
latexmk -xelatex main.tex
```

成品位于 `output/main.pdf`，同步文件为 `output/main.synctex.gz`，辅助文件也在 `output/`。命令行与 LaTeX Workshop 使用同一个输出位置。本机已有所需的 TeX Live 2025 和宏包。

```text
proposal/
├── .vscode/settings.json    # 当前项目的编辑器配置
├── .latexmkrc              # 编译和输出目录
├── main.tex                # 主文件
├── metadata.tex            # 封面信息与输出选项
├── sii-proposal.sty         # 版式和字体
├── sections/               # 正文编辑区
├── figures/sii_logo.pdf     # 校徽
└── output/main.pdf         # 编译与预览结果
```

## 填写

1. 在 `metadata.tex` 中填写姓名、学号、导师组、题目、专业和日期。花括号留空即保留空白。
2. `\ProposalMode` 设为 `all` 输出两类提纲，`thesis` 仅输出学位论文提纲，`practice` 仅输出实践成果提纲。填写说明始终保留。
3. `\ProposalType` 设为 `thesis` 或 `practice` 勾选封面对应选项，留空则均不勾选。
4. 开始正式撰写时将 `\TemplateBlankstrue` 改为 `\TemplateBlanksfalse`，关闭预留空白；在 `sections/thesis.tex` 或 `sections/practice.tex` 的标题之后直接填写正文。正文按段落自然跨页，外框跟随分页。
5. 研究进度每个阶段使用 `\ScheduleRow{起讫时间}{主要研究内容}{阶段性成果}`。可增删行，行间可分页，单行内部自动换行。一个阶段若长于一页，请拆成多行；续页表头不自动重复。

标题和正文中使用的 `&`、`%`、`_` 等 LaTeX 特殊字符分别写为 `\&`、`\%`、`\_`。插图可在正文中直接用 `\includegraphics[width=\linewidth]{figures/文件名}`；外框内不要使用浮动的 `figure` 或 `table` 环境。

## 字体与版式

- A4；上下页边距 2.54 cm，左右 3.175 cm；无页眉页码。
- 封面标题 24 bp；封面信息使用 12 bp 楷体，说明使用 12 bp 仿宋，正文使用 12 bp 宋体类字体；西文优先 Times New Roman。
- 中文优先使用 SimSun、KaiTi 和 FangSong。本机已安装楷体、仿宋；未安装 SimSun 时使用 macOS 的 Songti SC。因此宋体部分与 Windows 原版可能有细微字形和换行差异。
- 换电脑后会依次尝试 macOS 字体和 TeX Live 自带 Fandol 字体，不会因缺少专有字体立即编译失败。字体回退可能改变分页；需要严格一致时，应在新电脑安装相同字体。
- 进度表保留 DOCX 中定义的三列网格边框（Pages 导入时可能不显示嵌套表格边框）。空白模板优先复现原稿；正式撰写时允许自然增页。

`sii-proposal.sty` 集中管理版式，日常填写通常只需修改 `metadata.tex` 和 `sections/` 下的内容。
