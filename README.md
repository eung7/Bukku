![header](https://capsule-render.vercel.app/api?type=soft&color=062C30&height=300&section=header&text=Bukku:%20부끄&fontSize=90&fontColor=FFFFFF)
# BUKKU: 부끄 _나의 서재 앱

> Bukku is the App you can organize books and leave notes. 
> You can search for various books through the network and add books yourself. 
> And can leave a book review and bookmark for each book. Build your own library with simple and clear functions!

---
## Features

- Search various books through the network
- Add books yourself with library pictures.
- books can be classified into your library(reading, scheduled to read, read completed)
- Leave reviews and bookmarks on each book. and you can pin a particular bookmark.
- See the book reviews and bookmarks at once in memotab.

## UI/UX
### Theme Color / Icon
![스크린샷 2022-06-20 23 40 17](https://user-images.githubusercontent.com/97531269/175806008-5065c54e-dc84-42f7-b797-afe77b5d18ca.png) 
 ![180x180](https://user-images.githubusercontent.com/97531269/175806479-6a4c59ff-f524-4cc6-8ddd-523c8e8156a3.png)
### Views
![Library 001](https://user-images.githubusercontent.com/97531269/175805970-5621f7fb-5bf6-4752-86f3-87fbd1630d20.jpeg)
![11 001](https://user-images.githubusercontent.com/97531269/175806555-d90b2861-a167-4cd5-92d2-823aec099e03.jpeg)
![무제 001](https://user-images.githubusercontent.com/97531269/175806709-6ce4958e-5209-4b1e-bc4a-81f7ebffbfc0.jpeg)

## Notes

### FileManager

> Filemanager was used to store user data. I wanted to implement local based App after getting books from the network. So the ```Struct type``` containing the user's info was changed to ```json``` and stored in the embedded directory of the iPhone. also Image transforming to Data structure
>> ![image](https://user-images.githubusercontent.com/97531269/175807758-86bd555a-3f78-47d8-8d23-908193ba8922.png)

### LongPressGesture Drag & Drop 
> Drag cell is from sourceIndexPath and drop cell is to destinationIndexPath
>>![Simulator Screen Recording - iPhone 13 Pro Max - 2022-06-26 at 18 25 41](https://user-images.githubusercontent.com/97531269/175807875-2bf24f9e-fa79-42f0-9855-446b418ae41b.gif)

### Pin Bookmark
> If you pin a bookmark, keep it at the top even if another bookmark is added.
>>![Simulator Screen Recording - iPhone 13 Pro Max - 2022-06-26 at 18 33 33](https://user-images.githubusercontent.com/97531269/175808190-5fdd9936-6067-4823-a148-0bb40c06e54f.gif)
>>![Simulator Screen Recording - iPhone 13 Pro Max - 2022-06-26 at 18 37 26](https://user-images.githubusercontent.com/97531269/175808302-5e363c5e-95ec-4ec4-9068-bc9ebebd8874.gif)

### Search and Store Book
> Search book and store book to your own library. if you have already the particular book, prevent the book from being added. 
>>![Simulator Screen Recording - iPhone 13 Pro Max - 2022-06-26 at 18 44 39](https://user-images.githubusercontent.com/97531269/175808622-2a94add2-d7d8-4a0b-a674-09d9d44a8118.gif)

### Write Review 
> Write a review and view all the books that have written a review in memoTab at once.
>>![Simulator Screen Recording - iPhone 13 Pro Max - 2022-06-26 at 18 49 53](https://user-images.githubusercontent.com/97531269/175808747-aa7fb3e0-ddd3-48fc-a70c-e966cc9549bd.gif)

### MVVM 
> The Bukku app adopted the MVVM structure. DataBinding was conducted as a computed property. In order to create a full-fledged MVVM, I want to proceed with refactoring with functional programming (RxSwift) in the future. 
>> [Example Code](https://github.com/eung7/Bukku/blob/master/Bukku/ViewModels/LibraryTab/LibraryDetailViewModel.swift)

## Open Source

- Alamofire v5.6.1 https://github.com/Alamofire/Alamofire
- JVFloatLabeledTextField v1.2.5 https://github.com/jverdi/JVFloatLabeledTextField
- Kingfisher v7.2.2 https://github.com/onevcat/Kingfisher
- Pageboy v3.6.2 https://github.com/uias/Pageboy
- PanModal v1.2.7 https://github.com/slackhq/PanModal
- RSKPlaceholderTextView v6.1.0 https://github.com/ruslanskorb/RSKPlaceholderTextView
- SnapKit v5.6.0 https://github.com/SnapKit/SnapKit
- Tabman v2.9.1 https://github.com/uias/Tabman
- Toast v5.0.1 https://github.com/scalessec/Toast-Swift
- RxSwift v6.5.0 https://github.com/ReactiveX/RxSwift (will be refactoring)

## version history

### v1.0.0
> Release App (will be)

---

