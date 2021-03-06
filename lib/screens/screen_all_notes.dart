import 'package:flutter/material.dart';
import 'package:note_app_sample/data/data.dart';
import 'package:note_app_sample/data/note_model/note_model.dart';
import 'package:note_app_sample/screens/screen_add_notes.dart';
import 'package:note_app_sample/widget/note_item.dart';

class ScreenAllNotes extends StatelessWidget {
  const ScreenAllNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await NoteDB.instance.getAllNotes();
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'All Notes',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: NoteDB.instance.noteListNotifier,
              builder: (context, List<NoteModel> newNote, _) {
                return GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  padding: const EdgeInsets.all(20),
                  children: List.generate(newNote.length, (index) {
                    final _note = NoteDB.instance.noteListNotifier.value[index];

                    if (_note.id == null) {
                      const SizedBox();
                    }
                    return NoteItem(
                      id: _note.id!,
                      title: _note.title ?? 'No Title',
                      content: _note.content ?? 'No Content',
                    );
                  }),
                );
              })),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((ctx) => ScreenAddNote(
                    type: ActionType.addNote,
                  )),
            ),
          );
        },
        label: const Text('new'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
