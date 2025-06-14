# スクリプトパラメータの定義
param(
    [switch]$SkipBackup
)

# edit-registory.ps1から関数を読み込み
. ".\edit-registory.ps1"

# install-applications.ps1から関数を読み込み
. ".\install-applications.ps1"

# メイン実行関数
function Main {
    Write-Host "Windows環境設定を開始します..." -ForegroundColor Cyan
    
    # レジストリ設定を実行
    if ($SkipBackup) {
        Write-Host "レジストリのバックアップをスキップします。" -ForegroundColor Yellow
        Set-RegistrySettings -SkipBackup
    } else {
        Set-RegistrySettings
    }
    
    # アプリケーションをインストール
    Install-AllApplications
    
    Write-Host "すべての設定が完了しました。" -ForegroundColor Cyan
}

# スクリプト実行
Main
