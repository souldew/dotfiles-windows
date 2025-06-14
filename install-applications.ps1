# Microsoft Storeアプリケーションインストール関数
function Install-MicrosoftStore-Applications {
    Write-Host "Microsoft Storeアプリケーションをインストール中..." -ForegroundColor Green
    try {
        #! Windows Storeからインストール
        # winget install --id Bitwarden.Bitwarden
        # winget install --id Microsoft.WSL
        # winget install --id Microsoft.VisualStudioCode
        # winget install SlackTechnologies.Slack
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
        # winget install --id 9NFTCH6J7FHV # MSI: Microsoft.PowerAutomateDesktop
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