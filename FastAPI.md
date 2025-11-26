---
fastapi_project/
├── main.py                # 应用入口
├── config.py              # 数据库配置
├── models/                # Pydantic 和 ORM 模型
│   └── user_model.py
├── routers/               # 路由层
│   └── user.py
├── services/              # 业务逻辑层
│   └── user_service.py
├── database/              # 数据库连接、会话
│   └── session.py
├── crud/                  # 数据访问层
│   └── user_crud.py
└── requirements.txt       # 依赖
---

# FastAPI 工程架构

## 依赖（requirements.txt）

```txt
fastapi
uvicorn[standard]
sqlalchemy
pymysql
```

```bash
pip install -r requirements.txt
```

## 

##  一、基础层优先（模型 + 配置）

### 1.1 `config.py`（配置文件）

```
DATABASE_URL = "mysql+pymysql://user:pass@host:port/db"
```

### 1.2 models/doris_table_structure.py`

- 创建 ORM 模型 `DorisTableStructureDetail`（用于建表、查询）
- 定义 Pydantic 模型 `DorisTableStructureCreate`、`DorisTableStructureResponse`

### 1.3 `database/session.py`

- 创建数据库引擎
- 定义 `SessionLocal` 和依赖 `get_db()`

------

## 二、逻辑层（业务处理）

### `services/table_structure_service.py`

- 书写逻辑函数（增删改查）
- **注意：不能依赖 FastAPI，只依赖 SQLAlchemy、模型**

------

##  三、接口层（路由）

### `routers/table_structure.py`

- 每个函数负责调用 `service` 中的方法
- 使用 `Depends(get_db)` 注入数据库连接
- 写 `@router.post()`、`@router.get()` 等

------

##  四、主程序入口

### main.py`

- 创建 FastAPI 实例 `app`
- 执行 `Base.metadata.create_all(...)` 建表
- 引入并挂载所有路由 `include_router(...)`

------

##  总结：推荐书写顺序列表

| 步骤 | 文件                                  | 内容                           |
| ---- | ------------------------------------- | ------------------------------ |
| 1    | `config.py`                           | 数据库连接配置                 |
| 2    | `models/doris_table_structure.py`     | ORM + Pydantic 模型定义        |
| 3    | `database/session.py`                 | 引擎、SessionLocal、get_db     |
| 4    | `services/table_structure_service.py` | 写具体业务处理逻辑（调用 ORM） |
| 5    | `routers/table_structure.py`          | 写接口，调用 service，注入 DB  |
| 6    | `main.py`                             | 启动应用、创建表、挂载路由     |



###  运行 FastAPI

进入项目根目录，执行：

```
uvicorn main:app --reload --host 0.0.0.0 --port 8000

nohup uvicorn main:app --reload --host 0.0.0.0 --port 8000 > /opt/apps/MetaApp/uvicorn.log 2>&1 &
```



- 打开浏览器访问 **Swagger UI**：

```
http://127.0.0.1:8000/docs
```



# FastAPI 知识点体系

## 一. 基础概念

### 1.FastAPI 简介与特点

#### 1.1 **高性能**

- 基于 **Starlette + Uvicorn**，异步支持好
- 性能接近 **Node.js / Go**，远高于 Flask、Django REST Framework

#### 1.2 **开发效率高**

- 自动生成 **Swagger UI** 和 **ReDoc** 文档
- 开发者无需额外编写文档，接口即代码，所见即所得
- 快速原型开发，减少大量样板代码

#### 1.3. **数据验证强大**

- 内置 **Pydantic**，支持请求/响应的数据验证和序列化
- 自动检查类型、范围、正则、枚举
- 保证输入输出的正确性，减少运行时错误

#### 1.4. **类型提示友好**

- 使用 Python 的 **类型注解 (type hints)**
- IDE（如 PyCharm、VSCode）可以智能提示、自动补全
- 静态检查工具（mypy、pylance）支持良好

#### 1.5. **异步支持**

- 原生支持 `async/await`
- 适合高并发、IO 密集型应用（数据库、API 网关、微服务调用）

#### 1.6. **灵活的依赖注入**

- 使用 `Depends` 机制实现依赖注入
- 可复用组件：数据库连接、认证逻辑、中间件
- 代码解耦，易于维护和扩展

#### 1.7. **安全与认证**

- 内置支持 **OAuth2、JWT、API Key** 等认证方式
- 对接第三方认证服务方便

#### 1.8. **生态与扩展**

- 可与 **SQLAlchemy / Tortoise ORM / Beanie** 等 ORM 搭配
- 支持 **WebSocket、GraphQL、后台任务、微服务** 等场景

------

#### 1.9 总结

 **FastAPI = 高性能 + 自动文档 + 强类型验证 + 异步优先**，非常适合做 **现代化 API 服务**（特别是 AI 服务、微服务、数据平台接口）。

------

------



### 2 ASGI（替代 WSGI）

#### 2.1WSGI 简单回顾

**WSGI（Web Server Gateway Interface）** 是 Python Web 的传统标准接口，用于 **同步 Web 应用**。

- 典型使用：Flask、Django（传统模式）
- 工作方式：
  - Web 服务器（如 Gunicorn）接收到请求
  - 调用 Python 应用的 WSGI 接口
  - 应用返回响应
- **特点**：
  - 同步处理请求
  - 每个请求一个线程或进程
  - 不适合高并发和 WebSocket

**缺点**：

1. 无法原生支持 **异步/并发请求**
2. 无法处理 **WebSocket、长连接、HTTP2**
3. 高并发场景性能受限（线程/进程切换开销大）

------

#### 2.2 ASGI 简介

**ASGI（Asynchronous Server Gateway Interface）** 是 WSGI 的异步升级版。

- 支持 **异步 Web 应用**
- 可处理 **HTTP、WebSocket、HTTP2、后台任务** 等多种通信协议
- FastAPI、Starlette 都基于 ASGI

#### 核心特点

1. **异步优先**
   - 原生支持 `async/await`
   - 适合高并发 IO 密集型应用
2. **协议灵活**
   - HTTP、WebSocket、HTTP2、GraphQL 订阅
3. **可拓展**
   - 支持中间件、生命周期事件
   - 与 Celery、Redis Pub/Sub 等后台任务和事件驱动架构结合更自然
4. **高性能**
   - 结合 Uvicorn / Hypercorn 等 ASGI 服务器，可达到接近 Go 或 Node.js 的性能

------

#### 2.3 WSGI vs ASGI 对比

| 特性      | WSGI                      | ASGI                                |
| --------- | ------------------------- | ----------------------------------- |
| 异步支持  | ❌ 不支持                  | ✅ 原生支持 async/await              |
| WebSocket | ❌ 不支持                  | ✅ 支持                              |
| 协议      | 仅 HTTP                   | HTTP、WebSocket、HTTP2              |
| 性能      | 中等，高并发需多进程/线程 | 高性能，支持异步并发                |
| 框架例子  | Flask、Django（同步模式） | FastAPI、Starlette、Django Channels |

------

#### 2.4 FastAPI + ASGI

- FastAPI 本身是 **异步框架**，使用 ASGI 服务器（如 **Uvicorn**）部署
- 优势：
  - 高并发请求不阻塞
  - 可支持 WebSocket、实时消息推送
  - 数据处理、模型推理等 IO 操作可以异步执行，提高吞吐量

------

#### 2.5 总结：

 **ASGI 是 WSGI 的现代化升级版，支持异步、WebSocket 和高并发，适合现代 Python Web 框架（如 FastAPI）使用**。

------

------



### 3. Uvicorn / Gunicorn 部署

#### 3.1 Uvicorn

- **类型**：纯 Python 的 ASGI 服务器
- **特点**：
  - 轻量、启动快
  - 支持 **异步 I/O**（async/await）
  - 默认 **单进程**（可以用 `--workers` 指定多进程）
- **适用场景**：
  - 开发环境（快速调试，支持 `--reload` 热重载）
  - 小型生产环境（CPU/请求量不大）

```shell
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```



#### 3.2 Gunicorn + Uvicorn Worker

- **类型**：Gunicorn 是 WSGI/ASGI 多进程服务器 + Uvicorn 提供 ASGI Worker
- **特点**：
  - 适合 **生产环境**，支持多 worker 进程
  - 稳定、性能高，能充分利用多核 CPU
  - 可与 Nginx/负载均衡器配合
- **适用场景**：
  - 生产部署，API 请求量大
  - 需要多进程处理并发请求

```shell
gunicorn main:app -w 4 -k uvicorn.workers.UvicornWorker -b 0.0.0.0:8000
```

- main:app` → `main.py` 文件里 `app = FastAPI()
- `--workers 4` → 建议 CPU 核心数或稍少
- `--host 0.0.0.0` → 外网可访问

#### 3.3 核心区别总结

| 特性       | Uvicorn                    | Gunicorn + Uvicorn Worker      |
| ---------- | -------------------------- | ------------------------------ |
| 进程模型   | 单进程（可指定 --workers） | 多进程 Worker，更稳定          |
| 开发/生产  | 开发友好                   | 生产友好，负载均衡更佳         |
| 热重载     | 支持 `--reload`            | 不支持热重载                   |
| 性能       | 较轻量                     | 高并发、稳定，多核利用率更高   |
| 部署复杂度 | 简单                       | 稍复杂，需要理解 Gunicorn 配置 |

#### 3.4 总结

- **开发环境** → 用 **Uvicorn** + `--reload`
- **生产环境** → 用 **Gunicorn + Uvicorn Worker** 多进程部署

------

------



## 二. 路由与请求处理

### 1 路由定义

#### 1.1 基本概念

在 FastAPI 中，**路由**就是定义 **客户端请求 → 服务器函数处理 → 返回结果** 的映射。

常用装饰器：

| 装饰器              | HTTP 方法 | 用法示例                 |
| ------------------- | --------- | ------------------------ |
| `@app.get(path)`    | GET       | 用于获取资源（查询数据） |
| `@app.post(path)`   | POST      | 用于创建资源或提交数据   |
| `@app.put(path)`    | PUT       | 用于更新资源             |
| `@app.delete(path)` | DELETE    | 用于删除资源             |
| `@app.patch(path)`  | PATCH     | 用于部分更新资源         |

------

#### 1.2 示例代码

```python
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI(title="示例 API")

# 数据模型
class Item(BaseModel):
    name: str
    value: int

# GET 请求（查询）
@app.get("/hello")
def read_hello():
    return {"message": "Hello World"}

# GET 带参数
@app.get("/items/{item_id}")
def read_item(item_id: int, q: str = None):
    return {"item_id": item_id, "query": q}

# POST 请求（创建资源）
@app.post("/items")
def create_item(item: Item):
    return {"name": item.name, "value": item.value}

# PUT 请求（更新资源）
@app.put("/items/{item_id}")
def update_item(item_id: int, item: Item):
    return {"item_id": item_id, "name": item.name, "value": item.value}

# DELETE 请求（删除资源）
@app.delete("/items/{item_id}")
def delete_item(item_id: int):
    return {"deleted_item_id": item_id}
```

#### 1.3 FastAPI 的特点

- 路由自动支持 **参数校验**
- 支持 **请求体、查询参数、路径参数**
- 支持 **异步函数**：

```python
@app.get("/async_test")
async def async_test():
    return {"msg": "async support"}
```

------

------



### 2 路径参数、查询参数



#### 2.1 路径参数（Path Parameters）

- **定义**：直接写在 URL 路径里的参数，用 `{}` 包裹
- **特点**：
  - 必须提供
  - 类型可以指定（FastAPI 会自动校验和转换）
  - RESTful 风格推荐使用
- **用法示例**：

```
from fastapi import FastAPI

app = FastAPI()

# item_id 是路径参数
@app.get("/items/{item_id}")
def read_item(item_id: int):
    return {"item_id": item_id}
```

请求示例：

```
curl http://127.0.0.1:8000/items/123
# 返回: {"item_id":123}
```

> FastAPI 会自动把 `item_id` 转换为 `int`，如果传了非整数会返回 422 错误。



#### 2.2 查询参数（Query Parameters）

#####  **概念：**

- 查询参数在 URL `?` 后面，用 `key=value` 表示

- 查询参数在 URL `?` 后面，用 `key=value` 表示

**定义**：在 URL `?key=value` 形式传递的参数

**特点：**

- 可选（可以指定默认值）
- 类型可以指定（自动校验转换）

**用法示例**：

```python
@app.get("/items")
def read_items(q: str = None, limit: int = 10):
    return {"query": q, "limit": limit}
```

请求示例：

```bash
curl http://127.0.0.1:8000/items?q=abc&limit=5
# 返回: {"query":"abc","limit":5}
curl http://127.0.0.1:8000/items
# 返回: {"query": null,"limit":10}  # 使用默认值
```

------

#### 2.3路径参数 vs 查询参数

| 特性         | 路径参数                 | 查询参数                   |
| ------------ | ------------------------ | -------------------------- |
| 位置         | URL 路径中 `/items/{id}` | URL `?key=value`           |
| 是否必须     | 必须                     | 可选（可有默认值）         |
| 用途         | 标识资源                 | 过滤、分页、搜索、可选参数 |
| 自动类型校验 | 是                       | 是                         |
| 类型         | 单值为主，也可嵌套       | 单值、列表、布尔等均可     |

**注：**识资源就是用唯一的标识符（ID）来明确指出系统中的某个特定对象。

------

#### 2.4综合示例

```python
@app.get("/users/{user_id}/items")
def get_user_items(user_id: int, category: str = None, limit: int = 10):
    return {
        "user_id": user_id,        # 路径参数
        "category": category,      # 查询参数
        "limit": limit             # 查询参数
    }
```

请求示例：

```bash
curl "http://127.0.0.1:8000/users/42/items?category=books&limit=5"
# 返回: {"user_id":42,"category":"books","limit":5}
```

------

------



### 3 请求体 (`Body`)

#### 3.1 请求体 (Body) 概念

- **请求体** 是客户端向服务器发送数据的一部分，不在 URL 中，而是随 HTTP 请求的 **body** 发送。
- 常用于 **POST、PUT、PATCH** 等需要提交数据的请求。
- 在 FastAPI 中，通过 **Pydantic 模型** 或 `Body()` 注解获取请求体。

------

#### 3.2 使用场景

1. **创建资源**
   - 客户端提交完整对象信息，例如新增用户、创建订单
   - 示例 URL: `/users`（POST）
2. **更新资源**
   - 提交修改后的字段信息，例如修改用户资料
   - 示例 URL: `/users/{user_id}`（PUT / PATCH）
3. **提交复杂 JSON 数据**
   - 请求体可以是嵌套结构、数组、字典
   - 适合表单不便或数据结构复杂的场景

------

#### 3.3 基本示例

```python
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

# 定义请求体模型
class User(BaseModel):
    name: str
    age: int
    email: str

# POST 请求，获取请求体
@app.post("/users")
async def create_user(user: User):
    return {"msg": f"User {user.name} created", "user": user}
```

**调用示例（POST /users）**：

```json
{
  "name": "Alice",
  "age": 25,
  "email": "alice@example.com"
}
```

**返回**：

```json
{
  "msg": "User Alice created",
  "user": {
    "name": "Alice",
    "age": 25,
    "email": "alice@example.com"
  }
}
```

------

#### 3.4 请求体特点

| 特性     | 描述                                |
| -------- | ----------------------------------- |
| 数据位置 | HTTP body，不在 URL                 |
| 适合     | POST、PUT、PATCH                    |
| 支持格式 | JSON（默认）、表单、文件            |
| 验证方式 | Pydantic 模型自动验证字段类型和约束 |
| 可选字段 | 使用 `Optional` 或默认值            |

------

#### 3.5 与路径参数、查询参数对比

| 类型     | 数据位置                       | 用途                        | 是否必须           |
| -------- | ------------------------------ | --------------------------- | ------------------ |
| 路径参数 | URL 路径 `/users/{id}`         | 标识资源                    | ✅ 必须             |
| 查询参数 | URL 查询字符串 `/users?page=2` | 过滤、分页、搜索            | ❌ 可选             |
| 请求体   | HTTP Body                      | 创建/更新资源，提交复杂数据 | ❌ 可选，视业务而定 |

------

💡 **总结**：

- **路径参数** → 标识资源
- **查询参数** → 过滤/分页/搜索
- **请求体 (Body)** → 提交完整对象或复杂数据，用于创建或更新资源



### 4 表单与文件上传 (`Form`, `File`, `UploadFile`)

#### 4.1概念

在 HTTP 请求中，**表单与文件上传**通常通过 `multipart/form-data` 发送数据：

- **Form**：处理普通表单字段
- **File / UploadFile**：处理上传的文件

FastAPI 提供专用类型 **`Form`、`File`、`UploadFile`** 来获取这些数据。

------

#### 4.2`Form` 使用

##### 概念

- 用于接收表单字段（非 JSON）
- 类似传统 HTML 表单提交

##### 示例

```python
from fastapi import FastAPI, Form

app = FastAPI()

@app.post("/login")
async def login(username: str = Form(...), password: str = Form(...)):
    return {"username": username, "password": password}
```

**说明**：

- `Form(...)` 表示该字段必填
- 客户端用 `application/x-www-form-urlencoded` 或 `multipart/form-data` 提交

------

#### 4.3`File` 与 `UploadFile` 使用

##### 概念

- **File**：直接读取文件字节 (`bytes`)
- **UploadFile**：更高效，支持异步操作，提供文件名、内容类型、临时文件流

##### 示例

```python
from fastapi import FastAPI, File, UploadFile

app = FastAPI()

# 直接读取字节
@app.post("/uploadfile_bytes")
async def upload_bytes(file: bytes = File(...)):
    return {"file_size": len(file)}

# 使用 UploadFile
@app.post("/uploadfile")
async def upload_file(file: UploadFile = File(...)):
    return {
        "filename": file.filename,
        "content_type": file.content_type
    }
```

**特点对比**：

| 类型         | 数据类型     | 适合场景           | 优点                       |
| ------------ | ------------ | ------------------ | -------------------------- |
| `bytes`      | `bytes`      | 小文件、一次性读取 | 简单直接                   |
| `UploadFile` | `UploadFile` | 大文件、异步处理   | 不占用大量内存，支持 async |

------

#### 4.4 表单 + 文件同时上传

```python
from fastapi import FastAPI, Form, File, UploadFile

app = FastAPI()

@app.post("/submit")
async def submit_form(
    username: str = Form(...),
    password: str = Form(...),
    avatar: UploadFile = File(...)
):
    return {
        "username": username,
        "password": password,
        "filename": avatar.filename
    }
```

**说明**：

- 可以同时接收普通表单字段和文件
- 常用于注册用户上传头像或提交复杂表单

------

#### 4.5 应用场景总结

| 类型         | 场景示例                              |
| ------------ | ------------------------------------- |
| `Form`       | 登录、注册、普通表单提交              |
| `File`       | 小文件上传、一次性处理                |
| `UploadFile` | 大文件上传、图片、视频、PDF、异步处理 |
| 表单 + 文件  | 用户注册 + 上传头像、提交带附件的表单 |

------

#### 4.6 总结

- `Form` → 获取表单字段
- `File` → 获取文件字节（简单）
- `UploadFile` → 获取文件对象（高效，适合大文件）
- 表单和文件可以同时上传，常见于用户注册或资料提交场景

## 三. 数据验证与序列化

### 1 Pydantic 模型

#### 1.1 Pydantic 模型概念

- **Pydantic** 是一个 Python 数据验证和解析库
- **核心作用**：将原始数据（如 JSON）**转换成 Python 类型**，并 **自动校验字段类型和约束**
- 在 FastAPI 中，Pydantic 模型用于：
  1. **请求体验证**（Request Body）
  2. **响应体序列化**（Response Model）

------

#### 1.2 核心特点

| 特性         | 描述                                                     |
| ------------ | -------------------------------------------------------- |
| 类型验证     | 自动检查字段类型（str、int、float、bool、list、dict 等） |
| 数据转换     | 自动将输入值转换为目标类型（如 `"123"` → `int 123`）     |
| 必填/可选    | 通过 `Optional` 或默认值设置                             |
| 嵌套模型     | 支持复杂数据结构和列表嵌套                               |
| 数据校验     | 支持正则、最大值/最小值、长度限制、枚举等                |
| 友好错误提示 | 输入不合法时返回清晰的错误信息                           |

------

#### 1.3 基本用法示例

##### ① 定义请求体模型

```python
from pydantic import BaseModel

class User(BaseModel):
    name: str
    age: int
    email: str
```

##### ② 使用模型作为请求体

```python
from fastapi import FastAPI

app = FastAPI()

@app.post("/users")
async def create_user(user: User):
    return {"msg": f"User {user.name} created", "user": user}
```

##### 调用示例（POST JSON 请求）：

```python
{
  "name": "Alice",
  "age": 25,
  "email": "alice@example.com"
}
```

------

##### ③ 嵌套模型

```python
from typing import List

class Address(BaseModel):
    city: str
    zipcode: str

class User(BaseModel):
    name: str
    age: int
    addresses: List[Address]

# 请求体可以提交复杂嵌套 JSON
```

------

##### ④ 可选字段和默认值

```python
from typing import Optional

class User(BaseModel):
    name: str
    age: int = 18          # 默认值
    email: Optional[str]   # 可选字段
```

------

##### ⑤ 字段校验（示例）

```python
from pydantic import BaseModel, Field, EmailStr

class User(BaseModel):
    name: str = Field(..., min_length=2, max_length=20)
    age: int = Field(..., gt=0, lt=150)
    email: EmailStr
```

- `Field(..., min_length=2)` → 必填字段，最少长度 2
- `gt` / `lt` → 数值范围
- `EmailStr` → 内置邮箱格式验证

------

#### 1.4  Pydantic 在 FastAPI 的应用场景

| 场景     | 用法                                               |
| -------- | -------------------------------------------------- |
| 请求体   | POST / PUT 请求的数据验证和解析                    |
| 响应体   | 通过 `response_model` 自动生成返回 JSON 且校验类型 |
| 查询参数 | 可以嵌套复杂查询模型（可选）                       |
| 数据转换 | 自动将 JSON 数据转换为 Python 对象                 |

------

#### 1.5 总结

- Pydantic 模型是 FastAPI 的 **核心组成部分**
- 负责 **数据验证、类型转换、嵌套结构管理**
- 简化开发，减少手写校验逻辑，提高接口安全性和可维护性

### 2 数据验证（字段类型、默认值、正则、枚举等）

#### 2.1字段类型验证

- Pydantic 会根据字段类型自动验证输入数据
- 常用类型：`str`、`int`、`float`、`bool`、`list`、`dict`、`datetime` 等

##### 示例

```python
from pydantic import BaseModel

class User(BaseModel):
    name: str
    age: int
    is_active: bool

# 自动验证类型
user = User(name="Alice", age="25", is_active="true")
# age 和 is_active 会自动转换为 int 和 bool
```

##### **特点**：

- 输入类型错误会返回 422 Unprocessable Entity
- 自动转换合法字符串为对应类型

------

#### 2.2 默认值与可选字段

- **默认值**：字段未传入时使用默认值
- **Optional**：字段可选

```python
from typing import Optional

class User(BaseModel):
    name: str
    age: int = 18          # 默认值
    email: Optional[str]   # 可选字段
```

调用时：

```json
{
  "name": "Alice"
}
```

- age → 18
- email → None

------

### 2.3 正则验证

- 使用 `constr` 或 `Field` + `regex` 对字符串字段进行正则校验

```python
from pydantic import BaseModel, constr

class User(BaseModel):
    username: constr(regex=r'^[a-zA-Z0-9_]{3,20}$')  # 3-20位字母、数字、下划线
```

或使用 `Field`：

```python
from pydantic import Field

class User(BaseModel):
    phone: str = Field(..., regex=r'^\+?\d{10,15}$')  # 验证手机号
```

------

#### 2.4 枚举验证

- 使用 Python 内置 `Enum` 类型，限制字段值为固定集合

```python
from pydantic import BaseModel
from enum import Enum

class Gender(str, Enum):
    male = "male"
    female = "female"
    unknown = "unknown"

class User(BaseModel):
    name: str
    gender: Gender
```

调用示例：

```json
{"name": "Alice", "gender": "female"}  # ✅
{"name": "Bob", "gender": "other"}     # ❌ 422 错误
```

------

#### 2.5 数值和长度约束

- 使用 `Field` 约束数值范围、长度

```python
from pydantic import BaseModel, Field

class Product(BaseModel):
    price: float = Field(..., gt=0, lt=10000)      # 0 < price < 10000
    name: str = Field(..., min_length=2, max_length=50)
```

- gt / ge → 大于 / 大于等于
- lt / le → 小于 / 小于等于

------

#### 2.6 总结应用场景

| 验证类型          | 用法                                 | 场景示例                 |
| ----------------- | ------------------------------------ | ------------------------ |
| 字段类型          | int/str/bool/list 等                 | 用户年龄必须是整数       |
| 默认值 & Optional | age: int = 18                        | 用户未填年龄，默认 18    |
| 正则              | constr(regex=...) / Field(regex=...) | 用户名、手机号、邮箱格式 |
| 枚举              | Enum                                 | 性别、状态、角色限制     |
| 数值 / 长度约束   | Field(gt=0, lt=100)                  | 商品价格范围、字符串长度 |

------

#### 2.7总结

- Pydantic 的数据验证极大减少了手写校验代码
- 自动生成 422 错误响应，保证接口数据安全
- 可以组合多种验证（类型 + 范围 + 正则 + 枚举）

------

------



### 3 嵌套模型与复杂数据结构

#### 3.1 概念

- **嵌套模型**：Pydantic 模型中包含另一个模型作为字段
- **复杂数据结构**：列表、字典、嵌套组合等
- 用途：处理请求体或响应体中 **多层次、复杂 JSON 数据**

------

#### 3.2 基本示例：嵌套模型

```python
from typing import List
from pydantic import BaseModel

# 嵌套模型
class Address(BaseModel):
    city: str
    zipcode: str

class User(BaseModel):
    name: str
    age: int
    addresses: List[Address]  # 嵌套列表
```

##### 调用示例

```json
{
  "name": "Alice",
  "age": 25,
  "addresses": [
    {"city": "Beijing", "zipcode": "100000"},
    {"city": "Shanghai", "zipcode": "200000"}
  ]
}
```

- FastAPI 会自动解析 JSON → Python 对象
- 自动验证每一层字段类型和约束

------

#### 3.3 嵌套字典示例

```python
from pydantic import BaseModel
from typing import Dict

class Item(BaseModel):
    name: str
    price: float

class Order(BaseModel):
    order_id: int
    items: Dict[str, Item]  # 字典嵌套
```

##### 调用示例

```json
{
  "order_id": 1001,
  "items": {
    "item1": {"name": "Apple", "price": 5.5},
    "item2": {"name": "Banana", "price": 3.0}
  }
}
```

------

#### 3.4 支持的复杂类型

| 类型            | 描述       | 示例                         |
| --------------- | ---------- | ---------------------------- |
| List / Sequence | 列表嵌套   | `addresses: List[Address]`   |
| Dict / Mapping  | 字典嵌套   | `items: Dict[str, Item]`     |
| Optional        | 可选嵌套   | `address: Optional[Address]` |
| Union           | 多类型选择 | `data: Union[str, int]`      |

------

#### 3.5 响应体嵌套模型示例

```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/users/{user_id}", response_model=User)
async def get_user(user_id: int):
    return {
        "name": "Alice",
        "age": 25,
        "addresses": [
            {"city": "Beijing", "zipcode": "100000"}
        ]
    }
```

- FastAPI 会自动把嵌套模型序列化成 JSON
- 保证返回数据结构与 `response_model` 定义一致

------

#### 3.6 应用场景

| 场景            | 示例                       |
| --------------- | -------------------------- |
| 用户 + 地址列表 | 用户注册接口，提交多个地址 |
| 订单 + 商品字典 | 电商订单提交，多个商品信息 |
| 配置文件        | 提交复杂 JSON 配置结构     |
| 嵌套权限角色    | 用户角色权限层级管理       |

------

💡 **总结**：

- 嵌套模型 + 复杂数据结构 → FastAPI 支持 **任意层次 JSON 数据验证和序列化**
- 自动解析 JSON → Python 对象，并校验每一层字段类型和约束
- 提升开发效率，保证数据安全和结构一致性

### 4 响应模型 (`response_model`)

#### 4.1 概念

- **响应模型**（`response_model`）是 FastAPI 中用于定义接口 **返回数据结构** 的 Pydantic 模型
- 作用：
  1. **数据校验**：确保返回的数据类型和字段符合模型定义
  2. **数据过滤**：自动剔除不在模型中的字段
  3. **自动文档**：Swagger UI 会显示响应数据结构

------

#### 4.2 基本示例

```python
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class UserOut(BaseModel):
    name: str
    age: int

@app.get("/users/{user_id}", response_model=UserOut)
async def get_user(user_id: int):
    # 原始数据可能包含敏感字段
    user_data = {"name": "Alice", "age": 25, "password": "123456"}
    return user_data
```

**调用结果**：

```json
{
  "name": "Alice",
  "age": 25
}
```

- `password` 字段被自动过滤掉
- 确保接口只返回定义好的字段

------

#### 4.3 嵌套响应模型

```python
from typing import List

class Address(BaseModel):
    city: str
    zipcode: str

class UserOut(BaseModel):
    name: str
    age: int
    addresses: List[Address]

@app.get("/users/{user_id}", response_model=UserOut)
async def get_user(user_id: int):
    return {
        "name": "Alice",
        "age": 25,
        "addresses": [
            {"city": "Beijing", "zipcode": "100000"},
            {"city": "Shanghai", "zipcode": "200000"}
        ],
        "password": "123456"  # 会被过滤
    }
```

- 支持嵌套模型和列表
- 自动校验每一层数据

------

#### 4.4 响应模型的高级用法

##### ① 响应列表

```python
@app.get("/users/", response_model=List[UserOut])
async def list_users():
    return [
        {"name": "Alice", "age": 25, "addresses": []},
        {"name": "Bob", "age": 30, "addresses": []}
    ]
```

##### ② 响应别名

- 使用 `alias` 改变返回字段名

```
from pydantic import Field

class UserOut(BaseModel):
    username: str = Field(..., alias="name")
```

##### ③ 响应字段可选或默认值

```
class UserOut(BaseModel):
    name: str
    age: int = 18  # 默认值
    email: str = None  # 可选
```

------

#### 4.5 应用场景

| 场景         | 用法                             |
| ------------ | -------------------------------- |
| 数据过滤     | 去掉敏感字段（如密码、token）    |
| 数据校验     | 保证返回数据类型和字段正确       |
| 自动文档     | Swagger UI 自动显示返回结构      |
| 响应嵌套数据 | 用户 + 地址列表、订单 + 商品列表 |
| 集合响应     | 返回列表、字典等复杂结构         |

## 四. 依赖注入系统

### 1 Depends 机制

#### 1.1 概念

- **`Depends`** 是 FastAPI 的 **依赖注入机制**
- 用于 **复用逻辑、解耦代码、注入外部资源**
- 可以将函数或类作为依赖，通过参数自动传入
- 支持 **同步 / 异步函数**



#### 1.2 基本作用

1. **复用逻辑**
   - 例如数据库连接、用户认证、权限验证
2. **解耦业务代码**
   - 控制器函数只关心业务逻辑
3. **自动处理生命周期**
   - 可用于初始化 / 清理资源
4. **参数注入**
   - 自动将依赖函数的返回值作为参数传入主函数

------

#### 1.3 基本示例

##### ① 简单依赖函数

```python
from fastapi import FastAPI, Depends

app = FastAPI()

# 定义依赖函数
def common_parameters(q: str = None, limit: int = 10):
    return {"q": q, "limit": limit}

# 在路由中使用 Depends
@app.get("/items/")
async def read_items(params: dict = Depends(common_parameters)):
    return params
```

- 访问 `/items/?q=fastapi&limit=5`
- 输出：

```json
{"q": "fastapi", "limit": 5}
```

------

##### ② 用户认证示例

```
from fastapi import Header, HTTPException

# 模拟认证依赖
async def get_token_header(x_token: str = Header(...)):
    if x_token != "fake-super-secret-token":
        raise HTTPException(status_code=400, detail="Invalid X-Token")
    return x_token

@app.get("/users/me")
async def read_current_user(token: str = Depends(get_token_header)):
    return {"token": token}
```

- 请求头 `X-Token: fake-super-secret-token` 才能通过
- 认证逻辑独立于路由，实现复用

------

##### ③ 嵌套依赖

```
async def query_extractor(q: str = None):
    return q

async def query_or_cookie_extractor(
    q: str = Depends(query_extractor),
    last_query: str = None
):
    return q or last_query

@app.get("/items/")
async def read_query(query: str = Depends(query_or_cookie_extractor)):
    return {"query": query}
```

- `Depends` 可以嵌套，实现复杂依赖组合

------

#### 1.4 类依赖

```
class CommonQuery:
    def __init__(self, q: str = None, limit: int = 10):
        self.q = q
        self.limit = limit

@app.get("/items/")
async def read_items(commons: CommonQuery = Depends()):
    return {"q": commons.q, "limit": commons.limit}
```

- 类依赖可以存储状态
- 可用于数据库连接、配置对象等

------

#### 1.5 应用场景

| 场景           | 示例                       |
| -------------- | -------------------------- |
| 参数复用       | 公共查询参数、分页参数     |
| 认证 / 授权    | 用户身份验证、权限校验     |
| 数据库连接     | 注入 Session / 连接池      |
| 配置或环境变量 | 注入全局配置对象           |
| 业务逻辑复用   | 公共函数或工具函数解耦路由 |

------

#### 1.6 总结

- `Depends` 是 FastAPI 的 **核心依赖注入工具**
- 让代码 **解耦、复用、可测试**
- 支持函数 / 类 / 嵌套 / 异步
- 常用于认证、参数处理、数据库连接等

------

------



### 2 公共依赖（如数据库连接、鉴权）

## 2.1 概念

- **公共依赖**：指在 **多个路由中都会用到的依赖**，可以统一配置在 **应用 / 路由层级**，避免在每个接口重复写 `Depends`。
- 常用于：**认证、权限校验、数据库连接、日志记录** 等。

------

## 2.2 应用层级公共依赖

在创建 FastAPI 实例时设置：

```
from fastapi import FastAPI, Depends, HTTPException

app = FastAPI()

# 定义依赖
async def verify_token(x_token: str = None):
    if x_token != "fake-super-secret-token":
        raise HTTPException(status_code=403, detail="Invalid token")

# 全局应用依赖
app = FastAPI(dependencies=[Depends(verify_token)])

@app.get("/users")
async def get_users():
    return ["Alice", "Bob"]

@app.get("/orders")
async def get_orders():
    return ["order1", "order2"]
```

🚀 特点：

- 所有路由在执行前都会执行 `verify_token`
- 如果验证失败，直接返回错误，不会进入路由函数

------

## 2.3 路由层级公共依赖

只作用于某一组路由（例如用户相关接口）：

```python
from fastapi import APIRouter

router = APIRouter(
    prefix="/users",
    tags=["users"],
    dependencies=[Depends(verify_token)]  # 路由级别依赖
)

@router.get("/")
async def list_users():
    return ["Alice", "Bob"]

@router.get("/{user_id}")
async def get_user(user_id: int):
    return {"user_id": user_id}

app.include_router(router)
```

 **特点：**

- 只有 `users` 相关接口需要 `verify_token`
- 其他接口不受影响

------

## 2.4 单接口依赖 vs 公共依赖

| 类型                 | 配置位置                                      | 使用场景                                 |
| -------------------- | --------------------------------------------- | ---------------------------------------- |
| 单接口依赖           | 在函数参数里 `Depends(func)`                  | 特定接口需要额外处理                     |
| 公共依赖（路由级别） | `APIRouter(..., dependencies=[Depends(...)])` | 一组接口共用逻辑（如用户模块）           |
| 公共依赖（应用级别） | `FastAPI(..., dependencies=[Depends(...)])`   | 整个应用全局校验（如全局认证、审计日志） |

------

## 2.5 应用场景

- **认证 / 授权**：所有接口都要校验 Token / 权限
- **数据库连接**：在进入路由前获取 `db session`（结合 `yield` 使用）
- **日志 / 审计**：记录请求信息
- **速率限制**：全局限流控制

------

#### 2.6 总结

- **公共依赖** = 统一入口的 `Depends`
- 可配置 **应用级别** 或 **路由级别**
- 用于 **认证、日志、限流、数据库连接** 等跨路由的场景

------

------



### 3 可重用依赖

#### 3.1 概念

- **可重用依赖**：把某些通用逻辑（如认证、数据库会话、分页参数）抽象为函数或类，并通过 `Depends` 引入。
- 特点：
  - 可在多个接口中直接复用
  - 可组合（依赖里再用依赖）
  - 可维护性、可测试性高

------

#### 3.2 基本写法

##### 定义依赖函数

```python
from fastapi import Depends

def common_parameters(q: str = None, skip: int = 0, limit: int = 10):
    return {"q": q, "skip": skip, "limit": limit}
```

##### 在路由中复用

```python
@app.get("/items/")
async def read_items(commons: dict = Depends(common_parameters)):
    return commons

@app.get("/users/")
async def read_users(commons: dict = Depends(common_parameters)):
    return commons
```

`common_parameters` 作为依赖函数可以在多个路由中直接使用。

------

#### 3.3 带验证逻辑的依赖

```python
from fastapi import Header, HTTPException

async def verify_token(x_token: str = Header(...)):
    if x_token != "super-secret":
        raise HTTPException(status_code=403, detail="Invalid token")
    return x_token

@app.get("/profile")
async def get_profile(token: str = Depends(verify_token)):
    return {"token": token}
```

- `verify_token` 可在多个接口复用，不必重复写认证逻辑。

------

#### 3.4 类依赖（可复用配置对象）

```python
class CommonQuery:
    def __init__(self, q: str = None, limit: int = 10):
        self.q = q
        self.limit = limit

@app.get("/products/")
async def get_products(commons: CommonQuery = Depends()):
    return {"q": commons.q, "limit": commons.limit}
```

- 类依赖适合需要存储 **状态** 的依赖（如配置、连接池）。

------

#### 3.5 可组合依赖

依赖里再调用依赖，形成 **依赖链**：

```python
async def get_db():
    return {"db": "session"}

async def get_current_user(db=Depends(get_db)):
    return {"user": "Alice", "db": db}

@app.get("/me")
async def read_me(user=Depends(get_current_user)):
    return user
```

- `read_me` → `get_current_user` → `get_db`，依赖链会自动执行。

------

#### 3.6 应用场景

| 场景             | 示例                      |
| ---------------- | ------------------------- |
| **分页参数复用** | `skip`, `limit`, `q`      |
| **认证 / 授权**  | 解析 JWT、校验 Token      |
| **数据库连接**   | `SessionLocal` 注入       |
| **公共配置**     | 业务通用配置对象          |
| **复合逻辑**     | 依赖组合（认证 + 数据库） |

------

#### 3.7 总结

- **可重用依赖 = 复用逻辑 + 解耦业务 + 提升可维护性**
- 可以是 **函数**、**类**、**依赖组合**
- 常用于 **认证、数据库、分页、配置、权限校验**
- 是 FastAPI **依赖注入机制的精髓**



## 五. 异步编程

### 1 async/await 用法

#### 1.1 什么是 `async/await`

- `async`：定义一个 **异步函数**（coroutine 协程函数）
- `await`：在异步函数里 **等待另一个异步操作完成**，不会阻塞事件循环

📌 **关键区别**：

- 普通函数：`def func(): ...`
- 异步函数：`async def func(): ...`

------

#### 1.2 在 FastAPI 中的用法

FastAPI 支持两类路径函数：

1. **同步函数（普通 def）**：运行在 **线程池**（阻塞型操作推荐）
2. **异步函数（async def）**：运行在 **事件循环**（IO 密集型推荐）

------

##### ① 异步路径函数

```python
from fastapi import FastAPI
import asyncio

app = FastAPI()
@app.get("/async_task")
async def async_task():
    await asyncio.sleep(2)  # 模拟耗时 IO
    return {"msg": "This is async!"}
```

- `async def` 定义异步接口
- `await asyncio.sleep(2)` 表示等待 2 秒，不阻塞其他请求

------

##### ② 同步路径函数

```python
@app.get("/sync_task")
def sync_task():
    import time
    time.sleep(2)  # 阻塞
    return {"msg": "This is sync!"}
```

- `time.sleep(2)` 会阻塞线程
- FastAPI 会自动把它放进 **线程池**，不影响事件循环

------

#### 1.3 async/await 的场景

**适合用 async/await 的操作**（非阻塞 IO）

- 数据库异步驱动（例如 asyncpg, motor）
- HTTP 请求（例如 aiohttp, httpx）
- 文件 IO（aiofiles）
- WebSocket

 **不适合用 async/await 的操作**（CPU 密集型、阻塞操作）

- 数学计算、大数据处理
- 大量循环、压缩、加密

------

#### 1.4 示例：异步数据库

```python
from fastapi import FastAPI
import asyncpg

app = FastAPI()

async def get_db():
    conn = await asyncpg.connect(user="user", password="pwd", database="test", host="localhost")
    return conn

@app.get("/users")
async def read_users():
    conn = await get_db()
    rows = await conn.fetch("SELECT * FROM users;")
    await conn.close()
    return rows
```

------

#### 1.5 总结

- `async def`：声明异步函数
- `await`：等待异步任务完成，不阻塞其他请求
- FastAPI 可以同时支持 **同步 + 异步** 路由
- **推荐原则**：
  - IO 密集型 → 用 `async/await`（数据库、HTTP、文件）
  - CPU 密集型 → 用普通函数（FastAPI 会放入线程池）

### 2 同步与异步混合处理

#### 2.1. FastAPI 的执行模型

FastAPI 基于 **Starlette + Uvicorn(ASGI)**，支持：

- **同步函数 (`def`)**：自动放到 **线程池** 中运行；
- **异步函数 (`async def`)**：直接在 **事件循环 (event loop)** 中运行。

------

#### 2.2. 同步函数与异步函数的特点

##### 同步函数 (`def`)

- **适合 CPU 密集型** 任务（计算、图像处理、加密等）。
- FastAPI 自动把它们丢进 **线程池**（不会阻塞主事件循环）。

```python
@app.get("/sync")
def sync_task():
    import time
    time.sleep(2)  # 阻塞，但在单独的线程中执行
    return {"msg": "sync done"}
```

------

##### 异步函数 (`async def`)

- **适合 I/O 密集型** 任务（数据库、HTTP 请求、文件 I/O）。
- 可使用 `await` 调用异步库。

```python
@app.get("/async")
async def async_task():
    import asyncio
    await asyncio.sleep(2)  # 非阻塞
    return {"msg": "async done"}
```

------

#### 2.3. 混合处理场景

##### 异步函数中调用同步任务

如果直接调用同步函数，可能会阻塞事件循环。
 👉 解决办法：用 `run_in_threadpool`。

```python
from starlette.concurrency import run_in_threadpool

def blocking_task():
    import time
    time.sleep(2)
    return "sync task finished"

@app.get("/mixed")
async def mixed_task():
    result = await run_in_threadpool(blocking_task)
    return {"msg": result}
```

------

#####  同步函数中调用异步任务

同步函数运行在线程池里，**不能直接 `await`**。
    解决办法：

1. 把视图改成 `async def`；
2. 或者用 `asyncio.run()`（⚠️ 不推荐，会创建新事件循环）。

```python
import asyncio

async def async_work():
    await asyncio.sleep(1)
    return "async work"

@app.get("/call-async")
def call_async_from_sync():
    # 不推荐，但可用
    return {"msg": asyncio.run(async_work())}
```

------

#### 2.4. 适用场景总结

| 函数类型             | 适合场景               | 注意事项                                    |
| -------------------- | ---------------------- | ------------------------------------------- |
| `def` 同步函数       | CPU 密集型任务         | FastAPI 自动放入线程池，不会阻塞 event loop |
| `async def` 异步函数 | I/O 密集型任务         | 必须 `await` 异步库，避免调用阻塞代码       |
| 异步调用同步         | 用 `run_in_threadpool` | 避免阻塞 event loop                         |
| 同步调用异步         | 改成 `async def` 更好  | `asyncio.run()` 慎用                        |

------

#### 2.5. 最佳实践

- **数据库 / HTTP 请求** → `async def` + `await`
- **复杂计算 / AI 推理** → `def`，FastAPI 自动线程池处理
- **异步里调用同步库** → `await run_in_threadpool()`
- **保持接口风格统一**：尽量用 `async def`，更易扩展

### 3 异步数据库访问（SQLAlchemy Async, Tortoise ORM, Beanie）

#### 3.1. 为什么要用异步数据库访问？

- **同步数据库驱动**（如传统 `pymysql`, `mysqlclient`, `psycopg2`）会阻塞 event loop，影响高并发。
- **异步数据库驱动**（如 `asyncpg`, `aiomysql`）能在等待数据库响应时 **不阻塞事件循环**，从而处理更多请求。
- 在 FastAPI 里，推荐 **优先选择异步数据库驱动 + ORM**。

------

#### 3.2. 常见异步数据库驱动 / ORM

| 数据库         | 异步驱动 / ORM                                               |
| -------------- | ------------------------------------------------------------ |
| **PostgreSQL** | `asyncpg`（底层驱动）、`SQLAlchemy 2.x async`、`Tortoise ORM` |
| **MySQL**      | `aiomysql`（驱动）、`SQLAlchemy 2.x async`                   |
| **SQLite**     | `aiosqlite`（驱动）                                          |
| **MongoDB**    | `motor`（官方异步驱动）                                      |

------

#### 3.3. 使用示例

#####  PostgreSQL + asyncpg

```python
import asyncpg
from fastapi import FastAPI

app = FastAPI()

async def get_connection():
    return await asyncpg.connect(user="user", password="pass", 
                                 database="testdb", host="127.0.0.1")

@app.get("/users/{user_id}")
async def get_user(user_id: int):
    conn = await get_connection()
    row = await conn.fetchrow("SELECT * FROM users WHERE id=$1", user_id)
    await conn.close()
    return dict(row)
```

------

#####  MySQL + aiomysql

```python
import aiomysql
from fastapi import FastAPI

app = FastAPI()

async def get_conn():
    return await aiomysql.connect(host="127.0.0.1", port=3306, 
                                  user="root", password="123456", 
                                  db="testdb")

@app.get("/users/{user_id}")
async def get_user(user_id: int):
    conn = await get_conn()
    async with conn.cursor() as cur:
        await cur.execute("SELECT * FROM users WHERE id=%s", (user_id,))
        result = await cur.fetchone()
    conn.close()
    return result
```

------

##### SQLAlchemy 2.x (推荐，支持 MySQL / PostgreSQL / SQLite)

```python
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sqlalchemy.orm import sessionmaker
from fastapi import FastAPI, Depends

DATABASE_URL = "postgresql+asyncpg://user:pass@localhost/testdb"
engine = create_async_engine(DATABASE_URL, echo=True)
SessionLocal = sessionmaker(engine, class_=AsyncSession, expire_on_commit=False)

app = FastAPI()

async def get_db():
    async with SessionLocal() as session:
        yield session

@app.get("/users/{user_id}")
async def get_user(user_id: int, db: AsyncSession = Depends(get_db)):
    result = await db.execute("SELECT * FROM users WHERE id=:id", {"id": user_id})
    return result.fetchone()
```

------

#### 3.4. 使用建议

1. **小项目 / 学习**
   - 用 `asyncpg`（Postgres）或 `aiomysql`（MySQL），简单直接。
2. **企业级项目**
   - 用 `SQLAlchemy 2.x async`（ORM 支持，数据库可切换）。
3. **高性能场景**
   - PostgreSQL + `asyncpg` 是性能最好的组合之一。
   - MySQL 则选 `aiomysql`，但性能略逊。

------

#### 3.5. 最佳实践

- 统一使用 **异步驱动**，保持全链路非阻塞。
- 数据库连接池（pool）必须启用，否则高并发下会反复创建连接，性能差。
- 尽量用 ORM（SQLAlchemy Async / Tortoise），避免写大量原生 SQL。

## 六. 中间件与事件

### 1 中间件 (`@app.middleware`)

#### 1. 什么是中间件

在 FastAPI（底层是 Starlette）里，**中间件（Middleware）** 就是一段在 **请求(request)** 到达路由处理函数之前、以及 **响应(response)** 返回客户端之前，都会执行的逻辑。

 它的典型应用场景：

- 记录日志
- 处理跨域（CORS）
- 认证/鉴权
- 请求/响应拦截与修改
- 性能监控（统计请求耗时）

------

#### 1.2. 中间件的基本写法

FastAPI 提供了装饰器 `@app.middleware("http")` 来注册中间件。

```python
from fastapi import FastAPI, Request
import time

app = FastAPI()

@app.middleware("http")
async def add_process_time_header(request: Request, call_next):
    start_time = time.time()
    
    # 请求传给下一个中间件或最终的路由处理函数
    response = await call_next(request)
    
    process_time = time.time() - start_time
    response.headers["X-Process-Time"] = str(process_time)
    return response

@app.get("/")
async def read_root():
    return {"msg": "Hello World"}
```

 执行流程：

1. 请求进入 → 执行中间件（前置逻辑）
2. `call_next(request)` → 把请求交给下一个中间件或最终路由
3. 获取响应 → 执行中间件（后置逻辑）
4. 返回响应

------

#### 1.3. 多个中间件的执行顺序

- 多个中间件时，**先进后出**（栈结构）。

例如：

```python
@app.middleware("http")
async def middleware_a(request: Request, call_next):
    print("A: before")
    response = await call_next(request)
    print("A: after")
    return response

@app.middleware("http")
async def middleware_b(request: Request, call_next):
    print("B: before")
    response = await call_next(request)
    print("B: after")
    return response
```

执行顺序：

```bash
请求 -> A before -> B before -> 路由函数 -> B after -> A after -> 响应
```

------

#### 1.4. 常见应用场景

1. **日志记录**

```python
@app.middleware("http")
async def log_requests(request: Request, call_next):
    print(f"请求: {request.method} {request.url}")
    response = await call_next(request)
    print(f"响应状态: {response.status_code}")
    return response
```

1. **统一添加 Header**

```python
@app.middleware("http")
async def add_custom_header(request: Request, call_next):
    response = await call_next(request)
    response.headers["X-App-Name"] = "MyFastAPI"
    return response
```

1. **简单权限拦截**

```python
@app.middleware("http")
async def check_auth(request: Request, call_next):
    if "Authorization" not in request.headers:
        from fastapi.responses import JSONResponse
        return JSONResponse({"error": "Unauthorized"}, status_code=401)
    return await call_next(request)
```

------

#### 1. 5. 注意事项

- **必须调用 `await call_next(request)`**，否则请求不会继续传递。
- 中间件只能作用于 HTTP（ASGI 也支持 WebSocket，但写法不同）。
- 如果中间件里报错，响应就不会进入路由函数。

------

✅ 总结：

- `@app.middleware("http")` = 定义一个“拦截器”。
- 中间件有“前置逻辑 + 调用后续处理 + 后置逻辑”。
- 常用于 **日志、监控、安全、跨域、性能分析**。

### 2 生命周期事件（`startup`, `shutdown`）

#### 2.1. 生命周期事件是什么

在 FastAPI 应用运行时，会触发两个关键事件：

- **`startup`**
  - 在应用启动时执行（Uvicorn / Gunicorn 启动完成，接收请求之前）。
  - 常用于初始化资源（数据库连接池、缓存连接、加载配置）。
- **`shutdown`**
  - 在应用关闭时执行（进程结束前）。
  - 常用于清理资源（关闭数据库连接、停止任务、清理缓存）。

------

#### 2.2. 基本用法

```python
from fastapi import FastAPI

app = FastAPI()

@app.on_event("startup")
async def startup_event():
    print("应用启动中... 连接数据库 / 初始化资源")

@app.on_event("shutdown")
async def shutdown_event():
    print("应用关闭中... 释放资源 / 关闭连接")
```

启动应用时会打印：

```bash
应用启动中... 连接数据库 / 初始化资源
```

关闭时会打印：

```bash
应用关闭中... 释放资源 / 关闭连接
```

------

#### 2.3. 典型应用场景

##### 初始化数据库连接池

```python
from sqlalchemy.ext.asyncio import create_async_engine

DATABASE_URL = "postgresql+asyncpg://user:pass@localhost/db"
engine = create_async_engine(DATABASE_URL, echo=True)

@app.on_event("startup")
async def startup():
    # 这里可以测试连接池是否可用
    async with engine.begin() as conn:
        await conn.run_sync(lambda _: None)

@app.on_event("shutdown")
async def shutdown():
    await engine.dispose()  # 关闭连接池
```

------

#####  启动后台任务（定时任务）

```python
import asyncio

@app.on_event("startup")
async def startup():
    print("启动后台任务...")
    asyncio.create_task(background_worker())

async def background_worker():
    while True:
        print("后台运行中...")
        await asyncio.sleep(5)
```

------

#### 初始化缓存（Redis）

```python
import aioredis

redis = None

@app.on_event("startup")
async def startup():
    global redis
    redis = await aioredis.from_url("redis://localhost")

@app.on_event("shutdown")
async def shutdown():
    await redis.close()
```

------

#### 2.4. FastAPI 1.0+ 新推荐写法（Lifespan）

虽然 `@app.on_event` 还能用，但 FastAPI 推荐用 **`lifespan` 上下文管理器**。

```python
from fastapi import FastAPI
from contextlib import asynccontextmanager

@asynccontextmanager
async def lifespan(app: FastAPI):
    print("应用启动中...")
    yield  # 等价于运行中
    print("应用关闭中...")

app = FastAPI(lifespan=lifespan)
```

这样 `startup` 和 `shutdown` 就融合成一个生命周期管理器，逻辑更清晰。

------

#### 2.5. 总结

- **`startup`**：应用启动前初始化（DB/Redis/缓存/任务）。
- **`shutdown`**：应用关闭前清理（关闭连接/保存数据）。
- **推荐**：新项目用 `lifespan` 替代 `@app.on_event`，代码更简洁。

### 3 CORS 处理

#### 1. 什么是 CORS

- **跨域场景举例**

  - 前端运行在：`http://localhost:3000`
  - 后端 API 运行在：`http://localhost:8000`
  - 浏览器会认为这是 **跨域请求**，需要后端允许。

- **CORS 的核心**：
   后端必须在响应头里返回允许跨域的字段，例如：

  ```
  Access-Control-Allow-Origin: http://localhost:3000
  Access-Control-Allow-Methods: GET, POST
  Access-Control-Allow-Headers: Content-Type
  ```

------

#### 2. FastAPI 里开启 CORS

FastAPI 提供了 **中间件**：`CORSMiddleware`，基于 Starlette 实现。

```
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

# 允许的前端地址
origins = [
    "http://localhost:3000",
    "http://127.0.0.1:3000",
    "https://myfrontend.com",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,          # 允许的来源（* = 允许所有）
    allow_credentials=True,         # 是否允许携带 Cookie
    allow_methods=["*"],            # 允许的请求方法 ["GET", "POST", ...]
    allow_headers=["*"],            # 允许的请求头 ["Content-Type", "Authorization", ...]
)

@app.get("/")
async def main():
    return {"msg": "Hello CORS"}
```

------

#### 3. 参数说明

- `allow_origins`：允许访问的前端源（支持 `*` 通配符）。
- `allow_credentials`：是否允许跨域请求携带 Cookie / 认证信息。
- `allow_methods`：允许哪些 HTTP 方法（`*` 表示所有）。
- `allow_headers`：允许前端请求头（例如 `Authorization`）。

------

#### 4. 常见场景

#####  开发阶段（允许所有来源）

```
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)
```

#####  生产环境（只允许特定前端域名）

```
app.add_middleware(
    CORSMiddleware,
    allow_origins=["https://myfrontend.com"],
    allow_methods=["GET", "POST"],
    allow_headers=["Content-Type", "Authorization"],
    allow_credentials=True,
)
```

------

#### 5. 注意事项

1. **安全性**
   - 不要在生产环境随意用 `allow_origins=["*"]`，否则任何网站都能访问你的接口。
   - 如果接口需要登录态（Cookie / JWT），必须配置具体域名并启用 `allow_credentials=True`。
2. **预检请求 (OPTIONS)**
   - 跨域 `POST/PUT/DELETE` 请求时，浏览器会先发一个 `OPTIONS` 预检请求，FastAPI 的 `CORSMiddleware` 会自动处理。

## 七. 安全与认证

### 1 OAuth2 + JWT 认证

OAuth （Open Authority的缩写）是一个开放标准，该标准允许用户让第三方应用访问该用户在某一网站上存储的私密资源（如头像、照片、视频等），而在这个过程中无需将用户名和密码提供给第三方应用。实现这一功能是通过提供一个令牌（token），而不是用户名和密码来访问他们存放在特定服务提供者的数据。采用令牌（token）的方式可以让用户灵活的对第三方应用授权或者收回权限。

JWT（JSON Web Token）是一种用于在网络上传递信息的开放标准（RFC 7519）。它是一种轻量级，自包含的令牌，常被用于在客户端和服务器之间传递身份信息。JWT可以通过数字签名验证，确保信息的完整性，并且由于其简洁性，易于在URL、HTTP头部以及HTTP请求参数中传递。

#### 1.1 背景知识

- **OAuth2**：一个标准的认证授权协议，FastAPI 内置支持常见的 **Password Flow（密码模式）**。

- **JWT (JSON Web Token)**：一种 **无状态认证令牌**，通常由三部分组成：

  ```
  header.payload.signature
  ```

  - header：算法信息
  - payload：用户信息（user_id, 过期时间）
  - signature：签名，防止篡改

 核心思想：
 用户登录 → 颁发 JWT → 客户端带着 JWT 访问受保护接口 → 后端验证签名 & 过期时间 → 允许访问。

------

#### 1.2. 安装依赖

```
pip install "python-jose[cryptography]" passlib[bcrypt]
```

- `python-jose`：生成/解析 JWT
- `passlib`：加密/验证密码（BCrypt）

------

#### 1.3. FastAPI 实现 OAuth2 + JWT

```
from datetime import datetime, timedelta
from typing import Optional

from fastapi import FastAPI, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from jose import JWTError, jwt
from passlib.context import CryptContext
from pydantic import BaseModel

# ---------------- 配置 ----------------
SECRET_KEY = "your-secret-key"  # 生产环境要存放在环境变量
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30

# ---------------- 模型 ----------------
class Token(BaseModel):
    access_token: str
    token_type: str

class TokenData(BaseModel):
    username: Optional[str] = None

class User(BaseModel):
    username: str
    disabled: Optional[bool] = None

class UserInDB(User):
    hashed_password: str

# ---------------- 模拟数据库 ----------------
fake_users_db = {
    "alice": {
        "username": "alice",
        "hashed_password": "$2b$12$FQ8j3O1lQWyE8Xw0mX9CjOM.4U3kzN/1XOdQ2W3PlT7xUtWe5oHLK",  # "secret"
        "disabled": False,
    }
}

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

app = FastAPI()

# ---------------- 工具函数 ----------------
def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)

def get_password_hash(password):
    return pwd_context.hash(password)

def get_user(db, username: str):
    if username in db:
        user_dict = db[username]
        return UserInDB(**user_dict)

def authenticate_user(db, username: str, password: str):
    user = get_user(db, username)
    if not user or not verify_password(password, user.hashed_password):
        return False
    return user

def create_access_token(data: dict, expires_delta: Optional[timedelta] = None):
    to_encode = data.copy()
    expire = datetime.utcnow() + (expires_delta or timedelta(minutes=15))
    to_encode.update({"exp": expire})
    return jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)

# ---------------- 路由 ----------------
@app.post("/token", response_model=Token)
async def login(form_data: OAuth2PasswordRequestForm = Depends()):
    user = authenticate_user(fake_users_db, form_data.username, form_data.password)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="用户名或密码错误",
            headers={"WWW-Authenticate": "Bearer"},
        )
    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(
        data={"sub": user.username}, expires_delta=access_token_expires
    )
    return {"access_token": access_token, "token_type": "bearer"}

async def get_current_user(token: str = Depends(oauth2_scheme)):
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="无效的认证凭据",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        username: str = payload.get("sub")
        if username is None:
            raise credentials_exception
        return get_user(fake_users_db, username)
    except JWTError:
        raise credentials_exception

@app.get("/users/me")
async def read_users_me(current_user: User = Depends(get_current_user)):
    return current_user
```

------

#### 1.4. 使用流程

1. **获取 Token**

   ```bash
   curl -X POST "http://127.0.0.1:8000/token" \
   -d "username=alice&password=secret" \
   -H "Content-Type: application/x-www-form-urlencoded"
   ```

   返回：

   ```bash
   {"access_token":"xxxxx.yyyyy.zzzzz","token_type":"bearer"}
   ```

2. **带 Token 访问受保护接口**

   ```bash
   curl -H "Authorization: Bearer <token>" http://127.0.0.1:8000/users/me
   ```

------

#### 1.5. 特点 & 注意事项

 **优点**

- 无状态，服务端无需存储 session
- 可扩展，支持多服务共享认证
- 性能好（只需解码 JWT，不查库即可验证身份）

 **注意事项**

- `SECRET_KEY` 必须安全保存
- JWT 不能撤销（除非维护黑名单）
- 适合 API / 微服务，不太适合复杂权限管理（需要结合 RBAC）

### 2 API Key 验证

#### 2.1 什么是 API Key 验证？

- **API Key** = 一串密钥（字符串），通常在 **HTTP Header、Query 参数 或 Cookie** 里传递。
- 服务器端验证请求里是否携带了正确的 Key，如果不正确 → 拒绝访问。
- 常用于：
  - 内部服务调用
  - 第三方 API 授权
  - 简单安全校验（比 JWT 更轻量）

------

#### 2.2 FastAPI 中的实现方式

##### 方式一：放在请求头里

```
from fastapi import FastAPI, Security, HTTPException, Depends
from fastapi.security.api_key import APIKeyHeader

app = FastAPI()

API_KEY = "my-secret-api-key"
API_KEY_NAME = "access_token"

api_key_header = APIKeyHeader(name=API_KEY_NAME, auto_error=False)

async def get_api_key(api_key_header: str = Security(api_key_header)):
    if api_key_header == API_KEY:
        return api_key_header
    raise HTTPException(status_code=403, detail="Invalid API Key")

@app.get("/secure-data")
async def secure_data(api_key: str = Depends(get_api_key)):
    return {"message": "You have access to secure data"}
```

🔑 用法：

```
curl -H "access_token: my-secret-api-key" http://127.0.0.1:8000/secure-data
```

------

##### 方式二：放在查询参数里

```
from fastapi import Query

async def get_api_key(api_key: str = Query(None)):
    if api_key == API_KEY:
        return api_key
    raise HTTPException(status_code=403, detail="Invalid API Key")
```

调用：

```
http://127.0.0.1:8000/secure-data?api_key=my-secret-api-key
```

------

##### 方式三：放在 Cookie 里

```
from fastapi.security.api_key import APIKeyCookie

api_key_cookie = APIKeyCookie(name="access_token", auto_error=False)

async def get_api_key(api_key_cookie: str = Security(api_key_cookie)):
    if api_key_cookie == API_KEY:
        return api_key_cookie
    raise HTTPException(status_code=403, detail="Invalid API Key")
```

#### 2.3 特点对比

| 方式           | 优点                      | 缺点                                           |
| -------------- | ------------------------- | ---------------------------------------------- |
| **Header**     | 安全、常见做法（推荐）    | 需要在请求头里传递                             |
| **Query 参数** | 使用方便，直接拼在 URL 上 | 暴露在日志/浏览器历史里，不安全                |
| **Cookie**     | 方便浏览器自动携带        | 可能被 CSRF 攻击，需要配合 `SameSite/HttpOnly` |

------

#### 2.4 总结

- **轻量级安全** → API Key 验证
- **用户身份管理/权限控制** → OAuth2 + JWT
- **实际项目** → API Key 常用于 **服务间调用**，JWT 常用于 **用户登录鉴权**。

### 3 权限控制（角色、作用域）

#### 3.1 背景

在实际应用中，**认证（Authentication）** 只解决了 **谁（Who）在访问**；
 而 **授权（Authorization）** 解决的是 **能做什么（What can do）**。

常见需求：

- 管理员才能删除用户
- 普通用户只能查看自己的数据
- 不同角色拥有不同 API 权限

------

#### 3.2 基于 **角色（Role）** 的控制

最常见方式：在 **JWT Token** 里存储用户角色，然后在路由依赖中检查。

```
from fastapi import FastAPI, Depends, HTTPException, status
from typing import List

app = FastAPI()

# 模拟：从 JWT 或数据库中解析出的用户信息
def get_current_user():
    return {"username": "alice", "roles": ["user", "admin"]}

def role_checker(required_roles: List[str]):
    def wrapper(user=Depends(get_current_user)):
        if not any(role in user["roles"] for role in required_roles):
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Not enough permissions"
            )
        return user
    return wrapper

@app.get("/admin-data")
async def admin_data(user=Depends(role_checker(["admin"]))):
    return {"msg": f"Hello {user['username']}, you are an admin!"}

@app.get("/user-data")
async def user_data(user=Depends(role_checker(["user"]))):
    return {"msg": f"Hello {user['username']}, you are a normal user!"}
```

✅ 好处：实现 **RBAC（基于角色的访问控制）**。

------

#### 3.3 基于 **作用域（Scope）** 的控制

作用域适合更细粒度的权限（类似 OAuth2 的权限范围）。
 FastAPI 内置了 **OAuth2 scopes** 支持。

```
from fastapi import Security
from fastapi.security import OAuth2PasswordBearer

# 定义支持的作用域
oauth2_scheme = OAuth2PasswordBearer(
    tokenUrl="token",
    scopes={"read": "Read access", "write": "Write access", "admin": "Admin access"}
)

def get_current_user(token: str = Security(oauth2_scheme, scopes=["admin"])):
    # 这里通常会解析 JWT 并验证 scopes
    user_scopes = ["read", "admin"]  # 模拟从 token 解码出来的 scopes
    if not set(["admin"]).issubset(set(user_scopes)):
        raise HTTPException(
            status_code=403,
            detail="Not enough permissions"
        )
    return {"username": "bob", "scopes": user_scopes}

@app.get("/secure-admin")
async def secure_admin(user=Depends(get_current_user)):
    return {"msg": f"Hello {user['username']}, you have admin scope!"}
```

✅ 好处：支持 **OAuth2 标准的 Scopes**，适合 **第三方授权** 或 **API 权限分级**。

------

#### 3.4 角色 vs 作用域 对比

| 特点     | 角色（Role）                | 作用域（Scope）                     |
| -------- | --------------------------- | ----------------------------------- |
| 适用场景 | 系统内部用户权限（RBAC）    | 第三方应用授权（OAuth2）            |
| 粒度     | 粗粒度（管理员 / 普通用户） | 细粒度（read / write / admin）      |
| 存储位置 | JWT 中的 `roles`            | JWT 的 `scope` Claim                |
| 检查方式 | 自定义依赖检查              | `OAuth2PasswordBearer` + `Security` |

------

#### 3.5 实际项目最佳实践

- **企业管理系统** → 用 **角色（Role）**，简单直观（管理员、部门主管、员工）。
- **开放 API / 微服务** → 用 **作用域（Scope）**，支持更细权限（读 / 写 / 删除）。
- 也可以 **结合使用**：
  - 角色：用于用户分层
  - 作用域：用于具体 API 权限

## 八. API 文档与测试

### 1 自动生成 Swagger UI / ReDoc

#### 1.1为什么能自动生成

- FastAPI 使用 **Pydantic 模型** 来定义请求体、响应体
- 使用 **类型提示（type hints）** 来描述参数类型
- 内部基于 **OpenAPI（前称 Swagger）** 标准
- 所以能 **自动生成交互式文档**（Swagger UI / ReDoc）

------

#### 1.2 默认接口

启动 FastAPI 应用后，默认提供 2 个文档入口：

| 文档             | 地址                                 | 特点                        |
| ---------------- | ------------------------------------ | --------------------------- |
| **Swagger UI**   | `http://127.0.0.1:8000/docs`         | 可交互测试，支持 Try it out |
| **ReDoc**        | `http://127.0.0.1:8000/redoc`        | 简洁大纲，适合查阅 API 结构 |
| **OpenAPI JSON** | `http://127.0.0.1:8000/openapi.json` | 原始 OpenAPI Schema         |

------

#### 1.3 示例代码

```
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI(
    title="我的 API 文档",
    description="这是一个使用 FastAPI 的示例项目",
    version="1.0.0",
    contact={
        "name": "Data Mate",
        "url": "https://example.com",
        "email": "support@example.com",
    },
    license_info={
        "name": "Apache 2.0",
        "url": "https://www.apache.org/licenses/LICENSE-2.0.html",
    },
)

class Item(BaseModel):
    name: str
    price: float
    description: str | None = None

@app.post("/items/", response_model=Item, summary="创建新商品", tags=["商品管理"])
async def create_item(item: Item):
    """
    创建一个新商品  
    - **name**: 商品名称  
    - **price**: 商品价格  
    - **description**: 可选描述  
    """
    return item
```

启动后访问：

- `http://127.0.0.1:8000/docs` → Swagger UI
- `http://127.0.0.1:8000/redoc` → ReDoc

------

#### 1.4 个性化配置

- **禁用文档**

```
app = FastAPI(docs_url=None, redoc_url=None, openapi_url=None)
```

- **修改路径**

```
app = FastAPI(docs_url="/swagger", redoc_url="/documentation")
```

- **分组展示**

```
@app.get("/users/", tags=["用户管理"])
@app.get("/orders/", tags=["订单管理"])
```

- **接口摘要与描述**

```
@app.get("/status", summary="健康检查", description="返回服务运行状态")
```

------

#### 1.5 Swagger vs ReDoc 对比

| 特点       | Swagger UI     | ReDoc         |
| ---------- | -------------- | ------------- |
| 是否可交互 | 可直接测试接口 | 只读          |
| UI 风格    | 工具化         | 文档化        |
| 常用场景   | 开发调试       | 对外 API 文档 |

------

**总结**
 FastAPI 内置 OpenAPI 支持，自动生成 **Swagger UI / ReDoc**，
 开发者几乎不用额外配置，就能得到一个 **可交互 + 可发布的 API 文档**。

### 2 API Tags 与描述信息

#### 2.1 什么是 Tags

- **Tags** 用于对接口进行分组和分类
- 在 Swagger UI 和 ReDoc 里，可以清晰看到不同分组下的接口
- 类似于 **“目录”**，方便查找和维护

------

#### 2.2 在路由上添加 `tags`

```
from fastapi import FastAPI

app = FastAPI()

@app.get("/users/", tags=["用户管理"])
async def list_users():
    return [{"id": 1, "name": "Alice"}]

@app.post("/users/", tags=["用户管理"])
async def create_user(user: dict):
    return {"msg": "用户创建成功"}

@app.get("/orders/", tags=["订单管理"])
async def list_orders():
    return [{"id": 1001, "item": "Book"}]
```

Swagger UI 展示效果：

- 用户管理
  - GET /users/
  - POST /users/
- 订单管理
  - GET /orders/

------

#### 2.3 接口摘要（summary）与描述（description）

- **summary**：接口的简短说明（显示在列表）
- **description**：接口的详细描述（显示在接口详情）

```
@app.get(
    "/status", 
    tags=["系统管理"],
    summary="健康检查",
    description="""
    返回服务运行状态  
    - **uptime**: 系统运行时长  
    - **status**: 当前服务状态（ok/error）  
    """
)
async def status():
    return {"uptime": "24h", "status": "ok"}
```

------

#### 2.4 在 `FastAPI` 初始化时定义 Tags 元数据

这样能给每个分组写上 **文档说明**：

```
app = FastAPI(
    title="商城 API",
    version="1.0.0",
    openapi_tags=[
        {
            "name": "用户管理",
            "description": "处理用户注册、登录、查询等操作"
        },
        {
            "name": "订单管理",
            "description": "订单查询、创建、支付等相关功能"
        },
        {
            "name": "系统管理",
            "description": "系统状态监控、配置等"
        }
    ]
)
```

 Swagger UI 效果：

- 用户管理 → 下方带说明
- 订单管理 → 下方带说明
- 系统管理 → 下方带说明

------

#### 2.5 最佳实践

- **每个模块一个 Tag**，如「用户管理」「订单管理」「商品管理」
- **summary 简短**，一行概括接口功能
- **description 详细**，可使用 Markdown（支持加粗、列表、换行）
- **统一维护 tags 元数据**，便于文档清晰

------

 **总结**

- **tags**：接口分组
- **summary**：接口标题
- **description**：接口详细说明
- **openapi_tags**：全局定义分组说明

这样文档就会清晰、可读、专业。

### 3 单元测试（pytest + TestClient）

#### 3.1 基本思路

- 使用 **pytest** 作为测试框架
- 使用 **TestClient**（基于 `requests`）模拟 HTTP 请求
- 编写测试函数，验证接口的返回结果、状态码等

------

#### 3.2 示例项目

假设我们有一个简单的 FastAPI 应用：

```
# main.py
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class Item(BaseModel):
    name: str
    price: float

@app.post("/items/")
def create_item(item: Item):
    return {"name": item.name, "price": item.price}
```

------

#### 3.3 编写测试文件

在 **tests/** 目录下创建 `test_main.py`：

```
# tests/test_main.py
from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_create_item():
    response = client.post(
        "/items/",
        json={"name": "Book", "price": 19.9}
    )
    assert response.status_code == 200
    data = response.json()
    assert data["name"] == "Book"
    assert data["price"] == 19.9
```

------

#### 3.4 运行测试

在项目根目录执行：

```
pytest -v
```

输出示例：

```
tests/test_main.py::test_create_item PASSED
```

------

#### 3.5 高级用法

##### 依赖覆盖（覆盖 `Depends`）

比如接口依赖数据库，我们可以在测试时注入 **假的依赖**：

```
from fastapi import Depends

def get_db():
    return {"db": "real"}

@app.get("/db")
def read_db(db=Depends(get_db)):
    return db
```

在测试里覆盖：

```
def override_get_db():
    return {"db": "fake"}

app.dependency_overrides[get_db] = override_get_db

def test_read_db():
    response = client.get("/db")
    assert response.json() == {"db": "fake"}
```

------

##### 使用 `pytest.fixture` 管理测试环境

```
import pytest

@pytest.fixture
def test_client():
    from main import app
    client = TestClient(app)
    yield client  # 测试执行
    # 测试结束后的清理逻辑（比如关闭连接池）
```

------

##### 异步测试（pytest-asyncio）

如果你写了异步函数，可以用 `pytest-asyncio`：

```
import pytest
from httpx import AsyncClient
from main import app

@pytest.mark.asyncio
async def test_async_create_item():
    async with AsyncClient(app=app, base_url="http://test") as ac:
        response = await ac.post("/items/", json={"name": "Phone", "price": 999.9})
    assert response.status_code == 200
    assert response.json()["name"] == "Phone"
```

------

#### 3.6总结

- **TestClient** → 模拟 HTTP 请求
- **pytest** → 断言返回结果
- **dependency_overrides** → 替换依赖，适合测试数据库、鉴权等
- **pytest-asyncio + httpx** → 支持异步测试

## 九. 部署与性能优化

### 1 Uvicorn / Gunicorn 配置

FastAPI 是 **ASGI 框架**，生产环境不能直接用 `uvicorn main:app --reload`（开发模式）。
 常用部署方式：

1. **Uvicorn**（纯 ASGI 服务器，轻量）
2. **Gunicorn + Uvicorn Workers**（支持多进程，多核 CPU，高并发）

------

#### 1.1 Uvicorn 配置

##### 开发模式：

```
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

- `--reload`：代码变动自动重启，仅开发使用
- `--host 0.0.0.0`：允许外部访问
- `--port`：监听端口

##### 生产模式：

```
uvicorn main:app --host 0.0.0.0 --port 8000 --workers 4 --log-level info
```

- `--workers 4`：启动 4 个进程，提高并发能力
- `--log-level info`：设置日志级别

------

#### 1.2 Gunicorn + Uvicorn Workers（推荐生产环境）

Gunicorn 是成熟的 WSGI/ASGI 服务器，**可管理多个进程**，结合 Uvicorn Worker 用于 FastAPI。

```
gunicorn main:app -w 4 -k uvicorn.workers.UvicornWorker -b 0.0.0.0:8000 --log-level info
```

参数说明：

| 参数                               | 说明                                               |
| ---------------------------------- | -------------------------------------------------- |
| `-w 4`                             | 启动 4 个 worker 进程（一般 = CPU 核心数 * 2 + 1） |
| `-k uvicorn.workers.UvicornWorker` | 使用 Uvicorn Worker 处理 ASGI 请求                 |
| `-b 0.0.0.0:8000`                  | 绑定地址和端口                                     |
| `--log-level info`                 | 日志级别（debug / info / warning / error）         |

------

#### 1.3 配置示例文件（gunicorn_conf.py）

```
# gunicorn_conf.py
bind = "0.0.0.0:8000"
workers = 4  # 根据 CPU 核心数调整
worker_class = "uvicorn.workers.UvicornWorker"
timeout = 30  # 超时时间（秒）
loglevel = "info"
accesslog = "-"  # 输出到 stdout
errorlog = "-"   # 输出到 stdout
```

启动：

```
gunicorn -c gunicorn_conf.py main:app
```

------

#### 1.4 Nginx + Gunicorn / Uvicorn（常用生产架构）

```
客户端浏览器
       |
       | HTTPS
       v
    Nginx (反向代理)
       |
       | HTTP
       v
  Gunicorn + Uvicorn Worker (FastAPI)
       |
       v
      应用
```

优势：

- Nginx 负责静态文件、SSL/TLS、负载均衡
- Gunicorn + Uvicorn Worker 提升多进程并发
- FastAPI 专注业务逻辑

------

#### 1.5 小技巧

1. **worker 数量** = `CPU 核心数 * 2 + 1`，可提高吞吐量
2. **timeout**：接口慢时要适当调大，避免 Worker 被杀掉
3. **日志**：生产环境建议接入日志收集系统
4. **reload**：生产环境不要用 `--reload`

------

 **总结**

- 开发：直接 `uvicorn main:app --reload`
- 生产轻量：`uvicorn main:app --workers N`
- 生产推荐：`gunicorn -k uvicorn.workers.UvicornWorker` + 多 worker + Nginx

### 2 workers 数量与并发优化

#### 2.1 Worker 与并发基础

- **Worker**：工作进程，用于处理请求
- **并发模型**：
  - **同步 Worker**：一次只能处理一个请求
  - **异步 Worker**（如 `uvicorn.workers.UvicornWorker`）：支持 **异步请求并发**，单进程可处理多个请求

> FastAPI 是 ASGI 框架，本质上支持 **异步请求**，建议用 **异步 Worker**。

------

#### 2.2 Worker 数量配置

##### Gunicorn 公式（推荐经验值）

```
workers = 2 * CPU 核心数 + 1
```

示例：

```
# 4 核 CPU
workers = 2*4 + 1 = 9
```

- 适合 CPU 密集型任务
- I/O 密集型（如数据库、HTTP 调用）可以少一些 worker + 异步处理

------

##### Uvicorn 的 async worker 并发

- 单个 **Uvicorn Worker** 支持 **协程并发**
- 例如：

```
import asyncio

async def fetch_data():
    await asyncio.sleep(1)  # 模拟 I/O
```

- 1 个 worker 可以同时处理数百个请求，而不需要启动太多 worker

------

#### 2.3 并发优化策略

##### 2.3.1 异步优先

- 将 I/O 操作（数据库、HTTP 调用、文件）改为异步：

```
async def get_items():
    result = await db.fetch_items()  # 异步数据库
    return result
```

- 这样单个 worker 可以同时服务更多请求

##### 2,3.2 合理配置 Worker 数量

- CPU 密集型 → 增加 worker
- I/O 密集型 → 增加协程 / async，worker 不必太多

##### 2.3.3 使用连接池

- 数据库 / Redis / HTTP 客户端都要用连接池，避免阻塞 worker

##### 2.3.4 设置 timeout

- Gunicorn 的 `timeout` 配置，避免慢请求占用 worker：

```
timeout = 30  # 超过 30 秒 worker 会被重启
```

##### 2.3.5 Keep-Alive & 前端负载均衡

- Nginx 可开启 Keep-Alive，减少 TCP 建立开销
- 可以多台实例 + Nginx 负载均衡

------

#### 2.4 实际部署建议

| 场景     | CPU 核心 | Worker 数量 | 并发策略                |
| -------- | -------- | ----------- | ----------------------- |
| CPU 密集 | 4 核     | 9           | 同步即可                |
| I/O 密集 | 4 核     | 4-5         | 异步 + 连接池           |
| 高并发   | 8 核     | 17          | 异步 + 负载均衡 + Nginx |

------

#### 2.5 小结

- **Worker** 决定并行进程数量
- **异步** 决定单进程并发数量
- **I/O 密集** → 异步 + 少量 worker
- **CPU 密集** → 增加 worker
- 数据库 / 外部服务要 **异步 + 连接池**

### 3 静态文件、反向代理（Nginx）

#### 3.1 静态文件服务

FastAPI 可以直接提供静态文件（如 HTML、JS、CSS、图片等），使用 **`StaticFiles`**。

```
from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles

app = FastAPI()

# 挂载静态文件目录
app.mount("/static", StaticFiles(directory="static"), name="static")
```

 使用方法：

- 静态目录结构：

```
project/
├─ main.py
├─ static/
│   ├─ css/
│   ├─ js/
│   └─ images/
```

- 访问：

```
http://127.0.0.1:8000/static/css/style.css
```

 **注意事项：**

- 生产环境建议 **静态文件由 Nginx 提供**，FastAPI 仅提供动态接口，提高性能
- FastAPI 静态服务适合 **开发和小型项目**

------

#### 3.2 Nginx 反向代理 FastAPI

##### 3.2.1 为什么用 Nginx

- 提供 **负载均衡**
- 支持 **HTTPS/TLS**
- 服务静态文件（减少 FastAPI 压力）
- 控制访问日志、限流等

##### 3.2.2 基本配置示例

假设 FastAPI 运行在 `127.0.0.1:8000`，Nginx 监听 `80` 端口：

```
server {
    listen 80;
    server_name example.com;

    # 静态文件
    location /static/ {
        alias /path/to/project/static/;
        expires 30d;
    }

    # FastAPI 接口反向代理
    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

**说明：**

- `/static/` → 由 Nginx 直接提供
- `/` → 代理到 FastAPI
- `proxy_set_header` → 保留真实客户端 IP、协议等信息

------

#### 3.3 HTTPS 支持

```
server {
    listen 443 ssl;
    server_name example.com;

    ssl_certificate /etc/ssl/certs/example.com.crt;
    ssl_certificate_key /etc/ssl/private/example.com.key;

    location /static/ { ... }
    location / { proxy_pass http://127.0.0.1:8000; ... }
}
```

- Nginx 处理 TLS，FastAPI 内部仍然 HTTP，提高安全性和性能

------

#### 3.4 部署优化建议

1. **静态文件由 Nginx 提供**
2. **FastAPI 专注接口**，使用 Gunicorn + Uvicorn Worker
3. **Nginx 配置 Keep-Alive**，提高连接复用
4. **限流与防火墙**，保护 FastAPI 后端
5. **反向代理 headers**，让 FastAPI 能正确获取真实 IP

------

**总结：**

- 开发阶段：FastAPI 提供静态文件
- 生产阶段：Nginx 提供静态文件 + 反向代理 FastAPI
- 优势：减轻 FastAPI 压力、支持 HTTPS、负载均衡

### 4 日志与监控

#### 4.1 日志（Logging）

日志在开发和生产中非常重要，用于 **排查问题、性能分析、审计**。

##### 4.1.1 FastAPI 默认日志

- FastAPI 本身使用 **标准 Python `logging` 模块**
- Uvicorn/Gunicorn 会自动打印访问日志、错误日志

示例启动命令：

```
uvicorn main:app --host 0.0.0.0 --port 8000 --log-level info
```

- `--log-level` 可选： `debug` / `info` / `warning` / `error` / `critical`
- 日志示例：

```
INFO:     127.0.0.1:53720 - "GET /items/1 HTTP/1.1" 200 OK
ERROR:    Exception in ASGI application
```

------

##### 4.1.2 自定义日志

```
import logging
from fastapi import FastAPI, Request

app = FastAPI()

# 配置日志格式
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(name)s - %(message)s"
)
logger = logging.getLogger("myapp")

@app.middleware("http")
async def log_requests(request: Request, call_next):
    logger.info(f"请求开始: {request.method} {request.url}")
    response = await call_next(request)
    logger.info(f"请求结束: {request.method} {request.url} -> {response.status_code}")
    return response
```

- 可在中间件里记录**请求信息**（method、url、状态码、耗时）
- 也可记录**自定义业务日志**

------

##### 4.1.3 生产日志策略

- **日志切割**：使用 `logging.handlers.RotatingFileHandler` 或 `TimedRotatingFileHandler`
- **日志分级**：`info` 保存普通访问，`error` 保存异常
- **集中管理**：接入 ELK / Graylog / Loki 等日志系统

示例：

```
from logging.handlers import TimedRotatingFileHandler

handler = TimedRotatingFileHandler("app.log", when="midnight", backupCount=7)
logger.addHandler(handler)
```

------

#### 4.2 监控（Monitoring）

监控用于 **指标收集、性能分析、告警**。

------

##### 4.2.1 内置健康检查

- ##### 可以自己写 `/health` 或 `/metrics` 接口：

```
@app.get("/health", tags=["监控"])
async def health():
    return {"status": "ok"}
```

------

##### 4.2.2 Prometheus + FastAPI

- 用 `prometheus-fastapi-instrumentator` 自动采集请求指标

```
from prometheus_fastapi_instrumentator import Instrumentator
from fastapi import FastAPI

app = FastAPI()
Instrumentator().instrument(app).expose(app)
```

- 默认暴露 `/metrics`，Prometheus 可抓取
- 可监控：
  - 请求总数
  - 请求延迟
  - 状态码分布

------

##### 4.2.3 Grafana 可视化

- Prometheus + Grafana，绘制：
  - 每秒请求数（RPS）
  - 请求延迟（ms）
  - 错误率
  - 各接口耗时分布

------

##### 4.2.4 异常告警

- 接入 Sentry / OpenTelemetry / DingTalk / 邮件
- 捕获异常、请求失败率高、响应延迟高等

示例 Sentry：

```
import sentry_sdk
from sentry_sdk.integrations.asgi import SentryAsgiMiddleware

sentry_sdk.init("https://<DSN>@sentry.io/<project_id>")
app.add_middleware(SentryAsgiMiddleware)
```

------

#### 4.3 总结

| 维度     | 技术/工具                     | 描述                         |
| -------- | ----------------------------- | ---------------------------- |
| 日志     | logging / RotatingFileHandler | 请求日志、异常日志、业务日志 |
| 监控     | Prometheus + Instrumentator   | 自动收集请求指标             |
| 可视化   | Grafana                       | 请求量、延迟、错误率等       |
| 异常告警 | Sentry / OpenTelemetry        | 捕获异常和错误告警           |

------

 **建议实践**

1. 开发环境：`uvicorn --log-level debug` + 基础日志
2. 生产环境：
   - Gunicorn + Uvicorn Worker
   - Nginx 访问日志
   - Python 应用日志写入文件 / 集中系统
   - Prometheus + Grafana 监控
   - Sentry 告警异常

## 十. 高级应用

### 1 WebSocket

#### 1.1 什么是 WebSocket

- **WebSocket** 是一种全双工通信协议
- 客户端与服务器建立连接后，可 **实时双向发送消息**
- 适合：
  - 聊天系统
  - 实时推送（股票、比赛比分）
  - 游戏或协作应用

------

#### 1.2 FastAPI 基本用法

```
from fastapi import FastAPI, WebSocket

app = FastAPI()

@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    await websocket.accept()  # 接受连接
    while True:
        data = await websocket.receive_text()  # 接收消息
        await websocket.send_text(f"收到: {data}")  # 回传消息
```

- `WebSocket.accept()` → 接受客户端连接
- `WebSocket.receive_text()` → 接收文本消息
- `WebSocket.send_text()` → 发送文本消息

------

##### 1.2.1 客户端示例（JavaScript）

```
const ws = new WebSocket("ws://localhost:8000/ws");

ws.onopen = () => {
  console.log("已连接");
  ws.send("Hello FastAPI!");
};

ws.onmessage = (event) => {
  console.log("收到服务器消息:", event.data);
};
```

------

#### 1.3 多客户端管理

- 生产中通常需要管理 **多个 WebSocket 连接**
- 可以用 **列表或字典** 保存连接，并广播消息

```
clients = []

@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    await websocket.accept()
    clients.append(websocket)
    try:
        while True:
            data = await websocket.receive_text()
            for client in clients:
                await client.send_text(f"广播: {data}")
    except Exception:
        clients.remove(websocket)
```

------

#### 1.4 关闭连接与异常处理

```
try:
    await websocket.accept()
    while True:
        msg = await websocket.receive_text()
        await websocket.send_text(f"Echo: {msg}")
except WebSocketDisconnect:
    print("客户端断开连接")
```

- 使用 `WebSocketDisconnect` 捕获客户端断开

------

#### 1.5 生产部署注意事项

1. **使用异步 Worker**
   - Gunicorn + `uvicorn.workers.UvicornWorker`
   - WebSocket 依赖 ASGI，因此必须使用 ASGI Worker
2. **Nginx 配置 WebSocket**

```
location /ws/ {
    proxy_pass http://127.0.0.1:8000;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_set_header Host $host;
}
```

- `Upgrade` 和 `Connection: upgrade` 是 WebSocket 必须的
- 不配置会导致 400 错误

1. **心跳机制**
   - 避免长连接被 NAT / 负载均衡关闭
   - 客户端定期发送 ping/pong

------

#### 1.6 总结

| 特性         | 描述                                        |
| ------------ | ------------------------------------------- |
| 协议         | WebSocket (RFC 6455)                        |
| FastAPI 支持 | 原生 ASGI WebSocket，异步处理               |
| 多客户端     | 可用列表或字典管理连接，实现广播            |
| 部署要求     | ASGI Worker + Nginx 配置 Upgrade/Connection |
| 适用场景     | 实时聊天、通知、协作应用、游戏              |

### 2 GraphQL（Ariadne, Strawberry）

### 3 后台任务（BackgroundTasks）

### 

### 4 与 Celery / RQ 集成

### 5 微服务与事件驱动架构（Kafka, RabbitMQ, Redis Pub/Sub）

------

## FastAPI 知识拓扑图（层级结构）

```
FastAPI
├── 基础
│   ├── 框架简介
│   ├── ASGI / Uvicorn
│   └── Hello World
├── 路由
│   ├── GET / POST / PUT / DELETE
│   ├── 路径参数
│   ├── 查询参数
│   └── 请求体（Body / Form / File）
├── 数据处理
│   ├── Pydantic 模型
│   ├── 验证与序列化
│   └── 响应模型
├── 依赖注入
│   ├── Depends
│   ├── 公共依赖
│   └── 鉴权依赖
├── 异步与中间件
│   ├── async/await
│   ├── 异步数据库
│   ├── 中间件
│   └── 生命周期事件
├── 安全
│   ├── OAuth2 + JWT
│   ├── API Key
│   └── 权限控制
├── API 文档与测试
│   ├── Swagger UI / ReDoc
│   └── pytest + TestClient
├── 部署与优化
│   ├── Uvicorn/Gunicorn
│   ├── 并发优化
│   ├── Nginx 反向代理
│   └── 日志与监控
└── 高级应用
    ├── WebSocket
    ├── GraphQL
    ├── 后台任务
    └── 微服务集成
```