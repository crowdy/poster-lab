#!/bin/bash

# 일본어 폰트 자동 설치 스크립트
# Ubuntu/Debian 및 기타 Linux 배포판 지원

set -e  # 오류 발생 시 스크립트 중단

# 색상 정의
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 로그 함수들
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_step() {
    echo -e "${MAGENTA}[STEP]${NC} $1"
}

# 루트 권한 확인
check_root() {
    if [[ $EUID -eq 0 ]]; then
        log_warning "루트 권한으로 실행 중입니다. 사용자 폰트 폴더에 설치합니다."
        USER_FONTS_DIR="/root/.local/share/fonts"
    else
        USER_FONTS_DIR="$HOME/.local/share/fonts"
    fi
}

# 배포판 감지
detect_distro() {
    if command -v apt-get > /dev/null 2>&1; then
        DISTRO="debian"
        PKG_MANAGER="apt-get"
    elif command -v yum > /dev/null 2>&1; then
        DISTRO="redhat"
        PKG_MANAGER="yum"
    elif command -v dnf > /dev/null 2>&1; then
        DISTRO="fedora"
        PKG_MANAGER="dnf"
    elif command -v pacman > /dev/null 2>&1; then
        DISTRO="arch"
        PKG_MANAGER="pacman"
    elif command -v zypper > /dev/null 2>&1; then
        DISTRO="opensuse"
        PKG_MANAGER="zypper"
    else
        DISTRO="unknown"
        PKG_MANAGER=""
    fi
    
    log_info "감지된 배포판: $DISTRO"
}

# 필수 패키지 설치
install_dependencies() {
    log_step "필수 패키지 설치 중..."
    
    case $DISTRO in
        "debian")
            $PKG_MANAGER update
            $PKG_MANAGER install -y wget curl unzip fontconfig
            ;;
        "redhat"|"fedora")
            $PKG_MANAGER install -y wget curl unzip fontconfig
            ;;
        "arch")
            $PKG_MANAGER -S --noconfirm wget curl unzip fontconfig
            ;;
        "opensuse")
            $PKG_MANAGER install -y wget curl unzip fontconfig
            ;;
        *)
            log_warning "알 수 없는 배포판입니다. 수동으로 wget, curl, unzip, fontconfig를 설치해주세요."
            ;;
    esac
    
    log_success "필수 패키지 설치 완료"
}

# 폰트 폴더 생성
create_font_directories() {
    log_step "폰트 디렉토리 생성 중..."
    
    mkdir -p "$USER_FONTS_DIR"
    mkdir -p "$USER_FONTS_DIR/japanese"
    
    log_success "폰트 디렉토리 생성 완료: $USER_FONTS_DIR/japanese"
}

# Google Noto CJK 폰트 설치
install_noto_cjk_fonts() {
    log_step "Google Noto CJK 폰트 다운로드 및 설치 중..."
    
    local temp_dir=$(mktemp -d)
    cd "$temp_dir"
    
    # Noto Sans CJK 다운로드
    log_info "Noto Sans CJK 다운로드 중..."
    wget -q --show-progress "https://github.com/googlefonts/noto-cjk/releases/latest/download/Sans.zip" -O "NotoSansCJK.zip"
    
    # Noto Serif CJK 다운로드
    log_info "Noto Serif CJK 다운로드 중..."
    wget -q --show-progress "https://github.com/googlefonts/noto-cjk/releases/latest/download/Serif.zip" -O "NotoSerifCJK.zip"
    
    # 압축 해제 및 설치
    log_info "폰트 파일 압축 해제 중..."
    unzip -q "NotoSansCJK.zip" -d "NotoSans"
    unzip -q "NotoSerifCJK.zip" -d "NotoSerif"
    
    # OTC 파일을 사용자 폰트 디렉토리로 복사
    find "NotoSans" -name "*.otc" -exec cp {} "$USER_FONTS_DIR/japanese/" \;
    find "NotoSerif" -name "*.otc" -exec cp {} "$USER_FONTS_DIR/japanese/" \;
    
    # TTF 파일도 복사 (있는 경우)
    find "NotoSans" -name "*Japanese*.ttf" -exec cp {} "$USER_FONTS_DIR/japanese/" \;
    find "NotoSerif" -name "*Japanese*.ttf" -exec cp {} "$USER_FONTS_DIR/japanese/" \;
    
    cd - > /dev/null
    rm -rf "$temp_dir"
    
    log_success "Google Noto CJK 폰트 설치 완료"
}

# Source Han 폰트 설치 (Adobe)
install_source_han_fonts() {
    log_step "Adobe Source Han 폰트 다운로드 및 설치 중..."
    
    local temp_dir=$(mktemp -d)
    cd "$temp_dir"
    
    # Source Han Sans 다운로드
    log_info "Source Han Sans 다운로드 중..."
    wget -q --show-progress "https://github.com/adobe-fonts/source-han-sans/releases/latest/download/SourceHanSans.ttc" -O "SourceHanSans.ttc"
    
    # Source Han Serif 다운로드
    log_info "Source Han Serif 다운로드 중..."
    wget -q --show-progress "https://github.com/adobe-fonts/source-han-serif/releases/latest/download/SourceHanSerif.ttc" -O "SourceHanSerif.ttc"
    
    # 폰트 파일 복사
    cp "SourceHanSans.ttc" "$USER_FONTS_DIR/japanese/"
    cp "SourceHanSerif.ttc" "$USER_FONTS_DIR/japanese/"
    
    cd - > /dev/null
    rm -rf "$temp_dir"
    
    log_success "Adobe Source Han 폰트 설치 완료"
}

# 패키지 관리자를 통한 일본어 폰트 설치
install_distro_japanese_fonts() {
    log_step "배포판 일본어 폰트 패키지 설치 중..."
    
    case $DISTRO in
        "debian")
            $PKG_MANAGER install -y \
                fonts-noto-cjk \
                fonts-noto-cjk-extra \
                fonts-takao \
                fonts-vlgothic \
                fonts-migmix \
                fonts-ipafont \
                fonts-ipaexfont
            ;;
        "redhat"|"fedora")
            $PKG_MANAGER install -y \
                google-noto-cjk-fonts \
                google-noto-sans-cjk-jp-fonts \
                google-noto-serif-cjk-jp-fonts \
                vlgothic-fonts \
                ipa-gothic-fonts \
                ipa-mincho-fonts \
                ipa-pgothic-fonts \
                ipa-pmincho-fonts
            ;;
        "arch")
            $PKG_MANAGER -S --noconfirm \
                noto-fonts-cjk \
                adobe-source-han-sans-jp-fonts \
                adobe-source-han-serif-jp-fonts \
                ttf-hanazono
            ;;
        "opensuse")
            $PKG_MANAGER install -y \
                google-noto-sans-cjk-fonts \
                google-noto-serif-cjk-fonts
            ;;
        *)
            log_warning "알 수 없는 배포판입니다. 수동 설치를 계속합니다."
            return 1
            ;;
    esac
    
    log_success "배포판 일본어 폰트 패키지 설치 완료"
}

# IPAフォント 다운로드 및 설치
install_ipa_fonts() {
    log_step "IPA 폰트 다운로드 및 설치 중..."
    
    local temp_dir=$(mktemp -d)
    cd "$temp_dir"
    
    # IPAフォント 다운로드 URL들
    local ipa_fonts=(
        "https://moji.or.jp/wp-content/ipafont/IPAexfont/IPAexfont00401.zip"
        "https://moji.or.jp/wp-content/ipafont/IPAfont/IPAfont00303.zip"
    )
    
    for font_url in "${ipa_fonts[@]}"; do
        local filename=$(basename "$font_url")
        log_info "다운로드 중: $filename"
        
        if wget -q --show-progress "$font_url" -O "$filename"; then
            unzip -q "$filename"
            find . -name "*.ttf" -exec cp {} "$USER_FONTS_DIR/japanese/" \;
        else
            log_warning "$filename 다운로드 실패"
        fi
    done
    
    cd - > /dev/null
    rm -rf "$temp_dir"
    
    log_success "IPA 폰트 설치 완료"
}

# 폰트 캐시 업데이트
update_font_cache() {
    log_step "폰트 캐시 업데이트 중..."
    
    fc-cache -fv "$USER_FONTS_DIR" > /dev/null 2>&1
    
    # 시스템 전체 폰트 캐시도 업데이트 (권한이 있는 경우)
    if command -v > /dev/null 2>&1; then
        fc-cache -fv > /dev/null 2>&1 || log_warning "시스템 폰트 캐시 업데이트 실패"
    fi
    
    log_success "폰트 캐시 업데이트 완료"
}

# 설치된 일본어 폰트 확인
verify_installation() {
    log_step "설치된 일본어 폰트 확인 중..."
    
    local japanese_fonts_found=0
    
    # fc-list로 일본어 폰트 검색
    if command -v fc-list > /dev/null 2>&1; then
        local found_fonts=$(fc-list : family | grep -E "(Noto.*CJK|Source Han|IPA|Gothic|Mincho|Takao|VL)" | sort | uniq)
        
        if [[ -n "$found_fonts" ]]; then
            log_success "발견된 일본어 폰트들:"
            echo "$found_fonts" | while read -r font; do
                echo -e "  ${GREEN}✓${NC} $font"
            done
            japanese_fonts_found=1
        fi
    fi
    
    # 설치된 폰트 파일 직접 확인
    local installed_files=$(find "$USER_FONTS_DIR/japanese" -name "*.ttf" -o -name "*.otc" -o -name "*.ttc" 2>/dev/null | wc -l)
    
    if [[ $installed_files -gt 0 ]]; then
        log_success "폰트 디렉토리에 $installed_files 개의 폰트 파일이 설치되었습니다."
        japanese_fonts_found=1
    fi
    
    if [[ $japanese_fonts_found -eq 1 ]]; then
        log_success "일본어 폰트 설치가 성공적으로 완료되었습니다!"
    else
        log_warning "일본어 폰트를 찾을 수 없습니다. 수동으로 확인해주세요."
    fi
}

# 사용법 출력
show_usage() {
    echo "사용법: $0 [옵션]"
    echo ""
    echo "옵션:"
    echo "  -h, --help     이 도움말 출력"
    echo "  -q, --quick    패키지 관리자만 사용 (빠른 설치)"
    echo "  -f, --full     모든 폰트 설치 (기본값)"
    echo "  -c, --check    설치된 폰트만 확인"
    echo ""
    echo "예시:"
    echo "  $0              # 전체 폰트 설치"
    echo "  $0 --quick      # 패키지 관리자를 통한 빠른 설치"
    echo "  $0 --check      # 설치된 폰트 확인만"
}

# 메인 실행 함수
main() {
    echo -e "${CYAN}================================${NC}"
    echo -e "${CYAN}   일본어 폰트 설치 스크립트   ${NC}"
    echo -e "${CYAN}================================${NC}"
    echo ""
    
    local mode="full"
    
    # 명령행 인수 처리
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_usage
                exit 0
                ;;
            -q|--quick)
                mode="quick"
                shift
                ;;
            -f|--full)
                mode="full"
                shift
                ;;
            -c|--check)
                mode="check"
                shift
                ;;
            *)
                log_error "알 수 없는 옵션: $1"
                show_usage
                exit 1
                ;;
        esac
    done
    
    check_root
    detect_distro
    
    if [[ "$mode" == "check" ]]; then
        verify_installation
        exit 0
    fi
    
    # 설치 시작
    log_info "설치 모드: $mode"
    log_info "폰트 설치 경로: $USER_FONTS_DIR"
    echo ""
    
    install_dependencies
    create_font_directories
    
    if [[ "$mode" == "quick" ]]; then
        # 패키지 관리자만 사용
        install_distro_japanese_fonts || log_warning "패키지 관리자 설치 실패, 수동 설치로 진행"
    else
        # 전체 설치
        install_distro_japanese_fonts || log_warning "패키지 관리자 설치 실패, 수동 설치로 진행"
        install_noto_cjk_fonts
        install_source_han_fonts
        install_ipa_fonts
    fi
    
    update_font_cache
    verify_installation
    
    echo ""
    log_success "일본어 폰트 설치가 완료되었습니다!"
    log_info "터미널을 다시 시작하거나 애플리케이션을 재시작하여 새 폰트를 사용하세요."
}

# 스크립트 실행
main "$@"
