Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5642C2A73F3
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Nov 2020 01:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731909AbgKEAqo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Nov 2020 19:46:44 -0500
Received: from linux.microsoft.com ([13.77.154.182]:55244 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbgKEAqo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Nov 2020 19:46:44 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id E05C920B4905;
        Wed,  4 Nov 2020 16:46:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E05C920B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1604537201;
        bh=FcpXip4SnaLZonzdroaJgZEK4ET64vyGWJ2K22UIRtc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=I6oaX2fdGMmOelsdwFCLUyCEb7GXNNEXAY/vz3Nec6e4v+yUVAnMhlU4F+lE+0SA0
         peFnS1S8KBboebVJIyZlSyjXtOCef2ES9jJyQmdtWnFjwyQ1bR1+F02CACDaxCT3Dw
         pcRqwNWL/2t07zeOYoDyTw2xGDlpquvCwdSfwfto=
Subject: Re: [PATCH v8 1/4] powerpc: Refactor kexec functions to move arch
 independent code to drivers/of
To:     Rob Herring <robh@kernel.org>
Cc:     zohar@linux.ibm.com, bauerman@linux.ibm.com,
        gregkh@linuxfoundation.org, james.morse@arm.com,
        catalin.marinas@arm.com, sashal@kernel.org, will@kernel.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        frowand.list@gmail.com, vincenzo.frascino@arm.com,
        mark.rutland@arm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, masahiroy@kernel.org, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com
References: <20201030174429.29893-1-nramas@linux.microsoft.com>
 <20201030174429.29893-2-nramas@linux.microsoft.com>
 <20201104222847.GA14199@bogus>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <ef0b4d87-1f60-5692-2ba2-47806341d629@linux.microsoft.com>
Date:   Wed, 4 Nov 2020 16:46:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201104222847.GA14199@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/4/20 2:28 PM, Rob Herring wrote:

Hi Rob,

Thanks for reviewing the patch.

> On Fri, Oct 30, 2020 at 10:44:26AM -0700, Lakshmi Ramasubramanian wrote:
>> The functions remove_ima_buffer() and delete_fdt_mem_rsv() that handle
>> carrying forward the IMA measurement logs on kexec for powerpc do not
>> have architecture specific code, but they are currently defined for
>> powerpc only.
>>
>> remove_ima_buffer() and delete_fdt_mem_rsv() are used to remove
>> the IMA log entry from the device tree and free the memory reserved
>> for the log. These functions need to be defined even if the current
>> kernel does not support carrying forward IMA log across kexec since
>> the previous kernel could have supported that and therefore the current
>> kernel needs to free the allocation.
>>
>> Rename remove_ima_buffer() to remove_ima_kexec_buffer().
>> Define remove_ima_kexec_buffer() and delete_fdt_mem_rsv() in
>> drivers/of/fdt.c. A later patch in this series will use these functions
>> to free the allocation, if any, made by the previous kernel for ARM64.
>>
>> Define FDT_PROP_IMA_KEXEC_BUFFER for the chosen node, namely
>> "linux,ima-kexec-buffer", that is added to the DTB to hold
>> the address and the size of the memory reserved to carry
>> the IMA measurement log.
>>
>> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> Reported-by: kernel test robot <lkp@intel.com> error: kernel/kexec_file_fdt.c:30: undefined reference to `fdt_num_mem_rsv'
> 
> This should be added for a commit fixing the reported problem. 0-day
> didn't report what this patch implements.
I'll remove that in the updated patch I'll post.

> 
>> ---
>>   arch/powerpc/include/asm/ima.h   |  10 +--
>>   arch/powerpc/include/asm/kexec.h |   1 -
>>   arch/powerpc/kexec/file_load.c   |  33 +---------
>>   arch/powerpc/kexec/ima.c         |  55 +++-------------
>>   drivers/of/fdt.c                 | 110 +++++++++++++++++++++++++++++++
>>   include/linux/kexec.h            |  24 +++++++
>>   include/linux/libfdt.h           |   3 +
>>   7 files changed, 149 insertions(+), 87 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/ima.h b/arch/powerpc/include/asm/ima.h
>> index ead488cf3981..6355a85a3289 100644
>> --- a/arch/powerpc/include/asm/ima.h
>> +++ b/arch/powerpc/include/asm/ima.h
>> @@ -2,17 +2,13 @@
>>   #ifndef _ASM_POWERPC_IMA_H
>>   #define _ASM_POWERPC_IMA_H
>>   
>> +#include <linux/kexec.h>
>> +
>>   struct kimage;
>>   
>>   int ima_get_kexec_buffer(void **addr, size_t *size);
>>   int ima_free_kexec_buffer(void);
>>   
>> -#ifdef CONFIG_IMA
>> -void remove_ima_buffer(void *fdt, int chosen_node);
>> -#else
>> -static inline void remove_ima_buffer(void *fdt, int chosen_node) {}
>> -#endif
>> -
>>   #ifdef CONFIG_IMA_KEXEC
>>   int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
>>   			      size_t size);
>> @@ -22,7 +18,7 @@ int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node);
>>   static inline int setup_ima_buffer(const struct kimage *image, void *fdt,
>>   				   int chosen_node)
>>   {
>> -	remove_ima_buffer(fdt, chosen_node);
>> +	remove_ima_kexec_buffer(fdt, chosen_node);
>>   	return 0;
>>   }
>>   #endif /* CONFIG_IMA_KEXEC */
>> diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
>> index 55d6ede30c19..7c223031ecdd 100644
>> --- a/arch/powerpc/include/asm/kexec.h
>> +++ b/arch/powerpc/include/asm/kexec.h
>> @@ -126,7 +126,6 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
>>   int setup_new_fdt(const struct kimage *image, void *fdt,
>>   		  unsigned long initrd_load_addr, unsigned long initrd_len,
>>   		  const char *cmdline);
>> -int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size);
>>   
>>   #ifdef CONFIG_PPC64
>>   struct kexec_buf;
>> diff --git a/arch/powerpc/kexec/file_load.c b/arch/powerpc/kexec/file_load.c
>> index 9a232bc36c8f..7a17655c530e 100644
>> --- a/arch/powerpc/kexec/file_load.c
>> +++ b/arch/powerpc/kexec/file_load.c
>> @@ -18,6 +18,7 @@
>>   #include <linux/kexec.h>
>>   #include <linux/of_fdt.h>
>>   #include <linux/libfdt.h>
>> +#include <linux/kexec.h>
>>   #include <asm/setup.h>
>>   #include <asm/ima.h>
>>   
>> @@ -109,38 +110,6 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
>>   	return 0;
>>   }
>>   
>> -/**
>> - * delete_fdt_mem_rsv - delete memory reservation with given address and size
>> - *
>> - * Return: 0 on success, or negative errno on error.
>> - */
>> -int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size)
>> -{
>> -	int i, ret, num_rsvs = fdt_num_mem_rsv(fdt);
>> -
>> -	for (i = 0; i < num_rsvs; i++) {
>> -		uint64_t rsv_start, rsv_size;
>> -
>> -		ret = fdt_get_mem_rsv(fdt, i, &rsv_start, &rsv_size);
>> -		if (ret) {
>> -			pr_err("Malformed device tree.\n");
>> -			return -EINVAL;
>> -		}
>> -
>> -		if (rsv_start == start && rsv_size == size) {
>> -			ret = fdt_del_mem_rsv(fdt, i);
>> -			if (ret) {
>> -				pr_err("Error deleting device tree reservation.\n");
>> -				return -EINVAL;
>> -			}
>> -
>> -			return 0;
>> -		}
>> -	}
>> -
>> -	return -ENOENT;
>> -}
>> -
>>   /*
>>    * setup_new_fdt - modify /chosen and memory reservation for the next kernel
>>    * @image:		kexec image being loaded.
>> diff --git a/arch/powerpc/kexec/ima.c b/arch/powerpc/kexec/ima.c
>> index 720e50e490b6..2b790230ea15 100644
>> --- a/arch/powerpc/kexec/ima.c
>> +++ b/arch/powerpc/kexec/ima.c
>> @@ -11,6 +11,8 @@
>>   #include <linux/of.h>
>>   #include <linux/memblock.h>
>>   #include <linux/libfdt.h>
>> +#include <linux/ima.h>
>> +#include <asm/ima.h>
>>   
>>   static int get_addr_size_cells(int *addr_cells, int *size_cells)
>>   {
>> @@ -28,24 +30,6 @@ static int get_addr_size_cells(int *addr_cells, int *size_cells)
>>   	return 0;
>>   }
>>   
>> -static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
>> -			       size_t *size)
>> -{
>> -	int ret, addr_cells, size_cells;
>> -
>> -	ret = get_addr_size_cells(&addr_cells, &size_cells);
>> -	if (ret)
>> -		return ret;
>> -
>> -	if (len < 4 * (addr_cells + size_cells))
>> -		return -ENOENT;
>> -
>> -	*addr = of_read_number(prop, addr_cells);
>> -	*size = of_read_number(prop + 4 * addr_cells, size_cells);
>> -
>> -	return 0;
>> -}
>> -
>>   /**
>>    * ima_get_kexec_buffer - get IMA buffer from the previous kernel
>>    * @addr:	On successful return, set to point to the buffer contents.
>> @@ -100,37 +84,14 @@ int ima_free_kexec_buffer(void)
>>   
>>   }
>>   
>> -/**
>> - * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
>> - *
>> - * The IMA measurement buffer is of no use to a subsequent kernel, so we always
>> - * remove it from the device tree.
>> - */
>> -void remove_ima_buffer(void *fdt, int chosen_node)
>> -{
>> -	int ret, len;
>> -	unsigned long addr;
>> -	size_t size;
>> -	const void *prop;
>> -
>> -	prop = fdt_getprop(fdt, chosen_node, "linux,ima-kexec-buffer", &len);
>> -	if (!prop)
>> -		return;
>> -
>> -	ret = do_get_kexec_buffer(prop, len, &addr, &size);
>> -	fdt_delprop(fdt, chosen_node, "linux,ima-kexec-buffer");
>> -	if (ret)
>> -		return;
>> -
>> -	ret = delete_fdt_mem_rsv(fdt, addr, size);
>> -	if (!ret)
>> -		pr_debug("Removed old IMA buffer reservation.\n");
>> -}
>> -
>>   #ifdef CONFIG_IMA_KEXEC
>>   /**
>>    * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
>>    *
>> + * @image: kimage struct to set IMA buffer data
>> + * @load_addr: Starting address where IMA buffer is loaded at
>> + * @size: Number of bytes in the IMA buffer
>> + *
>>    * Architectures should use this function to pass on the IMA buffer
>>    * information to the next kernel.
>>    *
>> @@ -179,7 +140,7 @@ int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
>>   	int ret, addr_cells, size_cells, entry_size;
>>   	u8 value[16];
>>   
>> -	remove_ima_buffer(fdt, chosen_node);
>> +	remove_ima_kexec_buffer(fdt, chosen_node);
>>   	if (!image->arch.ima_buffer_size)
>>   		return 0;
>>   
>> @@ -201,7 +162,7 @@ int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
>>   	if (ret)
>>   		return ret;
>>   
>> -	ret = fdt_setprop(fdt, chosen_node, "linux,ima-kexec-buffer", value,
>> +	ret = fdt_setprop(fdt, chosen_node, FDT_PROP_IMA_KEXEC_BUFFER, value,
>>   			  entry_size);
>>   	if (ret < 0)
>>   		return -EINVAL;
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index 4602e467ca8b..d2e6f8ce0e42 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/serial_core.h>
>>   #include <linux/sysfs.h>
>>   #include <linux/random.h>
>> +#include <linux/kexec.h>
>>   
>>   #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
>>   #include <asm/page.h>
>> @@ -1289,4 +1290,113 @@ static int __init of_fdt_raw_init(void)
>>   late_initcall(of_fdt_raw_init);
>>   #endif
>>   
>> +#ifdef CONFIG_HAVE_IMA_KEXEC
> 
> Can we avoid #ifdef and use IS_ENABLED() within the functions?
I can use IS_ENABLED() or move the functions to another C file and 
conditionally build based on the CONFIG.

> 
>> +/**
>> + * do_get_kexec_buffer - Get address and size of IMA kexec buffer
>> + *
>> + * @prop: IMA kexec buffer node in the device tree
>> + * @len: Size of the given device tree node property
>> + * @addr: Return address of the node
>> + * @size: Return size of the node
>> + */
>> +int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
>> +			size_t *size)
>> +{
>> +	int addr_cells, size_cells;
>> +	struct device_node *root;
>> +
>> +	root = of_find_node_by_path("/");
> 
> The code in fdt.c operates on flat trees. This is an unflattened tree.

Would it be better if I move these functions to a new C file under 
"drivers/of"?

> 
>> +	if (!root)
>> +		return -EINVAL;
>> +
>> +	addr_cells = of_n_addr_cells(root);
>> +	size_cells = of_n_size_cells(root);
>> +
>> +	of_node_put(root);
>> +
>> +	if (len < 4 * (addr_cells + size_cells))
>> +		return -ENOENT;
>> +
>> +	*addr = of_read_number(prop, addr_cells);
>> +	*size = of_read_number(prop + 4 * addr_cells, size_cells);
> 
> There's nothing in this function specific to 'kexec buffer'.
> 
> This interface is kind of broken. 'prop' could come from anywhere in
> the tree, but we always read the root address and size cells. Those only
> apply to immediate child node properties. And anything other than
> immediate root child nodes, there needs to be address translation.
> 

I moved this function from arch/powerpc/kexec/ima.c to here so that it 
can be shared by ARM64 as well. Below is one of the usage of 
do_get_kexec_buffer().

         prop = of_get_property(of_chosen, "linux,ima-kexec-buffer", &len);
         if (!prop)
                 return -ENOENT;

         ret = do_get_kexec_buffer(prop, len, &tmp_addr, &tmp_size);

Is there a way to detect if the 'prop' is an immediate root child node 
or not so that we can handle it appropriately in this interface function?

>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * remove_ima_kexec_buffer - remove the IMA buffer property and
>> + *			     reservation from @fdt
> 
> IIRC, kerneldoc requires this to be one line.
I'll upate.

> 
>> + *
>> + * @fdt: Flattened Device Tree to update
>> + * @chosen_node: Offset to the chosen node in the device tree
>> + *
>> + * The IMA measurement buffer is of no use to a subsequent kernel,
>> + * so we always remove it from the device tree.
>> + */
>> +void remove_ima_kexec_buffer(void *fdt, int chosen_node)
>> +{
> 
> Can't this go in some common kexec code?

I'd considered moving this to "kernel", but Thiago suggested 
"drivers/of" is a better place. If you have suggestions for a better 
place, please let me know.

Note that this function needs to be available even when CONFIG_IMA is 
not enabled. So I can't move it to "security/integrity/ima".

> 
>> +	int ret, len;
>> +	unsigned long addr;
>> +	size_t size;
>> +	const void *prop;
>> +
>> +	prop = fdt_getprop(fdt, chosen_node, FDT_PROP_IMA_KEXEC_BUFFER, &len);
>> +	if (!prop) {
>> +		pr_debug("Unable to find the ima kexec buffer node\n");
>> +		return;
>> +	}
>> +
>> +	ret = do_get_kexec_buffer(prop, len, &addr, &size);
>> +	fdt_delprop(fdt, chosen_node, FDT_PROP_IMA_KEXEC_BUFFER);
>> +	if (ret) {
>> +		pr_err("Unable to delete the ima kexec buffer node\n");
>> +		return;
>> +	}
>> +
>> +	ret = delete_fdt_mem_rsv(fdt, addr, size);
>> +	if (!ret)
>> +		pr_debug("Removed old IMA buffer reservation.\n");
>> +}
>> +#endif /* CONFIG_HAVE_IMA_KEXEC */
>> +
>> +#ifdef CONFIG_KEXEC_FILE
>> +/**
>> + * delete_fdt_mem_rsv - delete memory reservation with given address and size
>> + *
>> + * @fdt: Flattened Device Tree to update
>> + * @start: Starting address of the reservation to delete
>> + * @size: Size of the reservation to delete
>> + *
>> + * Return: 0 on success, or negative errno on error.
>> + */
>> +int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size)
>> +{
>> +	int i, ret, num_rsvs = fdt_num_mem_rsv(fdt);
>> +
>> +	for (i = 0; i < num_rsvs; i++) {
>> +		uint64_t rsv_start, rsv_size;
>> +
>> +		ret = fdt_get_mem_rsv(fdt, i, &rsv_start, &rsv_size);
>> +		if (ret) {
>> +			pr_err("Malformed device tree.\n");
>> +			return -EINVAL;
>> +		}
>> +
>> +		if (rsv_start == start && rsv_size == size) {
>> +			ret = fdt_del_mem_rsv(fdt, i);
>> +			if (ret) {
>> +				pr_err("Error deleting device tree reservation.\n");
>> +				return -EINVAL;
>> +			}
>> +
>> +			pr_debug("Freed reserved memory at %lu of size %lu\n",
>> +				 start, size);
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	return -ENOENT;
>> +}
>> +#endif /* CONFIG_KEXEC_FILE */
>> +
>>   #endif /* CONFIG_OF_EARLY_FLATTREE */
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 9e93bef52968..6c6c6791a7ba 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -407,6 +407,30 @@ static inline int kexec_crash_loaded(void) { return 0; }
>>   #define kexec_in_progress false
>>   #endif /* CONFIG_KEXEC_CORE */
>>   
>> +#if defined(CONFIG_OF_EARLY_FLATTREE) && defined(CONFIG_HAVE_IMA_KEXEC)
> 
> CONFIG_OF_EARLY_FLATTREE is wrong because that's all early boot (i.e.
> init section) functions.
> 
> If these functions are implemented in fdt.c, then this is the wrong
> header. But it's the implementation that should move.

If you think defining these functions in "drivers/of" is okay, I'll move 
them to a new C file in OF.

Would CONFIG_OF_FLATTREE be a better one to enable these ima kexec 
functions? "of_" and "fdt_" are the functions called by these ima kexec 
functions.

> 
>> +extern void remove_ima_kexec_buffer(void *fdt, int chosen_node);
>> +extern int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
>> +			       size_t *size);
>> +#else
>> +static inline void remove_ima_kexec_buffer(void *fdt, int chosen_node) {}
>> +static inline int do_get_kexec_buffer(const void *prop, int len,
>> +				      unsigned long *addr, size_t *size)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +#endif /* CONFIG_OF_EARLY_FLATTREE && CONFIG_HAVE_IMA_KEXEC */
>> +
>> +#if defined(CONFIG_OF_EARLY_FLATTREE) && defined(CONFIG_KEXEC_FILE)
>> +extern int delete_fdt_mem_rsv(void *fdt, unsigned long start,
>> +			      unsigned long size);
>> +#else
>> +static inline int delete_fdt_mem_rsv(void *fdt, unsigned long start,
>> +				     unsigned long size)
>> +{
>> +	return 0;
>> +}
>> +#endif /* CONFIG_OF_EARLY_FLATTREE && CONFIG_KEXEC_FILE */
>> +
>>   #endif /* !defined(__ASSEBMLY__) */
>>   
>>   #endif /* LINUX_KEXEC_H */
>> diff --git a/include/linux/libfdt.h b/include/linux/libfdt.h
>> index 90ed4ebfa692..75fb40aa013b 100644
>> --- a/include/linux/libfdt.h
>> +++ b/include/linux/libfdt.h
>> @@ -5,4 +5,7 @@
>>   #include <linux/libfdt_env.h>
>>   #include "../../scripts/dtc/libfdt/libfdt.h"
>>   
>> +/* Common device tree properties */
>> +#define FDT_PROP_IMA_KEXEC_BUFFER	"linux,ima-kexec-buffer"
> 
> This is not part of libfdt. We generally don't do defines for DT
> strings.
Should I create a new header file for this or would you suggest using an 
existing one?

thanks,
  -lakshmi

> 
>> +
>>   #endif /* _INCLUDE_LIBFDT_H_ */
>> -- 
>> 2.29.0
>>

