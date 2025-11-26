#  LaTeX 公式语法大全

** **LaTeX 公式语法大全（适用于 Typora、Overleaf 等 MathJax 支持环境）**，涵盖日常数学公式书写中最常用的部分：

------

##  一、基本结构

```latex
$$ 公式 $$               % 块级公式（居中）
\( 公式 \)              % 行内公式（嵌入文本）
```

------

## 二、上下标（指数、下标）

```latex
a^2                     % a 的平方 → a²
a_1                     % 下标 1 → a₁
x_i^2                   % xi 的平方
```

------

##  三、常见运算符

```latex
latex复制编辑+ - \times \div         % 加、减、乘、除：× ÷
\pm \mp                 % ± ∓
\cdot                   % 点乘 ·
\frac{a}{b}             % 分式：a/b
\sqrt{x}                % 根号 √x
\sqrt[n]{x}             % n 次根 √[n]x
```

------

##  四、常用函数

```latex
\sin \cos \tan          % 三角函数：sin, cos, tan
\log \ln \exp           % 对数、自然对数、指数
```

------

## 五、求和 / 积分 / 极限

```latex
\sum_{i=1}^{n} i        % 求和符号 ∑
\prod_{i=1}^{n} i       % 连乘符号 ∏
\int_{a}^{b} f(x)dx     % 定积分
\lim_{x \to 0} f(x)     % 极限
```

------

##  六、等式与对齐（多行）

```latex
\begin{aligned}
a &= b + c \\
x &= y - z
\end{aligned}
```

------

## 七、逻辑与集合

```latex
latex复制编辑\in \notin \subset \supset        % 属于、不属于、子集、超集
\cap \cup \setminus               % 交集、并集、差集
\forall \exists                   % ∀ 存在 ∃
\Rightarrow \Leftrightarrow       % 推导 ⇒ ⇔
```

------

##  八、矩阵

```latex
\begin{bmatrix}
a & b \\
c & d
\end{bmatrix}
```

还可用 `pmatrix`、`vmatrix`、`matrix` 环境。

------

##  九、特殊符号

```latex
\infty                 % ∞
\approx \equiv         % ≈ ≡
\le \ge \neq =         % ≤ ≥ ≠ =
\alpha \beta \theta    % 希腊字母
\text{文本}            % 插入普通文本
```

------

##  十、字体/样式

```latex
\mathbf{A}       % 粗体 A
\mathit{B}       % 斜体 B
\mathrm{C}       % 正体 C
\mathbb{R}       % 黑板粗体 R（实数集）
\mathcal{F}      % 花体 F
```

------

##  示例组合公式：

```latex
\bar{x} = \frac{1}{n} \sum_{i=1}^n x_i,\quad
s = \sqrt{\frac{1}{n - 1} \sum_{i=1}^n (x_i - \bar{x})^2}
$$
```

------

##  提示（在 Typora 中）：

- `$$公式$$` → 用于居中显示的公式块。
- `\\` → 换行。
- `\quad`、`\;` → 控制空格。
- `\text{}` → 插入普通文本。

