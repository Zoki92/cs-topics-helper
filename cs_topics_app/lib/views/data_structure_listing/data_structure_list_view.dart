import 'package:cs_topics_app/bloc/infinite_scroll_bloc/infinite_scroll_bloc.dart';
import 'package:cs_topics_app/http_api_clients/urls.dart';
import 'package:cs_topics_app/models/data_structure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class DataStructureListView extends StatefulWidget {
  @override
  _DataStructureListViewState createState() => _DataStructureListViewState();
}

class _DataStructureListViewState extends State<DataStructureListView> {
  final _scrollController = ScrollController();
  final _scrollTreshold = 100.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _onScroll();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollTreshold) {
      BlocProvider.of<InfiniteScrollBloc>(context).add(FetchData());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Structures'),
        centerTitle: true,
      ),
      body: BlocBuilder<InfiniteScrollBloc, InfiniteScrollState>(
        builder: (context, state) {
          if (state is InfiniteScrollInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is InfiteScrollFailure) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is InfiteScrollSuccess) {
            return ListView.builder(
              controller: _scrollController,
              itemBuilder: (BuildContext context, int index) {
                return index >= state.dataStructures.length
                    ? BottomLoader()
                    : DataStructureWidget(
                        dataStructure: state.dataStructures[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.dataStructures.length
                  : state.dataStructures.length + 1,
            );
          }
        },
      ),
    );
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}

class DataStructureWidget extends StatelessWidget {
  final DataStructure dataStructure;

  const DataStructureWidget({Key key, this.dataStructure}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DataStructureDetail(dataStructure: dataStructure),
          ),
        );
      },
      leading: Text('item'),
      title: Text(dataStructure.name),
      isThreeLine: true,
      dense: true,
      subtitle: Text('item'),
    );
  }
}

class DataStructureDetail extends StatelessWidget {
  final DataStructure dataStructure;

  const DataStructureDetail({Key key, this.dataStructure}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dataStructure.name),
        centerTitle: true,
      ),
      body: Markdown(
        data: dataStructure.markdownContent.content,
        imageDirectory: base,
      ),
    );
  }
}
