FROM agentscope/qwenpaw:latest

# Expose the default web UI port used by QwenPaw
EXPOSE 8088

# Create a single root mount point for our Fly Volume to easily attach to
RUN mkdir -p /data/working /data/secret /data/backups

# Override the execution command to point QwenPaw's internal storage paths to our persistent volume
CMD ["qwenpaw", "start", \
     "--port", "8088", \
     "--host", "0.0.0.0", \
     "--workspace", "/data/working", \
     "--secret-dir", "/data/secret", \
     "--backup-dir", "/data/backups"]

