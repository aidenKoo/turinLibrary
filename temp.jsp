SELECT * FROM tblBook WHERE bookTitle like '%" + keyword + "%' or "
author like '%"  + keyword + "%' or publisher like '%" + keyword + "%' or publicationYear like '%" + keyword + "%' or summary like '%" + keyword + "%' or content like '%" + keyword + "%'or"
							+ "sectionCode = (SELECT sectionCode from tblcategory where category like '%" + keyword +"%')";