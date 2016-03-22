
#include <stdio.h>
#include <string.h>
#include "all.c"

struct set
{
	char key;
	char* value;
} mySet[]={
		{'a',".- \0"},{'b',"-... \0"},
		{'c',"-.-. \0"},{'d',"-.. \0"},
		{'e',". \0"},{'f',"..-. \0"},
		{'g',"--. \0"},{'h',".... \0"},
		{'i',".. \0"},{'j',".--- \0"},
		{'k',"-.- \0"},{'l',".-.. \0"},
		{'m',"-- \0"},{'n',"-. \0"},
		{'o',"--- \0"},{'p',".--. \0"},
		{'q',"--.- \0"},{'r',".-. \0"},
		{'s',"... \0"},{'t',"- \0"},
		{'u',"..- \0"},{'v',"...- \0"},
		{'w',".-- \0"},{'x',"-..- \0"},
		{'y',"-.-- \0"},{'z',"--.. \0"},

		{'1',".---- \0"},{'2',"..--- \0"},{'3',"...-- \0"},{'4',"....- \0"},{'5',"..... \0"},
		{'6',"-.... \0"},{'7',"--... \0"},{'8',"---.. \0"},{'9',"----. \0"},{'0',"----- \0"},

		{'.',"...... \0"},{',',".-.-.- \0"},
		{':',"---... \0"},{';',"-.-.- \0"},
		{'?',"..--.. \0"},{'!',"--..-- \0"},
		{' ',"  \0"},{'\n',"\n\0"},
		{'"',".-..-. \0"},{'\'',".----. \0"},
		{'(',"-.--.- \0"},{')',"-.--.- \0"},
		{'/',"-..-. \0"},{'-',"-....- \0"},
		
	};

char* convert(char ch){
	int j=0;
	while (j<49)
	{
		if(ch==mySet[j].key)
		{
			return mySet[j].value;
		}
		j++;
	}
	return "";
}

void converter()
{
	FILE *fin= fopen("input.txt","r");
	FILE *fout= fopen("output.txt","w");
	int n=0;
	if(fin==NULL){
		printf("error of input!");
	}else
	{
		char ch=fgetc(fin);
		while(ch!=EOF)
		{
			char* str=convert(ch);
			fputs(str,fout);
			ch=fgetc(fin);
		};	
	}
	fclose(fout);
	fclose(fin);	
}