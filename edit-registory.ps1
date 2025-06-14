# 単独実行時のパラメータ定義
param(
    [switch]$SkipBackup
)

# レジストリバックアップ関数
function Backup-Registry {
    param(
        [string]$UserName = $env:USERNAME
    )
    
    # フォルダの存在確認＆作成
    $registoryBackupDir = "C:\Users\$UserName\works\my-registory-log"
    if (-not (Test-Path $registoryBackupDir)) {
        New-Item -Path $registoryBackupDir -ItemType Directory | Out-Null
    }

    # バックアップ先の表示
    Write-Host "バックアップ先: $registoryBackupDir" -ForegroundColor Green

    # 日付・時刻付きファイル名（24時間表記）
    $distRegistoryFile = "$registoryBackupDir\{0:yyyy-MM-dd_HH-mm}_HKCU.reg" -f (Get-Date)
    Write-Host "バックアップファイル: $distRegistoryFile" -ForegroundColor Green

    try {
        # レジストリのバックアップを実行
        reg export HKCU "$distRegistoryFile" /y
        Write-Host "レジストリのバックアップが完了しました。" -ForegroundColor Green
    }
    catch {
        Write-Host "レジストリのバックアップに失敗しました: $_" -ForegroundColor Red
    }
}

# IME設定関数
function Set-IMESettings {
    Write-Host "IME設定を適用中..." -ForegroundColor Yellow
    
    try {
        $imePath = "HKCU:\Software\Microsoft\IME\15.0\IMEJP\MSIME"
        
        # スペースを常に半角にする
        Set-ItemProperty -Path $imePath -Name "InputSpace" -Value 2
        Write-Host "  - スペースを常に半角に設定" -ForegroundColor Gray

        # テンキー入力を常に半角にする
        Set-ItemProperty -Path $imePath -Name "option3" -Value 0
        Write-Host "  - テンキー入力を常に半角に設定" -ForegroundColor Gray

        # 無変換キーでIME-OFF
        Set-ItemProperty -Path $imePath -Name "KeyAssignmentMuhenkan" -Value 1
        Write-Host "  - 無変換キーでIME-OFF設定" -ForegroundColor Gray

        # 変換キーでIME-ON
        Set-ItemProperty -Path $imePath -Name "KeyAssignmentHenkan" -Value 0
        Write-Host "  - 変換キーでIME-ON設定" -ForegroundColor Gray

        # Shift+Spaceで別幅スペース
        Set-ItemProperty -Path $imePath -Name "KeyAssignmentShiftSpace" -Value 3
        Write-Host "  - Shift+Spaceで別幅スペース設定" -ForegroundColor Gray

        Write-Host "IME設定が完了しました。" -ForegroundColor Green
    }
    catch {
        Write-Host "IME設定でエラーが発生しました: $_" -ForegroundColor Red
    }
}

# メインのレジストリ設定関数
function Set-RegistrySettings {
    param(
        [switch]$SkipBackup
    )
    
    Write-Host "レジストリ設定を開始します..." -ForegroundColor Cyan
    
    if (-not $SkipBackup) {
        Backup-Registry
    }
    
    Set-IMESettings
    
    Write-Host "レジストリ設定が完了しました。" -ForegroundColor Cyan
}

# スクリプトが直接実行された場合のみ実行される部分
# ($MyInvocation.InvocationName でスクリプトが直接呼ばれたかを判定)
if ($MyInvocation.InvocationName -ne '.') {
    Write-Host "edit-registory.ps1を単独で実行しています..." -ForegroundColor Cyan
    
    # レジストリ設定を実行
    Set-RegistrySettings -SkipBackup:$SkipBackup
}