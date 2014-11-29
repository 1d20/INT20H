from neomodel import StructuredNode, StringProperty, IntegerProperty, RelationshipTo, RelationshipFrom, BooleanProperty, One

class Country(StructuredNode):
    code = StringProperty(unique_index=True, required=True)
    name = StringProperty(unique_index=True, required=True)
    #contains
    universities = RelationshipFrom('University', 'country')

    def to_json(self):
        return {'code':self.code, 'name':self.name}
    def to_full_json(self):
        return {'code':self.code, 'name':self.name, 'universities':[u.to_json() for u in self.universities.all()]}

class University(StructuredNode):
    code = StringProperty(unique_index=True, required=True)
    name = StringProperty(unique_index=True, required=True)
    #in
    country = RelationshipTo(Country, 'country', cardinality=One)
    #contains
    faculties = RelationshipFrom('Faculty', 'university')

    def to_json(self):
        return {'code':self.code, 'name':self.name, 'country':self.country.all()[0].code}
    def to_full_json(self):
        return {'code':self.code, 'name':self.name, 'country':self.country.all()[0].code, 'faculties':[u.to_json() for u in self.faculties]}

class Faculty(StructuredNode):
    code = StringProperty(unique_index=True, required=True)
    name = StringProperty(unique_index=True, required=True)
    #in
    university = RelationshipTo(University, 'university', cardinality=One)
    #contains
    departments = RelationshipFrom('Department', 'faculty')

    def to_json(self):
        return {'code':self.code, 'name':self.name, 'university':self.university.all()[0].code}
    def to_full_json(self):
        return {'code':self.code, 'name':self.name, 'university':self.university.all()[0].code, 'departments':[u.to_json() for u in self.departments]}

class Department(StructuredNode):
    code = StringProperty(unique_index=True, required=True)
    name = StringProperty(unique_index=True, required=True)
    #in
    faculty = RelationshipTo(Faculty, 'faculty', cardinality=One)
    #contains
    groups = RelationshipFrom('Group', 'department')
    staff = RelationshipFrom('Employee', 'department')

    def to_json(self):
        return {'code':self.code, 'name':self.name, 'university':self.university.all()[0].code}
    def to_full_json(self):
        return {'code':self.code, 'name':self.name, 'university':self.university.all()[0].code, 'departments':[u.to_json() for u in self.departments]}

class Group(StructuredNode):
    code = StringProperty(unique_index=True, required=True)
    name = StringProperty(unique_index=True, required=True)
    #in
    department = RelationshipTo(Department, 'department', cardinality=One)
    #contains
    students = RelationshipFrom('Student', 'group')

class Student(StructuredNode):
    code = StringProperty(unique_index=True, required=True)
    name = StringProperty(unique_index=True, required=True)
    is_lead = BooleanProperty(required=True, default=False)
    #in
    group = RelationshipTo(Group, 'group', cardinality=One)

class Employee(StructuredNode):
    name = StringProperty(unique_index=True, required=True)
    post = StringProperty(required=True)
    #in
    department = RelationshipTo(Department, 'department')
