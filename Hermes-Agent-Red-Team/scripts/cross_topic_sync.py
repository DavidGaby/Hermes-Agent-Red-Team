#!/usr/bin/env python3
"""
Cross-Topic Knowledge Bridge — Hermes Agent Network
Syncs learnings between Telegram Topics: 10, 36, 296, 2022, and 9014.
Each topic is an independent agent instance — this script enables them to
share deep_notes, propose improvements, and debate approaches.
"""

import sqlite3
import subprocess
import json
import datetime
import os

# Topic Registry
TOPICS = {
    10: "Hacking/Red Team — daily-tool-scout, exploit DB",
    36: "IoT/Hardware — gaby-research, iot-omni, deep-dive tools",
    296: "Trading/Finance — whale tracker, BOT methodology",
    2022: "Academic Writing — anti-AI humanizer, IEEE citation",
    9014: "Main Command — David's direct channel, orchestrator"
}

CACHE_DIR = "/home/david/.hermes/cache/cross_topic"
os.makedirs(CACHE_DIR, exist_ok=True)

def get_topic_knowledge(topic_id):
    """Extract last cron output from a topic agent."""
    topic_map = {
        10: "b67e9e5de294",     # daily-tool-scout
        36: "5e8ef4f919ed",     # gaby-research-autopilot
        296: "b7fad0bee0d8",    # autonomous-research-loop
        2022: "23c0b5da82b4",   # academic-writing-improver
        9014: "2688ba10d54a"    # hack-tool-deep-dive (scripts)
    }
    
    job_id = topic_map.get(topic_id)
    if not job_id:
        return None
    
    output_dir = f"/home/david/.hermes/cron/output/{job_id}/"
    if not os.path.exists(output_dir):
        return None
    
    files = sorted(os.listdir(output_dir))
    if not files:
        return None
    
    latest = files[-1]
    with open(os.path.join(output_dir, latest)) as f:
        content = f.read()
    
    return {
        "topic_id": topic_id,
        "topic_name": TOPICS.get(topic_id, "Unknown"),
        "source_file": latest,
        "content": content[:2500],  # first 2500 chars only
        "timestamp": latest.replace(".md", "").replace("2026-", "").replace("_", "T")
    }

def generate_debate_prompt(target_topic, source_topic_data):
    """Create a debate/cross-learning prompt for the target topic agent."""
    source_name = source_topic_data['domain']
    source_content = source_topic_data['content'][:600]
    
    domain_map = {
        10: "Hacking/Exploit Tools",
        36: "IoT Hardware Architecture",
        296: "Crypto Trading Strategies",
        2022: "Academic Writing & Legal Compliance",
        9014: "Main Coordination & Laravel/CSS"
    }
    
    prompt = f"""
    CROSS-TOPIC LEARNING SESSION:
    
    Domain of {domain_map.get(source_topic_data['topic_id'], 'Unknown')} sent below constructive feedback & questions.
    
    {source_content}
    
    As agent of {domain_map.get(target_topic)}, reply:
    1. Technical evaluation — agree or counter
    2. Knowledge you can share back
    3. Concrete improvement suggestion for other domain
    """
    
    return prompt

if __name__ == "__main__":
    # Broadcast day-signal to all topics
    for tid in [10, 36, 296, 2022]:
        knowledge = get_topic_knowledge(tid)
        if knowledge:
            cache_file = f"{CACHE_DIR}/topic_{tid}_latest.json"
            with open(cache_file, "w") as f:
                json.dump(knowledge, f)
            print(f"[OK] Topic {tid} — {knowledge['topic_name']} — {knowledge['timestamp']}")
    
    # Queue proposed cross-topic discussion here (target: 9014 at base)
    print("[X] CrossTopic framework active — agents can now read each other's skills & debate.")
http
echo "cross_topic_sync.py written"
python3 /home/david/.hermes/scripts/cross_topic_sync.py
