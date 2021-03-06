// lab_02_instruction_performance.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <fstream>

void inline add_register()
{
	__asm{
		add eax, edx
	}
}

void inline add_variable()
{
	int var1 = 10;
	int var2 = 450;
	__asm{
		mov edx, var2
		add var1, edx
	}
}

void inline mul_register()
{
	__asm{
		imul eax, edx
	}
}

void inline fdiv_register()
{
	double var1 = 34251.0;
	double var2 = 32424;
	__asm{
		fld var1;
		fld var2;
		fdiv;
	}
}

void inline fsub_register()
{
	double var1 = 34251.0;
	double var2 = 32424;
	__asm{
		fld var1;
		fld var2;
		fsub;
	}
}

void inline sort_static_array()
{
	int arr[10] = { 5, 3, 2, 9, 8, 1, 0, -1, 23, 2};
	const int len = sizeof(arr)/sizeof(arr[0]);
	for(int i = 0; i < len; i++)
	{
		for(int j = i; j < len; j++)
		{
			if (arr[i] > arr[j])
			{
				int tmp = arr[i];
				arr[i] = arr[j];
				arr[j] = tmp;
			}
		}
	}
}

void inline sort_dynamic_array()
{
	const int len = 10;
	int* arr = (int*)malloc(sizeof(int) * len);
	arr[0] = 5;
	arr[1] = 3;
	arr[2] = 2;
	arr[3] = 9;
	arr[4] = 8;
	arr[5] = 1;
	arr[6] = 0;
	arr[7] = -1;
	arr[8] = 23;
	arr[9] = 2;
	for(int i = 0; i < len; i++)
	{
		for(int j = i; j < len; j++)
		{
			if (arr[i] > arr[j])
			{
				int tmp = arr[i];
				arr[i] = arr[j];
				arr[j] = tmp;
			}
		}
	}
}

int main()
{
	unsigned cycles_high1 = 0, cycles_low1 = 0, cpuid_time = 0;
	unsigned cycles_high2 = 0, cycles_low2 = 0;
	unsigned __int64 temp_cycles1 = 0, temp_cycles2 = 0;
	unsigned __int64 total_cycles = 0;
	//compute the CPUID overhead 
	__asm {
		pushad
		CPUID
		RDTSC
		mov cycles_high1, edx
		mov cycles_low1, eax
		popad
		pushad
		CPUID
		RDTSC
		popad
		pushad
		CPUID
		RDTSC
		mov cycles_high1, edx
		mov cycles_low1, eax
		popad
		pushad
		CPUID
		RDTSC
		popad
		pushad
		CPUID
		RDTSC
		mov cycles_high1, edx
		mov cycles_low1, eax
		popad
		pushad
		CPUID
		RDTSC
		sub eax, cycles_low1
		mov cpuid_time, eax
		popad
	}
	cycles_high1 = 0;
	cycles_low1 = 0;
	//Measure the code sequence 
	__asm {
		pushad
		CPUID
		RDTSC
		mov cycles_high1, edx
		mov cycles_low1, eax
		popad
	}

	sort_dynamic_array();

	__asm {
		pushad
		CPUID
		RDTSC
		mov cycles_high2, edx
		mov cycles_low2, eax
		popad
	}
	temp_cycles1 = ((unsigned __int64)cycles_high1 << 32) | cycles_low1;
	temp_cycles2 = ((unsigned __int64)cycles_high2 << 32) | cycles_low2;
	total_cycles = temp_cycles2 - temp_cycles1 - cpuid_time;

	printf("total time:%lld\n", total_cycles);
    return 0;
}

