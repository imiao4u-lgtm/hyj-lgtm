# 🔒 StaticCrypt 自动加密配置指南

## 📁 目录结构说明

```
github pages/
├── index.html                    # 公开页面(不加密)
├── project-finance.html          # 加密后的页面(自动生成)
├── project-jaxx.html             # 加密后的页面(自动生成)
├── project-speed.html            # 加密后的页面(自动生成)
├── project-loan.html             # 加密后的页面(自动生成)
├── scr/                          # 源文件目录(未加密)
│   ├── project-finance.html      # 原始文件,在这里编辑
│   ├── project-jaxx.html
│   ├── project-speed.html
│   └── project-loan.html
├── .github/
│   └── workflows/
│       └── encrypt.yml           # GitHub Actions 自动化配置
├── encrypt-local.bat             # 本地加密脚本(Windows)
└── .gitignore                    # Git 忽略配置

```

---

## 🚀 初次设置步骤

### 1️⃣ 在 GitHub 设置密码

1. 进入你的 GitHub 仓库
2. 点击 **Settings** → **Secrets and variables** → **Actions**
3. 点击 **New repository secret**
4. 填写:
   - Name: `ENCRYPT_PASSWORD`
   - Secret: 你的密码(例如: `MySecret123`)
5. 点击 **Add secret**

### 2️⃣ 提交自动化配置到 GitHub

```bash
cd "D:\personal\HTML_RM\github pages"

# 添加所有新文件
git add .github/workflows/encrypt.yml
git add .gitignore
git add encrypt-local.bat

# 提交
git commit -m "Add staticrypt auto-encryption"
git push
```

### 3️⃣ 移动现有文件到 scr 目录

**重要:** 如果你已经有 `project-*.html` 文件在根目录,需要先移动到 `scr/` 目录:

```bash
# 创建 scr 目录(如果不存在)
mkdir scr

# 移动现有的项目页面到 scr(作为源文件)
move project-finance.html scr\
move project-jaxx.html scr\
move project-speed.html scr\
move project-loan.html scr\
```

---

## 📝 日常使用流程

### 方式一:自动化(推荐)

1. **编辑源文件**:在 `scr/` 目录下修改你的页面
   ```
   scr/project-finance.html  ← 在这里编辑
   ```

2. **提交到 GitHub**:
   ```bash
   git add scr/
   git commit -m "Update project finance page"
   git push
   ```

3. **自动加密**:GitHub Actions 会自动:
   - 检测到 `scr/` 目录的变化
   - 使用你设置的密码加密所有页面
   - 生成加密后的文件到根目录
   - 自动提交并推送

4. **完成**:几分钟后访问你的 GitHub Pages,页面已更新并加密

### 方式二:本地加密(可选)

如果你想在本地预览加密效果:

1. **修改 `encrypt-local.bat` 中的密码**:
   ```batch
   set PASSWORD=your_password_here  ← 改成你的密码
   ```

2. **双击运行** `encrypt-local.bat`

3. **手动提交**:
   ```bash
   git add project-*.html
   git commit -m "Update encrypted pages"
   git push
   ```

---

## 🔄 更新密码

### 在 GitHub 更新密码:

1. 进入 **Settings** → **Secrets and variables** → **Actions**
2. 点击 `ENCRYPT_PASSWORD` 右侧的 **Update**
3. 输入新密码并保存

### 重新加密所有页面:

更新密码后,需要触发一次重新加密:

```bash
# 方法1:修改任意 scr 文件并提交(推荐)
# 在 scr/project-finance.html 里随便加个空格
git add scr/
git commit -m "Trigger re-encryption"
git push

# 方法2:手动触发 GitHub Actions
# 在 GitHub 仓库页面:
# Actions → Auto Encrypt Protected Pages → Run workflow
```

---

## ⚙️ 参数说明

在 `encrypt.yml` 中的加密命令:

```bash
staticrypt scr/project-finance.html "${{ secrets.ENCRYPT_PASSWORD }}" -o project-finance.html -r 30 --short
```

参数解释:
- `-o project-finance.html`: 输出到根目录
- `-r 30`: 记住密码 30 天(使用 localStorage)
- `--short`: 使用简洁的密码提示界面

其他可选参数:
- `-r 0`: 不记住密码(每次都要输入)
- `--title "标题"`: 自定义密码页面标题
- `--instructions "说明"`: 自定义提示文字

---

## 🔍 查看加密状态

### 在 GitHub 查看自动化日志:

1. 进入仓库页面
2. 点击 **Actions** 标签
3. 查看最近的 workflow 运行记录
4. 点击查看详细日志

### 验证加密是否成功:

访问你的页面:
```
https://your-username.github.io/your-repo/project-finance.html
```

应该会看到密码输入界面,而不是直接显示内容。

---

## ❓ 常见问题

### Q1: 为什么 Actions 没有自动运行?

**检查:**
- 确保修改的是 `scr/` 目录下的文件
- 确保 `.github/workflows/encrypt.yml` 已提交
- 查看 Actions 标签是否有错误日志

### Q2: 密码输入正确但无法访问?

**可能原因:**
- 浏览器缓存了旧的加密版本 → 清除缓存或使用无痕模式
- GitHub Pages 还没更新 → 等待 1-2 分钟

### Q3: 如何移除密码保护?

**方法:**
1. 直接将 `scr/` 目录下的文件复制到根目录
2. 删除 `.github/workflows/encrypt.yml`
3. 提交并推送

### Q4: 可以给不同页面设置不同密码吗?

**可以!** 修改 `encrypt.yml`:

```yaml
- name: Encrypt protected pages
  run: |
    staticrypt scr/project-finance.html "${{ secrets.PASSWORD_FINANCE }}" -o project-finance.html -r 30 --short
    staticrypt scr/project-jaxx.html "${{ secrets.PASSWORD_JAXX }}" -o project-jaxx.html -r 30 --short
```

然后在 GitHub Secrets 中添加多个密码:
- `PASSWORD_FINANCE`
- `PASSWORD_JAXX`

---

## 🎯 最佳实践

1. ✅ **永远在 `scr/` 目录下编辑源文件**
2. ✅ **不要手动编辑根目录的加密文件**(会被覆盖)
3. ✅ **定期备份 `scr/` 目录**
4. ✅ **使用强密码**(至少 8 位,包含字母数字)
5. ✅ **不要在代码中硬编码密码**

---

## 📞 技术支持

如果遇到问题:
1. 查看 GitHub Actions 日志
2. 检查 `.gitignore` 是否正确
3. 确认 `scr/` 目录结构正确

---

**配置完成后,你只需要:**
1. 在 `scr/` 目录编辑页面
2. `git push` 提交
3. 等待自动加密完成 ✨
