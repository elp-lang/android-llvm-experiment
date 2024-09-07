; ModuleID = 'hello_world.ll'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:16-S128"
target triple = "aarch64-android"

; Define a function named 'main'
define i32 @main() {
  ; Create a label for the beginning of the function
  entry:

  ; Call the Android functions to create a text view with the text "Hello World"
  %textView = call i8* @TextView_new()
  %text = call i8* @TextView_setText(i8* %textView, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i64 0, i64 0))

  ; Center the text view
  call void @TextView_setGravity(i8* %textView, i32 17) ; Center horizontally and vertically

  ; Return 0 to indicate successful execution
  ret i32 0
}

; Define the string "Hello World"
@.str = private constant [3 x i8] c"Hello World\00"