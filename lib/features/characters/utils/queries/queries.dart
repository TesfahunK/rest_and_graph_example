import 'package:graphql_flutter/graphql_flutter.dart';

allCharactersQuery() => gql('''
query get_characters(\$page:Int! ) {
	characters(page:\$page) {
		info {count pages next prev}
		characters:results {
			id
			name
			status
			image
		}
	}
}
''');
