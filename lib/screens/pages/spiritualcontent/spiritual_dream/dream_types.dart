class DreamType {
  final String title;
  final String description;

  DreamType({required this.title, required this.description});
}

final List<DreamType> dreamTypes = [
  DreamType(
    title: 'Guidance Dreams',
    description: 'Dreams that provide direction or answers to life questions.'
  ),
  DreamType(
    title: 'Warning Dreams',
    description: 'Dreams that alert you to potential dangers or mistakes.'
  ),
  DreamType(
    title: 'Inspirational Dreams',
    description: 'Dreams that uplift your spirit and encourage positive action.'
  ),
  DreamType(
    title: 'Prophetic Dreams',
    description: 'Dreams that foretell future events or spiritual happenings.'
  ),
];
