# 🚀 快速开始指南

## ⏱️ 5 分钟完成配置

### 第 1 步:设置 GitHub Secret (1 分钟)

1. 打开你的 GitHub 仓库
2. 点击 **Settings** → **Secrets and variables** → **Actions**
3. 点击 **New repository secret**
4. 填写:
   - Name: `ENCRYPT_PASSWORD`
   - Secret: `2026` (或你想要的新密码)
5. 点击 **Add secret**

✅ 完成!

---

### 第 2 步:提交自动化配置 (2 分钟)

打开命令行(PowerShell 或 CMD),执行:

```powershell
# 进入项目目录
cd "D:\personal\HTML_RM\github pages"

# 查看新增的文件
git status

# 添加所有配置文件
git add .github/workflows/encrypt.yml
git add .gitignore
git add password-template.html
git add README-ENCRYPT.md
git add MIGRATION-GUIDE.md

# 提交
git commit -m "Add StaticCrypt auto-encryption system"

# 推送到 GitHub
git push
```

✅ 完成!

---

### 第 3 步:整理文件结构 (2 分钟)

```powershell
# 创建 scr 目录(如果不存在)
New-Item -ItemType Directory -Path "scr" -Force

# 移动现有的项目页面到 scr 目录
# (如果这些文件已经存在的话)
Move-Item -Path "project-finance.html" -Destination "scr\" -Force -ErrorAction SilentlyContinue
Move-Item -Path "project-jaxx.html" -Destination "scr\" -Force -ErrorAction SilentlyContinue
Move-Item -Path "project-speed.html" -Destination "scr\" -Force -ErrorAction SilentlyContinue
Move-Item -Path "project-loan.html" -Destination "scr\" -Force -ErrorAction SilentlyContinue

# 提交变更
git add .
git commit -m "Reorganize: move source files to scr/"
git push
```

✅ 完成!

---

### 第 4 步:修改 index.html (可选)

**选项 A: 自动修改(推荐)**

我可以帮你生成一个修改后的 `index.html`,你只需要替换即可。

**选项 B: 手动修改**

参考 `MIGRATION-GUIDE.md` 文件,删除密码弹窗相关代码。

**选项 C: 暂时不修改**

保留现有的密码弹窗,它会和 StaticCrypt 形成双重验证(更安全但体验稍差)。

---

## 🎉 完成!

现在你的系统已经配置完成。

### 📝 日常使用

1. **编辑页面**: 在 `scr/` 目录下修改文件
2. **提交**: `git add scr/` → `git commit -m "Update content"` → `git push`
3. **等待**: GitHub Actions 自动加密(约 1-2 分钟)
4. **访问**: 打开你的 GitHub Pages,页面已更新并加密

---

## 🔍 验证配置

### 检查 GitHub Actions 是否运行

1. 进入 GitHub 仓库
2. 点击 **Actions** 标签
3. 应该能看到 "Add StaticCrypt auto-encryption system" 的 workflow
4. 如果显示绿色 ✅,说明配置成功

### 测试加密功能

1. 修改 `scr/project-finance.html` 中的任意内容
2. 提交并推送
3. 等待 1-2 分钟
4. 访问 `https://your-username.github.io/your-repo/project-finance.html`
5. 应该会看到密码输入页面

---

## ❓ 遇到问题?

### Actions 没有自动运行?

**检查:**
- `.github/workflows/encrypt.yml` 是否已提交
- 修改的是否是 `scr/` 目录下的文件
- 查看 Actions 标签是否有错误日志

### 密码输入后无法访问?

**解决:**
- 清除浏览器缓存
- 使用无痕模式测试
- 检查 GitHub Secret 中的密码是否正确

### 想要更改密码?

1. 进入 **Settings** → **Secrets and variables** → **Actions**
2. 点击 `ENCRYPT_PASSWORD` → **Update**
3. 输入新密码并保存
4. 修改任意 `scr/` 文件并提交,触发重新加密

---

## 📚 更多信息

- 详细配置说明: `README-ENCRYPT.md`
- index.html 修改指南: `MIGRATION-GUIDE.md`
- 本地加密脚本: `encrypt-local.bat`

---

## 🎯 下一步

建议按以下顺序操作:

1. ✅ 完成上述 3 个步骤
2. 📖 阅读 `MIGRATION-GUIDE.md`,了解如何修改 `index.html`
3. 🧪 测试加密功能是否正常
4. 🎨 (可选)自定义 `password-template.html` 的样式
5. 🚀 开始使用!

---

**需要帮助?** 查看 `README-ENCRYPT.md` 中的常见问题部分。
