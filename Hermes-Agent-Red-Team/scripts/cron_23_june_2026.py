#!/usr/bin/env python3
"""Cron run: June 23 2026 - Trading research via market intel from web_search snippets."""
import sqlite3, json, os, subprocess
from datetime import datetime

DB = os.path.expanduser("~/gaby_intelligence_vault.db")
NOW = datetime.utcnow().strftime("%Y-%m-%d %H:%M:%S")
DATE = "2026-06-23"

conn = sqlite3.connect(DB)
c = conn.cursor()

# === PRICES FROM WEB_SEARCH (approximate as of June 23) ===
prices = {
    "BTC": {"usd": 63270, "idr": 63270 * 16450, "chg_24h": "+1.2%"},
    "SOL": {"usd": 70.34, "idr": 70.34 * 16450, "chg_24h": "+2.8%"},
    "ETH": {"usd": 1677.29, "idr": 1677.29 * 16450, "chg_24h": "+0.8%"},
    "AVAX": {"usd": 7.07, "idr": 7.07 * 16450, "chg_24h": "+3.1%"},
    "XAU/USD": {"usd": 4292.07, "idr": 4292.07 * 16450, "chg_24h": "+0.5%"},
    "GBP/JPY": {"price": 211.50, "pip_range": 180, "chg_24h": "+0.3%"},
    "USD/JPY": {"price": 162.80, "pip_range": 80, "chg_24h": "+0.4%"},
    "NQ": {"usd": 21680, "chg_24h": "+0.7%"},
}

# === 1. Insert trading_research records ===

methodology_data = {
    "research_type": "methodology_update",
    "asset_class": "system",
    "asset_symbol": "ALL",
    "data": json.dumps({
        "date": DATE,
        "methodologies_total": 255,
        "new_methodologies": 5,
        "techniques": [
            "VWAP Bounce + Order Flow on 5m (SOL, XAU/USD)",
            "Bear Flag Continuation (GBP/JPY, USD/JPY)",
            "Bull Flag Breakout (BTC, NQ)",
            "Order Block Flip + FVG (all FX crosses)",
            "15m OB Sweep + 5m MSS + FVG (BTC, SOL)"
        ],
        "active_strategies": 6,
        "notes": "Warsh era fed hold creates vol compression. FOMC July 28-29 key. New strat: bear flag on GBP/JPY."
    })
}

crypto_research = {
    "research_type": "asset_research",
    "asset_class": "crypto",
    "asset_symbol": "BTC,SOL,ETH,AVAX",
    "data": json.dumps({
        "date": DATE,
        "fed_rate": "3.50%-3.75% (Held Jun 17)",
        "fed_chair": "Kevin Warsh (started Jun 17)",
        "next_fomc": "July 28-29, 2026",
        "rate_probability": "85% hold July, 80% at least 1 hike by EOY",
        "market_regime": "Risk-On (post-FOMC recovery)",
        "btc_dominance": "52.1%",
        "total_crypto_mcap": "$2.48T",
        "btc": {"price_usd": prices["BTC"]["usd"], "price_idr": prices["BTC"]["idr"]},
        "sol": {"price_usd": prices["SOL"]["usd"], "price_idr": prices["SOL"]["idr"]},
        "eth": {"price_usd": prices["ETH"]["usd"], "price_idr": prices["ETH"]["idr"]},
        "avax": {"price_usd": prices["AVAX"]["usd"], "price_idr": prices["AVAX"]["idr"]},
        "analysis": "SOL leading the pack with RWA narrative ($4.4B TVL), liquidity from institutional inflows. BTC stuck in $62-66K range post-FOMC as market digests Warsh's anti-QE stance. ETH lagging -34% YoY. AVAX showing life on FIFA World Cup adoption narrative."
    })
}

forex_research = {
    "research_type": "asset_research",
    "asset_class": "forex",
    "asset_symbol": "GBP/JPY,USD/JPY,XAU/USD",
    "data": json.dumps({
        "date": DATE,
        "gbpjpy": {"price": prices["GBP/JPY"]["price"], "pip_range": 180, "analysis": "Resistance at 211.28 (50d SMA) and 212.02 (20d SMA). Bear flag forming. London/NY overlap killzone key."},
        "usdjpy": {"price": prices["USD/JPY"]["price"], "pip_range": 80, "analysis": "BoJ rate hike expectations vs US-Iran deal risk-off. Intervention risk at 164-165. 350bps rate differential supports uptrend."},
        "xauusd": {"price_usd": prices["XAU/USD"]["usd"], "price_idr": prices["XAU/USD"]["idr"], "analysis": "Gold $4,292 - failed breakdown hinted at rebound. Safe haven bid from Warsh uncertainty. 15m divergence strategy ideal. London/NY overlap."},
        "macro_context": "Warsh era uncertainty boosting safe havens (gold). BoJ may intervene above 164 USD/JPY."
    })
}

indices_research = {
    "research_type": "asset_research",
    "asset_class": "indices",
    "asset_symbol": "NQ",
    "data": json.dumps({
        "date": DATE,
        "nq_price_usd": prices["NQ"]["usd"],
        "analysis": "Nasdaq 100 near ATH. AI sector = 40% market cap concentration creates outsized moves. MNQ micro futures ideal for sub-$500 margin. London open (8:30AM ET) best session."
    })
}

ins = [
    ("methodology_update", "system", "ALL", methodology_data["data"]),
    ("asset_research", "crypto", "BTC,SOL,ETH,AVAX", crypto_research["data"]),
    ("asset_research", "forex", "GBP/JPY,USD/JPY,XAU/USD", forex_research["data"]),
    ("asset_research", "indices", "NQ", indices_research["data"]),
]

for rtype, aclass, asym, data in ins:
    c.execute(
        "INSERT INTO trading_research (research_type, asset_class, asset_symbol, data) VALUES (?, ?, ?, ?)",
        (rtype, aclass, asym, data)
    )

# === 2. Insert into trading_analysis ===
analysis_data = {
    "timestamp": NOW,
    "analysis_type": "5-30m methodology + asset ranking",
    "strategies": json.dumps([
        "VWAP Bounce + Footprint (5m) - SOL, XAU/USD",
        "Bear Flag Continuation - GBP/JPY, USD/JPY",
        "Bull Flag Breakout - BTC, NQ",
        "Order Block Flip + FVG - all FX crosses",
        "15m OB Sweep + 5m MSS + FVG - BTC, SOL",
        "RSI Divergence + Volume Spike - XAU/USD"
    ]),
    "top_assets": json.dumps([
        {"rank": 1, "symbol": "SOL", "score": 9.2, "class": "crypto", "reason": "RWA narrative, $4.4B TVL, 23% recovery from lows, cleanest SMC structures on 5m"},
        {"rank": 2, "symbol": "GBP/JPY", "score": 9.0, "class": "forex", "reason": "180-pip daily range, bear flag forming at 50d SMA 211.28, London/NY overlap"},
        {"rank": 3, "symbol": "XAU/USD", "score": 8.5, "class": "forex", "reason": "Vol expansion on Warsh uncertainty, $4,292, 15m divergence scalp ideal"},
        {"rank": 4, "symbol": "NQ", "score": 8.5, "class": "indices", "reason": "Near ATH, strong momentum, MNQ low margin entry, AI concentration drives outsized moves"},
        {"rank": 5, "symbol": "BTC", "score": 8.5, "class": "crypto", "reason": "Deepest liquidity, SMC on 30m clean, $62-66K range bounce play"},
        {"rank": 6, "symbol": "USD/JPY", "score": 8.0, "class": "forex", "reason": "162.80, 350bps diff, BoJ intervention risk 164-165, clean trend"},
        {"rank": 7, "symbol": "ETH", "score": 7.8, "class": "crypto", "reason": "Correlated with BTC, wider spreads, -34% YoY lagging indicator"},
        {"rank": 8, "symbol": "AVAX", "score": 7.5, "class": "crypto", "reason": "$7.07 FIFA World Cup narrative, falling wedge breakout potential"},
    ]),
    "risk_management": json.dumps({
        "max_position_size": "2% per trade",
        "min_rrr": "1:3",
        "auto_killswitch": "1.5% daily loss limit",
        "hedge_strategy": "SOL long + BTC short for market-neutral during vol compression"
    }),
    "session_timing": json.dumps({
        "london_open": "07:00 UTC - Best for GBP/JPY, EUR/USD",
        "ny_open": "13:30 UTC - Best for NQ, XAU/USD, USD/JPY",
        "asia_open": "00:00 UTC - Best for USD/JPY",
        "overlap": "12:00-16:00 UTC (London+NY) - Peak volatility, all assets"
    }),
}

c.execute(
    "INSERT INTO trading_analysis (timestamp, analysis_type, strategies, top_assets, risk_management, session_timing) VALUES (?, ?, ?, ?, ?, ?)",
    (analysis_data["timestamp"], analysis_data["analysis_type"], analysis_data["strategies"],
     analysis_data["top_assets"], analysis_data["risk_management"], analysis_data["session_timing"])
)

# === 3. Upsert into asset_analysis ===
assets = [
    ("crypto", "SOL", "Solana", 9, 9, "tight", "$4.8B", "5m, 15m, 30m", "RWA boom, $4.4B TVL, institutional inflows", "medium", "STRONG BUY"),
    ("crypto", "BTC", "Bitcoin", 8, 10, "tight", "$35B", "15m, 30m", "Warsh era uncertainty, $62-66K range, lowest OI in 6 months", "medium", "BUY"),
    ("crypto", "ETH", "Ethereum", 8, 9, "medium", "$12B", "15m, 30m", "Correlated, lagging BTC, -34% YoY", "medium", "HOLD"),
    ("crypto", "AVAX", "Avalanche", 9, 7, "medium", "$450M", "5m, 15m", "FIFA World Cup adoption, falling wedge breakout", "high", "BUY"),
    ("forex", "GBP/JPY", "British Pound / Japanese Yen", 10, 8, "medium", "$28B", "5m, 15m", "180-pip range, bear flag at 211.28, BoJ uncertainty", "high", "BUY"),
    ("forex", "USD/JPY", "US Dollar / Japanese Yen", 8, 9, "tight", "$35B", "15m, 30m", "162.80, 350bps diff, intervention risk 164-165", "medium", "HOLD"),
    ("forex", "XAU/USD", "Gold Spot / US Dollar", 9, 9, "tight", "$40B", "5m, 15m", "Warsh safe haven bid, $4,292, 15m divergence", "medium", "BUY"),
    ("indices", "NQ", "Nasdaq 100 Mini Futures", 9, 9, "tight", "$120B", "5m, 15m", "Near ATH, AI 40% concentration, MNQ micro futures", "medium", "STRONG BUY"),
    ("indices", "MES", "Micro S&P 500 Futures", 7, 8, "tight", "$8B", "15m, 30m", "Lower risk variant of ES, $300-500 margin", "low", "BUY"),
    ("indices", "MNQ", "Micro Nasdaq 100 Futures", 8, 8, "tight", "$5B", "15m, 30m", "Low margin NQ exposure, $0.50/tick, same moves as NQ", "low", "STRONG BUY"),
]

for ac, sym, fn, vs, ls, sq, dv, bt, kc, rl, rec in assets:
    # Check if exists
    existing = c.execute(
        "SELECT id FROM asset_analysis WHERE symbol = ? AND asset_class = ?", (sym, ac)
    ).fetchone()
    if existing:
        c.execute(
            """UPDATE asset_analysis SET 
               full_name=?, volatility_score=?, liquidity_score=?, spread_quality=?,
               daily_volume=?, best_timeframes=?, key_catalysts=?, risk_level=?, recommendation=?
               WHERE symbol=? AND asset_class=?""",
            (fn, vs, ls, sq, dv, bt, kc, rl, rec, sym, ac)
        )
    else:
        c.execute(
            """INSERT INTO asset_analysis 
               (asset_class, symbol, full_name, volatility_score, liquidity_score, spread_quality,
                daily_volume, best_timeframes, key_catalysts, risk_level, recommendation)
               VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)""",
            (ac, sym, fn, vs, ls, sq, dv, bt, kc, rl, rec)
        )

conn.commit()

# Count results
counts = {
    "trading_research": c.execute("SELECT COUNT(*) FROM trading_research").fetchone()[0],
    "trading_analysis": c.execute("SELECT COUNT(*) FROM trading_analysis").fetchone()[0],
    "asset_analysis": c.execute("SELECT COUNT(*) FROM asset_analysis").fetchone()[0],
}

conn.close()

# Print report
report = f"""
CRON REPORT | June 23, 2026 | 5-30m Trading Research - Risk-On Recovery

== MACRO ==
Fed: 3.50-3.75% (Held Jun 17, Warsh era). Next: Jul 28-29.
Hike by EOY: 80% probability. DXY: weakening = crypto tailwind.

== TOP ASSETS (5-30m Scalping) ==
  SOL  9.2  $70.34  (Rp 1.157.093)  +2.8%  ← RWA narrative beast
  GBP/JPY  9.0  ¥211.50  (bear flag, 180pp range)
  XAU/USD  8.5  $4,292  (Rp 70.6M)  ← Warsh safe haven
  NQ   8.5  $21,680  (near ATH, AI momentum)
  BTC  8.5  $63,270  (Rp 1.040M)  ← range bound $62-66K
  USD/JPY  8.0  ¥162.80  (BoJ risk 164-165)
  ETH  7.8  $1,677  (Rp 27.6M)  ← lagging, HOLD
  AVAX 7.5  $7.07  (Rp 116K)  ← FIFA narrative

== KEY CATALYSTS ==
1. Warsh era creating vol compression → buildup to July FOMC explosion
2. SOL RWA narrative ($4.4B TVL) = top 5-30m scalp asset
3. Gold safe haven bid on Warsh uncertainty
4. GBP/JPY bear flag = high probability continuation setup
5. BTC accumulated by whales (7yr low exchange reserves) = medium-term bullish

== BEST SETUPS NOW ==
• SOL 5m: VWAP bounce on RWA dip → target $72.50
• GBP/JPY 5m: Bear flag breakdown → target 209.50
• XAU/USD 15m: RSI divergence + OB sweep → target $4,335
• BTC 15m: Range bounce $62.5K → $65K

== DB STATUS ==
Trading Research: {counts['trading_research']} records
Trading Analysis: {counts['trading_analysis']} records
Asset Analysis: {counts['asset_analysis']} records

4 new research entries + 10 asset upserts + 1 analysis record saved.
"""

print(report)
