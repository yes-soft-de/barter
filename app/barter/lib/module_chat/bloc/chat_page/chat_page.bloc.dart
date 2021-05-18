import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:barter/consts/keys.dart';
import 'package:barter/module_swap/service/swap_service.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:barter/module_chat/model/chat/chat_model.dart';
import 'package:barter/module_notifications/model/notifcation_item/notification_item.dart';
import 'package:barter/module_notifications/service/notification_service/notification_service.dart';

import '../../service/chat/char_service.dart';

@provide
class ChatPageBloc {
  static const STATUS_CODE_INIT = 1588;
  static const STATUS_CODE_EMPTY_LIST = 1589;
  static const STATUS_CODE_GOT_DATA = 1590;
  static const STATUS_CODE_BUILDING_UI = 1591;

  bool listening = true;

  final ChatService _chatService;
  // final SwapService _swapService;
  final NotificationService _notificationService;

  ChatPageBloc(
    this._chatService,
    // this._swapService,
    this._notificationService,
  );

  final PublishSubject<Pair<int, List<ChatModel>>> _chatBlocSubject =
      new PublishSubject();

  Stream<Pair<int, List<ChatModel>>> get chatBlocStream =>
      _chatBlocSubject.stream;
  final PublishSubject<NotificationModel> _notificationUpdateSubject =
      PublishSubject();

  final PublishSubject<List<NotificationModel>> _acticeChats = PublishSubject();

  Stream<List<NotificationModel>> get acticeChatsStream => _acticeChats.stream;

  Stream<NotificationModel> get notificationStream =>
      _notificationUpdateSubject.stream;

  // We Should get the UUID of the ChatRoom, as such we should request the data here
  void getMessages(String chatRoomID) {
    if (!listening) listening = true;
    _chatService.chatMessagesStream.listen((event) {
      _chatBlocSubject.add(Pair(STATUS_CODE_GOT_DATA, event));
    });
    _chatService.requestMessages(chatRoomID);
  }

  void sendMessage(String chatRoomID, String chat) {
    _chatService.sendMessage(chatRoomID, chat);
  }

  void dispose() {
    listening = false;
  }

  void setNotificationComplete(NotificationModel swapItemModel) {
    // _swapService.updateSwap(swapItemModel);
  }

  void getActiveChats(String myId) {
    _notificationService.getNotifications().then((value) {
      List<NotificationModel> notificatios = [];
      value.forEach((element) {
        if (element.chatRoomId != null &&
            ((element.swap.status ==
                    ApiKeys.KEY_SWAP_STATUS_FIRST_USER_ACCEPTED && element.swap.userTowId == myId ) ||
                ( element.swap.status ==
                    ApiKeys.KEY_SWAP_STATUS_SECOND_USER_ACCEPTED && element.swap.userOneId == myId)||
               element.swap.status == ApiKeys.KEY_SWAP_STATUS_STARTED
            )) {
          notificatios.add(element);
        }
      });
      _acticeChats.add(notificatios);
    });
  }

  void checkSwapUpdates(String id) {
    _notificationService.getNotifications().then((value) {
      value.forEach((element) {
        if (element.chatRoomId == id) {
          _notificationUpdateSubject.add(NotificationModel(
              chatRoomId: id, swapId: element.swapId, swap: element.swap));
        }
      });
    });
  }
}
