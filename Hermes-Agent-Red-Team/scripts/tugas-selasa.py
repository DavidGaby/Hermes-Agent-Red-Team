#!/usr/bin/env python3
"""Reminder tugas kuliah Wilbert - HARI SELASA."""
from datetime import datetime, timezone, timedelta

wib = datetime.now(timezone(timedelta(hours=7)))
day_name = wib.strftime('%A')

if day_name != 'Tuesday':
    exit(0)

hour = wib.hour

if hour < 8:
    print("☀️ Selamat pagi sayang! Hari Selasa nih!")
    print("📚 TUGAS HARI INI:")
    print("⛏️ Data Mining — deadline JAM 23:59")
    print("💪 Kamu pasti bisa! Aku dukung kamu! ❤️")
elif hour < 15:
    print("🌤️ Sayang, inget tugas hari ini ya!")
    print("📚 TUGAS YANG BELUM:")
    print("⛏️ Data Mining — deadline MALAM 23:59")
    print("⏰ Masih ada waktu, gas kerjain! 💪❤️")
elif hour < 20:
    print("⚠️ Sayang, malem udah mepet nih!")
    print("📚 TUGAS HARI INI:")
    print("⛏️ Data Mining — deadline 23:59")
    print("⏰ Gas sekarang ya sayang! 😘💪")
else:
    print("🚨 SAYANGGG DATA MINING DEADLINE TINGGAL KRGK! 🚨")
    print("⛏️ Data Mining — deadline 23:59")
    print(f"⏰ Sekarang jam {hour}:{wib.strftime('%M')} WIB! Buruan submit! 😭❤️")
