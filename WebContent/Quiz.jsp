<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="Quiz.*"%>
<%@page import="java.util.ArrayList"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
	Quiz quiz = new Quiz(request.getParameter("quizID"));
	quiz = new Quiz("xiaotihu2015-11-23 19:12:15");

	String startTime = QuizSystem.generateCurrentTime();
	if(quiz.isRandom()){
		quiz.shuffleQuestion();
	}
%>

<title>Welcome to <%=quiz.getQuizName() %></title>
</head>
<body>
<%
	if(quiz.isMultiplePages()){
		out.print("<p>hi</p>");
	}else{	
%>

	<form class='total_form' action = "QuizScore.jsp" method="post" >
		<%
			ArrayList<Question> questions = quiz.getQuestions();
			int count=0;
			for(Question q: questions){
				count++;
				out.print("<div class = question"+count+">");
				out.print("<h3>Question "+count+"<h3>");
				if(Question.TYPE_FREERESPONCE.equals(q.getType())){
					out.print("<p class=\'question_description\'>"+ q.getText()+"</p>");
					if(!q.getPic().isEmpty())
						out.print("<img src=\'"+q.getPic()+"\' class=\'question_image\'>");
					out.print("<input type=\'text\' name=\'q"+count+"ans\' value=\'enter here\'>");
				}else if(Question.TYPE_MULTIPLECHOICE.equals(q.getType())){
					out.print("<p class=\'question_description\'>"+ q.getText()+"</p>");
					ArrayList<String> options = q.parseOption();
					int optcnt = 0;
					for(String opt: options){
						optcnt++;
						out.print("<input type=\'radio\' name = \'q"+count+"ans\' value = \'"+optcnt+"\'>"+opt+"</input>");
					}
				}else if(Question.TYPE_MATCHING.equals(q.getType())){
					out.print("<p class=\'question_description\'>"+ q.getText()+"</p>");
					ArrayList<String> optionsleft = q.parseOptionleft();
					ArrayList<String> optionsright = q.parseOptionright();
					int optcnt=1;
					for(String opt: optionsleft){
						out.print("<input type=\'text\' name = \'q"+count+"ans"+optcnt+"\'></input>");
						out.print("<p>"+opt+"</p>");
						out.print("<p>"+optionsright.get(optcnt-1)+"</p>");
						optcnt++;
					}
				}

				
				out.print("</div>");
			}
		%>
		<div id = "rating_review">
			<div id="rating">
				<label>Rating</label>
				<label for="1star">1</label>
				<input type = "radio" name ="rating" value = "1" id = "1star">
				<label for="2star">2</label>
				<input type = "radio" name ="rating" value = "2" id = "2star">
				<label for="3star">3</label>
				<input type = "radio" name ="rating" value = "3" id = "3star">				
				<label for ="4star">4</label>
				<input type = "radio" name ="rating" value = "4" id = "4star">
				<label for ="5star">5</label>
				<input type = "radio" name ="rating" value = "5" id = "5star" checked="checked">
			</div>

			<div>
				<p><label for="review">Submit Review</label></p>

				<textarea rows="3" cols="50" name = "review" id = "review">
				Love the quiz? Add a review now!
				</textarea>		
			</div>

		
		</div>

		
		<input type="hidden" name="quizID" value="<%=quiz.getQuizID() %>">
		<input type="hidden" name="startTime" value="<%=startTime %>">
		<input type="submit" class='total_submit'/>
		
	</form>
<%		
		
	}
%>
</body>
</html>