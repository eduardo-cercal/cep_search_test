import 'package:cep_search_test/home/components/dialog/components/advance_search/controller/advance_search_controller.dart';
import 'package:cep_search_test/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class StateSelectionScreen extends StatefulWidget {
  const StateSelectionScreen({Key? key}) : super(key: key);

  @override
  State<StateSelectionScreen> createState() => _StateSelectionScreenState();
}

class _StateSelectionScreenState extends State<StateSelectionScreen> {
  static const historyLength = 5;
  final advanceSearchController = Get.find<AdvanceSearchController>();
  final List<String> _searchHistory = [];
  late List<String> filterSearchHistory;
  late FloatingSearchBarController controller;
  String? selectedTerm;
  List cityList = [];

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
    filterSearchHistory = filterSearchTerms(filter: null);
    _loadItems();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingSearchBar(
        body: SearchResultsListView(searchTerm: selectedTerm, list: cityList),
        controller: controller,
        transition: CircularFloatingSearchBarTransition(),
        title: Text(selectedTerm ?? "Selecione o curso"),
        hint: "Digite o nome do curso",
        actions: [
          FloatingSearchBarAction.searchToClear(),
        ],
        onQueryChanged: (query) {
          setState(() {
            filterSearchHistory = filterSearchTerms(filter: query);
          });
        },
        onSubmitted: (query) async {
          if (selectedTerm != null) {
            cityList.clear();
            await _loadItems();
          }
          setState(() {
            addSearchTerm(query);
            selectedTerm = query;
            _filteredItems();
          });
          controller.close();
        },
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Colors.white,
              elevation: 4.0,
              child: Builder(
                builder: (context) {
                  if (filterSearchHistory.isEmpty && controller.query.isEmpty) {
                    return Container(
                      height: 56,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: const Text(
                        "Comece a pesquisar",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  } else if (filterSearchHistory.isEmpty) {
                    return ListTile(
                      title: Text(controller.query),
                      leading: const Icon(Icons.search),
                      onTap: () {
                        setState(() {
                          addSearchTerm(controller.query);
                          selectedTerm = controller.query;
                        });
                        controller.close();
                      },
                    );
                  } else {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: filterSearchHistory
                          .map(
                            (term) => ListTile(
                              title: Text(
                                term,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              leading: const Icon(Icons.history),
                              onTap: () {
                                setState(() {
                                  putSearchTermFirst(term);
                                  selectedTerm = term;
                                });
                                controller.close();
                              },
                            ),
                          )
                          .toList(),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  List<String> filterSearchTerms({
    required String? filter,
  }) {
    if (filter != null && filter.isNotEmpty) {
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }

    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }

    filterSearchHistory = filterSearchTerms(filter: null);
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
    filterSearchHistory = filterSearchTerms(filter: null);
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  Future<void> _loadItems() async {
    final List data = await advanceSearchController.getStatesFromApi();
    for (var element in data) {
      setState(() {
        cityList.add(element);
      });
    }
  }

  void _filteredItems() {
    final List newList = [];

    for (Map<String, dynamic> element in cityList) {
      if (selectedTerm != null &&
          (element["nome"].contains(selectedTerm!.toUpperCase().trimRight()) ||
              element["sigla"]
                  .contains(selectedTerm!.toUpperCase().trimRight()))) {
        newList.add(element);
      }
    }
    cityList.clear();
    cityList = newList;
  }
}

class SearchResultsListView extends StatelessWidget {
  final String? searchTerm;
  final List list;
  final advanceSearchController = Get.find<AdvanceSearchController>();
  final homeController = Get.find<HomeController>();

  SearchResultsListView(
      {Key? key, required this.searchTerm, required this.list})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fsb = FloatingSearchBar.of(context)!.value;
    return homeController.loading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView(
            padding: EdgeInsets.only(top: fsb.height + fsb.margins.vertical),
            children: List.generate(
              list.length,
              (index) {
                final item = list[index];
                return ListTile(
                  onTap: () {
                    advanceSearchController.stateMap.value = item;
                    Get.back();
                  },
                  title: Text("${item["name"]} - ${item["shortName"]}"),
                );
              },
            ),
          );
  }
}
