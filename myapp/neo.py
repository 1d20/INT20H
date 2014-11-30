from py2neo import neo4j, node, rel

graph_db = None

def db():
    global graph_db
    if not graph_db:
        graph_db = neo4j.GraphDatabaseService("http://localhost:7474/db/data/")
    return graph_db

def by_id(id):
    return node(neo4j.Node("http://localhost:7474/db/data/node/%d"%int(id)))

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
    n.add_labels(label)

    db().create(rel((n, "realate_to", by_id(parent))))

def find_by_label(label):
    nodes = []
    for n in [neo4j.Node(path) for path in db().find(label)]:
        nn = n.get_properties()
        nn['id'] = n._id
        nodes.append(nn)
    return nodes

def find_by_id(id):
    return by_id(id).get_properties()

def like(user_id, id):
    l = [neo4j.Node(path) for path in db().find("User",property_key="uid", property_value=user_id)]
    if len(l)==1:
        user_node, = l
    else:
        user_node, = db().create(node({"uid":user_id}))
        user_node.add_labels("User")

    db().create(rel((user_node, "like", by_id(id))))


















