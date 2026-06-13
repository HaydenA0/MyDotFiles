#!/usr/bin/env python3
# run it using uv run --with psutil python sysinfo.py
import psutil
import subprocess
import os


def get_cpu_info():
    # CPU Brand
    brand = "Unknown"
    try:
        with open("/proc/cpuinfo", "r") as f:
            for line in f:
                if "model name" in line:
                    brand = line.split(":")[1].strip()
                    break
    except Exception:
        pass

    # CPU Clock Speed
    freq = psutil.cpu_freq()
    clock_speed = f"{freq.current / 1000:.2f} GHz" if freq else "Unknown"

    # CPU Usage per thread (interval=1 blocks for 1 sec to get accurate usage)
    usage_per_thread = psutil.cpu_percent(interval=1, percpu=True)

    # CPU Temperature
    temp_str = "N/A"
    try:
        temps = psutil.sensors_temperatures()
        if temps:
            # Common sensor names for Intel and AMD
            for name in ["coretemp", "k10temp", "cpu_thermal", "nct6775"]:
                if name in temps:
                    temp_str = f"{temps[name][0].current} °C"
                    break
    except Exception:
        pass

    return brand, clock_speed, usage_per_thread, temp_str


def get_top_processes():
    # We use the 'ps' command natively to get accurate top processes easily
    try:
        output = subprocess.check_output(
            ["ps", "-eo", "pid,comm,%cpu", "--sort=-%cpu", "--no-headers"]
        ).decode()
        processes = output.strip().split("\n")[:10]

        parsed_processes = []
        for proc in processes:
            parts = proc.split(maxsplit=2)
            if len(parts) == 3:
                parsed_processes.append(parts)
        return parsed_processes
    except Exception:
        return []


def get_gpu_info():
    try:
        # Calls nvidia-smi. Fails gracefully if not installed/not NVIDIA
        output = (
            subprocess.check_output(
                [
                    "nvidia-smi",
                    "--query-gpu=name,utilization.gpu,temperature.gpu",
                    "--format=csv,noheader",
                ]
            )
            .decode()
            .strip()
            .split("\n")
        )

        gpus = []
        for line in output:
            if not line:
                continue
            parts = [p.strip() for p in line.split(",")]
            if len(parts) == 3:
                gpus.append(
                    {"brand": parts[0], "usage": parts[1], "temp": parts[2] + " °C"}
                )
        return gpus
    except FileNotFoundError:
        return None
    except Exception:
        return None


def get_ram_info():
    # RAM Brand (Requires sudo)
    brand = "Unknown (Run script with 'sudo' to detect)"
    try:
        output = subprocess.check_output(
            ["dmidecode", "-t", "memory"], stderr=subprocess.DEVNULL
        ).decode()
        manufacturers = set()
        for line in output.split("\n"):
            if "Manufacturer:" in line:
                val = line.split(":")[1].strip()
                if val.lower() not in [
                    "",
                    "unknown",
                    "no module installed",
                    "not specified",
                ]:
                    manufacturers.add(val)
        if manufacturers:
            brand = ", ".join(list(manufacturers))
    except Exception:
        pass

    # RAM Usage
    mem = psutil.virtual_memory()
    total_gb = mem.total / (1024**3)
    used_gb = mem.used / (1024**3)
    usage_str = f"{used_gb:.2f} GB / {total_gb:.2f} GB ({mem.percent}%)"

    return brand, usage_str


def main():
    print("Gathering system info... (this takes about 1 second)\n")
    print("=" * 45)

    # 1. CPU
    cpu_brand, cpu_clock, cpu_usage, cpu_temp = get_cpu_info()
    print("CPU INFO")
    print("=" * 45)
    print(f"Brand:       {cpu_brand}")
    print(f"Clock Speed: {cpu_clock}")
    print(f"Temperature: {cpu_temp}")
    print("Usage (per thread):")
    for i, usage in enumerate(cpu_usage):
        print(f"  Thread {i:<2}: {usage}%")
    print()

    # 2. TOP 10 PROCESSES
    print("=" * 45)
    print("TOP 10 PROCESSES (By CPU Usage)")
    print("=" * 45)
    print(f"{'PID':<10} {'COMMAND':<25} {'%CPU':<5}")
    for pid, comm, cpu in get_top_processes():
        print(f"{pid:<10} {comm:<25} {cpu:<5}")
    print()

    # 3. GPUs
    print("=" * 45)
    print("GPU INFO")
    print("=" * 45)
    gpus = get_gpu_info()
    if gpus is None:
        print("nvidia-smi not found. Cannot retrieve GPU details.")
        print("(Ensure you have an NVIDIA GPU and drivers installed)")
    else:
        for i, gpu in enumerate(gpus):
            if i > 1:  # Ensures we only show GPU 0 and GPU 1 as requested
                break
            print(f"GPU {i}:")
            print(f"  Brand:       {gpu['brand']}")
            print(f"  Usage:       {gpu['usage']}")
            print(f"  Temperature: {gpu['temp']}")
            print()
    if gpus is not None and len(gpus) == 0:
        print("No NVIDIA GPUs detected.")
    elif gpus is None:
        print()

    # 4. RAM
    ram_brand, ram_usage = get_ram_info()
    print("=" * 45)
    print("RAM INFO")
    print("=" * 45)
    print(f"Brand:       {ram_brand}")
    print(f"Usage:       {ram_usage}")
    print("=" * 45)


if __name__ == "__main__":
    main()
