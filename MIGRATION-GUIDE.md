# 📝 index.html 修改指南

## 🎯 目标
移除现有的密码弹窗系统,让 StaticCrypt 接管密码保护功能。

---

## 🗑️ 需要删除的代码

### 1. HTML 部分 (第 565-572 行左右)

**删除:**
```html
<!-- 密码验证弹窗 -->
<div class="pwd-modal-overlay" id="pwdModal">
    <div class="pwd-box">
        <div class="pwd-title">// SECURITY CHECK //</div>
        <input type="password" class="pwd-input" id="pwdInput" placeholder="ACCESS CODE" maxlength="8">
        <button class="pwd-btn" id="pwdBtn">UNLOCK</button>
        <div class="pwd-error" id="pwdError">ACCESS DENIED</div>
    </div>
</div>
```

### 2. CSS 部分 (第 470-530 行左右)

**删除整个 PASSWORD MODAL 区块:**
```css
/* ==================== 
   PASSWORD MODAL
   ==================== */
.pwd-modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(255, 255, 255, 0.9);
    backdrop-filter: blur(5px);
    z-index: 99999;
    display: flex;
    align-items: center;
    justify-content: center;
    opacity: 0;
    pointer-events: none;
    transition: opacity 0.3s;
}

.pwd-modal-overlay.active {
    opacity: 1;
    pointer-events: auto;
}

.pwd-box {
    background: #fff;
    border: 1px solid var(--structure);
    padding: 40px;
    text-align: center;
    width: 300px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    transform: translateY(20px);
    transition: transform 0.3s cubic-bezier(0.16, 1, 0.3, 1);
}

.pwd-modal-overlay.active .pwd-box {
    transform: translateY(0);
}

.pwd-title {
    font-family: var(--font-mono);
    font-size: 14px;
    margin-bottom: 20px;
    letter-spacing: 1px;
}

.pwd-input {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    font-family: var(--font-mono);
    font-size: 16px;
    text-align: center;
    letter-spacing: 5px;
    margin-bottom: 20px;
    outline: none;
    transition: border-color 0.3s;
}

.pwd-input:focus {
    border-color: var(--soul);
}

.pwd-btn {
    background: var(--structure);
    color: #fff;
    border: none;
    padding: 10px 20px;
    font-family: var(--font-mono);
    cursor: pointer;
    width: 100%;
    transition: background 0.3s;
}

.pwd-btn:hover {
    background: var(--soul);
}

.pwd-error {
    color: red;
    font-size: 10px;
    font-family: var(--font-mono);
    margin-top: 10px;
    display: none;
}
```

### 3. JavaScript 部分 (在 `<script>` 标签内)

**查找并删除以下代码:**

#### 3.1 变量声明部分
```javascript
const pwdModal = document.getElementById('pwdModal');
const pwdInput = document.getElementById('pwdInput');
const pwdBtn = document.getElementById('pwdBtn');
const pwdError = document.getElementById('pwdError');

// 不防小人
const encrypted = "MjAyNg==";
const ACCESS_KEY = atob(encrypted);
```

#### 3.2 密码验证函数
```javascript
// 弹窗逻辑
function showPwdModal() {
    pwdModal.classList.add('active');
    pwdInput.value = '';
    pwdError.style.display = 'none';
    setTimeout(() => pwdInput.focus(), 100);
}

function hidePwdModal() {
    pwdModal.classList.remove('active');
}

function verifyPassword() {
    const inputVal = pwdInput.value;
    if (inputVal === ACCESS_KEY) {
        // 密码正确
        sessionStorage.setItem('project_access_unlocked', 'true');
        hidePwdModal();
        if (pendingCard && pendingUrl) {
            performTransition(pendingCard, pendingUrl);
        }
    } else {
        // 密码错误
        pwdError.style.display = 'block';
        pwdInput.classList.add('shake');
        setTimeout(() => pwdInput.classList.remove('shake'), 500);
    }
}
```

#### 3.3 事件监听器
```javascript
// 绑定弹窗事件
pwdBtn.addEventListener('click', verifyPassword);
pwdInput.addEventListener('keydown', (e) => {
    if (e.key === 'Enter') verifyPassword();
    if (e.key === 'Escape') hidePwdModal();
});
pwdModal.addEventListener('click', (e) => {
    if (e.target === pwdModal) hidePwdModal();
});
```

#### 3.4 修改卡片点击逻辑

**原代码:**
```javascript
cards.forEach((card) => {
    card.addEventListener('click', (e) => {
        const targetUrl = card.getAttribute('data-target');
        if (targetUrl) {
            e.preventDefault();
            
            // 检查是否有缓存的授权
            const isUnlocked = sessionStorage.getItem('project_access_unlocked');
            if (isUnlocked === 'true') {
                performTransition(card, targetUrl);
            } else {
                // 显示密码弹窗
                pendingCard = card;
                pendingUrl = targetUrl;
                showPwdModal();
            }
        }
    });
});
```

**修改为:**
```javascript
cards.forEach((card) => {
    card.addEventListener('click', (e) => {
        const targetUrl = card.getAttribute('data-target');
        if (targetUrl) {
            e.preventDefault();
            // 直接跳转,让 StaticCrypt 处理密码验证
            performTransition(card, targetUrl);
        }
    });
});
```

#### 3.5 删除全局变量
```javascript
// 删除这两行
let pendingCard = null;
let pendingUrl = null;
```

---

## ✅ 修改后的完整卡片点击代码

```javascript
// ==================== 
// 通用卡片转场逻辑 (HERO TRANSITION)
// ==================== 
const cards = document.querySelectorAll('.proj-card-frame');
const curtain = document.querySelector('.page-transition-curtain');

cards.forEach((card) => {
    card.addEventListener('click', (e) => {
        const targetUrl = card.getAttribute('data-target');
        if (targetUrl) {
            e.preventDefault();
            performTransition(card, targetUrl);
        }
    });
});

function performTransition(originalCard, targetUrl) {
    const rect = originalCard.getBoundingClientRect();
    const clone = originalCard.cloneNode(true);
    clone.classList.add('clone-card');
    
    clone.style.top = rect.top + 'px';
    clone.style.left = rect.left + 'px';
    clone.style.width = rect.width + 'px';
    clone.style.height = rect.height + 'px';
    clone.style.margin = '0';
    
    document.body.appendChild(clone);
    void clone.offsetWidth;
    clone.classList.add('expanding');
    
    curtain.style.opacity = '1';
    curtain.style.pointerEvents = 'auto';
    
    setTimeout(() => {
        window.location.href = targetUrl;
    }, 600);
}
```

---

## 🔍 验证修改

修改完成后,检查以下内容:

1. ✅ HTML 中没有 `id="pwdModal"` 的元素
2. ✅ CSS 中没有 `.pwd-modal-overlay` 等相关样式
3. ✅ JavaScript 中没有 `showPwdModal`、`hidePwdModal`、`verifyPassword` 函数
4. ✅ 卡片点击直接调用 `performTransition`,不再检查 `sessionStorage`

---

## 🎨 效果预览

修改后的用户体验:

1. 用户在 `index.html` 点击项目卡片
2. 播放精美的卡片展开动画
3. 跳转到加密页面(例如 `project-finance.html`)
4. **StaticCrypt 的密码页面出现**(使用你的自定义模板,保持设计风格一致)
5. 输入密码后,内容解密并显示
6. 密码记住 30 天,下次访问不需要重新输入

---

## 💡 提示

- 如果你想保留原密码弹窗作为"预览",可以不删除,只需修改跳转逻辑即可
- 建议完全删除以简化代码维护
- 删除后记得测试所有项目卡片的跳转功能

---

## 📞 需要帮助?

如果不确定如何修改,可以:
1. 备份当前的 `index.html`
2. 使用文本编辑器的"查找"功能定位需要删除的代码
3. 逐步删除并测试

或者我可以帮你生成一个完整的修改后的 `index.html` 文件。
