#include "mex.h"
#include "../fastMult.h"
#include "mexCheckMacros.h"

/* Entry point */
void mexFunction( int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    double *A, *v, *B;
    size_t numElMat;                   /* size of matrix */

    mexCheckNargin(2);
    mexCheckNargout(1);
    
    /* make sure the arguments are real */
    mexCheckArginReal(0);
    mexCheckArginReal(1);
      
    /* check inputs have compatible lengths */
    mexCheckGeneric(mxGetNumberOfElements(prhs[0]) != 3*mxGetNumberOfElements(prhs[1]),\
		    "wrongNumEl", "Inputs must have the same number of elements.");
    
    /* check inputs have a number of elements divisible by 3 and 9 */
    mexCheckNElemMultiple(0,9);
    mexCheckNElemMultiple(1,3);
    

    /* create a pointer to the real data in the input matrix  */
    A = mxGetPr(prhs[0]);
    v = mxGetPr(prhs[1]);    

    /* get dimensions of the input matrix */
    numElMat = mxGetNumberOfElements(prhs[0]);

    /* create the output matrix */
    plhs[0] = mxCreateDoubleMatrix(9, (mwSize)numElMat/9,mxREAL);

    /* get a pointer to the real data in the output matrix */
    B = mxGetPr(plhs[0]);

    /* call the computational routine */
    fastMult3x3MatHat(A,v,B,numElMat/9);
}
