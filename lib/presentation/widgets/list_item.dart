import 'package:flutter/material.dart';
import 'package:shopping_cart_app/data/models/shopping_item.dart';

class ListItem extends StatefulWidget {
  final ShoppingItem item;
  final Function(bool) onToggle;
  final Function(String) onEdit;
  final VoidCallback onDelete;

  const ListItem({
    super.key,
    required this.item,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  late TextEditingController _controller;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.item.name);
  }

  @override
  void didUpdateWidget(ListItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.item.name != widget.item.name) {
      _controller.text = widget.item.name;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      if (_isEditing) {
        if (_controller.text.trim().isNotEmpty) {
          widget.onEdit(_controller.text);
        } else {
          _controller.text = widget.item.name;
        }
      }
      _isEditing = !_isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
          _isEditing
              ? IgnorePointer(
                child: Checkbox(
                  value: widget.item.isPurchased,
                  onChanged: null,
                ),
              )
              : Checkbox(
                value: widget.item.isPurchased,
                onChanged: (value) => widget.onToggle(value ?? false),
              ),
      title:
          _isEditing
              ? TextField(
                controller: _controller,
                autofocus: true,
                decoration: const InputDecoration(border: InputBorder.none),
                style: Theme.of(context).textTheme.bodyLarge,
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    widget.onEdit(value);
                    setState(() {
                      _isEditing = false;
                    });
                  }
                },
              )
              : Text(
                widget.item.name,
                style: TextStyle(
                  fontSize: 16,
                  decoration:
                      widget.item.isPurchased
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                  color:
                      widget.item.isPurchased
                          ? Theme.of(context).disabledColor
                          : Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
      trailing:
          _isEditing
              ? IconButton(
                icon: const Icon(Icons.check, color: Colors.greenAccent),
                onPressed: _toggleEdit,
              )
              : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: _toggleEdit,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: widget.onDelete,
                  ),
                ],
              ),
    );
  }
}
