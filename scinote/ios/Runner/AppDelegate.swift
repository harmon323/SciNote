import UIKit
import Flutter
import MobileCoreServices

@main
@objc class AppDelegate: FlutterAppDelegate, UIDocumentPickerDelegate {

    private var controller: FlutterViewController?
    private var channel: FlutterMethodChannel?

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // FlutterViewControllerの設定
        let flutterViewController = window?.rootViewController as! FlutterViewController
        controller = flutterViewController

        // MethodChannelの設定
        channel = FlutterMethodChannel(name: "file_picker_channel", binaryMessenger: flutterViewController.binaryMessenger)
        
        // MethodChannelでメソッドの呼び出しを受ける
        channel?.setMethodCallHandler { (call, result) in
            if call.method == "pickFile" {
                self.openFilePicker(result: result)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    // ファイル選択ダイアログを開く
    private func openFilePicker(result: @escaping FlutterResult) {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeContent)], in: .import)
        documentPicker.delegate = self
        controller?.present(documentPicker, animated: true, completion: nil)
    }

    // ファイル選択後の処理
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if let url = urls.first {
            // 選択されたファイルのパスを返す
            channel?.invokeMethod("pickFile", arguments: url.path)
        }
    }

    // キャンセル時の処理
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        channel?.invokeMethod("pickFile", arguments: nil)
    }
}
