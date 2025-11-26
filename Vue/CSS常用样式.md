# CSS常用样式

## **1. 选择器**

| 选择器              | 作用                                                   |
| ------------------- | ------------------------------------------------------ |
| `*`                 | 全局选择器（选中所有元素）                             |
| `element`           | 标签选择器（如 `div`、`p`）                            |
| `.class`            | 类选择器（如 `.box` 选中 `class="box"` 的元素）        |
| `#id`               | ID 选择器（如 `#header` 选中 `id="header"`）           |
| `element, element`  | 组合选择器（如 `h1, h2` 选中所有 h1 和 h2）            |
| `element element`   | 后代选择器（如 `div p` 选中 `div` 内所有 `p`）         |
| `element > element` | 子元素选择器（如 `ul > li` 选中 `ul` 直接子级的 `li`） |
| `element + element` | 相邻兄弟选择器（如 `h1 + p` 选中紧随 h1 之后的 p）     |
| `element ~ element` | 通用兄弟选择器（如 `h1 ~ p` 选中所有 h1 之后的 p）     |

------

## **2. 颜色 & 背景**

```css
color: red; /* 文字颜色 */
background-color: blue; /* 背景颜色 */
background-image: url('image.jpg'); /* 背景图片 */
background-size: cover; /* 背景填充 */
background-repeat: no-repeat; /* 不重复 */
background-position: center center; /* 居中对齐 */
```

------

## **3. 文字 & 字体**

```css
font-size: 16px; /* 字体大小 */
font-weight: bold; /* 加粗 */
font-style: italic; /* 斜体 */
text-align: center; /* 文字对齐 */
text-decoration: underline; /* 下划线 */
line-height: 1.5; /* 行高 */
letter-spacing: 2px; /* 字母间距 */
word-spacing: 4px; /* 单词间距 */
```

------

## **4. 盒模型（布局 & 间距）**

```css
width: 100px; /* 宽度 */
height: 200px; /* 高度 */
padding: 10px; /* 内边距 */
margin: 20px; /* 外边距 */
border: 2px solid black; /* 边框 */
box-sizing: border-box; /* 盒模型计算方式 */
```

------

## **5. 布局 & 定位**

```css
display: block; /* 块级元素 */
display: inline-block; /* 行内块 */
display: flex; /* 弹性布局 */
display: grid; /* 网格布局 */
position: static; /* 默认定位 */
position: relative; /* 相对定位 */
position: absolute; /* 绝对定位 */
position: fixed; /* 固定定位 */
top: 10px; left: 20px; /* 位置调整 */
```

------

## **6. Flexbox 弹性布局**

```css
display: flex;
flex-direction: row; /* 主轴方向 */
justify-content: center; /* 主轴对齐 */
align-items: center; /* 交叉轴对齐 */
gap: 10px; /* 子元素间距 */
```

------

## **7. Grid 网格布局**

```css
display: grid;
grid-template-columns: repeat(3, 1fr); /* 三列等宽 */
grid-gap: 10px; /* 间距 */
```

------

## **8. 过渡 & 动画**

```css
transition: all 0.3s ease-in-out; /* 过渡效果 */
animation: fadeIn 2s infinite; /* 动画 */
@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}
```

------

## **9. 其他常用样式**

```css
opacity: 0.5; /* 透明度 */
cursor: pointer; /* 鼠标样式 */
visibility: hidden; /* 隐藏元素 */
overflow: hidden; /* 隐藏溢出内容 */
z-index: 10; /* 层级 */
```