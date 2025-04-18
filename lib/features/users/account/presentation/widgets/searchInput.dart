import 'package:flutter/material.dart';

class SearchInput extends StatefulWidget {
  final Function(String) onSearch;
  final String placeholder;

  const SearchInput({
    Key? key,
    required this.onSearch,
    this.placeholder = 'Search',
  }) : super(key: key);

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 57,
      margin: const EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF99A5AC),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(Icons.search),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: widget.onSearch,
              decoration: InputDecoration(
                hintText: widget.placeholder,
                hintStyle: const TextStyle(
                  color: Color(0xFF99A5AC),
                  fontSize: 20,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              ),
              style: const TextStyle(
                color: Color(0xFF99A5AC),
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
