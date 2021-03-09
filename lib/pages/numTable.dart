import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<MainPage> {
  ScrollController _weightController;
  int _SelectedIndex = 0;
  int _limitNumber = 100;
  bool _dialogueFlag = false;

  Widget _buildTitleText() {
    return Container(
      margin: EdgeInsets.fromLTRB(10.0, 20.00, 10.00, 00.00),
      padding: EdgeInsets.fromLTRB(10.0, 50.00, 10.00, 10.00),
      child: Text(
        'Please Select number',
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSubtitle() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Center(
        child: Text(
          'Drag wheel to select number',
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildNumberButtons(int index) {
    return Container(
      height: 100,
      width: 100,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: RotatedBox(
        quarterTurns: 1,
        child: MaterialButton(
          textColor: Colors.black,
          child: Text('${index + 1}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color:
                      (_SelectedIndex == index) ? Colors.white : Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold)),
          padding: EdgeInsets.all(5),
          shape: CircleBorder(
              side: BorderSide(
                  color:
                      (_SelectedIndex == index) ? Colors.white : Colors.amber,
                  width: 2)),
        ),
      ),
    );
  }

  Widget _buildListWheelScrollView() {
    return ListWheelScrollView(
      itemExtent: 100,
      physics: FixedExtentScrollPhysics(),
      children: List<Widget>.generate(
          _limitNumber, (index) => _buildNumberButtons(index)),
      onSelectedItemChanged: (index) {
        _limitNumber++;
        setState(() {
          _SelectedIndex = index;
        });
      },
    );
  }

  Widget _buildNextButton() {
    return Align(
      alignment: Alignment(0.90, 0.90),
      child: FlatButton(
        padding: EdgeInsets.all(10),
        onPressed: () {
          _buildDiolugeBox();
        },
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 180.0,
            ),
            Text(
              'Get a Table',
              style: TextStyle(fontSize: 24),
            ),
            Icon(
              Icons.arrow_forward_sharp,
              color: Colors.black,
              size: 36,
            )
          ],
        ),
        color: Colors.amber,
        textColor: Colors.black,
      ),
    );
  }

  Future<dynamic> _buildDiolugeBox() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Stack(children: <Widget>[
            _buildNumTable(),
            Positioned(
              right: 1.1,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    radius: 14.0,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.close, color: Colors.red),
                  ),
                ),
              ),
            ),
          ]);
        });
  }

  Widget _buildTable(int i) {
    return Container(
        padding: EdgeInsets.all(3),
        margin: EdgeInsets.all(3),
        child: Text(
          '${(_SelectedIndex + 1)} X ${i} =  ${(_SelectedIndex + 1) * i}',
          style: TextStyle(color: Colors.white, fontSize: 28),
        ));
  }

  Widget _buildNumTable() {
    return AlertDialog(
      backgroundColor: Colors.black,
      elevation: 100,
      shape: Border.all(color: Colors.brown, width: 10),
      content: Column(
        mainAxisSize: MainAxisSize.max,
        children: List<Widget>.generate(
          10,
          (index) => _buildTable(index + 1),
        ),
      ),
      actions: <Widget>[
        FlatButton(
            child: Text("Previous"),
            textColor: Colors.white,
            color: Colors.black,
            onPressed: () async {
              _SelectedIndex--;
              setState(() {
                Navigator.of(context).pop();
                _buildDiolugeBox();
              });
            }),
        SizedBox(
          width: 100,
        ),
        FlatButton(
          child: Text("Next"),
          textColor: Colors.white,
          color: Colors.black,
          onPressed: () {
            _SelectedIndex++;
            setState(() {
              Navigator.of(context).pop();
              _buildDiolugeBox();
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final _style = Theme.of(context).textTheme.headline2;
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Numeric Tables'),
      ),
      body: Column(
        children: <Widget>[
          _buildTitleText(),
          _buildSubtitle(),
          Flexible(
            child: RotatedBox(
              quarterTurns: 3,
              child: _buildListWheelScrollView(),
            ),
          ),
          _buildNextButton(),
        ],
      ),
    );
  }
}
