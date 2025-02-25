# Путь к сетевой папке с архивами журналов регистрации
$BackUpLocation = "Путь к вашему хранилищу"

# Локальная папка для распаковки
$DestinationLocation = "D:\TestFolder"

# Параметры выборки данных
$JRYears = @("2024")            # Годы для обработки
$JRMonths = @("06","07","08","09") # Месяцы для обработки
$BaseName = "Наименование вашей базы 1С" # Шаблон имени базы 1С

# Поиск архивных файлов
$Archives = @()
foreach ($Year in $JRYears) {
    foreach ($Month in $JRMonths) {
        # Формирование полного пути и выборка ZIP-архивов
        $Archives += Get-ChildItem -Path "$BackUpLocation\$BaseName\$Year\$Month" -Filter "*.zip" | 
                    Select-Object -ExpandProperty Fullname
    }
}

# Распаковка архивов с помощью 7-Zip
foreach ($Archive in $Archives) {
    # Использование 7-Zip с ключами:
    # x - распаковка
    # -aoa - режим перезаписи файлов без подтверждения
    & "C:\Program Files\7-Zip\7z.exe" x -aoa $Archive -o"$DestinationLocation"
}

# Примечания:
# 1. Требуется установленный 7-Zip в стандартной локации
# 2. Структура каталогов на сервере должна соответствовать:
#    \Journal\{НазваниеБазы}\{Год}\{Месяц}\*.zip
# 3. Для работы со сетевыми ресурсами нужны соответствующие права доступа
# 4. При первом запуске рекомендуется проверить пути и наличие архивов
