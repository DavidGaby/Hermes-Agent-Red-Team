#!/usr/bin/env python3
"""Reminder tugas kuliah Wilbert - HARI JUMAT."""
from datetime import datetime, timezone, timedelta

wib = datetime.now(timezone(timedelta(hours=7)))
day_name = wib.strftime('%A')

if day_name != 'Friday':
    exit(0)

hour = wib.hour

if hour < 8:
    print("☀️ Selamat pagi sayang! Jumat berkah nih!")
    print("📚 TUGAS HARI INI:")
    print("🌐 Jaringan Komputer — deadline JAM 23:59")
    print("💪 Akhir pekan tinggal ini doang, semangat ya sayangku! ❤️")
elif hour < 15:
    print("🌤️ Sayang, jangan lupa tugas hari ini ya!")
    print("📚 TUGAS YANG BELUM:")
    print("🌐 Jaringan Komputer — deadline MALAM 23:59")
    print("⏰ Masih ada waktu, gas kerjain! 💪❤️")
elif hour < 20:
    print("⚠️ Sayang, malem udah mepet nih!")
    print("📚 TUGAS HARI INI:")
    print("🌐 Jaringan Komputer — deadline 23:59")
    print("⏰ Gas sekarang ya sayang! 😘💪")
else:
    print("🚨 SAYANGGG JARKOM DEADLINE TINGGAL KRGK! 🚨")
    print("🌐 Jaringan Komputer — deadline 23:59")
    print(f"⏰ Sekarang jam {hour}:{wib.strftime('%M')} WIB! Buruan submit! 😭❤️")
