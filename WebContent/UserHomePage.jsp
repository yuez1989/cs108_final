<%@ page import="Quiz.*,java.util.*, java.text.*" language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="QuizWebsite.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"
	integrity="sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ=="
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css"
	integrity="sha384-aUGj/X2zp5rLCbBxumKTCw2Z50WgIr1vs/PFN4praOTvYXWlVyh2UtNUU0KAUhAX"
	crossorigin="anonymous">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"
	integrity="sha512-K1qjQ+NcF2TYO/eI3M6v8EiNYZfA95pQumfvcVrTHtwQVDG+aHRqLi/ETn2uB+1JqwYqVG3LIvdm9lj6imS/pQ=="
	crossorigin="anonymous"></script>
<script src='UserHomePage.js'></script>
</head>
<title>Quizzzz <%
	String usrID = "default";
	if (!session.isNew()) {
		usrID = (String) session.getAttribute("user");
		if (usrID == null) {
			usrID = "default";
			response.setHeader("Refresh", "0;index.jsp");
		}		
	}
	out.println(usrID);
%>
</title>
<body>
	<%
		User user = new User(usrID);

		/*
		if (usrID.equals("yuez1989")) {
			Message msg = new Message("yuezhang","yuez1989","hello may I add as friend?","f");
			user.addMessage(msg);
		}
		*/

		UserInfo info = user.info;
		ArrayList<Message> unreadMsgAll = Utilities.unreadMessages(user);
		ArrayList<Message> unreadMsg = new ArrayList<Message>(); //(All messages that are received)
		for (Message msg : unreadMsgAll) {
			if ((msg.fromID).equals(usrID)) continue;
			unreadMsg.add(msg);
		}
		ArrayList<History> histories = Utilities.getRecentActivitiesOfUser(usrID);
		ArrayList<History> frdHistories = Utilities.getRecentFriendActivities(usrID);
		ArrayList<Quiz> popQuizzes = Utilities.getPopularQuiz();
	%>
	<div class="header-line">
		<div class="logo-header">
			<div class="logo-header-large"><a href="UserHomePage.jsp">Quizzzz</a></div>
			<div class="logo-header-small">Only fun learning wakes us up</div>
		</div>
		<div class="personal-header">
			<div class="inline-part">
				<form method="POST" action="Person.jsp" target="_blank">
					<input type="search" name="person" placeholder="search by user ID"
						style="color: black;" size="25"> <input type="submit"
						value="Submit" style="color: black;">
				</form>
			</div>
			<div class="inline-part">
				<span> Welcome, <%=usrID%></span>
			</div>
			<div class="inline-part" id="popup-parent">
				<form name="submitFormMsg" method="POST" action="Messages.jsp"
					target="_blank">
					<input type="hidden" name="usrID" value="<%=usrID%>"> <a
						href="javascript:document.submitFormMsg.submit()" target="_blank">Messages
						<%
 	if (unreadMsg.size() > 0) {
 		out.print("(" + unreadMsg.size() + ")");
 	}
 %>
					</a>
				</form>
			</div>
			<div id="popup-child">
				<%
					// Calculate different kinds of messages.
					int newFriendRequests = 0, newChallenges = 0, newTextMessages = 0;
					for (Message msg : unreadMsg) {
						if((msg.fromID).equals(usrID)) continue;
						char type = msg.type.charAt(0);
						switch (type) {
						case 'f':
							newFriendRequests++;
							break;
						case 'c':
							newChallenges++;
							break;
						case 't':
							newTextMessages++;
							break;
						default:
							newTextMessages++;
							break;
						}
					}
				%>
				<p>
					New friend request:
					<%=newFriendRequests%></p>
				<p>
					New challenges:
					<%=newChallenges%></p>
				<p>
					New text messages:
					<%=newTextMessages%></p>
			</div>
			<div class="inline-part">
				<a href="logout.jsp">Log Out</a>
			</div>
		</div>
		<div style="clear: both;"></div>
	</div>
	<div class="uhp-content">
		<div class="uhp-user col-md-3">
			<div class="column-name">PROFILE</div>
			<div class="news-feed">
				<form name="submitForm" method="POST" action="Person.jsp" target="_blank">
					<input type="hidden" name="person" value="<%=usrID%>">
					<a href="javascript:document.submitForm.submit()"><%=usrID%>'s profile</a>
				</form>
			</div>
			<% String settingStr = "Setting.jsp?usrID=" + usrID; %>
			<div class="news-feed"><a href=<%=settingStr%> target="_blank">Setting</a></div>
			<% if (user.permission == 1) { %>
				<div class="news-feed"><a href="AdminHomePage.jsp" target="_blank">Administration Settings</a></div>
			<%
				}
			%>
			<div class="quiz-options">
				<div class="create-quiz-button">
					<form method="POST" action="CreateQuiz.jsp"
						target="_blank">
						<input type="submit" value="Create New Quiz"></input>
					</form>
				</div>
				<div class="create-quiz-button">
					<form method="POST" action="QuizHomePage.jsp" target="_blank">
						<input type="search" name = "quizID" value="xinhuiwu2015-11-18 16:19:13">
						<br>
						<input type="submit" value="Search Quiz">
						<a href="Quizzes.jsp" target="_blank">See all Quizzes</a>
					</form>
				</div>
			</div>
			<div class="uhp-user-inner">
				<div>
					<span class="section-name">Achievements </span>
					<%
						ArrayList<AchievementRecord> achrs = info.achievementRecords;
						if (achrs.size() == 0) {
							out.println("No achievements yet.");
						}
						for (AchievementRecord achr : achrs) {
							%>
					<div id="popup-ach-parent">
						<span class='column-indent'><%=achr.achID%></span>
						<% Achievement ach = new Achievement(achr.achID); %>
						<div id='popup-ach-child'><%=ach.description%></div>
					</div>
					<%						
						}
					%>
				</div>
				<div>
					<span class="section-name">Recent Quizzes</span>
					<%
						Calendar cal = new GregorianCalendar();
						boolean hasRecent = false;
						int counter = 0;
						for (History hist : histories) {
							counter++;
							if (counter == 10) break;
							// calculate a date of 3 days ago
							Date endDate = QuizSystem.convertToDate(hist.end);
							Date threeDaysAgo = QuizSystem.convertToDate(QuizSystem.minusDay(hist.end, 3));

							if (endDate.compareTo(threeDaysAgo) >= 0) {
								hasRecent = true;
								String quizName = new Quiz(hist.quizID).getQuizName();
								String quizStr = "QuizHomePage.jsp?quizID=" + hist.quizID;
								quizStr= quizStr.substring(0,quizStr.indexOf(" "))+"_"+quizStr.substring(quizStr.indexOf(" ")+1);
							%>
							<span class='column-indent'><a href=<%=quizStr%> target="_blank"><%= quizName %></a></span>
							<%
							}
						}
						if (hasRecent == false) {
							out.println("<span class='column-indent'>No recent history.</span>");
						}
					%>
				</div>
				<div>
					<span class="section-name">Recent Creation</span>
					<%
						ArrayList<Quiz> createSelf = Utilities.getRecentCreatedQuiz(usrID);
						if (createSelf.size() == 0) {
							out.println("<span class='column-indent'>You did not created any quizzes yet.</span>");
						}
						for (Quiz quiz : createSelf) {
							String quizStr = "QuizHomePage.jsp?quizID=" + quiz.getQuizID();
							quizStr= quizStr.substring(0,quizStr.indexOf(" "))+"_"+quizStr.substring(quizStr.indexOf(" ")+1);
					%>
						<span class='column-indent'><a href=<%=quizStr%> target="_blank"><%=quiz.getQuizName()%></a></span>
					<%
						}
					%>
				</div>
				<div>
					<span class="section-name">Friends List</span>
					<%
						ArrayList<String> frdIDs = Utilities.getFriendList(usrID);
						if (frdIDs.size() == 0) {
							out.println("<span class='column-indent'>No friends yet.</span>");
						}
						int maxFrdsAppear = 0; // max number of friends shown
						for (String frdID : frdIDs) {
							String frdLink = "Person.jsp?person=" + frdID;
					%>
						<span class='column-indent'><a href=<%=frdLink%> target="_blank"><%=frdID%></a></span>
					<%	
							maxFrdsAppear++;
							if (maxFrdsAppear > 20) {
								break;
							}
						}
						String personLink = "Person.jsp?person=" + usrID;
					%>
					<span class='column-indent'><a href=<%=personLink%> target="_blank">...Go to profile to see all</a>
					</span>
				</div>
				<div style="clear: both;"></div>
			</div>
		</div>
		<div class="uhp-news col-md-6">
			<div class="column-name">NEWS OF FRIENDS</div>
			<div>
				<div class="column-name">Quizzes Taken Recent</div>
				<%
					if (frdHistories.size() == 0) {
						out.println("No recent friend activities; Add more friend!");
					}
					int counterHist = 0;
					for (History hist : frdHistories) {
						counterHist++;
						if (counterHist > 15) break;
						Quiz quiz = new Quiz(hist.quizID);
						String input = hist.usrID + " took quiz " + quiz.getQuizName() + " at " + hist.end + ", scoring "
								+ hist.score + ". Review: " + hist.review + ". Rating: " + hist.rating + ".";
						out.println("<span class='news-feed'>" + input + "</span>");
					}
				%>
			</div>
			<div>
				<div class="column-name">Quizzes Created</div>
				<%
					ArrayList<Quiz> recentCreatedQuizzesFrd = new ArrayList<Quiz>();
					for (String frdID : frdIDs) {
						ArrayList<Quiz> recents = Utilities.getRecentCreatedQuiz(frdID);
						recentCreatedQuizzesFrd.addAll(recents);
					}
					Collections.sort(recentCreatedQuizzesFrd);
					for (Quiz quiz : recentCreatedQuizzesFrd) {		
						String quizStr = "QuizHomePage.jsp?quizID=" + quiz.getQuizID();
						quizStr= quizStr.substring(0,quizStr.indexOf(" "))+"_"+quizStr.substring(quizStr.indexOf(" ")+1);
				%>
					<span class='news-feed'><a href=<%=quizStr%> target="_blank"><%=quiz.getQuizName()%></a></span>
				<% 
					}
				%>
			</div>
			<div>
				<div class="column-name">Achievements Earned</div>
				<%
					ArrayList<AchievementRecord> achrFrd = new ArrayList<AchievementRecord>();
					for (String frdID : frdIDs) {
						ArrayList<AchievementRecord> recents = Utilities.getRecentAchievements(frdID);
						achrFrd.addAll(recents);
					}
					Collections.sort(achrFrd);
					for (AchievementRecord achr : achrFrd) {
				%>
					<span class='news-feed'><%=achr.usrID%> achieved <%=achr.achID%> at <%=achr.time%></span>
				<%
					}
				%>
			</div>
			<div style="clear: both;"></div>
		</div>
		<div class="uhp-others col-md-3">
			<div class="column-name">OTHERS</div>
			<div>
				<div class="column-name">Announcements</div>
				<%
					ArrayList<String> announcements = new ArrayList<String>();
					announcements = Utilities.getRecentAnnouncements(10);
					
					if (announcements != null) {
						if (announcements.size() != 0) {
							for (String s : announcements) {
				%>
				<p><%=s%></p>
				<%
					}
						} else {
				%>
				<p>No Announcement</p>
				<%
					}
					} else {
				%>
				<p>No Announcement</p>
				<%
}
%>
			</div>
			<div>
				<div class="column-name">Popular Quizzes</div>
				<%
					for (Quiz quiz : popQuizzes) {
						String quizStr = "QuizHomePage.jsp?quizID=" + quiz.getQuizID();
						quizStr= quizStr.substring(0,quizStr.indexOf(" "))+"_"+quizStr.substring(quizStr.indexOf(" ")+1);
				%>
					<span style='padding-left: 10px;'><a href=<%=quizStr%> target="_blank"><%=quiz.getQuizName()%></a></span>
				<%
					}
				%>
			</div>
			<div>
				<div class="column-name">Recently Created Quizzes (in Public)</div>
				<%
					ArrayList<Quiz> recentQuizzesPublic = Utilities.getRecentQuiz();
					Collections.sort(recentQuizzesPublic);
					for (Quiz quiz : recentQuizzesPublic) {
						String quizStr = "QuizHomePage.jsp?quizID=" + quiz.getQuizID();
						quizStr= quizStr.substring(0,quizStr.indexOf(" "))+"_"+quizStr.substring(quizStr.indexOf(" ")+1);
				%>
					<span style='padding-left: 10px;'><a href=<%=quizStr%> target="_blank"><%=quiz.getQuizName()%></a></span>
				<%
					}
				%>
			</div>
			<div style="clear: both;"></div>
		</div>
		<div style="clear: both;"></div>
	</div>
</body>
</html>
