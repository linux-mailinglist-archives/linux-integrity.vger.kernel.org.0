Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D23F7C7AD9
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Oct 2023 02:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbjJMA3b (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Oct 2023 20:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjJMA3a (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Oct 2023 20:29:30 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9004B7
        for <linux-integrity@vger.kernel.org>; Thu, 12 Oct 2023 17:29:28 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39D0KfMH003833;
        Fri, 13 Oct 2023 00:29:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=3YPw4GsgXu1OLkx5aQELsQmUfqqKyplSoLMbSUsmmf8=;
 b=GE26PyhTYFvdo7Zup7leseiuKvSzqc25nv/CGWF+G1IybnQuVd8ZgyPAUO+Bs2n44OlS
 aCM2Zt9KQPWnNLywxHtM/jQmAxSrW9PmGUeoqDvRKTFB7LaKUdqqN8bN/SA4iW17PJKN
 HdOBfs9SMWIXXaojVZRIfmLAsdjXzstyrCN/NFDbR2d1ne42dj4UGeaHUB94qmrJu0zh
 mzmqfWJ+Dg1sFMIpn9YDJjkChbpphK6zWH7vmsPfm/J0rmaGSV/TOeFNpnrhuojMeZGD
 y3Nu9YmXt4LpidvpzXj7Pb+9aWoM5EY9I8EU3NTIQdrSjVxU4cbJEAWpAAf2OxwWLznB jg== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpu91g7br-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 00:29:14 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39CN4EVm010248;
        Fri, 13 Oct 2023 00:29:14 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tpt59gebf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 00:29:14 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39D0TDbi21430878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 00:29:13 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5824958056;
        Fri, 13 Oct 2023 00:29:13 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CC0358052;
        Fri, 13 Oct 2023 00:29:12 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 13 Oct 2023 00:29:12 +0000 (GMT)
Message-ID: <5098dd7c-70b5-f2ed-0fa6-0f0081f89df6@linux.ibm.com>
Date:   Thu, 12 Oct 2023 20:29:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2 3/7] ima: kexec: map source pages containing IMA buffer
 to image post kexec load
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        zohar@linux.ibm.com, ebiederm@xmission.com, noodles@fb.com,
        bauermann@kolabnow.com, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
 <20231005182602.634615-4-tusharsu@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20231005182602.634615-4-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OaeFo_BxDPpoFGVyWzFdkU3SK9vfwdvX
X-Proofpoint-ORIG-GUID: OaeFo_BxDPpoFGVyWzFdkU3SK9vfwdvX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_14,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130002
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 10/5/23 14:25, Tushar Sugandhi wrote:
> Currently, the mechanism to map and unmap segments to the kimage
> structure is not available to the subsystems outside of kexec.  This
> functionality is needed when IMA is allocating the memory segments
> during kexec 'load' operation.
>
> Implement kimage_map_segment() which takes a kimage pointer, an address,
> and a size.  Ensure that the entire segment is being mapped by comparing
> the given address and size to each segment in the kimage's segment array.
> Collect the source pages that correspond to the given address range,
> allocate an array of pointers to these pages, and map them to a
> contiguous range of virtual addresses.  If the mapping operation is
> successful, the function returns the start of this range.  Otherwise, it
> frees the page pointer array and returns NULL.
>
> Implement kimage_unmap_segment() that takes a pointer to a segment buffer
> and unmaps it using vunmap().
>
> Implement function ima_kexec_post_load(), to be called by IMA after kexec
> loads the new Kernel image.  ima_kexec_post_load() would map the IMA
> buffer allocated during kexec 'load' to a segment in the loaded image.
>
> Finally, move for_each_kimage_entry() macro from kexec_core.c to kexec.h.
>
> Signed-off-by: Tushar Sugandhi<tusharsu@linux.microsoft.com>
> ---
>   include/linux/ima.h                |  3 ++
>   include/linux/kexec.h              | 13 ++++++
>   kernel/kexec_core.c                | 73 ++++++++++++++++++++++++++++--
>   security/integrity/ima/ima_kexec.c | 32 +++++++++++++
>   4 files changed, 116 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 86b57757c7b1..006db20f852d 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -49,6 +49,9 @@ static inline void ima_appraise_parse_cmdline(void) {}
>   
>   #ifdef CONFIG_IMA_KEXEC
>   extern void ima_add_kexec_buffer(struct kimage *image);
> +extern void ima_kexec_post_load(struct kimage *image);
> +#else
> +static inline void ima_kexec_post_load(struct kimage *image) {}
>   #endif
>   
>   #else
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 22b5cd24f581..e00b8101b53b 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -490,6 +490,15 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
>   static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
>   #endif
>   
> +#define for_each_kimage_entry(image, ptr, entry) \
> +	for (ptr = &image->head; (entry = *ptr) && !(entry & IND_DONE); \
> +		ptr = (entry & IND_INDIRECTION) ? \
> +			boot_phys_to_virt((entry & PAGE_MASK)) : ptr + 1)
> +
> +extern void *kimage_map_segment(struct kimage *image,
> +				unsigned long addr, unsigned long size);
> +extern void kimage_unmap_segment(void *buffer);
> +
>   #else /* !CONFIG_KEXEC_CORE */
>   struct pt_regs;
>   struct task_struct;
> @@ -497,6 +506,10 @@ static inline void __crash_kexec(struct pt_regs *regs) { }
>   static inline void crash_kexec(struct pt_regs *regs) { }
>   static inline int kexec_should_crash(struct task_struct *p) { return 0; }
>   static inline int kexec_crash_loaded(void) { return 0; }
> +static inline void *kimage_map_segment(struct kimage *image,
> +				       unsigned long addr, unsigned long size)
> +{ return NULL; }
> +static inline void kimage_unmap_segment(void *buffer) { }
>   #define kexec_in_progress false
>   #endif /* CONFIG_KEXEC_CORE */
>   
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 3d578c6fefee..e01156f3c404 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -594,11 +594,6 @@ void kimage_terminate(struct kimage *image)
>   	*image->entry = IND_DONE;
>   }
>   
> -#define for_each_kimage_entry(image, ptr, entry) \
> -	for (ptr = &image->head; (entry = *ptr) && !(entry & IND_DONE); \
> -		ptr = (entry & IND_INDIRECTION) ? \
> -			boot_phys_to_virt((entry & PAGE_MASK)) : ptr + 1)
> -
>   static void kimage_free_entry(kimage_entry_t entry)
>   {
>   	struct page *page;
> @@ -921,6 +916,74 @@ int kimage_load_segment(struct kimage *image,
>   	return result;
>   }
>   
> +void *kimage_map_segment(struct kimage *image,
> +			 unsigned long addr, unsigned long size)
> +{
> +	unsigned long eaddr = addr + size;
> +	unsigned long src_page_addr, dest_page_addr;
> +	struct page **src_pages;
> +	int i, npages;
> +	kimage_entry_t *ptr, entry;
> +	void *vaddr = NULL;
> +
> +	/*
> +	 * Make sure that we are mapping a whole segment.
> +	 */
> +	for (i = 0; i < image->nr_segments; i++) {
> +		if (addr == image->segment[i].mem &&
> +		    size == image->segment[i].memsz) {
> +			break;
> +		}
> +	}

I wonder whether this distrust in the segments or in the passed 
pointer&size are justifyable since you call this function like this:

         ima_kexec_buffer = kimage_map_segment(image,
image->ima_buffer_addr,
image->ima_buffer_size);

and previously kexec_add_buffer() was also called:

         kbuf.buffer = kexec_buffer;
         kbuf.bufsz = kexec_buffer_size;
         kbuf.memsz = kexec_segment_size;
         ret = kexec_add_buffer(&kbuf);
         if (ret) {
                 pr_err("Error passing over kexec measurement buffer.\n");
                 vfree(kexec_buffer);
                 return;
         }

         image->ima_buffer_addr = kbuf.mem;
         image->ima_buffer_size = kexec_segment_size;

So the one segment should be matching these addresses.


> +
> +	if (i == image->nr_segments) {
> +		pr_err("%s: No segment matching [%lx, %lx)\n", __func__,
> +		       addr, eaddr);
> +		return NULL;
> +	}
> +
> +	/*
> +	 * Collect the source pages and map them in a contiguous VA range.
> +	 */
> +	npages = PFN_UP(eaddr) - PFN_DOWN(addr);
> +	src_pages = kmalloc(sizeof(*src_pages) * npages, GFP_KERNEL);
> +	if (!src_pages) {
> +		pr_err("%s: Could not allocate ima pages array.\n", __func__);
> +		return NULL;
> +	}
> +
> +	i = 0;
> +	for_each_kimage_entry(image, ptr, entry) {
> +		if (entry & IND_DESTINATION)
> +			dest_page_addr = entry & PAGE_MASK;
> +		else if (entry & IND_SOURCE) {
> +			if (dest_page_addr >= addr && dest_page_addr < eaddr) {
> +				src_page_addr = entry & PAGE_MASK;
> +				src_pages[i++] =
> +					virt_to_page(__va(src_page_addr));
> +				if (i == npages)
> +					break;
> +				dest_page_addr += PAGE_SIZE;
> +			}
> +		}
> +	}
> +
> +	/* Sanity check. */
> +	WARN_ON(i < npages);
> +
> +	vaddr = vmap(src_pages, npages, VM_MAP, PAGE_KERNEL);
On either success or failure kfree(sec_pages); should go right here to 
not have a memory leak.
> +	if (!vaddr) {
> +		pr_err("%s: Could not map imap buffer.\n", __func__);
> +		kfree(src_pages);
> +	}
> +	return vaddr;
> +}
> +
> +void kimage_unmap_segment(void *segment_buffer)
> +{
> +	vunmap(segment_buffer);
> +}
> +
>   struct kexec_load_limit {
>   	/* Mutex protects the limit count. */
>   	struct mutex mutex;
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 2c11bbe6efef..13fbbb90319b 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -12,6 +12,8 @@
>   #include <linux/kexec.h>
>   #include <linux/of.h>
>   #include <linux/ima.h>
> +#include <linux/reboot.h>
> +#include <asm/page.h>
>   #include "ima.h"
>   
>   #ifdef CONFIG_IMA_KEXEC
> @@ -19,6 +21,7 @@ struct seq_file ima_kexec_file;
>   struct ima_kexec_hdr ima_khdr;
>   static void *ima_kexec_buffer;
>   static size_t kexec_segment_size;
> +static bool ima_kexec_update_registered;
>   
>   void ima_clear_kexec_file(void)
>   {
> @@ -221,6 +224,7 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
>   	}
>   	memcpy(ima_kexec_buffer, buf, buf_size);
>   out:
> +	kimage_unmap_segment(ima_kexec_buffer);
>   	ima_kexec_buffer = NULL;
>   
>   	if (resume)
> @@ -232,6 +236,34 @@ struct notifier_block update_buffer_nb = {
>   	.notifier_call = ima_update_kexec_buffer,
>   };
>   
> +/*
> + * Create a mapping for the source pages that contain the IMA buffer
> + * so we can update it later.
> + */
> +void ima_kexec_post_load(struct kimage *image)
> +{
> +	if (ima_kexec_buffer) {
> +		kimage_unmap_segment(ima_kexec_buffer);
> +		ima_kexec_buffer = NULL;
> +	}
> +
> +	if (!image->ima_buffer_addr)
> +		return;
> +
> +	ima_kexec_buffer = kimage_map_segment(image,
> +					      image->ima_buffer_addr,
> +					      image->ima_buffer_size);
> +	if (!ima_kexec_buffer) {
> +		pr_err("%s: Could not map measurements buffer.\n", __func__);
> +		return;
> +	}
> +
> +	if (!ima_kexec_update_registered) {
> +		register_reboot_notifier(&update_buffer_nb);
> +		ima_kexec_update_registered = true;
> +	}
> +}
> +
>   #endif /* IMA_KEXEC */
>   
>   /*
