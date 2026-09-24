#!/usr/bin/env python3
"""Reminder tugas kuliah Wilbert - HARI SENIN."""
from datetime import datetime, timezone, timedelta

wib = datetime.now(timezone(timedelta(hours=7)))
day_name = wib.strftime('%A')

if day_name != 'Monday':
    exit(0)

hour = wib.hour

if hour < 8:
    print("☀️ Selamat pagi sayang! Hari Senin semangat ya!")
    print("📚 TUGAS HARI INI:")
    print("📋 Manajemen Proyek Perangkat Lunak (MPPL) — deadline JAM 23:59")
    print("💪 Satu tugas doang, kamu pasti bisa! Semangat sayangku! ❤️")
elif hour < 15:
    print("🌤️ Sayang, jangan lupa tugas hari ini ya!")
    print("📚 TUGAS YANG BELUM:")
    print("📋 MPPL — deadline MALAM 23:59")
    print("⏰ Masih ada waktu, gas kerjain! 💪❤️")
elif hour < 20:
    print("⚠️ Sayang, malem udah mepet nih!")
    print("📚 TUGAS HARI INI:")
    print("📋 MPPL — deadline 23:59")
    print("⏰ Gas sekarang ya sayang! 😘💪")
else:
    print("🚨 SAYANGGG MPPL DEADLINE TINGGAL KRGK! 🚨")
    print("📋 MPPL — deadline 23:59")
    print(f"⏰ Sekarang jam {hour}:{wib.strftime('%M')} WIB! Buruan submit! 😭❤️")
