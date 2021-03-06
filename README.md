# LCTT Platform - Linux 中国 - 翻译平台

LCTT (Linux.CN Translate Team) 是 [Linux 中国](http://linux.cn/) 社区的翻译小组，
负责从国外优秀媒体摘录、翻译和发布 Linux 相关的技术、资讯、杂文等内容。

LCTT 已经拥有近百余名活跃成员，并欢迎更多的 Linux 志愿者加入我们的团队。


## LCTT 成员的组成

**成员**: 社区成员，可以`推荐`原文。

**选题**: 从国外媒体或成员的`推荐`中摘录合适的`原文`转换为 Markdown 格式，并提交到翻译平台。

**译者**: 每次可以认领一篇`原文`进行翻译，将翻译好的`译文`提交后才可再次领取新的`原文`。

**校对**: 将`译文`进行文字润色、技术校对；同时也可否决低质量的翻译。

**发布**: 把最终校对后的文章，排版发布后进行归档。

**管理**: 维护翻译平台主页、管理成员列表和修改帮助内容等站务相关操作。

注:

1. 所有 **成员** （译者、校对和发布）都可以推荐文章到翻译平台。
2. 一个账号可以有多个角色


## 加入我们

请首先加入翻译组的 QQ 群: 198889102，加群时请说明是志愿者。

新加入的成员，请先阅读帮助页面的如何开始。

我们使用 GitHub 来进行第三方验证，请确保您已经 [注册 GitHub](https://github.com/join) 账号。


## 开发信息
### 文章生命周期和流程

+ `未创建`:
  - [1] **成员**在`新建原文`页面`新建文章` -> `新推荐`
  - [2] **选题**在`新建原文`页面`新建文章` -> `新原文`

+ `新推荐`:
  - [3] **选题**在`编辑文章`页面`批准推荐` -> `新原文`

+ `新原文`:
  - [4] **译者**在`翻译进度`页面`认领原文` -> `翻译中`

+ `翻译中`:
  - [5] **译者**在`编辑文章`页面`提交翻译` -> `已翻译`
  - [6] **译者**在`编辑文章`页面`放弃翻译` -> `新原文`

+ `已翻译`:
  - [7] **校对**在`编辑文章`页面`完成校对` -> `已校对`
  - [8] **校对**在`编辑文章`页面`否决翻译` -> `新原文`

+ `已校对`:
  - [9] **发布**在`翻译进度`页面发布译文并`归档文章`

注:

1. **管理** 可以在任何阶段对任意文章进行 `归档文章` 和 `恢复文章` 操作。
2. 版本控制要求任何文章的操作都应该被记录，所以文章创建后无法删除。

![流程图](https://rawgit.com/vizv/LCTT-Platform/develop/doc/LCTT_FlowChart.svg)


### 成员身份和权限

TODO


### 术语表

**定义**

+ `文章结构`: 定义了文章在翻译的生命周期中记录的相关信息
+ `文章状态`: 文章当前所处的翻译生命周期
+ `页面`: 用户可以交互的页面
+ `操作`: 通过界面的按钮或 API 执行的操作

**文章结构**

+ `原文标题`: 必填，文章原文标题(英文标题)
  - title
+ `文章来源`: 文章来源的站点或媒体名称
  - source
+ `文章来源 URL`: 文章所在的原始 URL
  - source_url
+ `许可信息`: 文章的转载许可，默认为　CC
  - license
+ `推荐稿`: 记录推荐
  - suggestion
+ `原文`: 记录原文
  - original
+ `译文`: 记录译文
  - translation
+ `终稿`: 记录终稿
  - publish
+ `文章状态`: 见 `文章状态`
  - state

**文章状态**

+ `未创建`: (文章尚未创建)
  - `nil`
+ `新推荐`: 由 **成员** 推荐但尚未被批准的原文
  - `:suggest`
+ `新原文`: 由 **选题** 摘录的原文或已批准的推荐
  - `:new`
+ `翻译中`: 由 **译者** 认领后但尚未提交的文章
  - `:translating`
+ `已翻译`: 由 **译者** 翻译但尚未进行校对的文章
  - `:translated`
+ `已校对`: 由 **校对** 完成校对后的文章
  - `:done`

**页面**

+ `项目动态`: 浏览项目动态和统计信息
  - `activity#index`
+ `文章列表`: 筛选和浏览当前的文章列表
  - `articles#index`
+ `新建原文`: 新建原文
  - `articles#new`
+ `编辑文章`: 浏览指定的文章进行翻译和校对
  - `articles#edit`
+ `翻译进度`: 浏览指定文章的翻译进度和执行文章操作
  - `articles#show`

**操作**

+ `新建文章`: 创建推荐或原文
  - `articles#create`
+ `批准推荐`: 批准 `新推荐`
  - `articles#update?action=approve`
+ `认领原文`: 开始翻译未认领的 `新原文`
  - `articles#update?action=claim`
+ `提交翻译`: 提交当前 `翻译中` 文章的译文
  - `articles#update?action=submit`
+ `放弃翻译`: 放弃当前 `翻译中` 的文章
  - `articles#update?action=cancel`
+ `完成校对`: 校对 `已翻译` 的文章并提交终稿
  - `articles#update?action=accept`
+ `否决翻译`: 打回质量低下的 `已翻译` 文章
  - `articles#update?action=deny`
+ `归档文章`: 由于版本控制的原因，文章只能被归档(成员无法修改和访问)并供管理员查阅和回档
  - `articles#update?action=archive`
+ `恢复文章`: 与归档操作相反，恢复被归档的文章
  - `articles#update?action=restore`

### 关于本项目

该平台使用 Ruby on Rails 框架开发。目前正处于开发阶段，暂时由 Viz 继续编写和维护。

如果您有兴趣参与，请加入 QQ 群联系 Viz :3
