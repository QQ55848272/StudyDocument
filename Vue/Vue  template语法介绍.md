# Vue  `<template>`语法介绍

在 Vue 的 `<template>` 部分，支持多种 **指令、绑定方式、事件处理和内置功能**。以下是 **Vue 2 和 Vue 3** 通用的 **模板方法大全**：

------

## **1. 插值表达式（Mustache 语法）**

```vue
<h1>{{ message }}</h1>
<p>{{ 1 + 2 }}</p>
<p>{{ isTrue ? 'Yes' : 'No' }}</p>
<p>{{ myFunction() }}</p>
```

> **⚠️ 不能在 `{{ }}` 里写多行代码或赋值操作**，但可以调用方法。

------

## **2. 指令（Directives）**

Vue 提供了一系列指令来动态绑定数据和操作 DOM。

### **(1) v-bind：属性绑定**

```vue
<img v-bind:src="imageUrl" alt="动态图片" />
<!-- 简写 -->
<img :src="imageUrl" />
```

### **(2) v-model：双向绑定**

```vue
<input v-model="username" />
<p>输入的内容：{{ username }}</p>
```

### **(3) v-if / v-else / v-else-if：条件渲染**

```vue
<p v-if="age > 18">成年人</p>
<p v-else-if="age === 18">刚成年</p>
<p v-else>未成年人</p>
```

### **(4) v-show：控制元素显示**

```vue
<p v-show="isVisible">这段文本会根据 isVisible 显示或隐藏</p>
```

> **`v-if` 直接移除/渲染 DOM，而 `v-show` 只是 `display: none`，性能不同。**

### **(5) v-for：列表渲染**

```vue
<ul>
  <li v-for="(item, index) in items" :key="index">{{ index }} - {{ item }}</li>
</ul>
```

> **`key` 需要唯一，避免渲染性能问题。**

### **(6) v-on：事件绑定**

```vue
<button v-on:click="handleClick">点击我</button>
<!-- 简写 -->
<button @click="handleClick">点击我</button>
```

### **(7) v-on 事件修饰符**

```vue
<button @click.stop="handleClick">阻止事件冒泡</button>
<button @click.prevent="submitForm">阻止默认行为</button>
<button @click.once="handleClick">只触发一次</button>
<button @click.self="handleClick">仅在自身点击时触发</button>
<button @click.capture="handleClick">事件捕获模式</button>
<button @mousewheel.passive="onScroll">优化滚动性能</button>
```

### **(8) v-model 修饰符**

```vue
<input v-model.lazy="text" /> <!-- 失去焦点时更新 -->
<input v-model.number="age" /> <!-- 自动转为数字 -->
<input v-model.trim="username" /> <!-- 去除前后空格 -->
```

### **(9) v-bind 绑定多个属性**

```vue
<div v-bind="{ id: 'app', class: activeClass }"></div>
```

### **(10) v-html：渲染 HTML**

```vue
<p v-html="htmlContent"></p>
```

> **⚠️ 小心 XSS（跨站脚本攻击）！不要渲染不受信任的 HTML。**

### **(11) v-cloak：避免闪烁**

```vue
<p v-cloak>{{ message }}</p>
<style>
[v-cloak] {
  display: none;
}
</style>
```

------

## **3. 计算属性 & 方法**

### **(1) 计算属性**

```vue
<template>
  <p>全名：{{ fullName }}</p>
</template>

<script>
export default {
  data() {
    return {
      firstName: "张",
      lastName: "三"
    };
  },
  computed: {
    fullName() {
      return this.firstName + " " + this.lastName;
    }
  }
};
</script>
```

### **(2) 直接调用方法**

```vue
<p>{{ getFullName() }}</p>

<script>
export default {
  methods: {
    getFullName() {
      return "张三";
    }
  }
};
</script>
```

> **计算属性（`computed`）具有缓存，方法（`methods`）每次都会重新计算。**

------

## **4. 组件相关**

### **(1) 组件插槽（`slot`）**

```vue
<MyComponent>
  <p>这个内容会插入到 MyComponent 里</p>
</MyComponent>
```

### **(2) 具名插槽**

```vue
<MyComponent>
  <template v-slot:header>
    <h1>这是头部</h1>
  </template>
  <template v-slot:footer>
    <p>这是底部</p>
  </template>
</MyComponent>
```

> Vue 3 可使用 **`#` 代替 `v-slot:`**，例如 `<template #header>`

------

## **5. 动态 Class & Style**

### **(1) 绑定动态类**

```vue
<div :class="{ active: isActive, 'text-danger': hasError }"></div>
<div :class="[activeClass, errorClass]"></div>
```

### **(2) 绑定动态样式**

```vue
<div :style="{ color: textColor, fontSize: fontSize + 'px' }"></div>
```

------

## **6. 条件与过滤**

### **(1) `v-if` 与 `template`**

```vue
<template v-if="isLoggedIn">
  <p>欢迎回来！</p>
</template>
```

### **(2) 过滤器（Vue 2，Vue 3 取消了此功能）**

```vue
<p>{{ price | currency }}</p>
<script>
Vue.filter("currency", function (value) {
  return "¥" + value.toFixed(2);
});
</script>
```

> **Vue 3 取消了 `filters`，可以使用计算属性代替。**

------

## **7. 事件传递**

### **(1) 子组件向父组件传递事件**

```vue
<!-- 子组件 -->
<template>
  <button @click="$emit('customEvent', '参数值')">触发事件</button>
</template>

<!-- 父组件 -->
<ChildComponent @customEvent="handleCustomEvent" />
```

------

## **总结**

| 功能       | 指令                            | 作用               |
| ---------- | ------------------------------- | ------------------ |
| 数据绑定   | `v-bind:` 或 `:`                | 绑定属性           |
| 双向绑定   | `v-model`                       | 绑定输入框         |
| 条件渲染   | `v-if` / `v-else-if` / `v-else` | 控制显示           |
| 显示隐藏   | `v-show`                        | 仅改变 `display`   |
| 列表渲染   | `v-for`                         | 遍历数据           |
| 事件监听   | `v-on:` 或 `@`                  | 监听点击等事件     |
| 事件修饰符 | `.stop` `.prevent` `.once`      | 阻止冒泡等         |
| 样式绑定   | `:class` `:style`               | 绑定动态样式       |
| 计算属性   | `computed`                      | 缓存计算           |
| 插槽       | `slot`                          | 组件内容插入       |
| 事件传递   | `$emit`                         | 子组件向父组件传值 |

这些就是 Vue 模板方法的常用技巧，你可以在项目中自由组合使用！ 🚀