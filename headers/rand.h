#ifndef RAND_H
#define RAND_H

#include <stdlib.h>
#include <time.h>
#include <QObject>

class Rand : public QObject
{
    Q_OBJECT

public:
    Q_INVOKABLE int randrange(int min, int max);
    Q_INVOKABLE double uniform(double min, double max);
};


#endif