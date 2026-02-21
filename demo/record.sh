#!/usr/bin/env bash
# Scripted demo for asciinema recording
# Simulates a realistic plugin session

set -e

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

type_slow() {
  local text="$1"
  local delay="${2:-0.04}"
  for (( i=0; i<${#text}; i++ )); do
    printf '%s' "${text:$i:1}"
    sleep "$delay"
  done
}

prompt() {
  printf "${GREEN}❯${NC} "
}

pause() {
  sleep "${1:-1}"
}

clear
echo ""
printf "${BOLD}claude-self-improve${NC} — self-improvement loop for Claude Code\n"
echo ""
pause 1.5

# Step 1: Install
prompt
type_slow "claude --plugin-dir ./claude-self-improve"
echo ""
pause 0.8
printf "${DIM}Loading plugin: claude-self-improve v0.1.0${NC}\n"
printf "${DIM}  ✓ Hook: PostToolUse → log-tool.sh${NC}\n"
printf "${DIM}  ✓ Hook: Stop → on-stop.sh${NC}\n"
printf "${DIM}  ✓ Skill: /self-improve:review${NC}\n"
printf "${DIM}  ✓ Skill: /self-improve:status${NC}\n"
printf "${DIM}  ✓ Skill: /self-improve:backlog-sync${NC}\n"
echo ""
pause 2

# Step 2: Work normally
printf "${CYAN}# You work normally... hooks log tool calls silently${NC}\n"
pause 1.5
printf "${DIM}  [log] Read src/main.ts${NC}\n"
sleep 0.3
printf "${DIM}  [log] Grep \"handleError\" → 3 matches${NC}\n"
sleep 0.3
printf "${DIM}  [log] Edit src/main.ts (line 42)${NC}\n"
sleep 0.3
printf "${DIM}  [log] Bash: npm test → FAIL${NC}\n"
sleep 0.3
printf "${DIM}  [log] Edit src/main.ts (line 42)${NC}\n"
sleep 0.3
printf "${DIM}  [log] Bash: npm test → OK${NC}\n"
echo ""
pause 2

# Step 3: Run review
prompt
type_slow "/self-improve:review"
echo ""
pause 1

printf "\n${BOLD}Analyzing project...${NC}\n"
sleep 0.5
printf "  📊 Tool calls logged: ${BOLD}47${NC}\n"
sleep 0.3
printf "  ❌ Failures: ${BOLD}${YELLOW}3${NC} (Bash: npm test)\n"
sleep 0.3
printf "  📝 Stale TODOs: ${BOLD}5${NC}\n"
sleep 0.3
printf "  🔄 Git: 2 reverts in last 7 days\n"
echo ""
pause 1.5

printf "${BOLD}Proposals:${NC}\n\n"
sleep 0.5

printf "${BOLD}1. [HIGH] Fix flaky test in auth module${NC}\n"
printf "   ${DIM}npm test failed 3x on same assertion. Root cause:${NC}\n"
printf "   ${DIM}async race condition in handleError().${NC}\n"
echo ""
sleep 1

printf "${BOLD}2. [MED] Remove stale TODO comments${NC}\n"
printf "   ${DIM}5 TODOs older than 30 days, 2 already implemented.${NC}\n"
echo ""
sleep 1

printf "${BOLD}3. [LOW] Extract repeated file reads into shared util${NC}\n"
printf "   ${DIM}src/config.ts read 12 times — consider caching.${NC}\n"
echo ""
pause 1.5

printf "${GREEN}✓ Implementing #1: fix flaky test...${NC}\n"
sleep 0.8
printf "${GREEN}✓ Tests passing${NC}\n"
sleep 0.5
printf "${GREEN}✓ PR created: improve/2026-02-22/fix-auth-race${NC}\n"
echo ""
pause 2
