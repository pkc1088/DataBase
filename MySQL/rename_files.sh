#!/bin/bash

# 경로를 인자로 받기 (현재 디렉토리로 기본 설정)
directory="${1:-.}"

# 해당 디렉토리에서 모든 .cpp 파일 찾기
find "$directory" -type f -name "*.cpp" | while read file; do
    # 파일 경로에서 날짜와 DB 축약어 제거
    filename=$(basename "$file")
    new_filename=$(echo "$filename" | sed -E 's/^[0-9]{2}\.[0-9]{2} DB //; s/\.cpp$/.sql/')

    # 새로운 파일 이름으로 변경
    mv "$file" "$(dirname "$file")/$new_filename"
done

echo "파일 이름 변경 완료!"
