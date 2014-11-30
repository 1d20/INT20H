from py2neo import neo4j, node, rel

graph_db = None

def db():
    global graph_db
    if not graph_db:
        graph_db = neo4j.GraphDatabaseService("http://localhost:7474/db/data/")
    return graph_db

def by_id(id):
    return node(neo4j.Node("http://localhost:7474/db/data/node/%d"%int(id)))
def user_node(id):
    l = [neo4j.Node(path) for path in db().find("User",property_key="uid", property_value=id)]
    if len(l)==1:
        n, = l
    else:
        n, = db().create(node({"uid":id}))
        n.add_labels("User")
    return n

def seed():
    db().clear()
    def ss(arr, label, parents=None):
        i = 0
        for a in arr:
            n, = db().create(node(a))
            n.add_labels(label)
            if parents:
                db().create(rel((n, "realate_to", parents[i])))
                i+=1

    countries = [
        {'code':'UA', 'name':'Ukraine'},
        {'code':'AT', 'name':'Atlantida'},
        {'code':'UK', 'name':'Kuda'},
    ]
    ss(countries, "Country")

    universities = [
        {'code':'KPI','name':'Kiev Pol Inst'},
        {'code':'MTI','name':'Mosc Tech Inst'},
        {'code':'LPF','name':'Lol pol Fuck'},
    ]
    ss(universities, "University", [neo4j.Node(path) for path in db().find("Country")])

def create(label, values, parent):
    n, = db().create(node(values))
    n.add_labels(str(label))

    db().create(rel((n, "realate_to", by_id(parent))))

def find_by_label(user_id, label):
    nodes = []
    for n in [neo4j.Node(path) for path in db().find(label)]:
        nn = n.get_properties()
        nn['id'] = n._id
        nn['likes'] = len(list(db().match(rel_type='like', end_node=n)))
        nn['is_liked'] = len(list(db().match(rel_type='like', end_node=n, start_node=user_node(user_id))))
        nodes.append(nn)
    return nodes

def find_by_id(user_id, id):
    n = by_id(id)
    nn = n.get_properties()
    nn['likes'] = len(list(db().match(rel_type='like', end_node=n)))
    nn['is_liked'] = len(list(db().match(rel_type='like', end_node=n, start_node=user_node(user_id))))
    return nn

def like(user_id, id):
    n = user_node(user_id)
    likes = list(db().match(rel_type='like', end_node=by_id(id), start_node=n))
    is_liked = len(likes)
    if is_liked == 0:
        db().create(rel((n, "like", by_id(id))))
        return 1, len(list(db().match(rel_type='like', end_node=by_id(id))))
    else:
        likes[0].delete()
        return -1, len(list(db().match(rel_type='like', end_node=by_id(id))))

















