import 'package:equatable/equatable.dart';

class DataStructure extends Equatable {
  final String name;
  final String created;
  final String category;
  final MarkDownContent markdownContent;

  DataStructure({
    this.name,
    this.created,
    this.category,
    this.markdownContent,
  });

  static DataStructure fromJson(var json) {
    return DataStructure(
      name: json['name'],
      created: json['created'],
      category: json['category'],
      markdownContent: MarkDownContent.fromJson(json['markdown_content']),
    );
  }

  static List<DataStructure> toListOfDataStructures(dynamic jsonList) {
    return jsonList
        .map<DataStructure>((json) => DataStructure.fromJson(json))
        .toList();
  }

  @override
  List<Object> get props => [name, category, markdownContent];
}

class MarkDownContent extends Equatable {
  final String name;
  final String content;

  MarkDownContent({this.name, this.content});

  static MarkDownContent fromJson(var json) {
    return MarkDownContent(content: json['content'], name: json['name']);
  }

  @override
  List<Object> get props => [name, content];
}
