Return-Path: <linux-integrity+bounces-1210-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F83785544B
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Feb 2024 21:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 822C31C20F79
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Feb 2024 20:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9274E12838E;
	Wed, 14 Feb 2024 20:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Th4sALM+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1B01B7E2
	for <linux-integrity@vger.kernel.org>; Wed, 14 Feb 2024 20:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707943675; cv=none; b=IQr4p9LilnMFJpMD2hSReToI6/7rMjjTtzmrN4H9X5e6DpOLacHun3BbKOohEUflPqqkP2URNPyk8nE0zbSvx8l4hhcolHg5yThV/dbIpq1QMOFFL0N/I6Ln1fIN+rH/HS+Zs0c24N5e5jtQDYb8wwU2xJDSFRsUsPJZ0qSHAxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707943675; c=relaxed/simple;
	bh=veliGrmeAP0w3FnWuomyYbQRry3qsAia25Iv37dOWb4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Isuwp4hMZinFForD4g/uziEWGBR1AHVSXacVh/1qQ6hLajSzU4ARRVoOo7hOGZU6hkUcDbOKBuf+xrM0J4Ji/OMi8fNoATca9R9zS9ADssbjD7j2OCB+291Dy1nPYCNVpBlRfUBewcFmCn7HAdq8GZGK5UsjxYsVRaYZZXLJsTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Th4sALM+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EKXKDp030427;
	Wed, 14 Feb 2024 20:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=B1wrrNiNnVa9z2mcRfdaXI8bZRRuFlYU2WG5xBfYnXM=;
 b=Th4sALM+7Ayo4kFqSbxpEIymIyDmdVmoJUnsWIT/9AxZx6b3q9B9OVmgw12ofO3RAhDr
 Qls6fUuYJf4+DMrDMZ0NJaz/0kKIToJ3LUlZtA4r7iHQB1FJOvkmA3Q4ha+HRbRA9o0o
 jijtL6KiLqUrMIqH3X7SAfMdxDLBD33KTnfm8SmWgQ5ZbNhZQJOmKrh6z6my2B/9zw0N
 PMAPwuf/WyFKgQMbUmxwqwfXLH4SV6DzMSuzsTk/cTjQt2TjtYSAqiZc4iDyGYFg28am
 9gw5+1v+LV0jRk0Es2FiHxTrnxDYSbFHT1K5a1qa5hxFvPhDijiAG6Oyss9HCqkU+YPx 5Q== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w94nf8d6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 20:47:16 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41EIs65Y024975;
	Wed, 14 Feb 2024 20:47:15 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mfpgcxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 20:47:15 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41EKlDkD1049232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 20:47:15 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D2F758059;
	Wed, 14 Feb 2024 20:47:13 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0482E58043;
	Wed, 14 Feb 2024 20:47:12 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Feb 2024 20:47:11 +0000 (GMT)
Message-ID: <4189d465-dafc-4cf8-80d2-972f60bb6214@linux.ibm.com>
Date: Wed, 14 Feb 2024 15:47:11 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v5 4/8] ima: kexec: define functions to copy IMA log at
 soft boot
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>, zohar@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, noodles@fb.com,
        bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
 <20240214153827.1087657-5-tusharsu@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20240214153827.1087657-5-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GtRFoz9wAA-XC97XHYkLgJct_bDEMrfW
X-Proofpoint-ORIG-GUID: GtRFoz9wAA-XC97XHYkLgJct_bDEMrfW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_13,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140163



On 2/14/24 10:38, Tushar Sugandhi wrote:
> IMA log is copied to the new Kernel during kexec 'load' using
> ima_dump_measurement_list().  The log copy at kexec 'load' may result in
> loss of IMA measurements during kexec soft reboot.  It needs to be copied
> over during kexec 'execute'.  Setup the needed infrastructure to move the
> IMA log copy from kexec 'load' to 'execute'.
> 
> Define a new IMA hook ima_update_kexec_buffer() as a stub function.
> It will be used to call ima_dump_measurement_list() during kexec
> 'execute'.
> 
> Implement kimage_file_post_load() and ima_kexec_post_load() functions
> to be invoked after the new Kernel image has been loaded for kexec.
> ima_kexec_post_load() maps the IMA buffer to a segment in the newly
> loaded Kernel.  It also registers the reboot notifier_block to trigger
> ima_update_kexec_buffer() at exec 'execute'.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> ---
>   include/linux/ima.h                |  3 ++
>   kernel/kexec_file.c                |  5 ++++
>   security/integrity/ima/ima_kexec.c | 46 ++++++++++++++++++++++++++++++
>   3 files changed, 54 insertions(+)
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
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 0e3689bfb0bb..fe59cb7c179d 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -186,6 +186,11 @@ kimage_validate_signature(struct kimage *image)
>   }
>   #endif
>   
> +void kimage_file_post_load(struct kimage *image)
> +{
> +	ima_kexec_post_load(image);
> +}
> +

We get this here at this point but it disappears later -- missing header?

kernel/kexec_file.c:189:6: warning: no previous prototype for 
‘kimage_file_post_load’ [-Wmissing-prototypes]
   189 | void kimage_file_post_load(struct kimage *image)
       |      ^~~~~~~~~~~~~~~~~~~~~


>   /*
>    * In file mode list of segments is prepared by kernel. Copy relevant
>    * data from user space, do error checking, prepare segment list
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index ccb072617c2d..1d4d6c122d82 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -12,10 +12,14 @@
>   #include <linux/kexec.h>
>   #include <linux/of.h>
>   #include <linux/ima.h>
> +#include <linux/reboot.h>
> +#include <asm/page.h>
>   #include "ima.h"
>   
>   #ifdef CONFIG_IMA_KEXEC
>   static struct seq_file ima_kexec_file;
> +static void *ima_kexec_buffer;
> +static bool ima_kexec_update_registered;
>   
>   static void ima_reset_kexec_file(struct seq_file *sf)
>   {
> @@ -184,6 +188,48 @@ void ima_add_kexec_buffer(struct kimage *image)
>   	kexec_dprintk("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
>   		      kbuf.mem);
>   }
> +
> +/*
> + * Called during kexec execute so that IMA can update the measurement list.
> + */
> +static int ima_update_kexec_buffer(struct notifier_block *self,
> +				   unsigned long action, void *data)
> +{
> +	return NOTIFY_OK;
> +}
> +
> +struct notifier_block update_buffer_nb = {
> +	.notifier_call = ima_update_kexec_buffer,
> +};
> +
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

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

