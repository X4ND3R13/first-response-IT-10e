import 'package:flutter/material.dart';

// ============================================================================
// 🛒 CARTSCREEN - KANTINKU STARTER TEMPLATE (Week 6: Navigation)
// Alta Global School | IT Grade 10 & 11 (SHS)
//
// 💡 PETUNJUK SISWA:
// Ini adalah halaman Keranjang / Checkout terakhir.
// Halaman ini menerima data dari MenuScreen melalui constructor.
// ============================================================================

class CartScreen extends StatelessWidget {
  final String userName;
  final String selectedItem;
  final String selectedPrice;

  const CartScreen({
    super.key,
    required this.userName,
    this.selectedItem = 'Lorem Ipsum',
    this.selectedPrice = 'Lorem Ipsum',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF092328),
      appBar: AppBar(
        automaticallyImplyLeading: false, // Disables the automatic back arrow button
        title: const Text(
          'lorem ipsum', // [GANTI DI SINI]: Judul halaman cart
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF12544F),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Lorem Ipsum',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8BBB92),
              ),
            ),
            const SizedBox(height: 20),

            // Item Card / Gallery Section
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.07),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF8BBB92),
                  child: Icon(Icons.image, color: Color(0xFF12544F)),
                ),
                title: Text(
                  selectedItem,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF092328),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Article Content / Longer Full Lorem Ipsum Text Block
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n\n'
                'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.\n\n'
                'Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur?\n\n'
                'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio.\n\n'
                'Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: Color(0xFF092328),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Action Button with Pop-up Dialog using real words
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF12544F),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // Tampilkan dialog konfirmasi
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Article Completed'),
                      content: Text(
                        'want to finish reading? "$selectedItem".',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Tutup dialog
                            Navigator.popUntil(
                              context,
                              (route) => route.isFirst,
                            ); // Kembali ke screen awal
                          },
                          child: const Text('yes'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text(
                  'done reading?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}