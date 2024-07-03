/* Include files */

#include "model_cgxe.h"
#include "m_iOZeEDZRCxmAiTWEIn3EAE.h"
#include "m_Cb7aKKaIGPUv5eb5pz1rVG.h"

unsigned int cgxe_model_method_dispatcher(SimStruct* S, int_T method, void* data)
{
  if (ssGetChecksum0(S) == 181942712 &&
      ssGetChecksum1(S) == 211979882 &&
      ssGetChecksum2(S) == 487995676 &&
      ssGetChecksum3(S) == 1364160168) {
    method_dispatcher_iOZeEDZRCxmAiTWEIn3EAE(S, method, data);
    return 1;
  }

  if (ssGetChecksum0(S) == 3101409414 &&
      ssGetChecksum1(S) == 597735598 &&
      ssGetChecksum2(S) == 3382801679 &&
      ssGetChecksum3(S) == 3523767298) {
    method_dispatcher_Cb7aKKaIGPUv5eb5pz1rVG(S, method, data);
    return 1;
  }

  return 0;
}
