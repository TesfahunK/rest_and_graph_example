import 'package:dio/dio.dart';
import 'package:sw_and_rick_morty_app/config/constants/links.dart';

final dioClient = Dio(BaseOptions(baseUrl: AppLinks.http_url));
