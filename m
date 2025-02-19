Return-Path: <linux-integrity+bounces-4900-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEAFA3C3D3
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Feb 2025 16:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D48777A85FB
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Feb 2025 15:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275BB1DC184;
	Wed, 19 Feb 2025 15:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fgSfp0ld"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E671F37BA;
	Wed, 19 Feb 2025 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739979475; cv=none; b=dbipLp9uucQ3aF6mlksy0J942JOETTDJGSikJVQLB8tkaJHF1t8tkWvztE3bZ+fqlpEMa1Wum8wD3HMo6/lVh9aecuCHYWZIhfc4mD057bNp9gIChrELG7pvpG/3p5vAH0p7bm6R7hPUPfKLhHefUgJmrl0e1R+Ag59G8yH92hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739979475; c=relaxed/simple;
	bh=axCNMnpKAhLuowO4WagW+r0b9RbhHX8hO31iLpIavNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZLBuocoMVxeGqkMrjLHCe6UAjj6qN/3JoXWoFVKSMLIPoYiz7Jceacr/LgE4zM8KsoklHhWnfOp8uWxsRd/LDlMyShlBo6vxVSM3DheZZA1jjdSml+SB0aA+GbChQpkWXYEWTOQDA++cLJvBBB3cXKQgn0vL6hN+KHXfhHzeSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fgSfp0ld; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JFbA2D011660;
	Wed, 19 Feb 2025 15:37:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GutrDS
	yCSH/AB96WUJAY2Xow2tXi6nzxIQdwxOo5sWo=; b=fgSfp0ldBCTrxRSd+1r43A
	oC+6tvhhoqMgzNUaL++C9/fvailI0YIt/IGxi6zNIX5FL1dg5eSH3AHLog2oUmYU
	SD0RQLjLr3vZraDHyYcAApytTd9OB1WwS+T+kVT6s8yQEXW/sPOtajNTWqyfyRvo
	0/PhMggfDO3pfyovjwiPipR9fjp920p+aWvDDHE2oXYVQ6SNjZc52oxERrBcqIU1
	HCGH3JdHtG6NFaKwBVh565ksw7/Wgla1oaWzENaSShMe5gEC/zeo+81MHX8VEb8r
	YelHwIgleSF/haIJ0WyJTCD6rnSjQgoChPA+Lbd0akiqQVkYJuvF86+A+PWjJ9oA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44w5c9bpwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 15:37:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51JE289l009646;
	Wed, 19 Feb 2025 15:37:13 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03y4sg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 15:37:13 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51JFbCpg29950608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 15:37:13 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAEB058059;
	Wed, 19 Feb 2025 15:37:12 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D913B58043;
	Wed, 19 Feb 2025 15:37:11 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Feb 2025 15:37:11 +0000 (GMT)
Message-ID: <f102607b-963a-40c6-a14f-0803f8b059cc@linux.ibm.com>
Date: Wed, 19 Feb 2025 10:37:11 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/7] ima: kexec: define functions to copy IMA log at
 soft boot
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
 <20250218225502.747963-5-chenste@linux.microsoft.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20250218225502.747963-5-chenste@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _2h1PqhZlz4EX5Bg4hbV1qibYy_kiHN-
X-Proofpoint-GUID: _2h1PqhZlz4EX5Bg4hbV1qibYy_kiHN-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_06,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190122



On 2/18/25 5:54 PM, steven chen wrote:
> IMA log is copied to the new Kernel during kexec 'load' using

The IMA log is currently copied to the new kernel ...


> ima_dump_measurement_list().  The log copy at kexec 'load' may result in
> loss of IMA measurements during kexec soft reboot.  It needs to be copied

However, the log copied at kexec 'load' may result in loss of IMA 
measurements due to missed measurements that only occurred after kexec 
'load'. Therefore, the log needs to be copied during kexec 'execute'. 
Setup the ...

> over during kexec 'execute'.  Setup the needed infrastructure to move the
> IMA log copy from kexec 'load' to 'execute'.
> 
> Define a new IMA hook ima_update_kexec_buffer() as a stub function.
> It will be used to call ima_dump_measurement_list() during kexec
> 'execute'.
> 
> Implement ima_kexec_post_load() function to be invoked after the new
> Kernel image has been loaded for kexec. ima_kexec_post_load() maps the
> IMA buffer to a segment in the newly loaded Kernel.  It also registers
> the reboot notifier_block to trigger ima_update_kexec_buffer() at
> exec 'execute'.

kexec 'execute'

> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>

With the above changes:

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   include/linux/ima.h                |  3 ++
>   security/integrity/ima/ima_kexec.c | 46 ++++++++++++++++++++++++++++++
>   2 files changed, 49 insertions(+)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 0bae61a15b60..8e29cb4e6a01 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -32,6 +32,9 @@ static inline void ima_appraise_parse_cmdline(void) {}
>   
>   #ifdef CONFIG_IMA_KEXEC
>   extern void ima_add_kexec_buffer(struct kimage *image);
> +extern void ima_kexec_post_load(struct kimage *image);
> +#else
> +static inline void ima_kexec_post_load(struct kimage *image) {}
>   #endif
>   
>   #else
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 704676fa6615..0fa65f91414b 100644
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
> @@ -183,6 +187,48 @@ void ima_add_kexec_buffer(struct kimage *image)
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
> +		pr_err("Could not map measurements buffer.\n");
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


