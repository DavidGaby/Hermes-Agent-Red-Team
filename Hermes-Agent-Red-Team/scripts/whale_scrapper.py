#!/usr/bin/env python3
"""Whale movement tracker - fetches data from web_search and logs to DB."""
import sqlite3
import datetime
import sys

DB_PATH = '/home/david/gaby_intelligence_vault.db'
USD_IDR = 16450  # July 2025 rate

def ensure_table(conn):
    conn.execute("""
        CREATE TABLE IF NOT EXISTS whale_tracking (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            timestamp TEXT DEFAULT CURRENT_TIMESTAMP,
            amount_btc REAL,
            from_address TEXT,
            to_address TEXT,
            amount_usd REAL,
            amount_idr REAL,
            signal TEXT,
            source TEXT
        )
    """)
    conn.commit()

def log_movement(conn, data):
    btc = data.get('amount_btc') or 0
    usd = data['amount_usd']
    idr = usd * USD_IDR
    conn.execute("""
        INSERT INTO whale_tracking (amount_btc, from_address, to_address, amount_usd, amount_idr, signal, source)
        VALUES (?, ?, ?, ?, ?, ?, ?)
    """, (btc, data['from_addr'], data['to_addr'], usd, idr, data['signal'], data.get('source', '')))

def main():
    conn = sqlite3.connect(DB_PATH)
    ensure_table(conn)

    # NOTE: Real data fetch requires web_search/web_extract which
    # can only be called from Hermes tool context, not from cron Python.
    # This script serves as the DB schema and logging interface.
    # Actual data ingestion happens via Hermes cron job calling tools directly.
    
    print(f"[{datetime.datetime.now().isoformat()}] Whale tracker DB ready.")
    print("Data ingestion delegated to Hermes cron tool pipeline.")
    
    conn.close()
    return 0

if __name__ == '__main__':
    import sqlite3
    sys.exit(main())