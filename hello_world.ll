; ModuleID = 'hello_world.ll'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:16-S128"
target triple = "x86_64-unknown-android"

; Include the necessary header
declare i8* @ANativeWindow_open(i32)
declare void @ANativeWindow_release(i32)
declare i32 @ANativeWindow_setBuffersGeometry(i8*, i32, i32, i32)
declare i8* @TextView_new()
declare i8* @TextView_setText(i8*, i8*)
declare void @TextView_setGravity(i8*, i32)

; Define a function named 'main'
define i32 @main() {
  ; Create a label for the beginning of the function
  entry:

  ; Call Android functions to create a window and draw text
  %window = call i8* @ANativeWindow_open(i32 0)
  %surface = call i32 @ANativeWindow_setBuffersGeometry(i8* %window, i32 800, i32 480, i32 32)

  ; Call the Android functions to create a text view with the text "Hello World"
  %textView = call i8* @TextView_new()
  %text = call i8* @TextView_setText(i8* %textView, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i64 0, i64 0))

  ; Center the text view
  call void @TextView_setGravity(i8* %textView, i32 17) ; Center horizontally and vertically

  call void @ANativeWindow_release(i8* %window)

  ; Return 0 to indicate successful execution
  ret i32 0
}

; Define the string "Hello World"
@.str = private constant [12 x i8] c"Hello World\00"
