# Flutter developer

## Main task:
Create an application to search for GIF images using Giphy API (https://developers.giphy.com/docs/api/endpoint#search).

### Requirements:
- Implement "live search" - i.e. request is sent in N milliseconds (for example 300) after the user has entered some input;
- Results are displayed in the list or grid of items;
- Request pagination - load enough items to populate the list and load more items every time the user scrolls to the end of the list (limit/offset);
- UI can be very simple but should be responsive, snappy, and implemented according to the platform guidelines;

###  Bonus points will be given for:
- Loading more results "seamlessly" before the user reaches the last item in the list so (at least on a decent network connection) the scrolling is not interrupted by the next page load;
- Using state management approaches or libraries such as BLoC (flutter_bloc), Riverpod or others;
- Separating business logic from the UI;
- Unit tests (we don't expect 100% coverage but rather see how do you approach unit testing)

### Notes:
- Some requirement points can be skipped if you feel like they are too complex at the time. Please provide a comment in the code about what has been skipped. We do expect all or most of the requirements implemented if applying for a more senior position.

### ** Important **
- It is ok to re-use parts of code from other sources. But it is important to understand it and to be able to explain what it does, as well as to attribute the original author.
