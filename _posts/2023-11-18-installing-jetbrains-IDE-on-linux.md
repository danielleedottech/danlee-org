# Introduction

Installing Jetbrains' IDEs on Linux distros that are not Ubuntu is not very straight forward, especially if you want to download the IDEs from their website as a tarball.


# This is a quick blog to get you started.

Download tarball file from Jetbrains' website to your `~/Downloads` directory:

(In this example I will be downloading Webstorm)


![Webstorm download site](/assets/images/jetbrains-ide-linux/webstorm-download-page.png)

After downloading, use this command to extract the tarball to your `/opt` folder.

```bash
cd ~/Downloads
sudo tar xvzf <NAME_OF_TARBALL> -C /opt/
```

A concrete example:
```bash
cd ~/Downloads
sudo tar xvzf WebStorm-2023.2.5.tar.gz -C /opt/
```

Great link on why the `/opt` folder is the ideal place to put your Jetbrains IDE (in my humble opinion):

<a href="https://www.baeldung.com/linux/opt-directory" target="_blank">
  https://www.baeldung.com/linux/opt-directory
</a>

Also make sure you understand how the directory is structured in your extracted directory. 

The data we should keep in mind is: 
- the full directory path of `bin` folder of the IDE
- the bash script that starts the IDE ie. 
  - bin/webstorm.sh or
  - bin/studio.sh or 
  - bin/idea.sh
- the svg/png file that will be used as a desktop entry icon ie.
  - bin/webstorm.svg
  - bin/studio.png

After this we want to add our Jetbrains IDE to our path so we can open it from our terminal like so:

```bash
webstorm.sh <SOME_PROJECT>
studio.sh <SOME_PROJECT>
idea.sh <SOME_PROJECT>
```

To do this run these commands to add your IDE to your path:
(make sure you replace the below placeholder with your IDE name and IDE `/opt` path)

```bash
echo '' >> ~/.bashrc
echo '# adding <YOUR_IDE_NAME> to path' >> ~/.bashrc
echo 'export PATH="/opt/<IDE_FOLDER_NAME>/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

Here is a concrete example:

```bash
echo '' >> ~/.bashrc
echo '# adding webstorm to path' >> ~/.bashrc
echo 'export PATH="/opt/WebStorm-232.10227.9/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```
Verify it works by running the in your terminal respective bash script such as `webstorm.sh`.


# Desktop Entry

Now that we have set running the IDE from the terminal, we need to add a way to make the IDE runnable through the Desktop GUI.

The way to do this is to create a desktop entry file in `~/.local/share/applications`.

This is how you can create a Desktop Entry file through the terminal:
(Make sure you replace all the variables in the below command)

```bash
touch ~/.local/share/applications/<IDE_NAME>.desktop
cat > ~/.local/share/applications/<IDE_NAME>.desktop << EOF
[Desktop Entry]
Encoding=UTF-8
Version=1.0
Type=Application
Terminal=false
Exec=<PATH_TO_IDE_START_SCRIPT>
Name=Webstorm
Icon=<PATH_TO_IDE_ICON>
EOF
```

A concrete example

```bash
touch ~/.local/share/applications/webstorm.desktop
cat > ~/.local/share/applications/webstorm.desktop << EOF
[Desktop Entry]
Encoding=UTF-8
Version=1.0
Type=Application
Terminal=false
Exec=/opt/WebStorm-232.10227.9/bin/webstorm.sh
Name=Webstorm
Icon=/opt/WebStorm-232.10227.9/bin/webstorm.svg
EOF
```

Now you should be able to access your Jetbrains IDE from both the terminal and Desktop GUI.

Thanks for reading!