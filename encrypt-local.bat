@echo off
chcp 65001 >nul
echo ================================
echo   本地加密脚本 (Windows)
echo ================================
echo.

REM 设置密码(本地测试用,正式环境用 GitHub Secret)
set PASSWORD=your_password_here

echo [1/4] 检查 staticrypt 是否已安装...
where staticrypt >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ 未找到 staticrypt,正在安装...
    npm install -g staticrypt
    if %errorlevel% neq 0 (
        echo ❌ 安装失败,请手动运行: npm install -g staticrypt
        pause
        exit /b 1
    )
)
echo ✅ staticrypt 已就绪

echo.
echo [2/4] 开始加密页面...
staticrypt scr\project-finance.html %PASSWORD% -o project-finance.html -r 30 --short
staticrypt scr\project-jaxx.html %PASSWORD% -o project-jaxx.html -r 30 --short
staticrypt scr\project-speed.html %PASSWORD% -o project-speed.html -r 30 --short
staticrypt scr\project-loan.html %PASSWORD% -o project-loan.html -r 30 --short

if %errorlevel% neq 0 (
    echo ❌ 加密失败
    pause
    exit /b 1
)

echo.
echo [3/4] 加密完成!
echo ✅ project-finance.html
echo ✅ project-jaxx.html
echo ✅ project-speed.html
echo ✅ project-loan.html

echo.
echo [4/4] 下一步操作:
echo 1. 检查加密后的文件是否正常
echo 2. 运行: git add .
echo 3. 运行: git commit -m "Update encrypted pages"
echo 4. 运行: git push
echo.
echo ================================
echo   完成! 按任意键退出
echo ================================
pause >nul
