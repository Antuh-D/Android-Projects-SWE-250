@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: MyAppBar(
      Headding: "All Upcoming Events",
      backpage: true,
    ),
    body: Padding(
      padding: const EdgeInsets.all(12),
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildMainContent(), //Instead of putting a long Column inside build() moved it into a new method.
    ),
  );
}

Widget _buildMainContent() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildFilterRow(),
      if (isFilterOpen) const SizedBox(height: 12),
      if (isFilterOpen) _buildCategoryList(),
      const SizedBox(height: 12),
      _buildEventList(),
    ],
  );
}

Widget _buildFilterRow() {
  final isFilterApplied = selectedCategory != 'All';

  return Row(
    children: [
      ElevatedButton.icon(
        onPressed: () {
          setState(() {
            if (isFilterApplied) {
              selectedCategory = 'All';
              filteredEvents = upcomingEvents;
              isFilterOpen = false;
            } else {
              isFilterOpen = !isFilterOpen;
            }
          });
        },
        icon: Icon(
          isFilterApplied || isFilterOpen ? Icons.close : Icons.filter_list,
        ),
        label: Text(
          isFilterApplied
              ? 'Clear Filter'
              : isFilterOpen
              ? 'Close Filters'
              : 'Filter (${selectedCategory})',
          style: TextStyle(color: AppColors.accentPink),
        ),
      ),
      const SizedBox(width: 12),
      if (isFilterApplied)
        Chip(
          label: Text(selectedCategory),
          deleteIcon: const Icon(Icons.close),
          onDeleted: () {
            setState(() {
              selectedCategory = 'All';
              filteredEvents = upcomingEvents;
            });
          },
        ),
    ],
  );
}

Widget _buildEventList() {
  return Expanded(
    child: filteredEvents.isEmpty
        ? const Center(child: Text('No Upcoming Events Found'))
        : EventGridView(
      events: filteredEvents,
      cardsPerRow: 1,
      cardHeight: 160,
      number: filteredEvents.length,
      spacing: 8,
    ),
  );
}
