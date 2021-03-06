/************************************************
 * CIS 365 - 01: Project 2
 * Logical Reasoning with Prologue
 *
 * Jack O'Brien & Jacob McKim
 * March 17, 2016
 ***********************************************/


/*------- Facts -------*/
/* class(Number, Name, Time, Days, Location, Professor, Major) */
class('467', 'CS Project', '10:00 am - 10:50 am', 'MWF', 'MAK B1118', 'Dr. Engelsma', 'CS').
class('463', 'IS Project', '2:00 pm - 2:50 pm', 'MWF', 'MAK D2123', 'Mr. Lange', 'IS').
class('460', 'MIS', '10:00 am - 11:15 am', 'TR', 'MAK B1116', 'Dr. P. Leidig', 'IS').
class('457', 'Data Communications', '2:00 pm - 2:50 pm', 'MWF', 'MAK D1117', 'Dr. Kalafut', 'CS').
class('452', 'OS Concepts', '1:00 pm - 1:50 pm', 'MWF', 'MAK D1117', 'Dr. Wolffe', 'CS').
class('451', 'Computer Architecture', '10:00 am - 10:50 am', 'MWF', 'MAK B1118', 'Dr. Kurmas', 'CS').
class('450', 'IS Project Management', '12:00 pm - 12:50 pm', 'MWF', 'MAK D1117', 'Dr. Schymik', 'IS').
class('443', 'Software Development Tools', '11:00 am - 11:50 am', 'MWF', 'MAK B1124', 'Ms. Peterman', 'IS').
class('437', 'Distributed Computing', '10:00 am - 10:50 am', 'MWF', 'MAK B1118', 'Dr. Engelsma', 'CS').
class('375', 'Wireless Networking Systems', '6:00 pm - 8:50 pm', 'R', 'EC 612', 'Dr. El-Said', 'IS').
class('371', 'Web Applicatino Programming', '4:00 pm - 5:15 pm', 'MW', 'MAK D1117', 'Dr. Scripps', 'CS').
class('365', 'AI', '10:00 am - 11:15 am', 'TR', 'MAK D1117', 'Dr. J. Leidig', 'CS').
class('361', 'System Programming', '4:00 pm - 5:15 pm', 'TR', 'MAK B1116', 'Dr. Trefftz', 'CS').
class('358', 'Information Insurance', '3:00 pm - 3:50 pm', 'MWF', 'MAK A1105', 'Dr. Kalafut', 'CS').
class('353', 'Database', '12:00 pm - 12:50 pm', 'MWF', 'MAK B1118', 'Dr. Alsabbagh', 'CS').
class('350', 'Software Engineering', '10:00 am - 10:50 am', 'MWF', 'MAK D1117', 'Dr. Jorgensen', 'CS').
class('343', 'Structure of Programming Languages', '1:00 pm - 1:50 pm', 'MWF', 'MAK B1124', 'Dr. Nandigam', 'CS').
class('339', 'IT Project Management', '1:00 pm - 2:15 pm', 'TR', 'MAK A1105', 'Mr. Lange', 'IS').
class('337', 'Network Systems Management', '3:00 pm - 3:50 pm', 'TR', 'MAK B1124', 'Dr. El-Said', 'IS').
class('333', 'DB Management and Implementation', '6:00 pm - 8:50 pm', 'W', 'MAK D1117', 'Ms. Posada', 'IS').
class('330', 'Systems Analysis and Design', '9:00 am - 9:50 am', 'MWF', 'MAK D1117', 'Dr. Du', 'IS').
class('661', 'Medical and BioInformatics', '6:00 pm - 8:50 pm', 'T', 'EC 612', 'Dr. J. Leidig', 'CIS').
class('671', 'Information Visualization', '6:00 pm - 8:50 pm', 'R', 'EC 612', 'Dr. J. Leidig', 'CIS').
class('691', 'MBI Capstone', '6:00 pm - 8:50 pm', 'M', 'EC 612', 'Dr. J. Leidig', 'CIS').

/* student(Name, Enrolled in class number, Enrolled in class name */
student('Jim', '467', 'CS Project').
student('Jim', '452', 'OS Concepts').
student('Jim', '457', 'Data Communications').
student('Pam', '437', 'Distributed Computing').
student('Pam', '457', 'Data Communications').
student('Pam', '452', 'OS Concepts').
student('Kara Thrace', '467', 'CS Project').
student('Kara Thrace', '452', 'OS Concepts').
student('Kara Thrace', '365', 'AI').
student('Gaius Baltar', '463', 'IS Project').
student('Gaius Baltar', '460', 'MIS').
student('Gaius Baltar', '375', 'Wireless Networking Systems').

/*------- Rules -------*/

/* Professor P teaches class C */
teaches(P, C) :- class(_,C,_,_,_,P,_).

/* Class C is during time T on day D */
during(C,T,D) :- class(_,C,T,D,_,_,_).

/* Student S is taking class C. */
taking(S,C) :- student(S,_,C).

/* course named N is of type T. */
coursetype(N,T) :- class(_,N,_,_,_,_,T). 

/* Professor P is teaching a class during time T on day D */
scheduled(P,T,D) :- teaches(P, C), during(C,T,D).

/* Professor P is teaching class S during time T on day D */
scheduledsubject(P,T,D,S) :- class(_,S,T,D,_,P,_).

/* Professors A and B are both teaching at time T on day D  */
teachsametime(A,B,T,D) :- teaches(A,X), during(X,T,D), teaches(B,Y), during(Y,T,D).

/* There is a schedule comflict between classes A and B if
 * A and B are during the same time on the same day and 
 * either have the same professor or the same room. */
scheduleconflict(A,B) :- class(_,A,T,D,R,_,_),class(_,B,T,D,R,_,_), A \= B ;class(_,A,T,D,_,P,_),class(_,B,T,D,_,P,_),A \= B.

/* Student A and B are both taking class C.  */
takingsamecourse(A,B,C) :- taking(A,C), taking(B,C).

/* Student S is taking a course of type T */
takingtype(S,T) :- taking(S,C), coursetype(C, T).

/*------- Goals -------*/
print_solution :-

/* Will find the set of all class with Dr. J. Leidig
 * as the teacher */
write(' 1. What does Dr. J. Leidig teach?'), nl,
setof(X, teaches('Dr. J. Leidig', X), Query1),
write(Query1), nl,

/* Will find all classes with Dr. J. Leidig as the 
 * teacher with the name Database */
write(' 2. Does Dr. J. Leidig teach Database?'), nl,
findall(X, teaches('Dr. J. Leidig', 'Database'), Query2),
write(Query2), nl,

/* Will find the time and day for every class Dr. J.
 * Leidig is scheduled for */
write(' 3. What is Dr. J. Leidig’s schedule?'), nl,
setof((T, D), scheduled('Dr. J. Leidig', T, D), Query3),
write(Query3), nl,

/* Will find the set of professors and classes with
 * the time of 10:00am - 11:15am on the days 'TR' */
write(' 4. Who is scheduled to teach what subject on TTH, 10am?'), nl,
setof((P, S), scheduledsubject(P, '10:00 am - 11:15 am', 'TR', S), Query4),
write(Query4), nl,

/* Will find all the days and times that the two specified
 * professors teach classes at the same time and day */
write(' 5. When do Dr. J. Leidig and Dr. El-Said teach at the same time?'), nl,
findall((T, D), teachsametime('Dr. J. Leidig', 'Dr. El-Said',T,D), Query5),
write(Query5), nl,

/* This will find all the professors that teach at the same time as Dr. Leidig. */
write(' 6. Who Teaches at the same time as Dr. J. Leidig?'), nl,
findall(B, (teachsametime('Dr. J. Leidig',B,T,D), B \= 'Dr. J. Leidig'), Query6),
write(Query6), nl,

/* This will find what courses jim and pam have in common with each other. */
write(' 7. What courses do Jim and Pam have in common?'), nl,
findall((C), takingsamecourse('Jim', 'Pam',C), Query7),
write(Query7), nl,

/* This will find all the individuals taking CS courses. */
write(' 8. Who is taking CS Courses?'), nl,
setof(S, takingtype(S, 'CS'), Query8),
write(Query8), nl,


/* This will find types of courses Gaius Baltar is taking. */
write(' 9. What type of courses are Gaius Baltar taking?'), nl,
setof((T), (taking('Gaius Baltar',C),coursetype(C,T)), Query9),
write(Query9), nl,

/* Will find all pairs of classes where there is a schedule
 * conflict, either by the professor or room being double booked */
write(' 10. Are there any scheduling conflicts of professors or locations?'), nl,
setof((A,B), scheduleconflict(A,B), Query10),
write(Query10), nl.

?- print_solution.
