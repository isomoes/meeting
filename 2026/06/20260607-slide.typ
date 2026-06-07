#import "@preview/touying:0.6.1": *
#import themes.simple: *
#import "@preview/cetz:0.3.2"
#import "@preview/fletcher:0.5.5" as fletcher: edge, node
#import "@preview/numbly:0.1.0": numbly
#import "@preview/theorion:0.3.2": *
#import cosmos.clouds: *
#show: show-theorion

// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#set text(font: (
  "Source Han Serif",
))

#let redt(content) = text(fill: red, content)
#let bluet(content) = text(fill: blue, content)
#let greent(content) = text(fill: green, content)
#let yellowt(content) = text(fill: yellow, content)
#let oranget(content) = text(fill: orange, content)
#let purplet(content) = text(fill: purple, content)
#let greyt(content) = text(fill: gray, content)
#let grayt(content) = text(fill: gray, content)

#show heading: set text(font: "Source Han Sans", weight: "bold")
#show raw: set text(font: "Source Han Mono SC")
#show: simple-theme.with(aspect-ratio: "16-9", footer: [学术组会])

#title-slide[
  = 学术组会
  #v(1.5em)

  三篇论文进展

  #v(1.5em)
  2026-06-07
]

=

== 三篇论文

#redt[主线：围绕轻量级 PRF 的故障攻击与防护，主导三篇论文。]

#table(
  columns: (auto, 1fr, auto),
  inset: 8pt,
  align: (left + horizon, left + horizon, center + horizon),
  stroke: 0.5pt + gray,
  [*论文*], [*主题*], [*角色*],
  [`gleeokLi`], [Gleeok 的差分故障分析（DFA）], [攻击],
  [`OrthrosDFDai`], [Orthros 的差分故障分析（DFA）], [攻击],
  [`OrthrosHuang`], [Orthros 低延迟并发错误检测（CED）], [防护],
)

= 问题

== Gleeok 与 Orthros DFA：方法高度相似

两篇 DFA 共享同一条技术路线：

- 在 #redt[末轮 S 层后] 注入字节故障，利用 #redt[差分传播] 约束 S 盒输入差分；
- 通过「多活跃列」传播模式限制原本不可分辨的输入差分；
- 逐步恢复末轮分支内部状态 $X^((r))$，反推轮密钥；
- 利用 #bluet[线性 / 置换式密钥扩展] 的可逆性，反解出主密钥。

#greent[即攻击框架、差分约束、密钥反推流程基本一致，可复用同一套分析模板。]

== 故障注入在实际中非常困难

#redt[最大共性瓶颈：故障模型在物理实现上代价高、难精确。]

- *模型理想化*：单字节「精确覆盖 / 定点」故障在真实硬件上极难复现；
- *随机性放大开销*：当字节位置与值随机时，所需故障数显著上升
  （Orthros 实验：平均约 #bluet[32\~51] 次故障才能完成一次密钥恢复）；

#greent[结论：理论上可行，但「实际可注入性」是评估这类 DFA 威胁的真正门槛。]

== 三篇论文都缺少对比基线（baseline）

#redt[三篇论文目前都没有可对照的 baseline，贡献「更优在哪」难以量化。]

- 两篇 DFA：所攻击的 Gleeok / Orthros 尚无公开 DFA 结果，故障数、复杂度无同类方法可比；
- CED 论文：Orthros 此前无 S 盒级并发错误检测方案，面积 / 延迟开销缺少同任务对照；
- 影响：审稿易质疑实验充分性与贡献定位。

