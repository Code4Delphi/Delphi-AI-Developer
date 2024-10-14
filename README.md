# Delphi AI Developer (Copilot)
Inspired by GitHub Copilot, Delphi AI Developer is a plugin that adds Artificial intelligence (AI) interaction capabilities to the Delphi IDE, using both the OpenAI API, Gemini API and Groq API, as well as offering offline AI support.

With Delphi AI Developer, you will have assistance in generating and refactoring code, facilitating and accelerating development.

Receive suggestions for creating and improving code directly in the IDE and take advantage of the possibility of creating predefined questions to speed up your searches.

## 📞 Contacts

<p align="left">
  <a href="https://t.me/Code4Delphi" target="_blank">
    <img src="https://img.shields.io/badge/Telegram-Join%20Channel-blue?logo=telegram">
  </a> 
  &nbsp;
  <a href="https://www.youtube.com/@code4delphi" target="_blank">
    <img src="https://img.shields.io/badge/YouTube-Join%20Channel-red?logo=youtube&logoColor=red">
  </a>
  &nbsp;
  <a href="https://www.linkedin.com/in/cesar-cardoso-dev" target="_blank">
    <img src="https://img.shields.io/badge/LinkedIn-Follow-blue?logo=LinkedIn&logoColor=blue">
  </a>  
  &nbsp;
  <a href="https://go.hotmart.com/U81331747Y?dp=1" target="_blank">
    <img src="https://img.shields.io/badge/Course-Open%20Tools%20API-F00?logo=delphi">
  </a>   
  &nbsp;
  <a href="mailto:contato@code4delphi.com.br" target="_blank">
    <img src="https://img.shields.io/badge/E--mail-Send-yellowgreen?logo=maildotru&logoColor=yellowgreen">
  </a>
</p> 

## 🚀 INSTALLATION

1 - Download Delphi AI Developer. You can download the .zip file or clone the project on your PC.
![image](https://github.com/Code4Delphi/Delphi-AI-Developer/assets/33873267/a32c9333-6d5a-4036-9891-b97778bca90a)


2 - In your Delphi, access the menu File > Open and select the file: Package\DelphiAIDeveloper.dpk

![image](https://github.com/Code4Delphi/Delphi-AI-Developer/assets/33873267/775fdf6d-a7a0-44d5-9eb3-7db0e117fe49)


3 - Right-click on the project name and select "Install"

![image](https://github.com/Code4Delphi/Delphi-AI-Developer/assets/33873267/03dde077-8f28-4b99-a2a2-9565e862b392)


4- The "AI Developer" item will be added to the IDE's MainMenu

![image](https://github.com/Code4Delphi/Delphi-AI-Developer/assets/33873267/1c0ae468-ec44-4095-b299-65e873e79741)

<br/>

## ⚙️ PLUGIN SETTINGS
Access the menu “AI Developer” > “Settings” > Tab “Preferences”
![image](https://github.com/user-attachments/assets/c89d1145-4178-45ec-bd45-ecb13dfc37cc)

1. **Language used in questions:** Indicate in which language you will ask questions in chats, so that the prompts generated by the Plugin are generated in the same language.
2. **AI default (Chat and Databases Chat):** Default AI when starting the IDE.
3. **Color to highlight Delphi/Pascal code:** Color to highlight Delphi/Pascal/SQL code in responses displayed on chat screens
4. **Default Prompts:** Prompts added in this field will be sent to the AIs along with the requests. This can significantly improve the quality of the responses. (Example prompt: Always return SQL commands in lowercase letters)


<br/>

## ⚪ CONFIGURING IAS ONLINE
You can choose between 3 APIs, Gemini (Google), ChatGPT (OpenAI) and Groq. Gemini and Groq APIs are free. 

Access the menu “AI Developer” > “Settings” > Tab “IAs on-line”
![image](https://github.com/user-attachments/assets/2c3a45a2-94c8-4449-8c71-58246f6ca67f)

1. Inform the desired model.
2. Click on the **"Generate API Key"** link to generate your key.
3. In this field you must enter the API access key.

<br/>

## 🟠 CODE COMPLETION

To configure, access the menu “AI Developer” > “Settings” > Tab “Code Completion”

![image](https://github.com/user-attachments/assets/fd26a49c-5969-4bbe-8a2e-32e9623bf1d7)

1. Enables/disables use of Code Completion
2. **AI default:** Default AI that will be used by Code Completion
3. **Suggestion Code Color**: Color code suggested by plugin before being accepted
4. Shortcut to invoke Code Completion usage (requires restart of Delphi IDE)
5. **Default Prompts:** Prompts added in this field will be sent to the AIs along with the requests. This can significantly improve the quality of the responses. (Example prompt: Always return SQL commands in lowercase letters)

- To use it, simply use the configured shortcut keys (default Alt+Enter)
- To **accept** the suggestion, simply use the Tab key.
![delphi-ai-developer-previa-02](https://github.com/user-attachments/assets/f09fe06a-4471-43e7-b99e-1ac701dad211)


<br/>

## 🔵 AI CHAT INTERACTING WITH DELPHI IDE
Access the menu “AI Developer” > “Chat” or Ctrl+Shift+Alt+A
![image](https://github.com/user-attachments/assets/a8e58367-36c3-481f-8583-98d19cee68af)

1. Select the desired AI to be used in the chat
2. Field where the question/prompt should be added
3. Field where the AI ​​response will be displayed
4. Access the menu with pre-registered questions (to register, access the menu: “AI Developer” > “Defaults Questions”)
5. By checking this option, the AI ​​will only return codes, without inserting comments or explanations.
6. By checking the "Use current unit code in query" option, the source code of the current unit will be used as a reference for the prompt sent to the AIs.
Note: If the current unit has any code selected, only the selected code snippet will be used as a reference, otherwise the entire unit code will be used.
7. Button that makes the request to the AIs
8. **Insert Selected Text at Cursor**: Inserts the selected text into the response, field in the IDE code editor (if there is no selection, use the entire response)
9. Create new unit with selected code (if there is no selection, use the entire response)
10. Copy Selected Text (if there is no selection, use the entire response)
11. Clean all and start a new chat
12. Opens a menu with additional options

<br/>

## 🟣 CHAT FOR DATABASE INTERACTION
- To register Databases, access the menu “AI Developer” > “Databases Registers”
![image](https://github.com/user-attachments/assets/aacd2440-898a-4e7d-96fd-8dfa94c09c76)

- **Generate reference with database**
- Note: This process must always be performed whenever a new field or table is added to the database.
![image](https://github.com/user-attachments/assets/8649509e-189b-46d2-bc0d-378ead1e8929)

- Optional Step: Link Default Database to Project or Project Group
![image](https://github.com/user-attachments/assets/92812a6f-fdd6-45e0-b60c-b26669f166dc)

- Chat for database

![image](https://github.com/user-attachments/assets/f3aeb00e-cdcb-491d-b360-5c625c5c8f2f)


1. Select the desired database
2. Quick access to the reference generation screen for the selected database
3. Select the desired AI to be used in the chat
4. Field where the question/prompt should be added
5. Button that makes the request to the AIs
6. Field where the AI ​​response will be displayed
7. Button to execute the SQL command of the field with the response (field 6)
8. Grid with the response from the execution of the SQl command
9. Options for copying or exporting Grid data
10. Access the menu with pre-registered questions (to register, access the menu: “AI Developer” > “Defaults Questions”)
11. By checking this option, the AI ​​will only return SQL commands, without inserting comments or explanations.
12. By checking the "Use current unit code in query" option, the source code of the current unit will be used as a reference for the prompt sent to the AIs.
Note: If the current unit has any code selected, only the selected code snippet will be used as a reference, otherwise the entire unit code will be used.
13. **Insert Selected Text at Cursor**: Inserts the selected text into the response, field in the IDE code editor (if there is no selection, use the entire response)
14. Create new unit with selected code (if there is no selection, use the entire response)
15. Copy Selected Text (if there is no selection, use the entire response)
16. Clean all and start a new chat
17. Opens a menu with additional options

<br/>

## 🟤 IAS OFF-LINE

To use AI offline, follow these steps:
1. Install Ollama, which can be found at the following link: [https://ollama.com/download](https://ollama.com/download)
2. Choose the desired model. This can be done at the following link: [https://ollama.com/library](https://ollama.com/library)
![image](https://github.com/user-attachments/assets/1c259158-8118-421e-84ab-f6931b1438c0)
3. Open command prompt or terminal and run the command “ollama run <name_model>” and wait for the installation to finish
![image](https://github.com/user-attachments/assets/b5c12854-5ce4-4fe7-aa49-b0396f0d4040)
4. **To configure**, access the menu “AI Developer” > “Settings” > Tab “IAs off-Line“
![image](https://github.com/user-attachments/assets/f821ab05-743a-480f-a72b-f7ca3809ae6b)


<br/>

## ▶️ DEMO VIDEO
Para mais detalhes sobre o plugin, assista à nossa palestra, eleita como uma das melhores da Embarcadero Conference 2024. O vídeo está em português (pt-BR), mas estamos fornecendo legendas e, possivelmente, uma versão em inglês.
* [https://www.youtube.com/watch?v=2NAlUFK2FGs](https://www.youtube.com/watch?v=2NAlUFK2FGs)

<br/>

## 💬 CONTRIBUTIONS / IDEAS / BUG FIXES
Any suggestions or help are welcome. Send us a pull request or open an [issue](/../../issues/).

<br/>

## ⚠️ LICENSE
`Delphi AI Developer` is free and open-source wizard licensed under the [MIT License](LICENSE).

