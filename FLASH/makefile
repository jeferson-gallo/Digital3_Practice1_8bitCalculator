################################################################################
# Automatically-generated file. Do not edit!
################################################################################

#Progress monitor hint: 1
first : all
-include ../makefile.init

# This file contains definitions of environment variables used in the makefiles and .args files if exist.
-include makefile.local

RM := "$(GNU_Make_Install_DirEnv)/rm" -f

# All of the sources participating in the build are defined here
-include sources.mk
-include subdir.mk
-include Sources/subdir.mk
-include Project_Settings/Linker_Files/subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(ASM_DEPS)),)
-include $(ASM_DEPS)
endif
ifneq ($(strip $(ASM_UPPER_DEPS)),)
-include $(ASM_UPPER_DEPS)
endif
ifneq ($(strip $(S_DEPS)),)
-include $(S_DEPS)
endif
ifneq ($(strip $(S_UPPER_DEPS)),)
-include $(S_UPPER_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 
OBJS += \
default.lst \
Practice_1_Calculator_8bits.obj \

OBJS_QUOTED += \
"default.lst" \
"Practice_1_Calculator_8bits.obj" \

OBJS_OS_FORMAT += \
default.lst \
Practice_1_Calculator_8bits.obj \

EXECUTABLES += \
Practice_1_Calculator_8bits.obj \

EXECUTABLES_QUOTED += \
"Practice_1_Calculator_8bits.obj" \

EXECUTABLES_OS_FORMAT += \
Practice_1_Calculator_8bits.obj \

BURNER_OUTPUT_OUTPUTS += \
Practice_1_Calculator_8bits.obj.s19 \

BURNER_OUTPUT_OUTPUTS_QUOTED += \
"Practice_1_Calculator_8bits.obj.s19" \

BURNER_OUTPUT_OUTPUTS_OS_FORMAT += \
Practice_1_Calculator_8bits.obj.s19 \


# All Target
call-burner := 0
ifneq ($(strip $(EXECUTABLES)),)
ifneq ($(strip $(BBL_SRCS_QUOTED)),)
call-burner := 1
endif
endif
ifeq ($(call-burner),1)
all: Practice_1_Calculator_8bits.obj Practice_1_Calculator_8bits.obj.s19
else
all: Practice_1_Calculator_8bits.obj
endif

# Tool invocations
Practice_1_Calculator_8bits.obj: $(ASM_SRCS)
	@echo 'Building target: $@'
	@echo 'Executing target #2 $@'
	@echo 'Invoking: HCS08 Assembler'
	"$(HC08ToolsEnv)/ahc08" -Objn"Practice_1_Calculator_8bits.obj" -ArgFile"Practice_1_Calculator_8bits.args" $(ASM_SRCS_QUOTED) $(ASM_SRCS_QUOTED)
	@echo 'Finished building target: $@'
	@echo ' '

Practice_1_Calculator_8bits.obj.s19: $(BBL_SRCS) $(EXECUTABLES)
	@echo 'Executing target #3 $@'
	@echo 'Invoking: S08 Burner'
	"$(HC08ToolsEnv)/burner" -ArgFile"Practice_1_Calculator_8bits.obj.args" -f="$<" -env"ABS_FILE=$(strip $(EXECUTABLES_OS_FORMAT))"
	@echo 'Finished building: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(S_DEPS_QUOTED) "./*/*.d"  $(BURNER_OUTPUT_OUTPUTS_QUOTED) $(ASM_UPPER_DEPS_QUOTED) "./*/*.obj"  $(EXECUTABLES_QUOTED) $(S_UPPER_DEPS_QUOTED) $(ProjDirPath)/FLASH/Practice_1_Calculator_8bits.obj $(ProjDirPath)/FLASH/Practice_1_Calculator_8bits.args $(ProjDirPath)/FLASH/Practice_1_Calculator_8bits.obj.args $(ProjDirPath)/FLASH/Practice_1_Calculator_8bits.obj.s19 $(ProjDirPath)/FLASH/Practice_1_Calculator_8bits.sx
	-@echo ' '

.PHONY: all clean dependents explicit-dependencies warning-messages
.SECONDARY:

-include ../makefile.targets

explicit-dependencies: 

warning-messages: 

