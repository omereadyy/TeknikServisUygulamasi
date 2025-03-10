import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Sayfası',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const TeknikServisAnaSayfa(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade300,
              Colors.blue.shade600,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Logo veya İkon
                          const Icon(
                            Icons.account_circle,
                            size: 100,
                            color: Colors.blue,
                          ),
                          const SizedBox(height: 20),

                          // Hoşgeldiniz Yazısı
                          const Text(
                            'Hoş Geldiniz',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Email Alanı
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Kullanıcı adresi',
                              hintText: 'Kullanıcı adresinizi giriniz',
                              prefixIcon: const Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Lütfen kullanıcı adresinizi giriniz';
                              }
                              if (!value.contains('')) {
                                return 'Geçerli bir kullanici adresi giriniz';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),

                          // Şifre Alanı
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              labelText: 'Şifre',
                              hintText: 'Şifrenizi giriniz',
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Lütfen şifrenizi giriniz';
                              }
                              if (value.length < 6) {
                                return 'Şifre en az 6 karakter olmalıdır';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),

                          // Beni Hatırla
                          Row(
                            children: [
                              Checkbox(
                                value: _rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    _rememberMe = value!;
                                  });
                                },
                              ),
                              const Text('Beni Hatırla'),
                              const Spacer(),
                              TextButton(
                                onPressed: () {
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
                                 );
                                  // Şifremi unuttum işlemleri
                                },
                                child: const Text('Şifre İste'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Giriş Butonu
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Giriş Yap',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Kayıt Ol Butonu
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Hesabınız yok mu?'),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()),
                                  );
                                  // Kayıt sayfasına yönlendirme
                                },
                                child: const Text('Kayıt Ol'),
                              ),
                            ],
                          ),

                          // Sosyal Medya Girişleri
                          const Divider(height: 30),
                          const Text('Veya şununla giriş yapın:'),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _socialButton('Google', Icons.g_mobiledata),
                              _socialButton('Facebook', Icons.facebook),
                              _socialButton('Apple', Icons.apple),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialButton(String platform, IconData icon) {
    return IconButton(
      onPressed: () {
        // Sosyal medya giriş işlemleri
      },
      icon: Icon(icon, size: 30),
    );
  }
}

class TeknikServisAnaSayfa extends StatefulWidget {
  const TeknikServisAnaSayfa({super.key});

  @override
  State<TeknikServisAnaSayfa> createState() => _TeknikServisAnaSayfaState();
}

class _TeknikServisAnaSayfaState extends State<TeknikServisAnaSayfa> {
  final List<ArizaDurumu> _arizalar = [
    ArizaDurumu(
      parcaAdi: 'Motor',
      durum: 'İyi',
      aciklama: 'Normal çalışıyor',
      icon: Icons.engineering,
      renk: Colors.green,
    ),
    ArizaDurumu(
      parcaAdi: 'Fren Sistemi',
      durum: 'Kritik',
      aciklama: 'Fren balataları değişmeli',
      icon: Icons.engineering,
      renk: Colors.red,
    ),
    ArizaDurumu(
      parcaAdi: 'Lastik Basıncı',
      durum: 'Uyarı',
      aciklama: 'Lastik basıncı düşük, kontrol edin.',
      icon: Icons.tire_repair,
      renk: Colors.orange,
    ),
    ArizaDurumu(
      parcaAdi: 'Far Sistemi',
      durum: 'Hata',
      aciklama: 'Farlar çalışmıyor veya arızalı.',
      icon: Icons.lightbulb,
      renk: Colors.yellow,
    ),

    ArizaDurumu(
      parcaAdi: 'Yağ Seviyesi',
      durum: 'Uyarı',
      aciklama: 'Yağ seviyesi düşük',
      icon: Icons.oil_barrel,
      renk: Colors.orange,
    ),
    ArizaDurumu(
      parcaAdi: 'Akü',
      durum: 'İyi',
      aciklama: 'Şarj durumu normal',
      icon: Icons.battery_full,
      renk: Colors.green,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teknik Servis'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BildirimlerSayfasi()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Ömer Faruk Dündar'),
              accountEmail: Text('omer.dundar@gmail.com'),
              currentAccountPicture: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Ana Sayfa'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Servis Geçmişi'),
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => const ServiceHistoryPage()),
                );
                // Servis geçmişi sayfasına yönlendirme
              },
            ),
            ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text('Randevu Al'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AppointmentPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text('Maliyet Hesaplama'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MaliyetHesaplama(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Ayarlar'),
              onTap: () {
               Navigator.push
                 (context,
                   MaterialPageRoute(builder: (context) => const SettingsPage()),
               );
              },
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Çıkış yap'),
              onTap: () {
                Navigator.pushReplacement
                  (context,
                    MaterialPageRoute(builder: (context)=> const LoginPage()),
                );
                // Login sayfasına yönlendirme
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Araç Bilgileri Kartı
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Araç Bilgileri',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _bilgiSatiri('Marka', 'Seat'),
                      _bilgiSatiri('Model', 'Leon'),
                      _bilgiSatiri('Yıl', '2024'),
                      _bilgiSatiri('Plaka', '73 FB 027'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Arıza Durumu Başlığı
              const Text(
                'Arıza Durumu',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Arıza Kartları
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: _arizalar.length,
                itemBuilder: (context, index) {
                  final ariza = _arizalar[index];
                  return Card(
                    child: InkWell(
                      onTap: () {
                        _arizaDetayGoster(context, ariza);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              ariza.icon,
                              size: 40,
                              color: ariza.renk,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              ariza.parcaAdi,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              ariza.durum,
                              style: TextStyle(
                                color: ariza.renk,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              // Hızlı İşlemler
              const Text(
                'Hızlı İşlemler',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _hizliIslemButonu(
                    'Randevu Al',
                    Icons.calendar_today,
                    Colors.blue,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AppointmentPage()),
                      );
                    },
                  ),

                  _hizliIslemButonu(
                    'Servis Çağır',
                    Icons.car_repair,
                    Colors.orange,
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ServisCagirSayfasi()),
                      );
                    }
                  ),

                  _hizliIslemButonu(
                    'Bilgi',
                    Icons.help_outline,
                    Colors.red,
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BilgiSayfasi()),
                      );
                    }
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bilgiSatiri(String baslik, String deger) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            baslik,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(deger),
        ],
      ),
    );
  }


  Widget _hizliIslemButonu(String text, IconData icon, Color color, {required VoidCallback onTap}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: color,
          child: IconButton(
            icon: Icon(icon, color: Colors.white),
            onPressed: onTap, // Burada doğrudan onTap'i kullanıyoruz
          ),
        ),
        const SizedBox(height: 5),
        Text(text),
      ],
    );
  }

  void _arizaDetayGoster(BuildContext context, ArizaDurumu ariza) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(ariza.parcaAdi),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Durum: ${ariza.durum}'),
            const SizedBox(height: 10),
            Text('Açıklama: ${ariza.aciklama}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Kapat'),
          ),
          TextButton(
            onPressed: () {
              // Servis randevusu alma sayfasına yönlendirme
              Navigator.pop(context);
            },
            child: const Text('Randevu Al'),
          ),
        ],
      ),
    );
  }
}

class ArizaDurumu {
  final String parcaAdi;
  final String durum;
  final String aciklama;
  final IconData icon;
  final Color renk;

  ArizaDurumu({
    required this.parcaAdi,
    required this.durum,
    required this.aciklama,
    required this.icon,
    required this.renk,
  });
}

class MaliyetHesaplama extends StatefulWidget {
  const MaliyetHesaplama({super.key});

  @override
  State<MaliyetHesaplama> createState() => _MaliyetHesaplamaState();
}

class _MaliyetHesaplamaState extends State<MaliyetHesaplama> {
  final List<ServisKalemi> _servisKalemleri = [];
  double _toplamMaliyet = 0;
  double _iskonto = 0;
  final double _kdvOrani = 0.18;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detaylı Maliyet Hesaplama'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => _gecmisHesaplamalariGoster(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Özet Kart
          Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Maliyet Özeti',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  _ozetSatiri('Ara Toplam:', _toplamMaliyet),
                  _ozetSatiri('KDV (%${(_kdvOrani * 100).toInt()}):',
                      _toplamMaliyet * _kdvOrani),
                  _ozetSatiri('İskonto:', _iskonto),
                  const Divider(),
                  _ozetSatiri(
                    'Genel Toplam:',
                    (_toplamMaliyet + (_toplamMaliyet * _kdvOrani)) - _iskonto,
                    isBold: true,
                  ),
                ],
              ),
            ),
          ),

          // Kategori Filtreleme
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text('Kategori: '),
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: 'Tümü',
                    items: [
                      'Tümü',
                      'Motor',
                      'Elektrik',
                      'Mekanik',
                      'Kaporta',
                      'Bakım'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? yeniDeger) {
                      // Kategori filtreleme işlemi
                    },
                  ),
                ),
              ],
            ),
          ),

          // Servis Kalemleri Listesi
          Expanded(
            child: ListView.builder(
              itemCount: _servisKalemleri.length,
              itemBuilder: (context, index) {
                final kalem = _servisKalemleri[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ExpansionTile(
                    leading: Icon(
                      _getKategoriIcon(kalem.kategori),
                      color: _getKategoriColor(kalem.kategori),
                    ),
                    title: Text(kalem.islemAdi),
                    subtitle: Text(
                      '${kalem.kategori} - ${kalem.maliyet.toStringAsFixed(2)} TL',
                    ),
                    trailing: Text(
                      'Toplam: ${(kalem.maliyet * kalem.miktar).toStringAsFixed(2)} TL',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Açıklama: ${kalem.aciklama}'),
                            Text('Miktar: ${kalem.miktar}'),
                            Text('Birim Fiyat: ${kalem.maliyet} TL'),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton.icon(
                                  icon: const Icon(Icons.edit),
                                  label: const Text('Düzenle'),
                                  onPressed: () => _kalemDuzenle(index),
                                ),
                                TextButton.icon(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  label: const Text('Sil',
                                      style: TextStyle(color: Colors.red)),
                                  onPressed: () => _kalemSil(index),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Alt Toplam ve İşlem Butonları
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Column(
              children: [
                // İskonto Girişi
                Row(
                  children: [
                    const Text('İskonto:'),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          suffix: Text('TL'),
                          isDense: true,
                        ),
                        onChanged: (value) {
                          setState(() {
                            _iskonto = double.tryParse(value) ?? 0;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.save),
                        label: const Text('Kaydet'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: _hesaplamaKaydet,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.payment),
                        label: const Text('Ödeme'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: _odemeYap, // Burada _odemeYap fonksiyonunu doğrudan bağlıyoruz
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _yeniKalemEkle,
        label: const Text('Yeni İşlem'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget _ozetSatiri(String baslik, double deger, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            baslik,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            '${deger.toStringAsFixed(2)} TL',
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold ? Colors.blue : null,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getKategoriIcon(String kategori) {
    switch (kategori) {
      case 'Motor':
        return Icons.engineering;
      case 'Elektrik':
        return Icons.electric_bolt;
      case 'Mekanik':
        return Icons.build;
      case 'Kaporta':
        return Icons.car_repair;
      case 'Bakım':
        return Icons.miscellaneous_services;
      default:
        return Icons.work;
    }
  }

  Color _getKategoriColor(String kategori) {
    switch (kategori) {
      case 'Motor':
        return Colors.red;
      case 'Elektrik':
        return Colors.yellow[700]!;
      case 'Mekanik':
        return Colors.blue;
      case 'Kaporta':
        return Colors.purple;
      case 'Bakım':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _yeniKalemEkle() {
    showDialog(
      context: context,
      builder: (context) => ServisKalemiForm(
        onSave: (kalem) {
          setState(() {
            _servisKalemleri.add(kalem);
            _toplamMaliyetHesapla();
          });
        },
      ),
    );
  }

  void _kalemDuzenle(int index) {
    showDialog(
      context: context,
      builder: (context) => ServisKalemiForm(
        kalem: _servisKalemleri[index],
        onSave: (kalem) {
          setState(() {
            _servisKalemleri[index] = kalem;
            _toplamMaliyetHesapla();
          });
        },
      ),
    );
  }

  void _kalemSil(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('İşlem silinecektir'),
        content: const Text('Bu işlemi silmek istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _servisKalemleri.removeAt(index);
                _toplamMaliyetHesapla();
              });
              Navigator.pop(context);
            },
            child: const Text('Sil', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _toplamMaliyetHesapla() {
    _toplamMaliyet = _servisKalemleri.fold(
      0,
          (toplam, kalem) => toplam + (kalem.maliyet * kalem.miktar),
    );
  }

  void _odemeYap() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Tam yükseklikte açılmasını sağlar
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: const OdemeFormu(),
          ),
        ),
      ),
    );
  }

  void _hesaplamaKaydet() {
    // Hesaplama kaydetme işlemi
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Hesaplama kaydedildi')),
    );
  }

  void _gecmisHesaplamalariGoster() {
    // Geçmiş hesaplamaları gösterme işlemi
  }
}



class ServisKalemi {
  final String islemAdi;
  final String kategori;
  final String aciklama;
  final double maliyet;
  final int miktar;

  ServisKalemi({
    required this.islemAdi,
    required this.kategori,
    required this.aciklama,
    required this.maliyet,
    required this.miktar,
  });
}

class ServisKalemiForm extends StatefulWidget {
  final ServisKalemi? kalem;
  final Function(ServisKalemi) onSave;

  const ServisKalemiForm({
    super.key,
    this.kalem,
    required this.onSave,
  });

  @override
  State<ServisKalemiForm> createState() => _ServisKalemiFormState();
}

class _ServisKalemiFormState extends State<ServisKalemiForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _islemController;
  late TextEditingController _aciklamaController;
  late TextEditingController _maliyetController;
  late TextEditingController _miktarController;
  String _secilenKategori = 'Motor';

  @override
  void initState() {
    super.initState();
    _islemController = TextEditingController(text: widget.kalem?.islemAdi);
    _aciklamaController = TextEditingController(text: widget.kalem?.aciklama);
    _maliyetController = TextEditingController(
      text: widget.kalem?.maliyet.toString(),
    );
    _miktarController = TextEditingController(
      text: widget.kalem?.miktar.toString(),
    );
    if (widget.kalem != null) {
      _secilenKategori = widget.kalem!.kategori;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.kalem == null ? 'Yeni İşlem' : 'İşlem Düzenle'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: _secilenKategori,
                decoration: const InputDecoration(
                  labelText: 'Kategori',
                  border: OutlineInputBorder(),
                ),
                items: [
                  'Motor',
                  'Elektrik',
                  'Mekanik',
                  'Kaporta',
                  'Bakım'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _secilenKategori = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _islemController,
                decoration: const InputDecoration(
                  labelText: 'İşlem Adı',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value?.isEmpty ?? true ? 'Bu alan gereklidir' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _aciklamaController,
                decoration: const InputDecoration(
                  labelText: 'Açıklama',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _maliyetController,
                      decoration: const InputDecoration(
                        labelText: 'Birim Fiyat (TL)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value?.isEmpty ?? true) return 'Bu alan gereklidir';
                        if (double.tryParse(value!) == null) {
                          return 'Geçerli bir sayı giriniz';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _miktarController,
                      decoration: const InputDecoration(
                        labelText: 'Miktar',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value?.isEmpty ?? true) return 'Bu alan gereklidir';
                        if (int.tryParse(value!) == null) {
                          return 'Geçerli bir sayı giriniz';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('İptal'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onSave(
                ServisKalemi(
                  islemAdi: _islemController.text,
                  kategori: _secilenKategori,
                  aciklama: _aciklamaController.text,
                  maliyet: double.parse(_maliyetController.text),
                  miktar: int.parse(_miktarController.text),
                ),
              );
              Navigator.pop(context);
            }
          },
          child: const Text('Kaydet'),
        ),
      ],
    );
  }
}

class OdemeFormu extends StatefulWidget {
  const OdemeFormu({super.key});

  @override
  State<OdemeFormu> createState() => _OdemeFormuState();
}

class _OdemeFormuState extends State<OdemeFormu> {
  final _formKey = GlobalKey<FormState>();
  String _secilenOdemeTipi = 'Kredi Kartı';
  final _kartNumarasiController = TextEditingController();
  final _sonKullanmaController = TextEditingController();
  final _cvvController = TextEditingController();
  final _adSoyadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Ödeme Bilgileri',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _secilenOdemeTipi,
              items: ['Kredi Kartı', 'Banka Kartı']
                  .map((tip) => DropdownMenuItem(
                value: tip,
                child: Text(tip),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _secilenOdemeTipi = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Ödeme Tipi',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _kartNumarasiController,
              decoration: const InputDecoration(
                labelText: 'Kart Numarası',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Kart numarası gereklidir';
                if (value!.length != 16) return '16 haneli numara giriniz';
                return null;
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _sonKullanmaController,
                    decoration: const InputDecoration(
                      labelText: 'Son Kullanma Tarihi (AA/YY)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Tarih gereklidir';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: _cvvController,
                    decoration: const InputDecoration(
                      labelText: 'CVV',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value?.isEmpty ?? true) return 'CVV gereklidir';
                      if (value!.length != 3) return '3 haneli kod giriniz';
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _adSoyadController,
              decoration: const InputDecoration(
                labelText: 'Kart Üzerindeki İsim',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) return 'İsim gereklidir';
                return null;
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Ödeme işlemi burada gerçekleştirilecek
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Ödeme işlemi başarıyla tamamlandı'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.blue, // Arka plan rengi
                  foregroundColor: Colors.white, // Metin rengi
                ),
                child: const Text('Ödemeyi Tamamla'),

              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar'),
        centerTitle: true,
        elevation: 2,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profil Kartı
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    child: Icon(Icons.person, size: 40),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Ömer Faruk Dündar',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'omerdundar@gmail.com',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () {
                      // Profil düzenleme sayfasına git
                    },
                    child: const Text('Profili Düzenle'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Uygulama Ayarları
          const Text(
            'Uygulama Ayarları',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Karanlık Mod'),
                  subtitle: const Text('Uygulama temasını değiştir'),
                  secondary: const Icon(Icons.dark_mode),
                  value: true,
                  onChanged: (bool value) {
                    // Karanlık mod değişimi
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text('Bildirimler'),
                  subtitle: const Text('Bildirim tercihlerini yönet'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // Bildirim ayarları
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text('Dil Seçimi'),
                  subtitle: const Text('Türkçe'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // Dil seçimi
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Güvenlik Ayarları
          const Text(
            'Güvenlik',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.lock),
                  title: const Text('Gizlilik ve Güvenlik'),
                  subtitle: const Text('Güvenlik ayarlarını yönet'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // Güvenlik ayarları
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.password),
                  title: const Text('Şifre Değiştir'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // Şifre değiştirme
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Diğer
          const Text(
            'Diğer',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('Hakkında'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationName: 'Teknik Servis',
                      applicationVersion: '1.0.0',
                      applicationIcon: const FlutterLogo(),
                      children: const [
                        Text('Teknik Servis uygulaması tüm haklarını saklı tutar.'),
                      ],
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.help),
                  title: const Text('Yardım ve Destek'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // Yardım sayfası
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text('Çıkış Yap',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Çıkış Yap'),
                        content: const Text('Çıkış yapmak istediğinizden emin misiniz?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('İptal'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Çıkış işlemleri
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginPage()),
                                    (route) => false,
                              );
                            },
                            child: const Text('Çıkış Yap',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Versiyon Bilgisi
          const Center(
            child: Text(
              'Version 1.0.0',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class ServiceHistoryPage extends StatefulWidget {
  const ServiceHistoryPage({super.key});

  @override
  State<ServiceHistoryPage> createState() => _ServiceHistoryPageState();
}

class _ServiceHistoryPageState extends State<ServiceHistoryPage> {
  String _selectedFilter = 'Tümü';
  String _searchQuery = '';

  final List<Map<String, dynamic>> serviceHistory = [
    {
      'date': '2024-02-20',
      'type': 'Periyodik Bakım',
      'cost': '1500₺',
      'status': 'Tamamlandı',
      'details': 'Yağ değişimi ve filtre kontrolü yapıldı.',
      'technician': 'Mehmet Yılmaz',
      'parts': ['Motor Yağı', 'Yağ Filtresi', 'Hava Filtresi'],
      'warranty': '6 ay',
      'nextService': '2024-08-20',
      'kilometer': '45.000 km',
      'duration': '2 saat',
      'photos': ['photo1.jpg', 'photo2.jpg'],
    },
    {
      'date': '2023-12-10',
      'type': 'Fren Sistemi Onarımı',
      'cost': '2500₺',
      'status': 'Bekliyor',
      'details': 'Ön fren balataları değiştirilecek.',
      'technician': 'Ali Demir',
      'parts': ['Fren Balataları', 'Fren Diski'],
      'warranty': '1 yıl',
      'nextService': '2024-12-10',
      'kilometer': '42.000 km',
      'duration': 'Beklemede',
      'photos': [],
    },
    {
      'date': '2023-08-05',
      'type': 'Klima Gazı Dolumu',
      'cost': '750₺',
      'status': 'Tamamlandı',
      'details': 'Klima gazı yenilendi ve sistem kontrol edildi.',
      'technician': 'Ayşe Kaya',
      'parts': ['Klima Gazı'],
      'warranty': '3 ay',
      'nextService': '2024-08-05',
      'kilometer': '38.000 km',
      'duration': '1 saat',
      'photos': ['photo3.jpg'],
    },
  ];

  List<Map<String, dynamic>> get filteredHistory {
    return serviceHistory.where((service) {
      final matchesFilter = _selectedFilter == 'Tümü' ||
          service['status'] == _selectedFilter;
      final matchesSearch = service['type']
          .toLowerCase()
          .contains(_searchQuery.toLowerCase()) ||
          service['details']
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());
      return matchesFilter && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Servis Geçmişi'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterOptions(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Arama Çubuğu
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Servis kaydı ara...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          // Özet Kartları
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    'Toplam Servis',
                    serviceHistory.length.toString(),
                    Icons.build,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildSummaryCard(
                    'Tamamlanan',
                    serviceHistory
                        .where((s) => s['status'] == 'Tamamlandı')
                        .length
                        .toString(),
                    Icons.check_circle,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildSummaryCard(
                    'Bekleyen',
                    serviceHistory
                        .where((s) => s['status'] == 'Bekliyor')
                        .length
                        .toString(),
                    Icons.pending,
                    Colors.orange,
                  ),
                ),
              ],
            ),
          ),

          // Servis Listesi
          Expanded(
            child: ListView.builder(
              itemCount: filteredHistory.length,
              itemBuilder: (context, index) {
                final service = filteredHistory[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  child: ExpansionTile(
                    leading: CircleAvatar(
                      backgroundColor: service['status'] == 'Tamamlandı'
                          ? Colors.green
                          : Colors.orange,
                      child: Icon(
                        service['status'] == 'Tamamlandı'
                            ? Icons.check
                            : Icons.pending,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      service['type'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${service['date']} - ${service['cost']}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetailRow('Teknisyen', service['technician']),
                            _buildDetailRow('Detaylar', service['details']),
                            _buildDetailRow('Garanti', service['warranty']),
                            _buildDetailRow(
                                'Sonraki Servis', service['nextService']),
                            _buildDetailRow('Kilometre', service['kilometer']),
                            _buildDetailRow('Süre', service['duration']),
                            const SizedBox(height: 8),
                            const Text(
                              'Kullanılan Parçalar:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Wrap(
                              spacing: 8,
                              children: (service['parts'] as List)
                                  .map((part) => Chip(
                                label: Text(part),
                                backgroundColor: Colors.blue[100],
                              ))
                                  .toList(),
                            ),
                            if (service['photos'].isNotEmpty) ...[
                              const SizedBox(height: 8),
                              const Text(
                                'Fotoğraflar:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              SizedBox(
                                height: 100,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: service['photos'].length,
                                  itemBuilder: (context, photoIndex) {
                                    return Card(
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        color: Colors.grey[300],
                                        child: const Icon(Icons.photo),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton.icon(
                                  icon: const Icon(Icons.share),
                                  label: const Text('Paylaş'),
                                  onPressed: () {
                                    // Paylaşım işlemi
                                  },
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.print),
                                  label: const Text('Yazdır'),
                                  onPressed: () {
                                    // Yazdırma işlemi
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
      String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(fontSize: 12),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Filtreleme Seçenekleri',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ...['Tümü', 'Tamamlandı', 'Bekliyor'].map(
                    (filter) => ListTile(
                  title: Text(filter),
                  leading: Radio<String>(
                    value: filter,
                    groupValue: _selectedFilter,
                    onChanged: (value) {
                      setState(() {
                        _selectedFilter = value!;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Randevu Al'),
      ),
      body: const Center(
        child: Text('Randevu Al Sayfası'),
      ),
    );
  }

class _AppointmentPageState extends State<AppointmentPage> {
  String? selectedService;
  String? selectedVehicle;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _kmController = TextEditingController();

  // Örnek veriler
  final List<Map<String, dynamic>> services = [
    {
      'name': 'Periyodik Bakım',
      'icon': Icons.build,
      'duration': '2 saat',
      'price': '1500₺'
    },
    {
      'name': 'Yağ Değişimi',
      'icon': Icons.oil_barrel,
      'duration': '1 saat',
      'price': '800₺'
    },
    {
      'name': 'Fren Kontrolü',
      'icon': Icons.add_alert_rounded,
      'duration': '1.5 saat',
      'price': '600₺'
    },
    {
      'name': 'Klima Bakımı',
      'icon': Icons.ac_unit,
      'duration': '1 saat',
      'price': '500₺'
    },
    {
      'name': 'Lastik Değişimi',
      'icon': Icons.tire_repair,
      'duration': '45 dakika',
      'price': '400₺'
    },
  ];

  final List<String> vehicles = [
    'Toyota Corolla (34 ABC 123)',
    'Honda Civic (34 XYZ 789)',
  ];

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        selectedTime = null; // Tarih değiştiğinde saati sıfırla
      });
    }
  }

  Future<void> _selectTime() async {
    if (selectedDate == null) {
      _showMessage('Lütfen önce tarih seçin');
      return;
    }

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: const TimePickerThemeData(
              backgroundColor: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      // Mesai saatleri kontrolü (09:00 - 18:00)
      if (picked.hour < 9 || picked.hour >= 18) {
        _showMessage('Lütfen 09:00 - 18:00 arası bir saat seçin');
        return;
      }
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _confirmAppointment() {
    if (selectedService == null ||
        selectedVehicle == null ||
        selectedDate == null ||
        selectedTime == null ||
        _kmController.text.isEmpty) {
      _showMessage('Lütfen tüm zorunlu alanları doldurun!');
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Randevu Onayı'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Araç', selectedVehicle!),
              _buildDetailRow('Hizmet', selectedService!),
              _buildDetailRow('Tarih',
                  '${selectedDate!.toLocal().toString().split(' ')[0]}'),
              _buildDetailRow('Saat', selectedTime!.format(context)),
              _buildDetailRow('Kilometre', '${_kmController.text} km'),
              if (_noteController.text.isNotEmpty)
                _buildDetailRow('Not', _noteController.text),
              const Divider(),
              _buildDetailRow(
                  'Tahmini Süre',
                  services
                      .firstWhere((s) => s['name'] == selectedService)['duration']
                      .toString()),
              _buildDetailRow(
                  'Tahmini Ücret',
                  services
                      .firstWhere((s) => s['name'] == selectedService)['price']
                      .toString()),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessDialog();
            },
            child: const Text('Onayla'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 10),
            Text('Randevu Alındı'),
          ],
        ),
        content: const Text('Randevunuz başarıyla oluşturuldu. Randevu detayları SMS ve e-posta ile gönderilecektir.'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Ana sayfaya dön
            },
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
  Widget _hizliIslemButonu(BuildContext context,String text, IconData icon, Color color) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: color,
          child: IconButton(
            icon: Icon(icon, color: Colors.white),
            onPressed: () {
              // Sayfa yönlendirmelerini burada yapıyoruz
              if (text == 'Randevu Al') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AppointmentPage()),
                );
              } else if (text == 'Servis Çağır') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ServisCagirSayfasi()),
                );
              } else if (text == 'Bilgi') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BilgiSayfasi()),
                );
              }
            },
          ),
        ),
        const SizedBox(height: 5),
        Text(text),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Randevu Al'),
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Üst bilgi kartı
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Randevunuzu en az 24 saat öncesinden oluşturmanızı rica ederiz.',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Araç Seçimi
                  const Text(
                    'Araç Seçin',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: selectedVehicle,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.directions_car),
                    ),
                    hint: const Text('Araç seçin'),
                    items: vehicles.map((vehicle) {
                      return DropdownMenuItem(
                        value: vehicle,
                        child: Text(vehicle),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedVehicle = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),

                  // Hizmet Seçimi
                  const Text(
                    'Hizmet Seçin',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: services.length,
                    itemBuilder: (context, index) {
                      final service = services[index];
                      final isSelected = service['name'] == selectedService;
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedService = service['name'];
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                            isSelected ? Colors.blue.shade100 : Colors.white,
                            border: Border.all(
                              color: isSelected
                                  ? Colors.blue
                                  : Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                service['icon'],
                                color: isSelected ? Colors.blue : Colors.grey,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                service['name'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isSelected ? Colors.blue : Colors.black,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                              Text(
                                service['price'],
                                style: TextStyle(
                                  color: isSelected ? Colors.blue : Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Tarih ve Saat Seçimi
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tarih',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            InkWell(
                              onTap: _selectDate,
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.calendar_today),
                                    const SizedBox(width: 8),
                                    Text(
                                      selectedDate == null
                                          ? 'Tarih Seçin'
                                          : '${selectedDate!.toLocal()}'
                                          .split(' ')[0],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Saat',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            InkWell(
                              onTap: _selectTime,
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.access_time),
                                    const SizedBox(width: 8),
                                    Text(
                                      selectedTime == null
                                          ? 'Saat Seçin'
                                          : selectedTime!.format(context),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Kilometre Bilgisi
                  const Text(
                    'Güncel Kilometre',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _kmController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Güncel kilometre bilgisi',
                      suffixText: 'km',
                      prefixIcon: const Icon(Icons.speed),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Not Alanı
                  const Text(
                    'Ek Notlar (İsteğe Bağlı)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _noteController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Eklemek istediğiniz notları yazın',
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Randevu Al Butonu
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _confirmAppointment,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Randevu Al',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServisCagirSayfasi extends StatefulWidget {
  @override
  State<ServisCagirSayfasi> createState() => _ServisCagirSayfasiState();
}

class _ServisCagirSayfasiState extends State<ServisCagirSayfasi> {
  final _formKey = GlobalKey<FormState>();
  final _konumController = TextEditingController();
  final _aciklamaController = TextEditingController();
  String? _selectedProblem;
  bool _isUrgent = false;

  final List<Map<String, dynamic>> _problemTipleri = [
    {
      'title': 'Motor Arızası',
      'icon': Icons.engineering,
      'color': Colors.red,
    },
    {
      'title': 'Lastik Sorunu',
      'icon': Icons.tire_repair,
      'color': Colors.orange,
    },
    {
      'title': 'Akü Problemi',
      'icon': Icons.battery_alert,
      'color': Colors.yellow,
    },
    {
      'title': 'Kaza/Hasar',
      'icon': Icons.car_crash,
      'color': Colors.red,
    },
    {
      'title': 'Yakıt Bitti',
      'icon': Icons.local_gas_station,
      'color': Colors.green,
    },
    {
      'title': 'Diğer',
      'icon': Icons.build,
      'color': Colors.blue,
    },
  ];

  void _servisCagir() {
    if (_formKey.currentState!.validate()) {
      // Servis çağırma işlemi burada yapılacak
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.green),
              const SizedBox(width: 10),
              const Text('Servis Çağrınız Alındı'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Servis ekibimiz en kısa sürede size ulaşacaktır.'),
              const SizedBox(height: 10),
              Text('Tahmini varış süresi: 30 dakika'),
              const SizedBox(height: 10),
              const Text('Servis detayları SMS ile gönderilecektir.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tamam'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yol Yardımı Çağır'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bilgi Kartı
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue.shade100),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue.shade700),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Acil yol yardımı için konumunuzu ve sorununuzu belirtin. '
                              'Ekiplerimiz en kısa sürede size ulaşacaktır.',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Problem Tipi Seçimi
                const Text(
                  'Sorun Türü',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: _problemTipleri.length,
                  itemBuilder: (context, index) {
                    final problem = _problemTipleri[index];
                    final isSelected = problem['title'] == _selectedProblem;
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedProblem = problem['title'];
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? problem['color'].withOpacity(0.1)
                              : Colors.grey.shade50,
                          border: Border.all(
                            color: isSelected
                                ? problem['color']
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              problem['icon'],
                              color: problem['color'],
                              size: 32,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              problem['title'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isSelected
                                    ? problem['color']
                                    : Colors.black87,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                // Konum Bilgisi
                TextFormField(
                  controller: _konumController,
                  decoration: InputDecoration(
                    labelText: 'Konum',
                    hintText: 'Mevcut konumunuz',
                    prefixIcon: const Icon(Icons.location_on),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.my_location),
                      onPressed: () {
                        // Konum alma işlemi
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen konum bilgisi girin';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Açıklama
                TextFormField(
                  controller: _aciklamaController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Açıklama',
                    hintText: 'Sorununuzu kısaca açıklayın',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Acil Durum Switchi
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _isUrgent ? Colors.red.shade50 : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: _isUrgent ? Colors.red.shade200 : Colors.grey.shade300,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: _isUrgent ? Colors.red : Colors.grey,
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text('Acil Durum'),
                      ),
                      Switch(
                        value: _isUrgent,
                        onChanged: (value) {
                          setState(() {
                            _isUrgent = value;
                          });
                        },
                        activeColor: Colors.red,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Servis Çağır Butonu
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _servisCagir,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isUrgent ? Colors.red : Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _isUrgent ? Icons.warning : Icons.car_repair,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          _isUrgent ? 'ACİL SERVİS ÇAĞIR' : 'SERVİS ÇAĞIR',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _konumController.dispose();
    _aciklamaController.dispose();
    super.dispose();
  }
}
class BilgiSayfasi extends StatelessWidget {
  final List<Map<String, dynamic>> servisBilgileri = [
    {
      'baslik': 'Çalışma Saatleri',
      'icerik': 'Hafta içi: 08:00 - 18:00\nCumartesi: 09:00 - 16:00\nPazar: Kapalı',
      'icon': Icons.access_time,
      'color': Colors.blue,
    },
    {
      'baslik': 'İletişim',
      'icerik': 'Tel: (512) 123 45 67\nE-posta: info@teknikservis.com\nAdres: Teknoloji Mah. Servis Cad. No:1 Merkez/GAZİANTEP',
      'icon': Icons.contact_phone,
      'color': Colors.green,
    },
    {
      'baslik': 'Hizmetlerimiz',
      'icerik': '• Periyodik Bakım\n• Motor Tamiri\n• Elektrik Sistemleri\n• Fren Sistemleri\n• Klima Servisi\n• Yol Yardım',
      'icon': Icons.build,
      'color': Colors.orange,
    },
  ];

  final List<Map<String, dynamic>> sikSorulanSorular = [
    {
      'soru': 'Randevu almadan gelebilir miyim?',
      'cevap': 'Acil durumlar dışında randevu almanızı öneririz. Böylece bekleme sürenizi minimumda tutabiliriz.',
    },
    {
      'soru': 'Yedek parça garantisi var mı?',
      'cevap': 'Kullandığımız tüm yedek parçalar orijinal olup 2 yıl garantilidir.',
    },
    {
      'soru': 'Servis ücreti nasıl hesaplanır?',
      'cevap': 'Servis ücretleri yapılan işlem ve kullanılan parçalara göre değişiklik gösterir. İşlem öncesi detaylı fiyat bilgisi verilir.',
    },
    {
      'soru': 'Araç takip sisteminiz var mı?',
      'cevap': 'Evet, servisimize gelen tüm araçlar için online takip sistemi mevcuttur.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Servis Bilgileri'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Üst Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade700, Colors.blue.shade900],
                ),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.car_repair,
                    size: 50,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Profesyonel Teknik Servis',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '20 Yıllık Tecrübe',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            // Servis Bilgileri
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Servis Bilgileri',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...servisBilgileri.map((bilgi) => _buildBilgiKarti(bilgi)).toList(),

                  const SizedBox(height: 20),

                  // Sık Sorulan Sorular
                  const Text(
                    'Sık Sorulan Sorular',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...sikSorulanSorular.map((soru) => _buildSoruKarti(soru)).toList(),

                  const SizedBox(height: 20),

                  // Kalite Belgeleri
                  _buildKaliteBelgeleri(),

                  const SizedBox(height: 20),

                  // Sosyal Medya Linkleri
                  _buildSosyalMedya(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Whatsapp veya telefon ile iletişim
          _iletisimeGec(context);
        },
        icon: const Icon(Icons.phone_android),
        label: const Text('Hızlı İletişim'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _buildBilgiKarti(Map<String, dynamic> bilgi) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              bilgi['icon'],
              size: 24,
              color: bilgi['color'],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bilgi['baslik'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    bilgi['icerik'],
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSoruKarti(Map<String, dynamic> soru) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ExpansionTile(
        title: Text(
          soru['soru'],
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              soru['cevap'],
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKaliteBelgeleri() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Kalite Belgeleri',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildBelgeKarti('ISO 9001', Icons.verified_user),
            _buildBelgeKarti('TSE', Icons.library_add_check_rounded),
            _buildBelgeKarti('OHSAS', Icons.security),
          ],
        ),
      ],
    );
  }

  Widget _buildBelgeKarti(String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(height: 5),
          Text(title),
        ],
      ),
    );
  }

  Widget _buildSosyalMedya() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sosyal Medya',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSosyalMedyaButon(Icons.facebook, Colors.blue),
            _buildSosyalMedyaButon(Icons.phone_callback, Colors.red),
          ],
        ),
      ],
    );
  }

  Widget _buildSosyalMedyaButon(IconData icon, Color color) {
    return IconButton(
      icon: Icon(icon),
      color: color,
      onPressed: () {
        // Sosyal medya linkine yönlendirme
      },
    );
  }

  void _iletisimeGec(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.blue),
              title: const Text('Telefon ile Ara'),
              onTap: () {
                // Telefon ile arama
              },
            ),
            ListTile(
              leading: const Icon(Icons.telegram, color: Colors.green),
              title: const Text('WhatsApp ile Mesaj'),
              onTap: () {
                // WhatsApp ile mesaj
              },
            ),
          ],
        ),
      ),
    );
  }
}
class BildirimlerSayfasi extends StatelessWidget {
  // Örnek bildirim verileri
  final List<BildirimModel> bildirimler = [
    BildirimModel(
      baslik: 'Bakım Hatırlatması',
      mesaj: 'Aracınızın periyodik bakım zamanı yaklaşıyor.',
      tarih: DateTime.now().subtract(const Duration(hours: 2)),
      tip: BildirimTipi.bakim,
      okundu: false,
    ),
    BildirimModel(
      baslik: 'Randevu Onayı',
      mesaj: '25 Mart 2024 14:30 tarihli randevunuz onaylanmıştır.',
      tarih: DateTime.now().subtract(const Duration(days: 1)),
      tip: BildirimTipi.randevu,
      okundu: true,
    ),
    BildirimModel(
      baslik: 'Kampanya',
      mesaj: 'Mart ayına özel işçilikte %20 indirim fırsatını kaçırmayın!',
      tarih: DateTime.now().subtract(const Duration(days: 2)),
      tip: BildirimTipi.kampanya,
      okundu: true,
    ),
    BildirimModel(
      baslik: 'ÖNEMLİ!!!',
      mesaj: 'Periyodik bakımınız başarıyla tamamlanmıştır.!',
      tarih: DateTime.now().subtract(const Duration(days: 2)),
      tip: BildirimTipi.kampanya,
      okundu: true,
    ),
    // Daha fazla bildirim eklenebilir
  ];

  BuildContext? get context => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bildirimler'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'tumu',
                child: Text('Tümünü Okundu İşaretle'),
              ),
              const PopupMenuItem(
                value: 'sil',
                child: Text('Tümünü Temizle'),
              ),
            ],
            onSelected: (value) {
              // Seçilen işlemi gerçekleştir
            },
          ),
        ],
      ),
      body: bildirimler.isEmpty
          ? _buildBosbildirim()
          : ListView.builder(
        itemCount: bildirimler.length,
        itemBuilder: (context, index) {
          return _buildBildirimKarti(bildirimler[index]);
        },
      ),
    );
  }

  Widget _buildBosbildirim() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Bildiriminiz Bulunmuyor',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Yeni bildirimleriniz burada görünecek',
            style: TextStyle(
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBildirimKarti(BildirimModel bildirim) {
    return Dismissible(
      key: Key(bildirim.baslik),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        // Bildirimi sil
      },
      child: Card(
        elevation: bildirim.okundu ? 0 : 2,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        color: bildirim.okundu ? null : Colors.blue.shade50,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _getBildirimRengi(bildirim.tip).withOpacity(0.2),
            child: Icon(
              _getBildirimIkonu(bildirim.tip),
              color: _getBildirimRengi(bildirim.tip),
            ),
          ),
          title: Text(
            bildirim.baslik,
            style: TextStyle(
              fontWeight: bildirim.okundu ? FontWeight.normal : FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(bildirim.mesaj),
              const SizedBox(height: 4),
              Text(
                _formatTarih(bildirim.tarih),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          trailing: bildirim.okundu
              ? null
              : Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
          onTap: () {
            // Bildirim detayını göster
            _showBildirimDetay(context!, bildirim);
          },
        ),
      ),
    );
  }

  void _showBildirimDetay(BuildContext context, BildirimModel bildirim) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: _getBildirimRengi(bildirim.tip).withOpacity(0.2),
                  child: Icon(
                    _getBildirimIkonu(bildirim.tip),
                    color: _getBildirimRengi(bildirim.tip),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    bildirim.baslik,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              bildirim.mesaj,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              _formatTarih(bildirim.tarih),
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 16),
            if (!bildirim.okundu)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Bildirimi okundu olarak işaretle
                    Navigator.pop(context);
                  },
                  child: const Text('Okundu Olarak İşaretle'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getBildirimRengi(BildirimTipi tip) {
    switch (tip) {
      case BildirimTipi.bakim:
        return Colors.orange;
      case BildirimTipi.randevu:
        return Colors.green;
      case BildirimTipi.kampanya:
        return Colors.purple;
      default:
        return Colors.blue;
    }
  }

  IconData _getBildirimIkonu(BildirimTipi tip) {
    switch (tip) {
      case BildirimTipi.bakim:
        return Icons.build;
      case BildirimTipi.randevu:
        return Icons.calendar_today;
      case BildirimTipi.kampanya:
        return Icons.local_offer;
      default:
        return Icons.notifications;
    }
  }

  String _formatTarih(DateTime tarih) {
    final now = DateTime.now();
    final difference = now.difference(tarih);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes} dakika önce';
      }
      return '${difference.inHours} saat önce';
    } else if (difference.inDays == 1) {
      return 'Dün';
    }
    return '${tarih.day}/${tarih.month}/${tarih.year}';
  }
}

enum BildirimTipi { bakim, randevu, kampanya }

class BildirimModel {
  final String baslik;
  final String mesaj;
  final DateTime tarih;
  final BildirimTipi tip;
  bool okundu;

  BildirimModel({
    required this.baslik,
    required this.mesaj,
    required this.tarih,
    required this.tip,
    this.okundu = false,
  });
}

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _resetPassword() {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      Future.delayed(const Duration(seconds: 2), () {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Şifre sıfırlama kodu telefonunuza gönderildi!"))
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Şifremi Unuttum')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Şifrenizi mi unuttunuz?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Kayıtlı telefon numaranızı girin, size şifrenizi sıfırlamak için bir kod gönderelim.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Telefon Numarası',
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen bir telefon numarası girin';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _resetPassword,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                    'Sıfırlama Kodu Gönder',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Geri Dön'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool isPasswordVisible = false;

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      Future.delayed(const Duration(seconds: 2), () {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Kayıt başarılı!"))
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kayıt Ol')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Yeni Hesap Oluştur',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Ad Soyad',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Adınızı girin'
                    : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Kullanıcı Adı',
                  prefixIcon: const Icon(Icons.supervised_user_circle),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Kullanıcı Adını giriniz'
                    : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Telefon',
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) => (value == null || value.length < 10)
                    ? 'Geçerli bir telefon numarası girin'
                    : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: passwordController,
                obscureText: !isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Şifre',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) => (value == null || value.length < 6)
                    ? 'Şifre en az 6 karakter olmalı'
                    : null,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _signUp,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                    'Kayıt Ol',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Zaten bir hesabınız var mı?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Giriş Yap'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

