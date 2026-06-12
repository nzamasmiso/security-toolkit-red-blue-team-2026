# Meterpreter Migration Detector

This repository contains defensive detection scripts built to identify Meterpreter process migration activity.

Inside you’ll find cross-platform scripts that monitor process behavior for indicators commonly associated with process injection and migration. The tools analyze how processes are spawned, how they relate to their parent processes, and look for memory patterns that don’t match normal application behavior. 

One script is built for Linux environments and the other for Windows. Both are written to use only built-in system tools so they can run in restricted environments without extra dependencies. Results are saved to timestamped files so each scan is kept separate and can be reviewed later.

The repository demonstrates practical blue team skills: understanding attacker techniques, translating them into detection logic, and building tooling that helps SOC teams spot suspicious behavior before it escalates.

---
Built with Bash and PowerShell. Designed for learning, and SOC demonstration.
