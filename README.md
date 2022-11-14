# Лабараторна робота 4
**Виконав: Гнітецький Костянтин Юліанович ІПЗ - 1**
Завдання: Create terraform scenario for provisioning infrastructure on GCP (or AWS) cloud Requirement 
1. Create one instance (image: ubuntu 20.04) 
2. Allow HTTP/HTTPS traffic on a NIC 
3. Provision one SSH public key for created instance 
4. Install Web Server (Apache HTTP Server / NGINX HTTP Server) via bash scenario
# Хід роботи
Виконувати цю лабараторну я вирішив на AWS. Для цього реєструємо акаунт.
Отримуємо Access key та Secret access key

![aws](https://cdn.discordapp.com/attachments/1032017662575902805/1041678098258731008/image.png)

Далі, скачуємо тераформ для Windows.
Почувши що тераформ вимагає багато пам'яті, я вирішив не ризикувати з віртуальною машиною.
Обов'язково небхідно добавити розташування exe файла до змінної PATH в вінді.
Або можна пропустити цей крок, якщо закинути файл в System32. Ця папка вже там вказана.

Перейдемо до коду. Для початку треба вказати провайдера. Так же добавляю один інстанс юбунту(вказавши його ami)

![terraform](https://media.discordapp.net/attachments/1032017662575902805/1041679481716363394/image.png)

Після цього, переходимо в консоль. Перейшовши в папку з тераформ файлом, вводимо terraform init.
На цьому етапі тераформ загрузить всі необхідні йому файли, для роботи з AWS.
Якщо ввести terraform apply то тераформ створить один інстанс, як ми йому і вказали

![instance](https://cdn.discordapp.com/attachments/1032017662575902805/1041679740345524244/image.png)

![instance](https://cdn.discordapp.com/attachments/1032017662575902805/1041680150787526666/image.png)

Для виконання завдання 2, потрібно створити Security Group.
Код:

`resource "aws_security_group" "ubuntuSecurity"{`
    `name        = "MyUbuntu"`
    `description = "LabWork4"`

 `ingress {`
    `from_port        = 22`
    `to_port          = 22`
    `protocol         = "tcp"`
    `cidr_blocks      = ["0.0.0.0/0"]`
  `}`

  `ingress {`
    `from_port        = 80`
    `to_port          = 80`
    `protocol         = "tcp"`
    `cidr_blocks      = ["0.0.0.0/0"]`
  `}`

  `ingress {`
    `from_port        = 443`
    `to_port          = 443`
    `protocol         = "tcp"`
    `cidr_blocks      = ["0.0.0.0/0"]`
  `}`

  `egress {`
    `from_port        = 0`
    `to_port          = 0`
    `protocol         = "-1"`
    `cidr_blocks      = ["0.0.0.0/0"]`
  `}`
`}`

І вказати цю групу в інстансі. Щоб задавати її динамічно, і не міняти кожен раз, витягуємо айді таким чином:
`vpc_security_group_ids = [aws_security_group.ubuntuSecurity.id]`

Завдання 3 вимагає створити SSH ключ. Для цього я використав команду ssh-keygen.

![ssh](https://cdn.discordapp.com/attachments/1032017662575902805/1041681346927525949/image.png)

Далі потрібно створити групу ключів, і передати її на AWS.

`resource "aws_key_pair" "myKeys" {
  key_name = "kostia"
  public_key = "ssh-rsa AAAAB3N(here was my key)= kosti@DESKTOP-5QLBSRH"
}`

І знову вказати в інстансі цю групу
`key_name = "kostia"`

Після цього, вводимо в консолі terraform apply, і підтверджуємо команду.

Можна логінитись і виконувати завдання 4.
Нажавши на інстанс, і кнопку Connect, можна скопіювати команду. Для мене це:
ssh -i "kostia.pem" ubuntu@ec2-3-68-221-12.eu-central-1.compute.amazonaws.com

![connect](https://media.discordapp.net/attachments/1032017662575902805/1041682076883222618/image.png)

Вводимо такі команди:
`sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2`

Цим ми встановити пакет Apache. Наш сайт майтиме такий вигляд:

![page](https://media.discordapp.net/attachments/1032017662575902805/1041683647050297376/image.png)

Щоб замінити сторінку, треба вказати свій код.
`echo "<h1>Created by Terraform. Hello Kostia Hnitetskiy</h1>" | sudo tee /var/www/html/index.html`

І маємо результат:

![result](https://cdn.discordapp.com/attachments/1032017662575902805/1041683902487592990/image.png)
