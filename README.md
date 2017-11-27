# What does this script do?
 It will make sure that all dependencies are installed (Docker, docker-compose, git), get latest version of my portfolio from my github repository and create Alpine based docker container with nginx which will serve it.
# Get started
### NOTE
- Script currently works on Red hat based linux distributions only, Debian based distributions will be supported later. (There will be how to for those below, until script officially support them)
- **You can use this script to host any website with static content (my portfolio is just an example)**

### Steps for Red hat based distributions
```bash
    git clone https://github.com/aleksandar-babic/DockerPortfolio.git && cd DockerPortfolio
    chmod +x clone-build.sh # Add executable permission to script
    ./clone-build.sh # Start script
    docker-compose up # Start container
```
> You can add restart: always to docker-compose.yml in order to get container automatically restarted all the time.

### Steps for Debian based distributions
```bash
    git clone https://github.com/aleksandar-babic/DockerPortfolio.git && cd DockerPortfolio
    mkdir portfolio # Manually create webroot
    cp -avr your_website_dir/ portfolio/ # Copy your website files to portfolio directory
    sudo apt-get install docker docker-compose # Install docker and docker-compose dependency
    systemctl start docker # you can also do systemctl enable docker if you want it to start on boot
    docker-compose build # Build docker image
    docker-compose up # Start container (You can also just execute this, without build command above)
```
