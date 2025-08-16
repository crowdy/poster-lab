# PSD 처리 도구 모음

PowerShell 7과 Aspose.PSD를 사용하여 PSD 파일을 분석하고 처리하는 통합 도구 모음입니다.

## 🚀 빠른 참조

| 목적 | 사용할 스크립트 |
|------|----------------|
| PSD 구조 분석하기 | `Get-LayerInfo.ps1` |
| 레이어를 PNG로 추출하기 | `Extract-PNGFromPSD.ps1` |
| PNG를 PSD로 재합성하기 | `Compose-PSD.ps1` |
| 추출된 이미지 정리하기 | `Organize-Png.ps1` |
| 스마트 오브젝트 확인하기 | `Check-SmartObject.ps1` |
| 추출 문제 해결하기 | `Diagnose-Layer.ps1` |
| 색상 문제 해결하기 | `Analyze-ColorSpace.ps1` |
| 환경 확인하기 | `Get-NetRuntimeInfo.ps1` |

## 🔧 필수 환경

- **PowerShell 7** (Core) - `pwsh` 명령으로 실행
- **.NET 8.0** 런타임
- **Windows 환경** 권장

모든 스크립트는 PowerShell 7에서만 동작하며, Windows PowerShell에서는 실행되지 않습니다.

---

## 📁 핵심 인프라

### `Load-AsposePSD.ps1`
**모든 스크립트가 공통으로 사용하는 라이브러리 로더**

- Aspose.PSD 및 의존성 라이브러리 자동 다운로드 및 로드
- .NET 8.0 호환 패키지 관리
- 다른 스크립트에서 `. "$PSScriptRoot\Load-AsposePSD.ps1"`로 로드

---

## 🔍 분석 및 탐색 도구

### `Get-LayerInfo.ps1`
**PSD 구조와 모든 레이어 정보를 상세 분석**

```powershell
.\Get-LayerInfo.ps1 .\sample.psd
```

**주요 기능:**
- 레이어 트리 구조 시각화
- 레이어 통계 (총 개수, 그룹, 레이어별 분류)
- 블렌딩 모드, 가시성, 바운드 정보
- PSD 기본 정보 (크기, 색상 모드, 비트 깊이)

### `Check-SmartObject.ps1`
**종합적인 PSD 분석 및 스마트 오브젝트 검사**

```powershell
.\Check-SmartObject.ps1 -PsdFile .\sample.psd
```

**주요 기능:**
- 스마트 오브젝트 탐지 및 상세 정보
- 레이어 트리와 구조 분석
- 파일 크기 및 메타데이터 정보
- JSON 형태 분석 결과 저장

### `Get-SmartObject.ps1`
**간단한 스마트 오브젝트 확인 도구**

```powershell
.\Get-SmartObject.ps1 .\sample.psd
```

**주요 기능:**
- 스마트 오브젝트 존재 여부만 빠르게 확인

---

## 🎨 이미지 처리 도구

### `Extract-PNGFromPSD.ps1`
**PSD에서 개별 레이어를 PNG 파일로 추출하는 메인 도구**

```powershell
# 모든 레이어 추출
.\Extract-PNGFromPSD.ps1 -InputFile .\sample.psd -OutputPath .\output

# 특정 레이어만 추출
.\Extract-PNGFromPSD.ps1 -InputFile .\sample.psd -OutputPath .\output -LayerName "캐릭터_메인"

# JPG 형식으로 추출
.\Extract-PNGFromPSD.ps1 -InputFile .\sample.psd -OutputPath .\output -Format jpg

# 특정 추출 방법 지정
.\Extract-PNGFromPSD.ps1 -InputFile .\sample.psd -OutputPath .\output -ExtractionMethod 6
```

**주요 기능:**
- 6가지 다중 폴백 추출 방법 (Method 6: 픽셀 직접 처리가 기본)
- PNG/JPG 형식 지원
- 투명도 보존
- 기존 파일 덮어쓰기 옵션
- JSON 결과 리포트 생성

**추출 방법:**
- Method 0: 자동 폴백 (기본값)
- Method 1: 기본 Aspose 저장
- Method 2: 레이어 타입별 최적화
- Method 3: 강화된 픽셀 데이터 추출
- Method 4: 기본 픽셀 데이터 추출
- Method 5: 합성 + 크롭
- Method 6: 픽셀 직접 처리 (가장 안정적)

### `Compose-PSD.ps1`
**추출된 PNG 파일들을 다시 PSD로 재합성**

```powershell
.\Compose-PSD.ps1 -AssetJson .\extraction_result.json -OutputPath .\composed.psd

# 저메모리 모드로 실행
.\Compose-PSD.ps1 -AssetJson .\extraction_result.json -LowMemoryMode -BatchSize 5
```

**주요 기능:**
- Extract-PNGFromPSD.ps1의 JSON 결과를 입력으로 사용
- 메모리 최적화 옵션
- 대용량 캔버스 지원
- 배치 처리로 메모리 관리
- 자동 에러 복구

### `Organize-Png.ps1`
**추출된 PNG 파일들을 카테고리별로 정리**

```powershell
.\Organize-Png.ps1 -PosterDir "D:\poster" -JsonDir "D:\poster-json" -OutputBaseDir "D:\poster\machine"
```

**주요 기능:**
- 캐릭터, 아이콘, 머신 등 카테고리별 자동 분류
- 머신 ID별 폴더 구조 생성
- 단일 머신 PSD 파일 필터링
- Method 6 픽셀 직접 처리 사용

---

## 🔧 진단 및 문제 해결 도구

### `Diagnose-Layer.ps1`
**레이어 투명도 및 추출 문제 진단**

```powershell
.\Diagnose-Layer.ps1 -PsdPath .\sample.psd -LayerName "문제레이어" -OutputDir .\diagnosis
```

**주요 기능:**
- 레이어 픽셀 데이터 분석
- 투명도 문제 원인 파악
- 다양한 추출 방법 테스트
- 레이어 속성 상세 정보
- 문제 해결 권장사항 제시

### `Analyze-ColorSpace.ps1`
**색상 공간 및 픽셀 데이터 문제 해결**

```powershell
.\Analyze-ColorSpace.ps1 -PsdPath .\sample.psd -LayerName "색상문제레이어" -OutputDir .\colorfix
```

**주요 기능:**
- PSD 색상 모드 및 프로파일 분석
- RGB 색상 공간 강제 변환
- 픽셀 데이터 정규화
- 감마 보정 적용
- 색상 범위 분석 및 최적화

### `Get-NetRuntimeInfo.ps1`
**PowerShell 및 .NET 환경 진단**

```powershell
.\Get-NetRuntimeInfo.ps1
```

**주요 기능:**
- PowerShell 버전 및 에디션 확인
- .NET 런타임 정보
- System.Drawing 호환성 테스트
- 설치된 .NET 버전 목록
- 환경 문제 진단

---

## 📋 일반적인 워크플로우

### 1. 기본 PSD 분석 및 추출
```powershell
# 1단계: PSD 구조 분석
.\Get-LayerInfo.ps1 .\sample.psd

# 2단계: 모든 레이어 추출
.\Extract-PNGFromPSD.ps1 -InputFile .\sample.psd -OutputPath .\extracted

# 3단계: 추출 결과 확인
# extracted 폴더와 extraction_result_*.json 파일 확인
```

### 2. 문제가 있는 레이어 해결
```powershell
# 1단계: 문제 진단
.\Diagnose-Layer.ps1 -PsdPath .\sample.psd -LayerName "문제레이어" -OutputDir .\diagnosis

# 2단계: 색상 문제 해결 (필요시)
.\Analyze-ColorSpace.ps1 -PsdPath .\sample.psd -LayerName "문제레이어" -OutputDir .\colorfix

# 3단계: 특정 방법으로 재추출
.\Extract-PNGFromPSD.ps1 -InputFile .\sample.psd -OutputPath .\fixed -LayerName "문제레이어" -ExtractionMethod 5
```

### 3. PNG → PSD 재합성
```powershell
# 추출된 PNG들을 다시 PSD로 합성
.\Compose-PSD.ps1 -AssetJson .\extracted\extraction_result_sample_20250814_151234.json -OutputPath .\recreated.psd
```

### 4. 머신별 이미지 정리 (특수 용도)
```powershell
# 포스터 이미지들을 머신별로 정리
.\Organize-Png.ps1 -PosterDir "D:\poster" -JsonDir "D:\poster-json" -OutputBaseDir "D:\poster\organized"
```

---

## 🔄 스크립트 버전들

일부 스크립트에는 여러 버전이 있습니다:

**Compose-PSD 관련:**
- `compose-psd-claude.ps1`, `compose-psd-claude-2.ps1`, etc. - 개발 중 버전들
- `compose-psd-gemini.ps1`, `compose-psd-gemini-2.ps1` - 대안 구현들
- `Compose-PSD.ps1` - **현재 사용 권장 버전**

**기타 실험적 버전들:**
- `Convert-PSD2PNG.ps1` - 레거시 변환 도구
- `Extract-PNGFromPSD-w-transition.ps1` - 특수 기능 포함 버전

---

## ⚠️ 주의사항

1. **PowerShell 7 필수**: 모든 스크립트는 `pwsh` 명령으로 실행해야 합니다.
2. **메모리 사용량**: 대용량 PSD 파일 처리 시 메모리 부족에 주의하세요.
3. **파일 경로**: 공백이 포함된 경로는 따옴표로 감싸주세요.
4. **권한**: 일부 스크립트는 파일 쓰기 권한이 필요합니다.

---

## 📄 라이선스

이 도구들은 Aspose.PSD 라이브러리를 사용합니다. 상업적 사용 시 해당 라이선스를 확인하세요.
