# LabWork 5
Завдання: 
- Зареєструватись на AWS. 
- Створити інстанс EC2.
- Задеплоїти проект (може бути  html сторінка) і скинути посилання в звіт для можливості перегляду.

Я вже був зареєстрований на AWS, тому цей крок я пропустив.
Для створення інстансу ЕС2, я перейшов в потрібний розділ і вибрав Amazon Linux Image.
Скрипт для інстансу:
```
#!/bin/bash
yum update -y
yum install httpd -y
echo "<html><body><h1>Гнітецький Костянтин ІПЗ-1</h1></body></html>">/var/www/html/index.html
systemctl start httpd
systemctl enable httpd
```
![img](https://media.discordapp.net/attachments/1034852712384315472/1039190883112857681/image.png)
![img](https://cdn.discordapp.com/attachments/1034852712384315472/1039190956227965020/image.png)
![img](https://cdn.discordapp.com/attachments/1034852712384315472/1039190996107403324/image.png)

Link: http://3.75.186.179/
