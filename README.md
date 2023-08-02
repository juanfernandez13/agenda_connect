<h1>
  <img src="https://img.icons8.com/fluency/256/flutter.png" height=40/>
  Lista de contatos em Flutter
</h1>

![linguagem](https://img.shields.io/github/languages/top/juanfernandez13/agenda_connect?color=blue&style=for-the-badge)
![tamanho do projeto](https://img.shields.io/github/languages/code-size/juanfernandez13/agenda_connect?color=blue&style=for-the-badge)
![tamanho do projeto](https://img.shields.io/github/last-commit/juanfernandez13/agenda_connect?color=blue&style=for-the-badge)

Agenda connect, o aplicativo mobile híbrido para cadastrar listas de contatos, armazendando informações como nome, telefone, email, função. Além das opções de favoritar o contato e destacar o contato como emergência. Para criar esse projeto foi utilizado a linguagem [Dart](https://dart.dev/) e o framework [Flutter](https://flutter.dev/). O objetivo da aplicação era treinar a Requisições http com o package [Http](https://pub.dev/packages/http) e o gerenciamento de estado com o [Provider](https://pub.dev/packages/provider). Para trabalhar conceitos de POO, como o polimorfismo foi criado uma classe abstrata [Back4AppRepository](https://github.com/juanfernandez13/agenda_connect/blob/main/lib/repositories/back_4app_repository.dart) onde é implementado na classe [HttpBack4AppRepository](https://github.com/juanfernandez13/agenda_connect/blob/main/lib/repositories/impl/http_back4app_repository.dart), o BackEnd utilizado foi o [Back4App](https://www.back4app.com/). Outras funcionalidades da aplicação é o acesso a câmera, cropped de imagens e a galeria.

<p align=center>
  <img src="https://github.com/juanfernandez13/agenda_connect/blob/main/readme/app.gif" height=600/>
</p>

<h2>
<img src="https://img.icons8.com/nolan/256/iphone-x.png" height = 35/>
Telas do Aplicativo
</h2>
<p align=center>
  <img src="https://github.com/juanfernandez13/agenda_connect/blob/main/readme/splashScreen.jpeg" height=500/>
  <img src="https://github.com/juanfernandez13/agenda_connect/blob/main/readme/homeScreen.jpeg" height=500/>
  <img src="https://github.com/juanfernandez13/agenda_connect/blob/main/readme/editScreen.jpeg" height=500/>
</p>


Telas projetadas no [Figma](https://www.figma.com/), clique no [aqui](https://www.figma.com/file/SLSeHEHAzXITev1wDdMcUH/contatos_app?type=design&node-id=0%3A1&mode=design&t=qBAXtmDIgCdl6uAn-1) para acessar.

<h2>
<img src="https://img.icons8.com/nolan/256/wrench.png" height = 35/>
Funcionalidades
</h2>

- [x] **CRUD de contatos**: Realizar o cadastro, vizualiação, alteração e exclusão de contatos no BackEnd do [Back4App](https://www.back4app.com/) por meio de requisições Http.
- [x] **Geração de cor aleatória**: O card de cada contato possui uma cor única que é gerado durante o cadastro do usuário.
- [x] **Gerenciamento de estado com Provider**: O aplicativo utiliza o provider como gerenciador de estado.
- [x] **Acesso a câmera**: O aplicativo utilizando os pacotes [gallery saver](https://pub.dev/packages/gallery_saver) e [image picker](https://pub.dev/packages/image_picker) consegue realizar o acesso a câmera e a permanência da imagem no Smartphone.
- [x] **Edição de imagens**: Utilizando o pacote [image cropper](https://pub.dev/packages/image_cropper) consegue recortar uma imagem do smartphone.

<h2>
<img src="https://github.com/juanfernandez13/imc_app/blob/master/readme/icons8-box-64.png" height = 35/>
Packages
</h2>

* [provider](https://pub.dev/packages/provider)
* [http](https://pub.dev/packages/http)
* [path provider](https://pub.dev/packages/path_provider)
* [image picker](https://pub.dev/packages/image_picker)
* [gallery saver](https://pub.dev/packages/gallery_saver)
* [image cropper](https://pub.dev/packages/image_cropper)
* [brasil fields](https://pub.dev/packages/brasil_fields)

