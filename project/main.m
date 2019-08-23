//

//  main.m

#import <UIKit/UIKit.h>
#import "project-Swift.h"

/***************************阻止动态调试****************************/
//1.引入dlfcn.h 文件

#import <dlfcn.h>
#import <sys/types.h>

//2.预定义
typedef int (*ptrace_ptr_t)(int _request, pid_t _pid, caddr_t _addr, int _data);
#if !defined(PT_DENY_ATTACH)
#define PT_DENY_ATTACH 31
#endif

//3.定义函数
void disable_gdb(){
    void * handle = dlopen(0, RTLD_GLOBAL | RTLD_NOW);
    ptrace_ptr_t ptrace_ptr = dlsym(handle, "ptrace");
    ptrace_ptr(PT_DENY_ATTACH, 0, 0, 0);
    dlclose(handle);
}

//4.在main.m文件main方法中调用
int main(int argc, char * argv[]) {
    
#if !(DEBUG)
      disable_gdb();
#endif
    
    @autoreleasepool {
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        
    }
    
}

