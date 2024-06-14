#!/bin/bash

read -p "What is your name?: " name

if [ $name == "Aiya" ]; then
echo "You have been blocked: $name

elif [ $name == "Ahmad" ]; then
	echo "You are admin, be aware!"

elif [ $name != "Abdul" ]; then
	echo "You are not authorized user: $name"
else
echo "Welcome back $name"
fi
