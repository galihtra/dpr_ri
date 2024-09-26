import 'package:dpr_ri/data/models/deskripsi_konsepsi.dart';
import 'package:dpr_ri/data/service/ruu/api_service_ruu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import for professional fonts
import '../data/models/detail_ruu.dart';

class RuuDetailScreen extends StatefulWidget {
  final String ruuId;

  RuuDetailScreen({required this.ruuId});

  @override
  _RuuDetailScreenState createState() => _RuuDetailScreenState();
}

class _RuuDetailScreenState extends State<RuuDetailScreen> {
  late Future<RuuDetail> futureRuuDetail;

  @override
  void initState() {
    super.initState();
    futureRuuDetail = ApiService().fetchRuuDetail(widget.ruuId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail RUU',
          style: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<RuuDetail>(
        future: futureRuuDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.red)));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No detail available'));
          } else {
            final ruuDetail = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Card for Title and Basic Information
                    _buildCard(
                      title: 'Judul',
                      content: ruuDetail.judul.isNotEmpty ? ruuDetail.judul : 'Data not available',
                      icon: Icons.article,
                    ),
                    const SizedBox(height: 10),
                    _buildCard(
                      title: 'Tanggal Pengusulan',
                      content: ruuDetail.tanggalPengusulan.isNotEmpty ? ruuDetail.tanggalPengusulan : 'Data not available',
                      icon: Icons.calendar_today,
                    ),

                    // Pengusul Section with Divider
                    const SizedBox(height: 20),
                    const Text('Pengusul', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const Divider(thickness: 1.5),
                    if (ruuDetail.pengusul.isNotEmpty)
                      ...ruuDetail.pengusul.map(
                        (p) => _buildListTile(
                          leadingIcon: Icons.person,
                          title: p.namaPengusul.isNotEmpty ? p.namaPengusul : 'Data not available',
                          subtitle: '${p.subPengusul.isNotEmpty ? p.subPengusul : 'Data not available'} (${p.detailPengusul.isNotEmpty ? p.detailPengusul : 'Data not available'})',
                        ),
                      )
                    else
                      const Text('Data not available', style: TextStyle(color: Colors.red)),

                    const SizedBox(height: 20),
                    _buildCard(
                      title: 'Lingkup',
                      content: ruuDetail.lingkup.akd.isNotEmpty ? ruuDetail.lingkup.akd : 'Data not available',
                      icon: Icons.public,
                    ),
                    const SizedBox(height: 10),
                    _buildCard(
                      title: 'Status',
                      content: ruuDetail.status.isNotEmpty ? ruuDetail.status : 'Data not available',
                      icon: Icons.info,
                    ),
                    const SizedBox(height: 10),
                    _buildCard(
                      title: 'Keterangan',
                      content: ruuDetail.keterangan.isNotEmpty ? ruuDetail.keterangan : 'Data not available',
                      icon: Icons.note,
                    ),
                    const SizedBox(height: 10),
                    _buildCard(
                      title: 'Pembahasan',
                      content: ruuDetail.pembahasan.penjelasan.isNotEmpty ? ruuDetail.pembahasan.penjelasan : 'Data not available',
                      icon: Icons.gavel,
                    ),
                    const SizedBox(height: 20),

                    // Deskripsi Konsepsi Section
                    const Text('Deskripsi Konsepsi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const Divider(thickness: 1.5),
                    _buildDeskripsiKonsepsi(ruuDetail.deskripsiKonsepsi),

                    // Rekam Jejak Section
                    const SizedBox(height: 20),
                    const Text('Rekam Jejak', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const Divider(thickness: 1.5),
                    if (ruuDetail.rekamJejak != null && ruuDetail.rekamJejak!.isNotEmpty)
                      ...ruuDetail.rekamJejak!.map(
                        (rekam) => _buildListTile(
                          leadingIcon: Icons.timeline,
                          title: 'Tahap: ${rekam.tahap.isNotEmpty ? rekam.tahap : 'Data not available'}',
                          subtitle: 'Agenda: ${rekam.agenda.isNotEmpty ? rekam.agenda : 'Data not available'}\n'
                                    'Tanggal: ${rekam.tanggal.isNotEmpty ? rekam.tanggal : 'Data not available'}\n'
                                    'Penjelasan: ${rekam.penjelasan.isNotEmpty ? rekam.penjelasan : 'Data not available'}',
                        ),
                      )
                    else
                      const Text('Data not available', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  // Helper method to create a professional looking card
  Widget _buildCard({required String title, required String content, required IconData icon}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 30, color: Theme.of(context).primaryColor),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(content, style: TextStyle(fontSize: 15)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to display list tiles for Pengusul and Rekam Jejak
  Widget _buildListTile({required IconData leadingIcon, required String title, required String subtitle}) {
    return ListTile(
      leading: Icon(leadingIcon, color: Theme.of(context).primaryColor),
      title: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
    );
  }

  // Helper method to build Deskripsi Konsepsi section
  Widget _buildDeskripsiKonsepsi(DeskripsiKonsepsi? deskripsiKonsepsi) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCard(
          title: 'Latar Belakang',
          content: deskripsiKonsepsi?.latarBelakangTujuan.isNotEmpty == true ? deskripsiKonsepsi!.latarBelakangTujuan : 'Data not available',
          icon: Icons.info_outline,
        ),
        const SizedBox(height: 10),
        _buildCard(
          title: 'Jangkauan Arah',
          content: deskripsiKonsepsi?.jangkauanArah.isNotEmpty == true ? deskripsiKonsepsi!.jangkauanArah : 'Data not available',
          icon: Icons.navigation,
        ),
        const SizedBox(height: 10),
        _buildCard(
          title: 'Dasar Pembentukan',
          content: deskripsiKonsepsi?.dasarPembentukan.isNotEmpty == true ? deskripsiKonsepsi!.dasarPembentukan : 'Data not available',
          icon: Icons.book,
        ),
      ],
    );
  }
}
