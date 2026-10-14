import 'package:flutter/material.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  static const red = Color(0xFFC62828);
  static const darkRed = Color(0xFF8E1717);
  static const background = Color(0xFFFFF7F7);

  final searchController = TextEditingController();
  String selectedCategory = 'All';

  final categories = const [
    'All',
    'Heart',
    'Diabetes',
    'First Aid',
    'Prevention',
  ];

  final articles = const [
    {
      'title': 'Heart Attack',
      'subtitle': 'Serangan Jantung',
      'category': 'Heart',
      'icon': Icons.favorite_rounded,
      'color': Color(0xFFFFE1E1),
      'summary':
          'A heart attack happens when blood flow to part of the heart muscle is blocked.',
      'sections': [
        'What is a heart attack?',
        'A heart attack (serangan jantung) occurs when blood flow to part of the heart muscle is severely reduced or blocked, often because of a blood clot forming over a fatty plaque in a coronary artery.',
        'Common warning signs',
        '• Chest pressure, tightness, or discomfort.\n'
            '• Pain or discomfort in one or both arms, the back, neck, jaw, or upper abdomen.\n'
            '• Shortness of breath, cold sweat, nausea, or light-headedness.\n'
            'Symptoms can vary. Some people have mild or less typical symptoms.',
        'Risk factors',
        'Smoking, high blood pressure, high LDL cholesterol, diabetes, physical inactivity, and a family history of early heart disease can increase risk.',
        'What should you do?',
        'If you suspect a heart attack, contact local emergency medical services immediately. Do not wait to see whether symptoms disappear. Keep the person resting and follow the emergency dispatcher’s instructions.',
        'Remember',
        'A heart attack is not the same as cardiac arrest. A heart attack is a circulation problem; cardiac arrest occurs when the heart suddenly stops pumping effectively.',
      ],
    },
    {
      'title': 'Understanding Diabetes',
      'subtitle': 'Mengenal Diabetes',
      'category': 'Diabetes',
      'icon': Icons.bloodtype_rounded,
      'color': Color(0xFFFFE9D6),
      'summary':
          'Diabetes is a condition in which blood glucose stays too high.',
      'sections': [
        'What is diabetes?',
        'Diabetes (diabetes melitus) is a long-term condition involving problems with insulin production or how the body uses insulin. Insulin helps glucose move from the blood into cells.',
        'Why can it happen?',
        'Type 1 diabetes is an autoimmune condition in which the immune system attacks insulin-producing cells. It is not caused by eating too much sugar.\n\n'
            'Type 2 diabetes develops when the body becomes less responsive to insulin and/or cannot produce enough insulin. Genetics, age, body factors, and lifestyle can all contribute.',
        'Possible symptoms',
        '• Frequent urination.\n'
            '• Feeling very thirsty or hungry.\n'
            '• Unusual tiredness.\n'
            '• Blurred vision.\n'
            '• Unintentional weight loss, especially in some cases of type 1 diabetes.\n'
            'Some people with type 2 diabetes have no obvious symptoms.',
        'How to reduce risk?',
        'For type 2 diabetes, regular physical activity, balanced meals, adequate sleep, and health checks when recommended can help reduce risk. Type 1 diabetes cannot currently be prevented through lifestyle changes.',
        'Important',
        'Symptoms alone cannot confirm diabetes. A healthcare professional uses blood tests to make a diagnosis.',
      ],
    },
    {
      'title': 'Stroke Awareness',
      'subtitle': 'Kenali Stroke Sejak Dini',
      'category': 'Heart',
      'icon': Icons.psychology_alt_rounded,
      'color': Color(0xFFE8E5FF),
      'summary':
          'A stroke occurs when blood supply to part of the brain is interrupted or bleeding occurs.',
      'sections': [
        'What is a stroke?',
        'Stroke happens when a blood vessel supplying the brain is blocked or bursts. Brain cells can be damaged quickly, so urgent treatment matters.',
        'Remember BE FAST',
        'B — Balance: sudden loss of balance.\n'
            'E — Eyes: sudden vision changes.\n'
            'F — Face: one side of the face droops.\n'
            'A — Arms: one arm becomes weak.\n'
            'S — Speech: speech becomes slurred or difficult.\n'
            'T — Time: call emergency services immediately.',
        'What should you do?',
        'Note the time symptoms began, stay with the person, and follow emergency dispatcher instructions. Do not give food, drinks, or medication unless directed by a qualified professional.',
        'Do not wait',
        'Even if symptoms disappear after a few minutes, urgent medical assessment is still needed.',
      ],
    },
    {
      'title': 'CPR Basics',
      'subtitle': 'Dasar-Dasar CPR / RJP',
      'category': 'First Aid',
      'icon': Icons.health_and_safety_rounded,
      'color': Color(0xFFDDF5E8),
      'summary':
          'CPR helps maintain blood flow when someone is in cardiac arrest.',
      'sections': [
        'What is CPR?',
        'CPR (cardiopulmonary resuscitation), also called RJP in Indonesian, is an emergency procedure used when a person is unresponsive and not breathing normally.',
        'First-response priorities',
        '1. Make sure the scene is safe.\n'
            '2. Check responsiveness and breathing.\n'
            '3. Call local emergency services and ask someone to get an AED if available.\n'
            '4. If the person is unresponsive and not breathing normally, begin CPR according to your training and the dispatcher’s instructions.',
        'Use an AED',
        'An automated external defibrillator (AED) provides voice instructions. Turn it on and follow its prompts as soon as it is available.',
        'Learn hands-on',
        'CPR is best learned through practical training from a recognized first-aid or resuscitation provider. Follow your local guidelines and emergency dispatcher.',
      ],
    },
    {
      'title': 'Healthy Heart Habits',
      'subtitle': 'Kebiasaan untuk Jantung Sehat',
      'category': 'Prevention',
      'icon': Icons.monitor_heart_rounded,
      'color': Color(0xFFFFE5EF),
      'summary':
          'Small, consistent habits can support heart health over time.',
      'sections': [
        'Build healthy habits',
        '• Eat a variety of vegetables, fruit, whole grains, and other nutritious foods.\n'
            '• Be physically active regularly, at a level suitable for your health.\n'
            '• Avoid smoking and vaping.\n'
            '• Get enough sleep.\n'
            '• Manage stress in healthy ways.',
        'Know your numbers',
        'Blood pressure, cholesterol, and blood glucose checks can help identify risk factors early. Ask a healthcare professional how often you need screening.',
        'Consistency matters',
        'You do not need to change everything at once. Start with realistic habits and build them gradually.',
      ],
    },
    {
      'title': 'First Aid: Burns',
      'subtitle': 'Pertolongan Pertama pada Luka Bakar',
      'category': 'First Aid',
      'icon': Icons.local_fire_department_rounded,
      'color': Color(0xFFFFE9D6),
      'summary':
          'Prompt, appropriate first aid can reduce further damage from a burn.',
      'sections': [
        'Immediate care',
        'Move away from the heat source if it is safe. Cool the burn under cool running water for 20 minutes. Remove jewellery or clothing near the area unless it is stuck to the skin.',
        'What to avoid',
        'Do not apply ice, butter, toothpaste, or other home remedies. Do not pull away material stuck to the burn.',
        'When to seek urgent care',
        'Get urgent medical help for large or deep burns, chemical or electrical burns, burns affecting the face or airway, or burns in other high-risk areas. If you are unsure, seek professional advice.',
      ],
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get filteredArticles {
    final query = searchController.text.trim().toLowerCase();

    return articles.where((article) {
      final categoryMatches = selectedCategory == 'All' ||
          article['category'] == selectedCategory;

      final text = [
        article['title'],
        article['subtitle'],
        article['summary'],
        article['category'],
      ].join(' ').toLowerCase();

      return categoryMatches && text.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final items = filteredArticles;

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.fromLTRB(22, 24, 22, 27),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [darkRed, red, Color(0xFFE65353)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.health_and_safety_rounded,
                          color: Colors.white,
                          size: 29,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'MEDICAL LEARNING HUB',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Understand your health.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.w900,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      'Learn the signs. Know what to do.\nBelajar medis, selangkah demi selangkah.',
                      style: TextStyle(
                        color: Color(0xFFFFE9E9),
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: searchController,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: 'Search topics / Cari topik...',
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: red,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 23, 20, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Explore topics',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF29242A),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Choose a topic to start learning.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF77717A),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 40,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          final selected =
                              selectedCategory == category;

                          return ChoiceChip(
                            label: Text(category),
                            selected: selected,
                            onSelected: (_) {
                              setState(() {
                                selectedCategory = category;
                              });
                            },
                            selectedColor: red,
                            backgroundColor: Colors.white,
                            labelStyle: TextStyle(
                              color: selected
                                  ? Colors.white
                                  : const Color(0xFF5F5660),
                              fontWeight: FontWeight.w700,
                            ),
                            side: BorderSide(
                              color: selected
                                  ? red
                                  : const Color(0xFFF0D9D9),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (items.isEmpty)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(
                    child: Text(
                      'No topics found. Try another search.\nTopik tidak ditemukan.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 9, 20, 26),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final article = items[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 13),
                        child: Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => LearnArticleScreen(
                                    article: article,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xFFF2E5E5),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 54,
                                    height: 54,
                                    decoration: BoxDecoration(
                                      color: article['color'] as Color,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Icon(
                                      article['icon'] as IconData,
                                      color: red,
                                      size: 28,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          article['category'] as String,
                                          style: const TextStyle(
                                            color: red,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: 0.8,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          article['title'] as String,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFF29242A),
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          article['subtitle'] as String,
                                          style: const TextStyle(
                                            color: Color(0xFF77717A),
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          article['summary'] as String,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Color(0xFF5F5962),
                                            fontSize: 12,
                                            height: 1.45,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.chevron_right_rounded,
                                    color: Color(0xFFB5A7A7),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: items.length,
                  ),
                ),
              ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 28),
                child: Text(
                  'Educational content only — not a diagnosis or a substitute for professional medical care. In an emergency, contact your local emergency service.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF8C7777),
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LearnArticleScreen extends StatelessWidget {
  const LearnArticleScreen({
    super.key,
    required this.article,
  });

  final Map<String, dynamic> article;

  static const red = Color(0xFFC62828);
  static const darkRed = Color(0xFF8E1717);

  @override
  Widget build(BuildContext context) {
    final sections = article['sections'] as List<String>;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7F7),
      appBar: AppBar(
        backgroundColor: darkRed,
        foregroundColor: Colors.white,
        title: const Text(
          'Medical Learning',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [darkRed, red],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(23),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  article['icon'] as IconData,
                  color: Colors.white,
                  size: 38,
                ),
                const SizedBox(height: 15),
                Text(
                  article['title'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  article['subtitle'] as String,
                  style: const TextStyle(
                    color: Color(0xFFFFE6E6),
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          for (int i = 0; i < sections.length; i += 2)
            if (i + 1 < sections.length)
              Container(
                margin: const EdgeInsets.only(bottom: 13),
                padding: const EdgeInsets.all(17),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xFFF2E5E5),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sections[i],
                      style: const TextStyle(
                        color: darkRed,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 9),
                    Text(
                      sections[i + 1],
                      style: const TextStyle(
                        color: Color(0xFF49434A),
                        height: 1.65,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE8E8),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: darkRed,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'This article is for education only. It cannot diagnose a condition or replace professional medical advice. For suspected emergencies, call local emergency services immediately.',
                    style: TextStyle(
                      color: darkRed,
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
