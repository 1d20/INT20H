from py2neo import neo4j

graph_db = None

def db():
    global graph_db
    if not graph_db:
        graph_db = neo4j.GraphDatabaseService("http://localhost:7474/db/data/")
    return graph_db

def create(node_type, values):
    parent = values['parent']
    del values['parent']

    node = db().create(values)
    node.set_label(node_type.name)

    rel((node, "realate_to", parent))

def find_by_label(label):
    return [neo4j.Node(path).get_properties() for path in db().find(label)]

def find_by_id(id):
    return neo4j.Node("http://localhost:7474/db/data/node/%d"%int(id)).get_properties()
