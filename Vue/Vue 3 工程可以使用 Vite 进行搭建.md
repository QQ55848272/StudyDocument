# Vue 3 工程可以使用 Vite 进行搭建



### 1. 安装 Node.js

确保你的系统已安装 Node.js（建议使用 LTS 版本），然后检查：

```shell
node -v
npm -v
```

如果未安装，可前往 [Node.js 官网](https://nodejs.org/) 下载。

------

### 2. 创建 Vue 3 项目

使用 Vite 创建 Vue 3 项目：

```shell
npm create vite@latest my-vue3-app
```

然后选择：

- **Framework**: `Vue`
- **Variant**: `JavaScript` 或 `TypeScript`（推荐 TypeScript）

或者使用 Yarn：

```shell
yarn create vite my-vue3-app --template vue
```

------

### 3. 进入项目目录并安装依赖

```shell
cd my-vue3-app
npm install
```

------

### 4. 运行项目

```shell
npm run dev
```

浏览器打开 `http://localhost:5173/` 即可看到 Vue 3 项目运行。



# Vue 3 项目项目结构

```
my-vue3-project/
│── node_modules/        # 依赖包目录
│── public/              # 静态资源，最终会直接复制到 dist 目录
│   ├── favicon.ico      # 网站图标
│   ├── index.html       # HTML 模板文件
│── src/                 # 核心源码目录
│   ├── assets/          # 资源目录（如图片、CSS）
│   ├── components/      # 组件目录
│   ├── views/           # 页面级组件（如果使用 Vue Router）
│   ├── App.vue          # 根组件
│   ├── main.js          # 入口文件
│── .gitignore           # Git 忽略文件
│── babel.config.js      # Babel 配置文件
│── package.json         # 依赖和脚本管理
│── README.md            # 项目说明文件
│── vue.config.js        # Vue CLI 配置（可选）
│── yarn.lock / package-lock.json # 依赖锁定文件
```

## 📂 1. `node_modules/`

- 存放所有 **npm/yarn** 安装的依赖库，不要手动修改。
- 该目录通常不会提交到 Git（在 `.gitignore` 里忽略）。

------

## 📂 2. `public/` —— 静态资源目录

Vue CLI 默认不会对 `public` 目录的文件进行 Webpack 处理，直接复制到 `dist/` 目录中。

- **`index.html`**：
  - 这个 HTML 是 Vue 挂载的入口，`<div id="app"></div>` 是 Vue 应用的挂载点。
  - 你可以在这里添加 CDN 引入的第三方库（如 Bootstrap、Google Fonts）。
- **`favicon.ico`**：
  - 网站图标，可替换自己的图标。

------

## 📂 3. `src/` —— 核心源码目录

这个目录包含所有 Vue 组件、逻辑代码，是开发的主要部分。

### 📁 `assets/` —— 资源文件

- 存放静态资源，如图片、CSS、SVG、字体等。

- Webpack 会处理这里的资源，引用时可以使用：

  ```vue
  <img src="@/assets/logo.png" />
  ```

  @ 代表 src/目录的别名，避免写长路径。

### 📁 `components/` —— 复用组件

- 存放 Vue 组件，组件通常是**可复用的 UI 单元**，例如按钮、模态框等。

- 组件通常以 .vue 结尾：

  ```vue
  <!-- Button.vue -->
  <template>
    <button class="btn">{{ text }}</button>
  </template>
  <script setup>
  defineProps({ text: String });
  </script>
  <style scoped>
  .btn { background-color: blue; color: white; }
  </style>
  ```

### 📁 `views/` —— 页面级组件

- 如果使用 Vue Router，这里存放的是完整的页面级组件。

- 例如 Home.vue、About.vue 等：

  ```vue
  <!-- Home.vue -->
  <template>
    <div>首页内容</div>
  </template>
  ```

### 📁 `router/` —— 路由配置（如果使用 Vue Router）

- 负责管理前端路由，通常有一个 index.js：

  ```js
  // src/router/index.js
  import { createRouter, createWebHistory } from "vue-router";
  import Home from "@/views/Home.vue";
  import About from "@/views/About.vue";
  
  const routes = [
    { path: "/", component: Home },
    { path: "/about", component: About }
  ];
  
  const router = createRouter({
    history: createWebHistory(),
    routes,
  });
  
  export default router;
  ```

- `router` 需要在 `main.js` 里挂载。

### 📁 `store/` —— 状态管理（Vuex 或 Pinia）

- 存放全局状态管理的代码，Vue 3 推荐使用 

  Pinia 代替 Vuex：

  ```js
  // src/store/index.js (Pinia 示例)
  import { defineStore } from "pinia";
  
  export const useCounterStore = defineStore("counter", {
    state: () => ({ count: 0 }),
    actions: { increment() { this.count++; } }
  });
  ```

- 需要在 `main.js` 里引入。

### 📁 `utils/` —— 工具函数

- 存放公共工具函数，比如时间格式化、数据转换等：

  ```js
  // src/utils/date.js
  export function formatDate(date) {
    return new Date(date).toLocaleDateString();
  }
  ```

### 📁 `styles/` —— 全局样式

- 存放全局 CSS、SASS 或 Tailwind 相关的样式：

  ```css
  /* src/styles/global.css */
  body { font-family: Arial, sans-serif; }
  ```

------

## 📜 4. 重要文件解析

### **`App.vue`** —— 根组件

Vue 应用的最顶层组件，所有子组件都会挂载到这里：

```vue
<template>
  <router-view />  <!-- 显示路由组件 -->
</template>
```

### **`main.js`** —— 入口文件

Vue 应用的启动文件，负责创建 Vue 实例并挂载到 `#app`：

```js
import { createApp } from "vue";
import App from "./App.vue";
import router from "./router"; // 引入路由
import { createPinia } from "pinia"; // Vuex 替代方案

const app = createApp(App);
app.use(router);
app.use(createPinia());
app.mount("#app");
```

### **`.gitignore`** —— Git 忽略文件

- 避免不必要的文件（如 `node_modules/`）被提交到 Git。

### **`babel.config.js`** —— Babel 配置

- 让 Vue 代码可以兼容旧版浏览器。

### **`vue.config.js`** —— Vue CLI 配置

- 可选文件，用户自定义 Webpack 配置。

### **`package.json`** —— 依赖和脚本管理

- 记录 Vue 依赖项和 npm/yarn 运行脚本：

  ```josn
  {
    "scripts": {
      "serve": "vue-cli-service serve",
      "build": "vue-cli-service build"
    }
  }
  ```

------

## 总结：

- `public/`：存放静态资源，不会被 Webpack 处理。
- `src/`：核心代码，包括组件、页面、状态管理、工具函数等。
- `views/`：页面级组件，通常和 Vue Router 配合使用。
- `components/`：通用可复用的 Vue 组件。
- `router/`：管理前端路由（Vue Router）。
- `store/`：状态管理（Vuex / Pinia）。
- `utils/`：存放工具函数。
- `styles/`：全局样式文件。