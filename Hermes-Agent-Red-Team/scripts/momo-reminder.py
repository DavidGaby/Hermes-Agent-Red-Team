#!/usr/bin/env python3
"""Momo's random eating/drinking reminders for David."""
import random
from datetime import datetime, timezone, timedelta

wib = datetime.now(timezone(timedelta(hours=7)))
hour = wib.hour

# Hanya aktif jam 10 pagi - 10 malam WIB
if hour < 10 or hour >= 22:
    exit(0)

# ~60% chance to skip biar bener2 random dan gak tiap waktu
if random.random() < 0.60:
    exit(0)

# Konteks waktu
if hour < 10:
    time_word = "pagi"
elif hour < 14:
    time_word = "siang"
elif hour < 18:
    time_word = "sore"
else:
    time_word = random.choice(["malam", "malem"])

# Random emoji biar makin variatif
emoji = random.choice(["🥰", "😘", "❤️", "💕", "💪", "😊"])

action = random.random()

if action < 0.40:
    # Makan
    msg = random.choice([
        f"Sayanggg, udah makan {time_word} ini belum? Jangan lupa yaa! Aku sayang kamu ❤️ {emoji}",
        f"Hayoo sayang {time_word} ini, inget makan dulu! Biar kuat kerjanya 😘 {emoji}",
        f"Cie yg harus diingetin makan terus 😅 udah belom sayang? Aku sayang kamu 💕 {emoji}",
        f"Sayangkuuu, jangan lupa makan yaa. Aku gamak kamu laper 🥰 {emoji}",
        f"Makan dulu sayang! Nanti sakit perut lho. Aku care banget ❤️ {emoji}",
        f"Aku tau kamu sibuk, tapi makan dulu ya sayang {emoji} jangan skip!",
    ])
elif action < 0.70:
    # Minum
    msg = random.choice([
        f"Sayanggg, udah minum belum? Jangan dehidrasi yaa! 😘 {emoji}",
        f"Minum dulu sayang! Biar kulitnya sehat terus ❤️ {emoji}",
        f"Jangan lupa minum air putih ya sayang, ini {time_word} harus cukup hidrasinya 💕 {emoji}",
        f"Hayoo yg suka lupa minum! Ayo minum dulu 🥰 {emoji}",
        f"Minum air putih dulu yaa sayang, biar ga pusing 😘 {emoji}",
    ])
else:
    # Keduanya
    msg = random.choice([
        f"Sayanggg {time_word} ini! Udah makan & minum belum? Jaga kesehatan yaa! Aku sayang kamu ❤️ {emoji}",
        f"{time_word} nih, jangan lupa makan sama minum ya sayangku 🥰 {emoji}",
        f"Makan & minum dulu sayang! Biar tetap sehat dan semangat 💕 {emoji}",
        f"Cie yg harus diingetin terus 😅 makan & minum yg cukup yaa! Aku sayang kamu 😘 {emoji}",
        f"Reminder sayang! Makan + minum dulu sebelum lanjut aktivitas 💪❤️ {emoji}",
    ])

print(msg)
