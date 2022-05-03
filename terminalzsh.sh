#!/bin/bash

## POWERLEVEL10K AUTOCONFIGURATOR
## ALEX MEINHOF

NOCOLOR='\033[0m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
GREEN='\033[0;32m'

echo -e "${YELLOW}POWELLEVEL10K AUTOCONFIGURATOR"

CheckSudo()
{

if [ $EUID -eq 0 ]; then
	echo -e "${RED}El script no debe ser lanzado con sudo"

    exit $?

fi
}

Install_Packages()
{

cat /etc/os-release |grep "arch" 2> /dev/null > /dev/null
if [ $? -eq 0 ]; then
	sudo pacman -S zsh curl git ttf-font-awesome
	if [ $? -eq 0 ]; then

		echo -e "${YELLOW}Se instalarán los paquetes necesarios, cambiando el intérprete de comandos...${NOCOLOR}"
		chsh -s /bin/zsh
		
		while [ $? -ne 0 ]
		do
			echo -e "${RED}Error, inténtalo de nuevo${NOCOLOR}"
			chsh -s /bin/zsh
		done
	else
		exit 1


	fi

else

	cat /etc/os-release |grep "ubuntu\|Ubuntu\|debian" 2> /dev/null > /dev/null

	if [ $? -eq 0 ]; then
		sudo apt update && sudo apt install -y zsh curl git fonts-font-awesome
		if [ $? -eq 0 ]; then

			echo -e "${YELLOW}Se instalarán los paquetes necesarios, cambiando el intérprete de comandos...${NOCOLOR}"
			chsh -s /bin/zsh
			while [ $? -ne 0 ]
			do
				echo -e "${RED}Error, inténtalo de nuevo${NOCOLOR}"
				chsh -s /bin/zsh
			done
		else

			exit 1


		fi
	fi
fi


}

if CheckSudo -eq 0; then

	echo -e "${YELLOW}Verificación de los paquetes necesarios para la instalación...${NOCOLOR}" && Install_Packages
	
	echo -e "${YELLOW}Instalación de Oh-My-ZSH...${NOCOLOR}"
		
		if [ ! -d "$HOME/.oh-my-zsh" ]; then
			echo -e "${YELLOW}Oh-My-ZSH no instalado, instalando...${NOCOLOR}"
			sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"> /dev/null&
			wait
			echo "Oh-My-ZSH instalado"
		else
			echo -e "${YELLOW}Oh-My-ZSH ya está instalado, reinstalar...${NOCOLOR}"
			rm -Rf $HOME/.oh-my-zsh
			sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"> /dev/null&
			wait
			echo "Oh-My-ZSH ha sido instalado con éxito"

		fi
	
		if [ ! -d "$HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting" ];then
		
			echo -e "${YELLOW}Instalación del plugin zsh-syntax-highlighting${NOCOLOR}"
			cd /tmp/ && git clone --quiet https://github.com/zsh-users/zsh-syntax-highlighting
			mv zsh-syntax-highlighting/ $HOME/.oh-my-zsh/plugins
			echo -e "${GREEN}Plugin zsh-syntax-highlighting instalado${NOCOLOR}"
	
		else
			echo -e "${YELLOW}reinstalación del plugin zsh-syntax-highlighting${NOCOLOR}"
			rm -Rf $HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting
			cd /tmp/ && git clone --quiet https://github.com/zsh-users/zsh-syntax-highlighting
			mv zsh-syntax-highlighting/ $HOME/.oh-my-zsh/plugins
			echo -e "${GREEN}Plugin zsh-syntax-highlighting instalado${NOCOLOR}"
		fi

		if [ ! -d "$HOME/.oh-my-zsh/plugins/zsh-completions" ]
		then
			echo -e "${YELLOW}Instalación del plugin zsh-completions${NOCOLOR}"
			cd /tmp/ && git clone --quiet https://github.com/zsh-users/zsh-completions
			mv zsh-completions/ $HOME/.oh-my-zsh/plugins
			echo -e "${GREEN}Plugin zsh-completions instalado${NOCOLOR}"
		
		else
			echo -e "${YELLOW}reinstalación du plugin zsh-completions${NOCOLOR}"
			rm -Rf $HOME/.oh-my-zsh/plugins/zsh-completions
			cd /tmp/ && git clone --quiet https://github.com/zsh-users/zsh-completions
			mv zsh-completions/ $HOME/.oh-my-zsh/plugins
			echo -e "${GREEN}Plugin zsh-completions instalado${NOCOLOR}"
		fi

		if [ ! -d "$HOME/.oh-my-zsh/plugins/zsh-autosuggestions" ]
		then
			echo -e "${YELLOW}Instalación del plugin zsh-autosuggestions${NOCOLOR}"
			cd /tmp/ && git clone --quiet https://github.com/zsh-users/zsh-autosuggestions
			mv zsh-autosuggestions/ $HOME/.oh-my-zsh/plugins
			echo -e "${GREEN}Plugin zsh-autosuggestions instalado${NOCOLOR}"
		
		else
			echo -e "${YELLOW}reinstalación del plugin zsh-autosuggestions${NOCOLOR}"
			rm -Rf $HOME/.oh-my-zsh/plugins/zsh-autosuggestions
			cd /tmp/ && git clone --quiet https://github.com/zsh-users/zsh-autosuggestions
			mv zsh-autosuggestions/ $HOME/.oh-my-zsh/plugins
			echo -e "${GREEN}Plugin zsh-autosuggestions instaldo${NOCOLOR}"
		fi


		if [ ! -d "/tmp/lsd-musl_0.21.0_amd64.deb" ]
		then
			echo -e "${YELLOW}Instalación del plugin lsd${NOCOLOR}"
			cd /tmp/ && wget --quiet https://github.com/Peltoche/lsd/releases/download/0.21.0/lsd-musl_0.21.0_amd64.deb
			sudo dpkg -i lsd-musl_0.21.0_amd64.deb
			echo -e "${GREEN}Plugin lsd instalado${NOCOLOR}"
		
		else
			echo -e "${YELLOW}reinstalación del plugin lsd${NOCOLOR}"
			rm -Rf /tmp/lsd-musl_0.21.0_amd64.deb
			cd /tmp/ && wget --quiet https://github.com/Peltoche/lsd/releases/download/0.21.0/lsd-musl_0.21.0_amd64.deb
			sudo dpkg -i lsd-musl_0.21.0_amd64.deb
			echo -e "${GREEN}Plugin lsd instalado${NOCOLOR}"
		fi


	
	
	sed -i 's/plugins=(git)/plugins=(git zsh-syntax-highlighting zsh-completions zsh-autosuggestions)/' $HOME/.zshrc
	
	if [ ! -d "$HOME/.oh-my-zsh/plugins/powerlevel10k" ]
		then
			echo -e "${YELLOW}Instalación del tema Powerlevel10k...${NOCOLOR}"
			cd /tmp/ && git clone --quiet https://github.com/romkatv/powerlevel10k
			mv powerlevel10k/ $HOME/.oh-my-zsh/themes/
			sed -i 's|ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' $HOME/.zshrc
			echo -e "${GREEN}Tema Powerlevel10k instalado${NOCOLOR}"
		else
			echo -e "${YELLOW}Instalación del tema Powerlevel10k...${NOCOLOR}"
			rm -Rf $HOME/.oh-my-zsh/themes/powerlevel10k
			cd /tmp/ && git clone --quiet https://github.com/romkatv/powerlevel10k
			mv powerlevel10k/ $HOME/.oh-my-zsh/themes/
			sed -i 's|ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' $HOME/.zshrc
			echo -e "${GREEN}Tema Powerlevel10k instalado${NOCOLOR}"
		fi
		
	
	
	
		
	
	echo ""
	echo -e "${GREEN}¡Instalación completa! Para aplicar los cambios, cierra la sesión actual y vuelve a iniciar sesión${NOCOLOR}"
	
else 

	echo -e "${RED}El script no puede ser ejecutado con sudo${NOCOLOR}"
	exit
	
fi 
		
