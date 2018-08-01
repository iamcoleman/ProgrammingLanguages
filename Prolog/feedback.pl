%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%   Give Feedback to a User   %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Input from Haskell - Current Week 
% workout level       = 3 (low), 4 (medium), 5 (high)
% visit percentage    = 0 (penalty), 1 (consistent), 2 (bonus)
% workout rating      = 0 (penalty), 1 (consistent), 2 (bonus)
% workout improvement = 0 (penalty), 1 (consistent), 2 (bonus)

%%% Input from Previous Week Prolog Feedback
% prev week visit percent       = 0 (penalty), 1 (consistent), 2 (bonus)
% prev week workout rating      = 0 (penalty), 1 (consistent), 2 (bonus)
% prev week workout improvement = 0 (penalty), 1 (consistent), 2 (bonus)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  Sample Input From Haskell  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% John
% low workout plan
% consistent vistit percent 
% bonus workout rating
% bonus workout improvement
/*
user_level(low).

user_visit(con).
user_wr(bon).
user_wi(bon).

prev_user_visit(pen).
prev_user_wr(con).
prev_user_wi(con).
*/
%% Steve
% high workout plan
% bonus visit percent
% penalty workout rating
% penalty workout improvement

user_level(high).

user_level(high).
user_visit(bon).
user_wr(pen).
user_wi(pen).

prev_user_visit(bon).
prev_user_wr(bon).
prev_user_wi(con).




%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%    Workout Facts    %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%  Workout Levels  %%%
% workout_level(level)
workout_level(low).
workout_level(med).
workout_level(high).

%%% Visit Percentages %%%
% visit_percent(P/C/B)
visit_percent(pen).
visit_percent(con).
visit_percent(bon).

%%% Workout Rating %%%
% workout_rating(P/C/B)
workout_rating(pen).
workout_rating(con).
workout_rating(bon).

%%% Workout Improvement %%%
% workout_improvement(P/C/B)
workout_improvement(pen).
workout_improvement(con).
workout_improvement(bon).

%%% Previous and Current %%%
% compare(previous, current, change)
week_compare(pen, pen, '0').
week_compare(pen, con, '1').
week_compare(pen, bon, '2').
week_compare(con, pen, '-1').
week_compare(con, con, '0').
week_compare(con, bon, '1').
week_compare(bon, pen, '-2').
week_compare(bon, con, '-1').
week_compare(bon, bon, '0').




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  Feedback and Suggestions  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

is_penalty(X) :-
	X == 'pen' -> write('You are in the Penalty range'), nl; true.

is_consistent(X) :-
	X == 'con' -> write('You are in the Consistent range'), nl; true.

is_bonus(X) :-
	X == 'bon' -> write('You are in the Bonus range'), nl; true.

is_minus_two(X) :-
	X == '-2' -> write('Terrible!'), nl; true.

is_minus_one(X) :-
	X == '-1' -> write('Bad!'), nl; true.

is_zero(X) :-
	X == '0' -> write('Same as last week'), nl; true.

is_one(X) :-
	X == '1' -> write('Good!'), nl; true.

is_two(X) :-
	X == '2' -> write('Superb!'), nl; true.

visit_feedback :-
	write('For your visits to the gym this week...'), nl,
	user_visit(X),
	is_penalty(X),
	is_consistent(X),
	is_bonus(X).

visit_feedback_compare :-
	write('For your visits compared to last week...'), nl,
	user_visit(Curr),
	prev_user_visit(Prev),
	week_compare(Prev, Curr, Change),
	is_minus_two(Change),
	is_minus_one(Change),
	is_zero(Change),
	is_one(Change),
	is_two(Change).

wr_feedback :-
	write('For your workout rating this week...'), nl,
	user_wr(X),
	is_penalty(X),
	is_consistent(X),
	is_bonus(X).

wr_feedback_compare :-
	write('For your workout rating compared to last week...'), nl,
	user_wr(Curr),
	prev_user_wr(Prev),
	week_compare(Prev, Curr, Change),
	is_minus_two(Change),
	is_minus_one(Change),
	is_zero(Change),
	is_one(Change),
	is_two(Change).

wi_feedback :-
	write('For your workout improvement this week...'), nl,
	user_wi(X),
	is_penalty(X),
	is_consistent(X),
	is_bonus(X).

wi_feedback_compare :-
	write('For your workout improvement compared to last week...'), nl,
	user_wi(Curr),
	prev_user_wi(Prev),
	week_compare(Prev, Curr, Change),
	is_minus_two(Change),
	is_minus_one(Change),
	is_zero(Change),
	is_one(Change),
	is_two(Change).

get_feedback :-
	visit_feedback,
	wr_feedback,
	wi_feedback,
	nl,
	visit_feedback_compare,
	wr_feedback_compare,
	wi_feedback_compare.