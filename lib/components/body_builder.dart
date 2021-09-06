import 'package:flutter/cupertino.dart';
import 'package:maana_main_project_2/components/error_widget.dart';
import 'package:maana_main_project_2/components/loading_widget.dart';
import 'package:maana_main_project_2/util/enum/api_request_status.dart';

class BodyBuilder extends StatelessWidget {
  final APIRequestStatus apiRequestStatus;
  final Widget child;
  final Function reload;
  final String type;

  BodyBuilder(
      {Key key,
      @required this.apiRequestStatus,
      @required this.child,
      @required this.reload,
      this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    switch (apiRequestStatus) {
      case APIRequestStatus.loading:
        return LoadingWidget(
          type: type,
        );
        break;
      case APIRequestStatus.unInitialized:
        return LoadingWidget(
          type: type,
        );
        break;
      case APIRequestStatus.connectionError:
        return WidgetError(
          refreshCallBack: reload,
          isConnection: true,
        );
        break;
      case APIRequestStatus.error:
        return WidgetError(
          refreshCallBack: reload,
          isConnection: false,
        );
        break;
      case APIRequestStatus.loaded:
        return child;
        break;
      case APIRequestStatus.noData:
        return WidgetError(
          refreshCallBack: reload,
          isConnection: false,
          isnoBooks: true,
        );

        break;
      default:
        return LoadingWidget(
          type: type,
        );
    }
  }
}
