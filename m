Return-Path: <linux-integrity+bounces-4901-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C4CA3C450
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Feb 2025 17:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B993ABE6F
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Feb 2025 15:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644521F4601;
	Wed, 19 Feb 2025 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TjsD02zp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708411F2BAD;
	Wed, 19 Feb 2025 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739980661; cv=none; b=opW5G2XmW8hVYM3Lynafng6/BaFy8bPE6fg3+pSIdOxnTuwlkY3zcvqlm1zD+VuT/mYaHdXfIbIzzuh2W+4yxnmFZFODq9eEXchFK927x/yqyATcN/pdjk/FBm1NNFhBQFPXhhnBYesvhRgNYf/k0dyzicH5dHa33ZHHXuciTEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739980661; c=relaxed/simple;
	bh=CXnnR0RtfFEyq3pM1N2aVMn1BbDcUCsIKNrSdsEIFu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kPbC21YGcyjMBVPyS3YdMU/iX25dAXV31LdvcwNtCrzmwxDF2nrygQ3IBy2nyffhLJWqlJq8JLH94G7+bvAIGkcvIO211zfbsxfavwHL+lxTgLFQCNUTCK7mW9VM89K8TXzzwVG1T0uoAxRU4jw/4gXMwgChkihW2yRdcHCrC4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TjsD02zp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J75Cq4005346;
	Wed, 19 Feb 2025 15:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RNRYAF
	Z+vWlXibKC7lWNvKEzI0madAammI6tr38yBJI=; b=TjsD02zpA5OQUHOFu9tBNY
	e0ZXRdvZSquZN+rlqwDxa+fL4iTI06177bEGHn+61Dnpk2rzqGv7FuozNywgYj+3
	DqMvQejPpoOYMJ4JdVQxSorLrjiDkjUgA6Uq/feARiFq+X0QgAYntfQ1MwKiW/ab
	1gayuPKGnWHCaPdUOMF+jf7hkjV27aeua+AjGg73OjVRWE9q8ljSTmxYkRFB138Q
	CSExsiqjjrAtknEQ3cGZLYbTJEtz18Kaq1qbeirm054+zm+DagwvzIrrgMPD4djc
	/VoGYVi25MC4PZ4XTKmMbz/KLqBSnIeBEYKkYnskTK4+Nc1CnTYM5AbdHHNMQL5g
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44w650bhd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 15:57:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51JE1Ewr030243;
	Wed, 19 Feb 2025 15:57:15 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w01x4vr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 15:57:15 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51JFvDd318416154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 15:57:13 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 753435805D;
	Wed, 19 Feb 2025 15:57:14 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65CFC58055;
	Wed, 19 Feb 2025 15:57:13 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Feb 2025 15:57:13 +0000 (GMT)
Message-ID: <7433b986-f048-494d-a66a-5888cd37b081@linux.ibm.com>
Date: Wed, 19 Feb 2025 10:57:13 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/7] ima: kexec: move IMA log copy from kexec load to
 execute
To: steven chen <chenste@linux.microsoft.com>, zohar@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
 <20250218225502.747963-6-chenste@linux.microsoft.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20250218225502.747963-6-chenste@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fIeIYbbJTYuYoV9uVtLxM_3bePvUUM8D
X-Proofpoint-GUID: fIeIYbbJTYuYoV9uVtLxM_3bePvUUM8D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_06,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190122



On 2/18/25 5:55 PM, steven chen wrote:
> ima_dump_measurement_list() is called during kexec 'load', which may
> result in loss of IMA measurements during kexec soft reboot.  It needs

... due to missed measurements that only occurred after kexec 'load'. 
Therefore, this function needs to be ...

> to be called during kexec 'execute'.
> 
> This patch includes the following changes:
>   - Implement kimage_file_post_load() function to be invoked after the new
>     Kernel image has been loaded for kexec.

s/Kernel/kernel

>   - Call kimage_file_post_load() from kexec_file_load() syscall only for
>     kexec soft reboot scenarios and not for KEXEC_FILE_ON_CRASH.  It will
>     map the IMA segment, and register reboot notifier for the function
>     ima_update_kexec_buffer() which would copy the IMA log at kexec soft
>     reboot.
>   - Make kexec_segment_size variable local static to the file, for it to be

... to the file so that it becomes accessible ...

>     accessible both during kexec 'load' and 'execute'.
>   - Move ima_dump_measurement_list() call from ima_add_kexec_buffer()
>     to ima_update_kexec_buffer().
>   - Remove ima_reset_kexec_file() call from ima_add_kexec_buffer(), now
>     that the buffer is being copied at kexec 'execute', and resetting the
>     file at kexec 'load' will corrupt the buffer.

s/will/would

> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>

With  the above changes:

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   kernel/kexec_file.c                |  8 ++++++
>   security/integrity/ima/ima_kexec.c | 43 +++++++++++++++++++-----------
>   2 files changed, 36 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 606132253c79..76b6a877b842 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -201,6 +201,11 @@ kimage_validate_signature(struct kimage *image)
>   }
>   #endif
>   
> +static void kimage_file_post_load(struct kimage *image)
> +{
> +	ima_kexec_post_load(image);
> +}
> +
>   /*
>    * In file mode list of segments is prepared by kernel. Copy relevant
>    * data from user space, do error checking, prepare segment list
> @@ -428,6 +433,9 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>   
>   	kimage_terminate(image);
>   
> +	if (!(flags & KEXEC_FILE_ON_CRASH))
> +		kimage_file_post_load(image);
> +
>   	ret = machine_kexec_post_load(image);
>   	if (ret)
>   		goto out;
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 0fa65f91414b..f9dd7ff95b84 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -19,6 +19,7 @@
>   #ifdef CONFIG_IMA_KEXEC
>   static struct seq_file ima_kexec_file;
>   static void *ima_kexec_buffer;
> +static size_t kexec_segment_size;
>   static bool ima_kexec_update_registered;
>   
>   static void ima_reset_kexec_file(struct seq_file *sf)
> @@ -129,7 +130,6 @@ void ima_add_kexec_buffer(struct kimage *image)
>   	/* use more understandable variable names than defined in kbuf */
>   	void *kexec_buffer = NULL;
>   	size_t kexec_buffer_size = 0;
> -	size_t kexec_segment_size;
>   	int ret;
>   
>   	/*
> @@ -154,13 +154,6 @@ void ima_add_kexec_buffer(struct kimage *image)
>   		return;
>   	}
>   
> -	ret = ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
> -					kexec_segment_size);
> -	if (ret < 0) {
> -		pr_err("Failed to dump IMA measurements. Error:%d.\n", ret);
> -		return;
> -	}
> -
>   	kbuf.buffer = kexec_buffer;
>   	kbuf.bufsz = kexec_buffer_size;
>   	kbuf.memsz = kexec_segment_size;
> @@ -178,12 +171,6 @@ void ima_add_kexec_buffer(struct kimage *image)
>   	image->ima_segment_index = image->nr_segments - 1;
>   	image->is_ima_segment_index_set = true;
>   
> -	/*
> -	 * kexec owns kexec_buffer after kexec_add_buffer() is called
> -	 * and it will vfree() that buffer.
> -	 */
> -	ima_reset_kexec_file(&ima_kexec_file);
> -
>   	kexec_dprintk("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
>   		      kbuf.mem);
>   }
> @@ -194,7 +181,33 @@ void ima_add_kexec_buffer(struct kimage *image)
>   static int ima_update_kexec_buffer(struct notifier_block *self,
>   				   unsigned long action, void *data)
>   {
> -	return NOTIFY_OK;
> +	void *buf = NULL;
> +	size_t buf_size = 0;
> +	int ret = NOTIFY_OK;
> +
> +	if (!kexec_in_progress) {
> +		pr_info("No kexec in progress.\n");
> +		return ret;
> +	}
> +
> +	if (!ima_kexec_buffer) {
> +		pr_err("Kexec buffer not set.\n");
> +		return ret;
> +	}
> +
> +	ret = ima_dump_measurement_list(&buf_size, &buf,
> +					kexec_segment_size);
> +
> +	if (ret)
> +		pr_err("Dump measurements failed. Error:%d\n", ret);
> +
> +	if (buf_size != 0)
> +		memcpy(ima_kexec_buffer, buf, buf_size);
> +
> +	kimage_unmap_segment(ima_kexec_buffer);
> +	ima_kexec_buffer = NULL;
> +
> +	return ret;
>   }
>   
>   struct notifier_block update_buffer_nb = {


