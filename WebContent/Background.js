/**
 * 
 */

document.write("<div class='header-line'> <div class='logo-header'> <div class='logo-header-large'><a href='UserHomePage.jsp'>Quizzzz</a></div> <div class='logo-header-small'>Only fun learning wakes us up</div> </div> <div class='personal-header'> <div class='inline-part'> <form method='POST' action='Person.jsp' target='_blank'> <input type='search' name='person' placeholder='search by user ID' style='color: black;' size='25'> <input type='submit' value='Submit' style='color: black;'> </form> </div> <div class='inline-part'> <span> Welcome, <%=usrID%></span> </div> <div class='inline-part' id='popup-parent'> <form name='submitFormMsg' method='POST' action='Messages.jsp' target='_blank'> <input type='hidden' name='usrID' value='<%=usrID%>'> <a href='javascript:document.submitFormMsg.submit()' target='_blank'>Messages <% if (unreadMsg.size() > 0) { out.print('(' + unreadMsg.size() + ')'); } %> </a> </form> </div> <div id='popup-child'> <% int newFriendRequests = 0, newChallenges = 0, newTextMessages = 0; for (Message msg : unreadMsg) { if((msg.fromID).equals(usrID)) continue; char type = msg.type.charAt(0); switch (type) { case 'f': newFriendRequests++; break; case 'c': newChallenges++; break; case 't': newTextMessages++; break; default: newTextMessages++; break; } } %> <p> New friend request: <%=newFriendRequests%></p> <p> New challenges: <%=newChallenges%></p> <p> New text messages: <%=newTextMessages%></p> </div> <div class='inline-part'> <a href='logout.jsp'>Log Out</a> </div> </div> <div style='clear: both;'></div> </div>");