import 'package:lettutor/models/Review.dart';
import 'package:lettutor/models/User.dart';

final reviewList = [
  Review(
    author: User(name: null, email: 'john.doe@example.com', id: '11'),
    comment:
        'The tutor was very patient and explained the concepts clearly. I was able to understand the material much better after the session.',
    rating: 4.5,
    createdAt: DateTime.parse('2023-12-03 19:36:50'),
  ),
  Review(
    author: User(name: 'Jane Smith', email: 'jane.smith@example.com', id: '12'),
    comment:
        'I appreciate the tutor\'s ability to simplify complex topics. The examples used during the session were very helpful.',
    rating: 4.0,
    createdAt: DateTime.parse('2023-12-04 10:15:30'),
  ),
  Review(
      author: User(
          name: 'Alice Johnson', email: 'alice.johnson@example.com', id: '13'),
      comment:
          'The tutor was very knowledgeable and answered all my questions. I feel more confident about the subject now.',
      rating: 5.0,
      createdAt: DateTime.parse('2023-12-05 14:20:40')),
  Review(
    author:
        User(name: 'Bob Williams', email: 'bob.williams@example.com', id: '14'),
    comment:
        'I liked how the tutor encouraged me to think critically and solve problems on my own. It was a very interactive session.',
    rating: 4.5,
    createdAt: DateTime.parse('2023-12-06 16:45:50'),
  ),
  Review(
    author: User(
        name: 'Charlie Brown', email: 'charlie.brown@example.com', id: '15'),
    comment:
        'The tutor was punctual and well-prepared for the session. The study materials provided were also very useful.',
    rating: 4.0,
    createdAt: DateTime.parse('2023-12-07 09:30:00'),
  )
];
