from flask import Flask, request, make_response, jsonify, send_from_directory
from dbHelper import *
import json
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World!'
 
@app.route('/pook_user/<user_id>') # URL뒤에 <>을 이용해 가변 경로를 적는다
def pook_user(user_id):
    db=dbHelper()
    result=db.getalldata("select * from pook_user where user_id='"+user_id+"'")
    
    res = make_response(json.dumps(result, ensure_ascii=False))
    res.headers['Content-Type'] = 'application/json'
    return res

@app.route('/pook_user_insert', methods=['POST'])
def pook_user_insert():
	user_id = request.form['user_id']
	nickname = request.form['nickname']
	phone = request.form['phone']
	print("=====================user========================")
	print(user_id)
	print(nickname)
	print(phone)
	print("=============================================")
	db=dbHelper()
	db.executedata("insert into pook_user (user_id, nickname, phone) values ('"+user_id+"','"+nickname+"','"+phone+"')")
	return jsonify(result="200")

@app.route('/pook_all_store')
def pook_all_store():
    db=dbHelper()
    result=db.getalldata("""
		SELECT * FROM pook_store
    """)

    res = make_response(json.dumps(result, ensure_ascii=False))
    res.headers['Content-Type'] = 'application/json'
    return res

@app.route('/pook_store', methods=['POST'])
def pook_store():
	page = request.form['page']
	search_category = request.form['search_category']
	search_text = request.form['search_text']

	search_option_str = ""
	if(search_category == "전체"):
		search_category = ""

	if(search_category != ""):
		search_option_str = search_option_str + "and category like '%" + search_category + "%'"
	if(search_text != ""):
		search_option_str = search_option_str + "and name like '%" + search_text + "%'"

	db=dbHelper()
	result=db.getalldata("""
		SELECT 
			B.store_id,
			B.name,
			B.contents,
			B.addr,
			B.phone,
			B.category,
			B.open,
			B.breaktime,
			B.parking,
			B.reserve_yn,
			B.location_x,
			B.location_y,
			B.thumbnail_path,
			B.score_avg
		FROM(
			SELECT CEIL(page_num / 5) as page, A.* FROM
			(
				SELECT
			    	CAST(@ROWNUM:=@ROWNUM+1 AS SIGNED) AS page_num,
			 		tb.*
			 	FROM
			 	(
					SELECT 
						a.*
					FROM
					(
						SELECT 
							c.*,
							(select IFNULL(CAST(CAST(AVG(CAST(score as DECIMAL(11,1))) as DECIMAL(11,1)) as char(11)),'0.0') from pook_review where store_id = c.store_id) as score_avg
						FROM 
							pook_store c
						where 
							1=1
							"""+search_option_str+"""
					) a
					ORDER BY a.score_avg desc,a.store_id*1 asc
			 	) tb,
				(SELECT @ROWNUM:=0) as R
			) A
			WHERE CEIL(page_num/IFNULL(5, 5)) = IFNULL("""+str(page)+""",1)
		) B
	""")

	res = make_response(json.dumps(result, ensure_ascii=False))
	res.headers['Content-Type'] = 'application/json'
	return res


@app.route('/pook_store_detail', methods=['POST'])
def pook_store_detail():
	store_id = request.form['store_id']
	user_id = request.form['user_id']

	db=dbHelper()
	result=db.getonedata("""
		SELECT 
			a.*,
			(SELECT CAST(COUNT(*) AS CHAR(20)) FROM pook_favorite WHERE store_id ='"""+store_id+"""' and user_id='"""+user_id+"""') AS favorite_cnt
		FROM 
			pook_store a
		WHERE
			a.store_id = '"""+store_id+"""'
	""")

	res = make_response(json.dumps(result, ensure_ascii=False))
	res.headers['Content-Type'] = 'application/json'
	return res

@app.route('/pook_reserve/<user_id>')
def pook_reserve(user_id):
    db=dbHelper()
    result=db.getalldata("""
    	SELECT 
    		b.reserve_id,
    		b.store_id,
    		b.store_name,
    		b.user_id,
    		b.reserve_people,
    		b.reserve_date,
    		b.reserve_time
		FROM(
			SELECT 
				a.reserve_id,
				a.store_id,
				(SELECT name FROM pook_store WHERE store_id = a.store_id) AS store_name,
				a.user_id,
				a.reserve_people,
				a.reserve_date,
				a.reserve_time,
				CAST(CONCAT(a.reserve_date,' ',a.reserve_time) AS datetime) AS cast_datetime 
			from pook_reserve a
			WHERE user_id = '"""+user_id+"""'
		) b
		ORDER BY b.cast_datetime
    """)
    #WHERE b.cast_datetime >= NOW()
    
    res = make_response(json.dumps(result, ensure_ascii=False))
    res.headers['Content-Type'] = 'application/json'
    print(json.dumps(result, ensure_ascii=False))
    return res

@app.route('/pook_reserve_insert', methods=['POST'])
def pook_reserve_insert():
	store_id = request.form['store_id']
	user_id = request.form['user_id']
	reserve_people = request.form['reserve_people']
	reserve_date = request.form['reserve_date']
	reserve_time = request.form['reserve_time']
	print("==================reserve===========================")
	print(user_id)
	print(reserve_people)
	print(reserve_date)
	print(reserve_time)
	print("=============================================")
	db=dbHelper()
	db.executedata("""
		insert into pook_reserve (reserve_id, store_id, user_id, reserve_people, reserve_date, reserve_time) values 
		((SELECT IFNULL(CAST(MAX(a.reserve_id*1)+1 AS CHAR(20)),1) AS test FROM pook_reserve a), '"""+store_id+"""', '"""+user_id+"""','"""+reserve_people+"""','"""+reserve_date+"""','"""+reserve_time+"""')
	""")
	return jsonify(result="200")

@app.route('/pook_review/<store_id>') # URL뒤에 <>을 이용해 가변 경로를 적는다
def pook_review(store_id):
    db=dbHelper()
    result=db.getalldata("select * from pook_review where store_id='"+store_id+"' ORDER BY (review_id*1) asc")
    
    res = make_response(json.dumps(result, ensure_ascii=False))
    res.headers['Content-Type'] = 'application/json'
    return res



@app.route('/pook_review_insert', methods=['POST'])
def pook_review_insert():
	user_id = request.form['user_id']
	nickname = request.form['nickname']
	store_id = request.form['store_id']
	score = request.form['score']
	review = request.form['review']
	print("==================review===========================")
	print(user_id)
	print(nickname)
	print(store_id)
	print(score)
	print(review)
	print("=============================================")
	db=dbHelper()
	db.executedata("""
		insert into pook_review (review_id, user_id, nickname, store_id, score, review) values 
		((SELECT IFNULL(CAST(MAX(a.review_id*1)+1 AS CHAR(20)),1) AS test FROM pook_review a), '"""+user_id+"""', '"""+nickname+"""','"""+store_id+"""','"""+score+"""','"""+review+"""')
	""")
	return jsonify(result="200")

@app.route('/pook_all_category')
def pook_all_category():
    db=dbHelper()
    result=db.getalldata("""
		SELECT category FROM pook_store GROUP BY category ORDER BY category ASC
    """)

    res = make_response(json.dumps(result, ensure_ascii=False))
    res.headers['Content-Type'] = 'application/json'
    return res


@app.route('/pook_favorite_list', methods=['POST'])
def pook_favorite_list():
	user_id = request.form['user_id']

	db=dbHelper()
	result=db.getalldata("""
		SELECT 
			b.*,
			(select IFNULL(CAST(CAST(AVG(CAST(score as DECIMAL(11,1))) as DECIMAL(11,1)) as char(11)),'0.0') from pook_review where store_id = b.store_id) as score_avg
		FROM 
			pook_favorite a, pook_store b 
		WHERE 
			a.user_id = '"""+user_id+"""' 
			and a.store_id = b.store_id
	""")

	res = make_response(json.dumps(result, ensure_ascii=False))
	res.headers['Content-Type'] = 'application/json'
	return res

@app.route('/pook_favorite_insert', methods=['POST'])
def pook_favorite_insert():
	user_id = request.form['user_id']
	store_id = request.form['store_id']
	db=dbHelper()
	db.executedata("""
		insert into pook_favorite (favorite_id, user_id, store_id) values 
		((SELECT IFNULL(CAST(MAX(a.favorite_id*1)+1 AS CHAR(20)),1) AS favorite_id FROM pook_favorite a), '"""+user_id+"""', '"""+store_id+"""')
	""")
	return jsonify(result="200")

@app.route('/pook_favorite_delete', methods=['POST'])
def pook_favorite_delete():
	user_id = request.form['user_id']
	store_id = request.form['store_id']
	db=dbHelper()
	db.executedata("""
		delete from pook_favorite where user_id='"""+user_id+"""' and store_id='"""+store_id+"""'
	""")
	return jsonify(result="200")

if __name__ == "__main__":
	app.run(host='0.0.0.0')
