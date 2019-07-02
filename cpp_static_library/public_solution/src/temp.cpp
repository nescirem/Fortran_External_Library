#include <iostream>
using namespace std;
class IntStack 

{
	public:
		IntStack(int num) { top = 0; maxelem = num; s = new int[maxelem]; }
		~IntStack() { if (s != nullptr) delete[] s; }
		void  push(int t) {
			if (top == maxelem) return;
			s[top++] = t;
		}
		int pop() {
			if (top == 0) return -1;
			return s[--top];
		}
		void display() {
			cout << "IntStack::Display\n";
			if (top == 0) { cout << "(empty)\n";  return; }
			for (int t = 0; t < top; t++) cout << s[t] << " ";
			cout << "\n";
		}
	private:
		int *s;
		int top;
		int maxelem;
};

typedef void * OpaqueObject;

// Function prototypes

extern "C" {
		OpaqueObject GetObject(int);
		void ExerciseObject2(OpaqueObject);
}

OpaqueObject GetObject(int s_size) {
		IntStack *s = new IntStack(s_size);
		return (OpaqueObject)s;

}

void ExerciseObject2(OpaqueObject foo) {
		IntStack *s = (IntStack *)foo;
		s->display();
		return;
}
