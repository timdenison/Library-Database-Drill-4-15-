USE dbLibrary
GO

--Find how many copies of The Lost Tribe are at Sharpstown Branch
SELECT lb.branchID,lb.branchname,b.Title,bc.copies FROM library_branches LB 
INNER JOIN book_copies BC
ON LB.BranchID = BC.BranchID JOIN books B
ON BC.BookID = B.BookID
WHERE LB.BranchName = 'Sharpstown' AND B.Title = 'The Lost Tribe'


--How Many copies of The Lost Tribe are owned by each library branch

SELECT B.Title,LB.BranchName,BC.Copies 
	FROM book_copies BC INNER JOIN library_branches LB
	ON BC.BranchID = LB.BranchID JOIN books B
	ON BC.BookID = B.BookID
		WHERE B.Title = 'The Lost Tribe'
		

-- Retreive the names of all the borrowers who do not have any
-- books checked out

SELECT BL.BookID,BR.CardNo,BR.Name
	FROM book_loans BL RIGHT OUTER JOIN borrowers BR
	ON BL.CardNo = BR.CardNo
	WHERE BL.BookID IS NULL
	
SELECT *
	FROM book_copies
	
SELECT LB.BranchName, B.Title, BC.Copies
	FROM book_copies BC INNER JOIN library_branches LB
	ON BC.BranchID = LB.BranchID JOIN books B
	ON B.BookID = BC.BookID
	WHERE LB.BranchName = 'Hobbiton'
	
	--4. For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today,
--retrieve the book title, the borrower's name, and the borrower's address.

SELECT B.Title, BR.Name,BR.[Address],BL.DateDue
	FROM book_loans BL INNER JOIN borrowers BR
	ON BL.CardNo = BR.CardNo JOIN books B
	ON B.BookID = BL.BookID JOIN library_branches LB
	ON BL.BranchID = LB.BranchID
	WHERE DateDue BETWEEN '2015-04-06' AND '2015-04-10'
	AND LB.BranchName = 'Sharpstown'
--5. For each library branch, retrieve the branch name and the total number of books loaned out from
--that branch.

SELECT * 
FROM book_copies bc INNER JOIN library_branches lb
ON bc.BranchID = lb.BranchID

SELECT lb.BranchName,SUM(bc.copies) as TotalCopies
FROM book_copies bc INNER JOIN library_branches lb
ON bc.BranchID = lb.BranchID
GROUP BY lb.BranchName

--6. Retrieve the names, addresses, and number of books 
--checked out for all borrowers who have more
--than five books checked out.

SELECT b.Name,b.[Address],COUNT(Name) as BooksOut
	FROM borrowers b INNER JOIN book_loans bl
	ON b.CardNo = bl.CardNo
GROUP BY b.Name,b.[address]
HAVING COUNT(Name) > 5
ORDER BY BooksOut DESC





--7. For each book authored (or co-authored) by "Stephen King", 
--   retrieve the title and the number of
--   copies owned by the library branch whose name is "Central"

SELECT B.Title,BA.AuthorName,BC.Copies,LB.BranchName
	FROM book_copies BC INNER JOIN library_branches LB
	ON BC.BranchID = LB.BranchID JOIN books B
	ON B.BookID = BC.BookID JOIN book_authors BA
	ON BA.AuthorBookID = B.BookID
	WHERE LB.BranchName = 'Central' AND BA.AuthorName = 'Stephen King'