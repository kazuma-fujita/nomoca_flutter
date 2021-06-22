import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomoca_flutter/data/entity/remote/keyword_search_entity.dart';
import 'package:nomoca_flutter/states/actions/keyword_search_list_action.dart';
import 'package:nomoca_flutter/states/reducers/keyword_search_list_reducer.dart';

import 'components/molecules/error_snack_bar.dart';

class KeywordSearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('病院を探す'),
      ),
      body: _ScrollListView(),
    );
  }
}

class _ScrollListView extends HookWidget {
  static const _threshold = 0.7;

  @override
  Widget build(BuildContext context) {
    return useProvider(keywordSearchListReducer).when(
      data: (items) => NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          final scrollProportion =
              scrollInfo.metrics.pixels / scrollInfo.metrics.maxScrollExtent;
          if (scrollProportion > _threshold) {
            context.read(keywordSearchListActionDispatcher).state =
                const KeywordSearchListAction.fetchList(
                    query: '', offset: 0, limit: 10);
          }
          return false;
        },
        child: items.isNotEmpty
            ? ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext _context, int index) {
                  return _buildRow(items[index]);
                },
              )
            : _emptyListView(),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => ErrorSnackBar(
        errorMessage: error.toString(),
        callback: () => context.refresh(keywordSearchListReducer),
      ),
    );
  }

  Widget _buildRow(KeywordSearchEntity entity) {
    return SizedBox(
      height: 80,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            children: [
              Text(
                entity.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${entity.address} ${entity.buildingName}',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emptyListView() {
    return const Center(
      child: Text(
        '病院が見つかりません',
        style: TextStyle(
          color: Colors.black54,
          fontSize: 16,
        ),
      ),
    );
  }
}
