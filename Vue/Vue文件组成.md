# Vue文件组成

### 1. **`<template>` 模板**

用于定义组件的 HTML 结构。

```
vue复制编辑<template>
  <div>
    <h1>{{ message }}</h1>
    <button @click="updateMessage">点击更新</button>
  </div>
</template>
```

### 2. **`<script>` 逻辑**

用于定义组件的状态、方法、生命周期等。
 Vue 3 推荐使用 **Composition API** (`setup`)，但 **Options API** (`data, methods, computed` 等) 也仍然支持。

#### **Composition API (Vue 3 推荐)**

```
vue复制编辑<script setup>
import { ref } from "vue";

const message = ref("Hello Vue!");
const updateMessage = () => {
  message.value = "Vue is awesome!";
};
</script>
```

#### **Options API (Vue 2 / Vue 3 兼容)**

```
vue复制编辑<script>
export default {
  data() {
    return {
      message: "Hello Vue!"
    };
  },
  methods: {
    updateMessage() {
      this.message = "Vue is awesome!";
    }
  }
};
</script>
```

### 3. **`<style>` 样式**

用于定义组件的 CSS 样式，可以使用 `scoped` 使样式仅作用于当前组件。

```
vue复制编辑<style scoped>
h1 {
  color: blue;
}
button {
  background-color: #42b983;
  color: white;
  padding: 5px 10px;
  border: none;
  cursor: pointer;
}
</style>
```

------

### **补充**

- **`<style scoped>`**：作用域 CSS，仅影响当前组件，避免污染全局样式。
- **`<script setup>`**（Vue 3 新特性）：更简洁高效的组合式 API 书写方式。
- **`<template>` 只能有一个根元素**，如果有多个元素，需用 `<div>` 包裹，或者使用 Vue 3 的 **Fragment** 特性（多个根节点）。