#include <sys/utsname.h>
#include <sys/stat.h>
#include <mach-o/dyld.h>
#include <sys/syscall.h>
#include <errno.h>
#include <dlfcn.h>
#include <mach/mach.h>
#include <mach-o/dyld_images.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <dirent.h>

uint32_t dyldCount = 0;
char **dyldNames = 0;
struct mach_header **dyldHeaders = 0;
void syncDyldArray() {
	uint32_t count = _dyld_image_count();
	uint32_t counter = 0;
	//NSLog(@"[FlyJB] There are %u images", count);
	dyldNames = (char **) calloc(count, sizeof(char **));
	dyldHeaders = (struct mach_header **) calloc(count, sizeof(struct mach_header **));
	for (int i = 0; i < count; i++) {
		const char *charName = _dyld_get_image_name(i);
		if (!charName) {
			continue;
		}
		NSString *name = [NSString stringWithUTF8String: charName];
		if (!name) {
			continue;
		}
		NSString *lower = [name lowercaseString];
		if ([lower containsString:@"substrate"] ||
		    [lower containsString:@"bawappie"] ||
		    [lower containsString:@"substitute"] ||
		    [lower containsString:@"substitrate"] ||
		    [lower containsString:@"cephei"] ||
		    [lower containsString:@"rocketbootstrap"] ||
		    [lower containsString:@"tweakinject"] ||
		    [lower containsString:@"jailbreak"] ||
		    [lower containsString:@"cycript"] ||
		    [lower containsString:@"pspawn"] ||
		    [lower containsString:@"libcolorpicker"] ||
		    [lower containsString:@"libcs"] ||
		    [lower containsString:@"bfdecrypt"] ||
		    [lower containsString:@"sbinject"] ||
		    [lower containsString:@"dobby"] ||
		    [lower containsString:@"libhooker"] ||
		    [lower containsString:@"snowboard"] ||
		    [lower containsString:@"libblackjack"] ||
		    [lower containsString:@"libobjc-trampolines"] ||
		    [lower containsString:@"cephei"] ||
		    [lower containsString:@"libmryipc"] ||
		    [lower containsString:@"libactivator"] ||
		    [lower containsString:@"alderis"] ||
		    // 아직 이걸 감지하는지는 몰라서 일단 주석
		    // [lower containsString:@"ablicense"] ||
		    // [lower containsString:@"abypass"] ||
		    [lower containsString:@"libcloaky"]) {
			// HBLogError(@"[ABPattern] BYPASSED dyld = %@", name);
			// if(![lower containsString:@"eversafe"])
			continue;
		}
		uint32_t idx = counter++;
		dyldNames[idx] = strdup(charName);
		dyldHeaders[idx] = (struct mach_header *) _dyld_get_image_header(i);
	}
	dyldCount = counter;
}

%group DYLDSaver
%hookf(uint32_t, _dyld_image_count) {
	return dyldCount;
}
%hookf(const char *, _dyld_get_image_name, uint32_t image_index) {
	return dyldNames[image_index];
}
%hookf(struct mach_header *, _dyld_get_image_header, uint32_t image_index) {
	return dyldHeaders[image_index];
}
%end

void DYLDSaver() {
	syncDyldArray();
	%init(DYLDSaver);
}