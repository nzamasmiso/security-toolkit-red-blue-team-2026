#! /bin/bash
set -euo pipefail

TARGET_FILE=$(1:-"targets.txt")
DATE=$(date +%Y%m%d)
REPORT_DIR="./reports_$(DATE)"
MAX_JOBS=3 #parallel scans

mkdir -p "$REPORT_DIR"

validate_ip(){
    [[$1 =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$]]
}

scan_targets(){
    local target=$1
    local safe_target=$(echo "$target" | tr -cd '0-9.')
    local report="REPORT_DIR/nmap_${safe_target}.txt"

    echo "[$(date +%H:%M:%S)] Starting scan: $safe_target"
    nmap -sV -T4 --host-timeout 10m "$safe_target" -oN "$report"

    open_ports=$(grep -c "open" "$report" ||echo "0")
    echo "[$(date +%H:%M:%S)] Done: $safe_target | Open ports: $open_ports"
}

export -f scan_target validate_ip
export REPORT_DIR

echo "Reading targets from $TARGET_FILE"
cat "$TARGET_FILE" | while read -r ip; do 
    if validate_ip "$ip"; then
        echo "$ip"
    else:
        echo "Invalid IP skipped: "$ip">&2
    fi
done | xargs -P $MAX_JOBS -I {} bash -c "scab_target '$@'" _ {}
echo "All scans completer. Reports in $REPORT_DIR"
