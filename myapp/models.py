from neomodel import StructuredNode, StringProperty, IntegerProperty, RelationshipTo, RelationshipFrom, BooleanProperty

class Country(StructuredNode):
    code = StringProperty(unique_index=True, required=True)
    name = StringProperty(unique_index=True, required=True)
    #contains
    universities = RelationshipFrom('University', 'country')

class University(StructuredNode):
    name = StringProperty(unique_index=True, required=True)
    #in
    country = RelationshipTo(Country, 'country')
    #contains
    faculties = RelationshipFrom('Faculty', 'university')

class Faculty(StructuredNode):
    code = StringProperty(unique_index=True, required=True)
    name = StringProperty(unique_index=True, required=True)
    #in
    university = RelationshipTo(University, 'university')
    #contains
    departments = RelationshipFrom('Department', 'faculty')

class Department(StructuredNode):
    code = StringProperty(unique_index=True, required=True)
    name = StringProperty(unique_index=True, required=True)
    #in
    faculty = RelationshipTo(Faculty, 'faculty')
    #contains
    groups = RelationshipFrom('Group', 'department')
    staff = RelationshipFrom('Employee', 'department')

class Group(StructuredNode):
    code = StringProperty(unique_index=True, required=True)
    name = StringProperty(unique_index=True, required=True)
    #in
    department = RelationshipTo(Department, 'department')
    #contains
    students = RelationshipFrom('Student', 'group')

class Student(StructuredNode):
    code = StringProperty(unique_index=True, required=True)
    name = StringProperty(unique_index=True, required=True)
    is_lead = BooleanProperty(required=True, default=False)
    #in
    group = RelationshipTo(Group, 'group')

class Employee(StructuredNode):
    name = StringProperty(unique_index=True, required=True)
    post = StringProperty(required=True)
    #in
    department = RelationshipTo(Department, 'department')
