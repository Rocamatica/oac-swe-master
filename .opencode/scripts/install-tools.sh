#!/usr/bin/env bash
# ============================================================
# install-tools.sh — Bootstrap para REPON
#
# Propósito: Reinstalar todas las herramientas Hugo + OAC
# en un REPON recién clonado. Las herramientas instaladas
# en Fase 3 no viajan en el repo (npm global, venvs), pero
# el código fuente de los MCPs sí está en .opencode/mcp/.
#
# Basado en: recursos/seleccion-herramientas-hugo-oac-validado.md
# Uso:       bash .opencode/scripts/install-tools.sh
# ============================================================

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
MCP_DIR="$ROOT_DIR/.opencode/mcp"
LOG_FILE="$ROOT_DIR/.opencode/scripts/install-tools.log"

echo "=========================================="
echo " REPOC — Instalación de herramientas Hugo"
echo "=========================================="
echo ""
echo "Log: $LOG_FILE"
echo ""

# Limpiar log previo
: > "$LOG_FILE"

# Helper: log + echo
log() {
    echo "[$(date '+%H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

# Helper: verifica que el comando anterior fue exitoso
check() {
    if [ $? -ne 0 ]; then
        log "ERROR: $*"
        exit 1
    fi
}

# ==============================================
# 1. npm global
# ==============================================
log "--- npm global ---"

log "Instalando hugo-extended..."
npm install -g hugo-extended >> "$LOG_FILE" 2>&1
check "hugo-extended"

log "Instalando pagefind..."
npm install -g pagefind >> "$LOG_FILE" 2>&1
check "pagefind"

log "Instalando agentic-seo..."
npm install -g agentic-seo >> "$LOG_FILE" 2>&1
check "agentic-seo"

log "Instalando wrangler..."
npm install -g wrangler >> "$LOG_FILE" 2>&1
check "wrangler"

# ==============================================
# 2. seofor.dev (binario Go, no npm)
# ==============================================
log "--- seofor.dev ---"

if command -v seo &>/dev/null; then
    log "seo ya instalado, saltando..."
else
    log "Instalando seofor.dev vía install.sh..."
    curl -sSfL https://raw.githubusercontent.com/ugolbck/seofordev/main/install.sh | bash >> "$LOG_FILE" 2>&1
    check "seofor.dev"
fi

# ==============================================
# 3. hugo-mcp (Python venv)
# ==============================================
log "--- hugo-mcp ---"

if [ -d "$MCP_DIR/hugo-mcp-src" ]; then
    log "Creando venv hugo-mcp..."
    python3 -m venv "$MCP_DIR/hugo-mcp-src/venv" >> "$LOG_FILE" 2>&1
    source "$MCP_DIR/hugo-mcp-src/venv/bin/activate"
    pip install -r "$MCP_DIR/hugo-mcp-src/requirements.txt" >> "$LOG_FILE" 2>&1
    deactivate
    log "hugo-mcp OK"
else
    log "WARN: hugo-mcp-src no encontrado en $MCP_DIR"
    log "      clónalo con: git clone https://github.com/jmrGrav/hugo-mcp.git $MCP_DIR/hugo-mcp-src"
fi

# ==============================================
# 4. hugo-memex (Python venv)
# ==============================================
log "--- hugo-memex ---"

if [ -d "$MCP_DIR/hugo-memex-src" ]; then
    log "Creando venv hugo-memex..."
    python3 -m venv "$MCP_DIR/hugo-memex-src/venv" >> "$LOG_FILE" 2>&1
    source "$MCP_DIR/hugo-memex-src/venv/bin/activate"
    pip install -e "$MCP_DIR/hugo-memex-src" >> "$LOG_FILE" 2>&1
    deactivate
    log "hugo-memex OK"
else
    log "WARN: hugo-memex-src no encontrado en $MCP_DIR"
    log "      clónalo con: git clone https://github.com/queelius/hugo-memex.git $MCP_DIR/hugo-memex-src"
fi

# ==============================================
# 5. hugo-docs-mcp (Go build)
# ==============================================
log "--- hugo-docs-mcp ---"

if [ -d "$MCP_DIR/hugo-docs-mcp-src" ]; then
    if command -v go &>/dev/null; then
        log "Compilando hugo-docs-mcp..."
        cd "$MCP_DIR/hugo-docs-mcp-src"
        go build -o "$MCP_DIR/hugo-docs-mcp" . >> "$LOG_FILE" 2>&1
        cd "$ROOT_DIR"
        log "hugo-docs-mcp OK ($(file "$MCP_DIR/hugo-docs-mcp" | awk '{print $NF}'))"
    else
        log "WARN: Go no instalado. No se puede compilar hugo-docs-mcp."
    fi
else
    log "WARN: hugo-docs-mcp-src no encontrado en $MCP_DIR"
    log "      clónalo con: git clone https://github.com/danfinn5/hugo-docs-mcp.git $MCP_DIR/hugo-docs-mcp-src"
fi

# ==============================================
# 6. Verificación
# ==============================================
log ""
log "=========================================="
log " Verificación"
log "=========================================="

ERRORS=0

verify() {
    local name="$1"
    local binary="$2"
    local version_cmd="$3"

    if command -v "$binary" &>/dev/null; then
        local version
        version=$(eval "$version_cmd" 2>/dev/null || echo "OK")
        log "  ✅ $name → $version"
    else
        log "  ❌ $name → NO INSTALADO"
        ERRORS=$((ERRORS + 1))
    fi
}

verify "hugo"          "hugo"          "hugo version | awk '{print \$5}'"
verify "pagefind"      "pagefind"      "pagefind --version"
verify "agentic-seo"   "agentic-seo"   "agentic-seo --version"
verify "seofor.dev"    "seo"           "seo --version"
verify "wrangler"      "wrangler"      "wrangler --version"

# Verificar venvs
if [ -f "$MCP_DIR/hugo-mcp-src/venv/bin/python" ]; then
    log "  ✅ hugo-mcp venv"
else
    log "  ❌ hugo-mcp venv → NO CREADO"
    ERRORS=$((ERRORS + 1))
fi

if [ -f "$MCP_DIR/hugo-memex-src/venv/bin/python" ]; then
    log "  ✅ hugo-memex venv"
else
    log "  ❌ hugo-memex venv → NO CREADO"
    ERRORS=$((ERRORS + 1))
fi

if [ -f "$MCP_DIR/hugo-docs-mcp" ]; then
    log "  ✅ hugo-docs-mcp binary"
else
    log "  ❌ hugo-docs-mcp binary → NO COMPILADO"
    ERRORS=$((ERRORS + 1))
fi

echo ""
if [ $ERRORS -eq 0 ]; then
    echo "✅ Todas las herramientas instaladas correctamente."
else
    echo "❌ $ERRORS errores. Revisa $LOG_FILE para detalles."
    exit 1
fi
