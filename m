Return-Path: <linux-integrity+bounces-1208-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E5B855365
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Feb 2024 20:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E762A1F21F84
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Feb 2024 19:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33FE13B7A8;
	Wed, 14 Feb 2024 19:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dYkJOdVs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3EE13B799
	for <linux-integrity@vger.kernel.org>; Wed, 14 Feb 2024 19:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707939867; cv=none; b=BPI/+ygbVky7p8YEhVY0oTeIheOZdOdWJvBpN4WyqKpNtXVJDc3nNJfR4nYpVErthxsuf/GFgr6RU/6dY3VFmfo998QULH4OwAz6OV7/zfxCr19r7wJZlrmUhy1CQ1BMAOfZhmlKnxQVgq+nbOtVSGbQvun6TaMiWL6GYOBsvwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707939867; c=relaxed/simple;
	bh=/wmYHUkXbMoCDAt1Hoj5n5NVGAMFWSMFnDz/92ni/pY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LdKpX/gPauTbdmxrZ7095u8igq/+02zWlVAP9DPDBzviXo+MwX4ZqUxrziAAVGb1+9yR7Sed10cyRcXQl4eiMqdu3tlLugq1Ey+7atp+CnRnoalelkYIdegeZchNs9aTqUgfzwUOL7tY+f8eaHop/g/LxKECx3PL50ryirWDmDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dYkJOdVs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EIV7v8006001;
	Wed, 14 Feb 2024 19:43:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=wsPvTurG4HTSwxjvaNIxv/am929am9ojU0IRhQ0+g+s=;
 b=dYkJOdVsSnfEDT+axzDZsgSm7/vDcdS2HEShJKCkVOUUNye2vpxmL581E3sYvegyXtBT
 xKm3c27nGLAXcE8bB/BeoGTxt53SI9aY7pobOhMiTTDtcnqn7ptCV3oBNPIzKum687ek
 QMdY5V6i5h1c8OXsD4j2HgjKqwhOXBUH5W7gbkksDfv526hqOE4wVgoSElA+fyccgoMK
 m48lFpSspvFGqBbtVnrqnYm+H0zysxlFqolWNB2SEFDnD2YCRf4OBhiCWrVL9XNJd8w+
 WQTgAEVin9sLUhMSAQXYtfkDmqg+r+4WhytfraulHIkVbh26AavL71dNB5go+x49rRcF Sg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w92gxj6ar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 19:43:40 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41EIQWTK004258;
	Wed, 14 Feb 2024 19:43:39 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6kv0g985-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 19:43:39 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41EJha3I9568886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 19:43:39 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2E1458043;
	Wed, 14 Feb 2024 19:43:36 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB0EE58055;
	Wed, 14 Feb 2024 19:43:34 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Feb 2024 19:43:34 +0000 (GMT)
Message-ID: <e5d6d47a-c9ee-47a1-aec8-aa59a5264884@linux.ibm.com>
Date: Wed, 14 Feb 2024 14:43:34 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/8] kexec: define functions to map and unmap segments
Content-Language: en-US
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>, zohar@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, noodles@fb.com,
        bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
 <20240214153827.1087657-3-tusharsu@linux.microsoft.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240214153827.1087657-3-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _hKO-KHEt4yYt4r37OIENDxY_vWfkbTT
X-Proofpoint-GUID: _hKO-KHEt4yYt4r37OIENDxY_vWfkbTT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_12,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 mlxscore=0 phishscore=0 clxscore=1011 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140154



On 2/14/24 10:38, Tushar Sugandhi wrote:
> Currently, the mechanism to map and unmap segments to the kimage
> structure is not available to the subsystems outside of kexec.  This
> functionality is needed when IMA is allocating the memory segments
> during kexec 'load' operation.  Implement functions to map and unmap
> segments to kimage.
> 
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
>   include/linux/kexec.h | 13 ++++++++++
>   kernel/kexec_core.c   | 59 +++++++++++++++++++++++++++++++++++++++----
>   2 files changed, 67 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 400cb6c02176..3145447eb77a 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -486,6 +486,11 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
>   static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
>   #endif
>   
> +#define for_each_kimage_entry(image, ptr, entry) \
> +	for (ptr = &image->head; (entry = *ptr) && !(entry & IND_DONE); \
> +		ptr = (entry & IND_INDIRECTION) ? \
> +			boot_phys_to_virt((entry & PAGE_MASK)) : ptr + 1)
> +
>   int crash_check_update_elfcorehdr(void);
>   
>   #ifndef crash_hotplug_cpu_support
> @@ -507,6 +512,10 @@ extern bool kexec_file_dbg_print;
>   	       kexec_file_dbg_print ? KERN_INFO : KERN_DEBUG,	\
>   	       ##__VA_ARGS__)
>   
> +extern void *kimage_map_segment(struct kimage *image,
> +				unsigned long addr, unsigned long size);
> +extern void kimage_unmap_segment(void *buffer);
> +
>   #else /* !CONFIG_KEXEC_CORE */
>   struct pt_regs;
>   struct task_struct;
> @@ -514,6 +523,10 @@ static inline void __crash_kexec(struct pt_regs *regs) { }
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
> index d08fc7b5db97..612ad8783bab 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -582,11 +582,6 @@ void kimage_terminate(struct kimage *image)
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
> @@ -909,6 +904,60 @@ int kimage_load_segment(struct kimage *image,
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
> +		pr_err("%s: Could not map ima buffer.\n", __func__);
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

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

