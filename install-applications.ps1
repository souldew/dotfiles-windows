# Microsoft Storeアプリケーションインストール関数
function Install-MicrosoftStore-Applications {
    Write-Host "Microsoft Storeアプリケーションをインストール中..." -ForegroundColor Green
    try {
        # WSL
        # wsl --install # WSLは特別に処理する
        # Bitwarden
        # winget install --id 9PJSDV0VPK04 --accept-package-agreements # MSI版: Bitwarden.Bitwarden
        # VS Code
        # winget install --id XP9KHM4BK9FZ7Q --accept-package-agreements # MSI版: Microsoft.VisualStudioCode
        # # VS Codeのレジストリ設定
        # #? Memo: -Forceオプションは既にある場合にエラーにならないようにするため
        # #? {0}は文字列フォーマットの記法
        # # %1 は選択した1つのファイルにおきかえられ、%V は複数ファイルやフォルダを選択した場合にも機能する
        # # -LiteralPathは"*"を通常文字として手扱うため
        # $vscodePath = Join-Path $env:LOCALAPPDATA "Programs\Microsoft VS Code\Code.exe"
        # New-Item -Path "HKCU:\Software\Classes\Directory\shell\VSCode\command" -Force | Out-Null
        # # フォルダ選択時のコンテキストメニューに追加
        # Set-ItemProperty -Path "HKCU:\Software\Classes\Directory\shell\VSCode\command" -Name "(default)" -Value ('"{0}" "%V"' -f $vscodePath)
        # Set-ItemProperty -Path "HKCU:\Software\Classes\Directory\shell\VSCode" -Name "(default)" -Value "Code で開く"
        # Set-ItemProperty -Path "HKCU:\Software\Classes\Directory\shell\VSCode" -Name "Icon" -Value $vscodePath
        # # ファイル選択時のコンテキストメニューに追加
        # New-Item -Path "HKCU:\Software\Classes\*\shell\VSCode\command" -Force | Out-Null
        # Set-ItemProperty -LiteralPath "HKCU:\Software\Classes\*\shell\VSCode\command" -Name "(default)" -Value ('"{0}" "%1"' -f $vscodePath)
        # Set-ItemProperty -LiteralPath "HKCU:\Software\Classes\*\shell\VSCode" -Name "(default)" -Value "Code で開く"
        # Set-ItemProperty -LiteralPath "HKCU:\Software\Classes\*\shell\VSCode" -Name "Icon" -Value $vscodePath
        # # フォルダ選択時のコンテキストメニューに追加
        # New-Item -Path "HKCU:\Software\Classes\Directory\Background\shell\VSCode\command" -Force | Out-Null
        # Set-ItemProperty -Path "HKCU:\Software\Classes\Directory\Background\shell\VSCode\command" -Name "(default)" -Value ('"{0}" "%V"' -f $vscodePath)
        # Set-ItemProperty -Path "HKCU:\Software\Classes\Directory\Background\shell\VSCode" -Name "(default)" -Value "Code で開く"
        # Set-ItemProperty -Path "HKCU:\Software\Classes\Directory\Background\shell\VSCode" -Name "Icon" -Value $vscodePath
        # AutoHotkey v2
        winget install --id 9PLQFDG8HH9D --accept-package-agreements # MSI版: AutoHotkey.AutoHotkey
        
        # Slack
        # winget install --id 9PLQFDG8HH9D --accept-package-agreements #MSI版: SlackTechnologies.Slack
        Write-Host "Microsoft Storeアプリケーションのインストールが完了しました。" -ForegroundColor Green
    }
    catch {
        Write-Host "Microsoft Storeアプリケーションのインストールでエラーが発生しました: $_" -ForegroundColor Red
    }
}

# 通常のアプリケーションインストール関数（今後の拡張用）
function Install-RegularApplications {
    Write-Host "通常のアプリケーションをインストール中..." -ForegroundColor Green
    try {
        # ここに通常のアプリケーションのインストールコマンドを追加
        # Power Automate Desktop
        # winget install --id 9NFTCH6J7FHV # MSI: Microsoft.PowerAutomateDesktop
        # Discord
        # winget install --id XPDC2RH70K22MN --accept-package-agreements # MSI: Discord.Discord

        # example
        # 例: winget install --id Google.Chrome
        # 例: winget install --id Microsoft.VisualStudioCode
        
        Write-Host "通常のアプリケーションのインストールが完了しました。" -ForegroundColor Green
    }
    catch {
        Write-Host "通常のアプリケーションのインストールでエラーが発生しました: $_" -ForegroundColor Red
    }
}

# すべてのアプリケーションをインストールする統合関数
function Install-AllApplications {
    Write-Host "アプリケーションインストールを開始します..." -ForegroundColor Cyan
    
    Install-MicrosoftStore-Applications
    Install-RegularApplications
    
    Write-Host "すべてのアプリケーションのインストールが完了しました。" -ForegroundColor Cyan
}

# スクリプトが直接実行された場合のみ実行される部分
# ($MyInvocation.InvocationName でスクリプトが直接呼ばれたかを判定)
if ($MyInvocation.InvocationName -ne '.') {
    Write-Host "install-applications.ps1を単独で実行しています..." -ForegroundColor Cyan
    
    # 実行
    Install-AllApplications
}