import 'package:flutter/material.dart';

class TopHeader extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;
  final Function(String) onSearch;
  final VoidCallback? onUndo; // زرار "إرجاع"

  const TopHeader({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.onSearch,
    this.onUndo,
  });

  static const List<String> categories = [
    'الكل', 'مواد غذائية', 'مشروبات', 'ألبان', 'منظفات', 'مخبوزات',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: const Color(0xFF141414),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              if (onUndo != null)
                ElevatedButton.icon(
                  onPressed: onUndo,
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text('إرجاع'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3A1F1F),
                    foregroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  textAlign: TextAlign.right,
                  onChanged: onSearch,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'بحث بالاسم أو امسح الباركود...',
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: const Color(0xFF1E1E1E),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // فلاتر التصنيفات
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              reverse: true, // عشان الترتيب يبقى من اليمين للشمال
              children: categories.map((cat) {
                final bool isSelected = cat == selectedCategory;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (_) => onCategorySelected(cat),
                    selectedColor: const Color(0xFFD4A017),
                    backgroundColor: const Color(0xFF1E1E1E),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.black : Colors.white70,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide.none,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}