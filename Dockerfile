# Start from the Kasm Ubuntu desktop image
FROM kasmweb/ubuntu-jammy-desktop:1.15.0

# Switch to the root user to perform installations
USER root

# --- Install Google Chrome ---
# Add Google's official GPG security key to fix the broken repository in the base image
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
# Now, update package lists and install Chrome directly from its repository
RUN apt-get update && apt-get install -y google-chrome-stable


# --- Install AnyDesk ---
RUN wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | apt-key add -
RUN echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list
RUN apt-get update && apt-get install -y anydesk


# --- Clean up ---
# Clean apt cache to reduce image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Switch back to the default non-root user that Kasm uses to run the desktop
USER kasm-user