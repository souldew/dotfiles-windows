# Microsoft Storeアプリケーションインストール関数
function Install-MicrosoftStore-Applications {
    Write-Host "Microsoft Storeアプリケーションをインストール中..." -ForegroundColor Green
    try {
        #! Windows Storeからインストール
        winget install --id Bitwarden.Bitwarden
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
