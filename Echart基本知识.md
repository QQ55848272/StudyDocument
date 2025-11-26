# Echart基本知识

ECharts（Enterprise Charts）是百度开源的一款强大的、可定制的数据可视化库，基于 JavaScript，适合各种图表类型的展示。下面是 ECharts 的一些基本知识点，帮助你快速入门：

------

##  一、引入方式

### 1. CDN 引入（简单方便）

```html

<script src="https://cdn.jsdelivr.net/npm/echarts/dist/echarts.min.js"></script>
```

### 2. 本地引入 / NPM 安装（推荐用于项目中）

```bash
npm install echarts --save
```

在模块化项目中使用：

```js
import * as echarts from 'echarts';
```

------

##  二、基本结构

一个 ECharts 图表的结构通常包括：

```js
// 1. 初始化
const myChart = echarts.init(document.getElementById('main'));

// 2. 配置项
const option = {
  title: {
    text: '主标题',
    subtext: '副标题',
  },
  tooltip: {},  // 提示框
  legend: {
    data: ['销量'],
  },
  xAxis: {
    data: ['衬衫', '羊毛衫', '雪纺衫', '裤子'],
  },
  yAxis: {},
  series: [
    {
      name: '销量',
      type: 'bar',  // 图表类型：bar柱状图，line折线图等
      data: [5, 20, 36, 10],
    },
  ],
};

// 3. 使用配置项
myChart.setOption(option);
```

------

### 一、初始化图表

#### 1. 获取容器

先准备一个 DOM 容器（通常是一个 `div`）：

```html
<div id="main" style="width: 600px; height: 400px;"></div>
```

#### 2. 初始化实例

```js
const myChart = echarts.init(document.getElementById('main'));
```

> `echarts.init(domElement)` 会返回一个图表实例（`myChart`），你可以用它来设置图表、监听事件、更新数据等。

------

###  二、配置项 Option 详解

这是 ECharts 的核心，基本结构如下：

```js
const option = {
  title: { ... },
  tooltip: { ... },
  legend: { ... },
  xAxis: { ... },
  yAxis: { ... },
  series: [ ... ],
};
```

#### 1. `title`：标题组件

```js
title: {
  text: '主标题',
  subtext: '副标题',
  left: 'center', // 水平居中（可选 left/center/right）
  top: 'top',     // 垂直位置（可选 top/middle/bottom）
  textStyle: {
    fontSize: 20,
    color: '#333'
  }
}
```

#### 2. `tooltip`：提示框组件（鼠标悬停显示）

```js
tooltip: {
  trigger: 'axis',   // 'item'（单个数据项），'axis'（整个坐标轴）
  axisPointer: {
    type: 'shadow'    // 十字线 cross、线型 line、阴影 shadow
  }
}
```

#### 3. `legend`：图例组件（显示 series 名称）

```js
legend: {
  data: ['销量'],
  top: 'bottom',    // 控制图例显示位置
}
```

#### 4. `xAxis` 和 `yAxis`：坐标轴

```js
xAxis: {
  type: 'category',          // 类别轴（也可为 'value'、'time'、'log'）
  data: ['衬衫', '羊毛衫', '雪纺衫'],
  axisLabel: {
    rotate: 45               // 标签旋转角度
  }
},
yAxis: {
  type: 'value',
  min: 0,
  max: 100
}
```

#### 5. `series`：系列列表（真正展示数据的部分）

```js
series: [
  {
    name: '销量',
    type: 'bar', // 折线图为 line，饼图为 pie
    data: [5, 20, 36],
    label: {
      show: true,
      position: 'top'  // 显示数据值的位置
    },
    itemStyle: {
      color: '#5470C6'
    }
  }
]
```

------

### 三、设置配置项（渲染图表）

```js
myChart.setOption(option);
```

> 如果你多次调用 `setOption`，它会自动合并配置，并尝试过渡动画。

------

###  四、示例汇总

```
js复制编辑const chartDom = document.getElementById('main');
const myChart = echarts.init(chartDom);

const option = {
  title: {
    text: '商品销量',
    subtext: '2025年第一季度',
    left: 'center'
  },
  tooltip: {
    trigger: 'axis'
  },
  legend: {
    data: ['销量'],
    top: 'bottom'
  },
  xAxis: {
    type: 'category',
    data: ['衬衫', '羊毛衫', '雪纺衫', '裤子', '高跟鞋']
  },
  yAxis: {
    type: 'value'
  },
  series: [
    {
      name: '销量',
      type: 'bar',
      data: [5, 20, 36, 10, 10],
      label: {
        show: true,
        position: 'top'
      }
    }
  ]
};

myChart.setOption(option);
```

##  三、常见图表类型

| 图表类型 | 类型名 (`type`) | 说明                                 |
| -------- | --------------- | ------------------------------------ |
| 折线图   | `line`          | 展示趋势                             |
| 柱状图   | `bar`           | 直观比较数量                         |
| 饼图     | `pie`           | 展示比例关系                         |
| 散点图   | `scatter`       | 分布与相关性                         |
| 雷达图   | `radar`         | 多维度对比                           |
| 仪表盘   | `gauge`         | 比如进度、百分比等                   |
| 地图     | `map`           | 地理数据展示（需要额外引入地图数据） |

------

## 四、核心组件介绍

### 核心组件一览

| 组件名        | 说明                               |
| ------------- | ---------------------------------- |
| `title`       | 图表标题                           |
| `tooltip`     | 悬停提示框                         |
| `legend`      | 图例，用于说明系列的含义           |
| `xAxis/yAxis` | 坐标轴，用于直角坐标系图表         |
| `grid`        | 控制图表绘图区的位置               |
| `series`      | 数据系列，是展示的核心部分         |
| `dataset`     | 原始数据集，可用于更清晰的数据管理 |
| `toolbox`     | 工具栏组件（保存图、数据视图等）   |

------

###  `title` - 标题组件

```js
title: {
  text: '主标题',
  subtext: '副标题',
  left: 'center',   // 标题居中显示
  textStyle: {
    fontSize: 18,
    color: '#333'
  }
}
```

------

###  `tooltip` - 提示框组件

```js
tooltip: {
  trigger: 'axis',  // 可选 'item' 或 'axis'
  axisPointer: {
    type: 'shadow'  // 交互指示类型：'line' | 'shadow' | 'none'
  }
}
```

------

###  `legend` - 图例组件

```js
legend: {
  data: ['销量', '库存'],  // 对应 series 中的 name
  top: 'top',
  textStyle: {
    color: '#666'
  }
}
```

------

###  `xAxis` / `yAxis` - 坐标轴

```js
xAxis: {
  type: 'category',
  data: ['Mon', 'Tue', 'Wed'],
  axisLine: {
    lineStyle: { color: '#888' }
  }
},
yAxis: {
  type: 'value',
  name: '数量',
  axisLabel: {
    formatter: '{value} 件'
  }
}
```

------

###  `grid` - 网格组件（控制绘图区）

```js
grid: {
  left: '10%',
  right: '10%',
  bottom: '15%',
  containLabel: true  // 防止标签溢出
}
```

------

###  `series` - 数据系列（核心）

```js
series: [
  {
    name: '销量',
    type: 'bar',   // 可选：'line'、'pie'、'scatter'等
    data: [10, 22, 28],
    itemStyle: {
      color: '#5470C6'
    },
    label: {
      show: true,
      position: 'top'
    }
  }
]
```

------

### toolbox` - 工具栏组件

```js
toolbox: {
  feature: {
    saveAsImage: {},     // 保存为图片
    dataView: { readOnly: false }, // 数据视图
    restore: {},         // 还原
    magicType: { type: ['line', 'bar'] } // 动态切换图类型
  },
  right: '10%',
  top: 'top'
}
```

------

###  完整示例：柱状图带全部核心组件

```js
const option = {
  title: {
    text: '商品统计',
    subtext: '2025年Q1'
  },
  tooltip: {
    trigger: 'axis'
  },
  legend: {
    data: ['销量', '库存']
  },
  toolbox: {
    feature: {
      saveAsImage: {},
      dataView: {},
      magicType: { type: ['line', 'bar'] },
      restore: {}
    }
  },
  grid: {
    left: '10%',
    right: '10%',
    bottom: '10%',
    containLabel: true
  },
  xAxis: {
    type: 'category',
    data: ['衬衫', '羊毛衫', '雪纺衫']
  },
  yAxis: {
    type: 'value'
  },
  series: [
    {
      name: '销量',
      type: 'bar',
      data: [5, 20, 36]
    },
    {
      name: '库存',
      type: 'bar',
      data: [15, 30, 16]
    }
  ]
};
```

------

## 📦五、常用技巧

1. ### **响应式自适应大小**

```js
window.addEventListener('resize', () => {
  myChart.resize();
});
```

1. ### **动态更新数据**

```js
myChart.setOption({
  series: [{ data: [10, 15, 22, 30] }]
});
```

1. ### **点击事件**

```js
myChart.on('click', function (params) {
  console.log(params);
});
```