Return-Path: <linux-integrity+bounces-859-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF46A8395FE
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jan 2024 18:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0344DB235FD
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jan 2024 17:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D127F7D5;
	Tue, 23 Jan 2024 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tS7QhAIy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFCB7F7E2
	for <linux-integrity@vger.kernel.org>; Tue, 23 Jan 2024 17:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706029606; cv=none; b=nQSIoR3kMU8A3/H6nJtUrxHBk9xpDxpMphSyyaGfNzKsIemE8hG5XpQ7a2xHf+dbXflxZ3nsLJBZG0y3a3/J0wUBlU11V5X/luw29hn10qpDxq4P1DOrI7s4supRyrTrg2A9oWIA9a9vVUWCtCyCBKBjuYhNio/sV2TnnKBHikw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706029606; c=relaxed/simple;
	bh=ABandDHQpPz8etHjXb9FzVEEvI1YuaisA7Ob9QrlkNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BSry/3hmRZeFSF/delcEKeV/UuitmuI5GFSgK+5iLqp0BbpcO7T7DT+N5hDqpG3Hyx9txHyygPPnlE/hTceZJPtq3g11uQcPtB5Gbihst+JszQliQW3zGqBJtDWnXeM3QOKgHWb//JKeYtUrrTZ0pbptH/3m6gMSadF6qlH2LGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tS7QhAIy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40NGfE81003137;
	Tue, 23 Jan 2024 17:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cvDo4W6sOdpNY/sWyt1gM9KLEdyD3VHgiBuxWk5y72g=;
 b=tS7QhAIykX8PwrJN6homy8wykJdSlHYfGb1xWOCIgqMDtTwKD3ACY+Tile1Y7Ny18PEk
 pR4yiXHHk/mY4LQm7Zhl7AHGTpg9jLNlKXKe8h8277rvRjXhaDsjfkiFttfjPznOYNfW
 YBSosxR6qClKJXMSs2P5mc4AF8QrnM8/KyGWdP34wMoGH8YEolkJgcT4S5sFuizaTOV7
 DM4kxG7b3A6BQruJtiHqjIuSJ81QECk6F85nnqpvOQzsbtIjsxaJfe1r1QoVoDkDPBeo
 x363IwN4aUWXTPsrOs0M74tXrkpmquYzi1I8uyFKMj3KzgCw9PG7bXHD5267dAaCzVSS iw== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vtbqaaf35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 17:03:35 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40NFqDg2022438;
	Tue, 23 Jan 2024 17:03:33 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vrt0m0b07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 17:03:33 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40NH3X3p23855802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 17:03:33 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C2485805C;
	Tue, 23 Jan 2024 17:03:33 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8E6E5805A;
	Tue, 23 Jan 2024 17:03:31 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jan 2024 17:03:31 +0000 (GMT)
Message-ID: <e375cd83-f424-4b0e-96e3-7a47a4f70715@linux.ibm.com>
Date: Tue, 23 Jan 2024 12:03:31 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] kexec: define functions to map and unmap segments
Content-Language: en-US
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>, zohar@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, noodles@fb.com,
        bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
 <20240122183804.3293904-3-tusharsu@linux.microsoft.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240122183804.3293904-3-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GIayIDHJ_gbEc-vASySdHe9dFulPM_kG
X-Proofpoint-ORIG-GUID: GIayIDHJ_gbEc-vASySdHe9dFulPM_kG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_09,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401230125



On 1/22/24 13:37, Tushar Sugandhi wrote:
> Implement kimage_map_segment() to enable mapping of IMA buffer source
> pages to the kimage structure post kexec 'load'.  This function,
> accepting a kimage pointer, an address, and a size, will gather the
> source pages within the specified address range, create an array of page
> pointers, and map these to a contiguous virtual address range.  The
> function returns the start of this range if successful, or NULL if
> unsuccessful.
> 
> Implement kimage_unmap_segment() for unmapping segments
> using vunmap().  Relocate 'for_each_kimage_entry()' macro from
> kexec_core.c to kexec.h for broader accessibility.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> ---
>   include/linux/kexec.h              | 13 +++++++
>   kernel/kexec_core.c                | 59 +++++++++++++++++++++++++++---
>   security/integrity/ima/ima_kexec.c |  1 +
>   3 files changed, 68 insertions(+), 5 deletions(-)
> 
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

This series applies to v6.5. You may want to rebase to 6.7.

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
> index 3d578c6fefee..26978ad02676 100644
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
> @@ -921,6 +916,60 @@ int kimage_load_segment(struct kimage *image,
>   	return result;
>   }
>   
> +void *kimage_map_segment(struct kimage *image,
> +			 unsigned long addr, unsigned long size)
> +{
> +	unsigned long eaddr = addr + size;
> +	unsigned long src_page_addr, dest_page_addr;
> +	unsigned int npages;
> +	struct page **src_pages;
> +	int i;
> +	kimage_entry_t *ptr, entry;
> +	void *vaddr = NULL;
> +
> +	/*
> +	 * Collect the source pages and map them in a contiguous VA range.
> +	 */
> +	npages = PFN_UP(eaddr) - PFN_DOWN(addr);
> +	src_pages = kmalloc_array(npages, sizeof(*src_pages), GFP_KERNEL);
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
> +	kfree(src_pages);
> +
> +	if (!vaddr)
> +		pr_err("%s: Could not map imap buffer.\n", __func__);

imap -> ima

> +
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
> index 99daac355c70..4f944c9b4168 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -170,6 +170,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>   	pr_debug("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
>   		 kbuf.mem);
>   }
> +

remove

>   #endif /* IMA_KEXEC */
>   
>   /*

