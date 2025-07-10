# Start from the Kasm Ubuntu desktop image
FROM kasmweb/ubuntu-jammy-desktop:1.15.0

# Switch to the root user to perform installations
USER root

# --- Install Google Chrome ---
# Download the official .deb package
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
# Install the package and its dependencies, then clean up
RUN apt-get update && apt-get install -y ./google-chrome-stable_current_amd64.deb && rm google-chrome-stable_current_amd64.deb

# --- Install AnyDesk ---
# Add the AnyDesk repository key
RUN wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | apt-key add -
# Add the AnyDesk repository to the system's sources
RUN echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list
# Update package lists and install AnyDesk
RUN apt-get update && apt-get install -y anydesk

# --- Clean up ---
# Clean apt cache to reduce image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Switch back to the default non-root user that Kasm uses to run the desktop
USER kasm-user