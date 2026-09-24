#!/usr/bin/env python3
"""Reminder tugas kuliah Wilbert - HARI MINGGU."""
from datetime import datetime, timezone, timedelta

wib = datetime.now(timezone(timedelta(hours=7)))
day_name = wib.strftime('%A')

if day_name != 'Sunday':
    exit(0)

hour = wib.hour

if hour < 8:
    print("☀️ Selamat pagi sayang! Hari Minggu nih!")
    print("📚 TUGAS HARI INI:")
    print("1️⃣ Arsitektur Berbasis Layanan — deadline JAM 23:59")
    print("2️⃣ IoT — deadline JAM 23:59")
    print("⏰ Kamu punya seharian, tapi jangan ditunda ya!")
    print("💪 Aku percaya kamu bisa! Semangat sayangku! ❤️")
elif hour < 15:
    print("🌤️ Sayang, siang ini jangan lupa ya!")
    print("📚 TUGAS YANG BELUM:")
    print("1️⃣ Arsitektur Berbasis Layanan — deadline MALAM 23:59")
    print("2️⃣ IoT — deadline MALAM 23:59")
    print("⏰ Masih ada waktu, gas kerjain sekarang! 💪❤️")
elif hour < 20:
    print("⚠️ SAYANG GGAMPAK MULAI SIANG NII!")
    print("📚 TUGAS HARI INI:")
    print("1️⃣ Arsitektur Berbasis Layanan — deadline 23:59")
    print("2️⃣ IoT — deadline 23:59")
    print("⏰ Tinggal beberapa jam lagii! Cepetan ya sayang! 😘💪")
else:
    print("🚨 SAYANGGG TENGGEMLAM! 🚨")
    print("📚 TUGAS HARI INI:")
    print("1️⃣ Arsitektur Berbasis Layanan — deadline 23:59")
    print("2️⃣ IoT — deadline 23:59")
    print(f"⏰ Sekarang jam {hour}:{wib.strftime('%M')} WIB! Buruan submit sayang! 😭❤️")
