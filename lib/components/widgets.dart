import 'package:flutter/material.dart';


class Widgets{

	static Text text(
		String texto,
		{
			Color cor = Colors.black,
			double tamFont = 18,
			TextAlign alinhamento = TextAlign.start,
			FontWeight negrito = FontWeight.normal,
			FontStyle italico = FontStyle.normal,
			TextDecoration sublinhado = TextDecoration.none
		}
	){
		return Text(
			texto,
			style: TextStyle(
				color: cor,
				fontSize: tamFont,
				fontWeight: negrito,
				fontStyle: italico,
				decoration:sublinhado
			),
			textAlign: alinhamento,
		);
	}
}