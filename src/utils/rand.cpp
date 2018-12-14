#include <rand.h>

int Rand::randrange(int min, int max) {
	// srand((unsigned)time(NULL)); 
	return min + (int)max * rand() / (RAND_MAX + 1);
}

double Rand::uniform(double min, double max) {
	// srand((unsigned)time(NULL)); 
	double f = (double)rand() / RAND_MAX;
	return min + f * (max - min);
}

// #include "rand.moc"
#include <moc_rand.cpp>