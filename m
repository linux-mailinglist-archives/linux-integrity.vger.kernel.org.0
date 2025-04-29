Return-Path: <linux-integrity+bounces-6056-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3426EAA124F
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Apr 2025 18:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C5AA18935FC
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Apr 2025 16:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0248F2459C9;
	Tue, 29 Apr 2025 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Evw07ja/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A0521772B;
	Tue, 29 Apr 2025 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945482; cv=none; b=NyFySC4IVDDzTtUI3jW/inVol2XYblLMf94mJCvjcER4RiX/8UIy4DmTwjwK8NawBfoujr1N5eLQornquSJPklos4S6IZf6SnoIv8mKzw/tM4wpZnhoi7js2/Zj6IomUjkmRznFBPylAs4AriXSgB8Z3qYIhcLw7NRKqDlLe57U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945482; c=relaxed/simple;
	bh=nRog4rgHQdqWWNURy9yDGbnz8Cf4zokBdQKc2g/uCj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H7ReSTC1UikpWvOC/32ZFSV3Y5hnj3ye7Gt8HMr4duunljLM7sfUUp/8UGlBo+c7BIBJiWbOVyJLUJ5qeRvdjURyx3S+Q2s/MSErhlxNHZrz6JatPlVC7ieWXlmgHcvc5JJG76uhySc+c/400BWRf+a2WpqpmA9QFCbQxFks+F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Evw07ja/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TA4YE0000608;
	Tue, 29 Apr 2025 16:50:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=u1ij4K
	yVPbarzVqmgQlnjtxugvQt3lIho1CryqH85Vk=; b=Evw07ja/zDnJdiqlVfmq/n
	GZxKHvXimq5oIgGz0AMFRlGy520ZMI6AQDQO51+8RRj6YdAFhmLFdtz77/Ix1iUK
	4M/u3CqvMSq68nK7Ujzr2+uSvYuTMikk3UEQKumEKsUd95wj0UgODniZq2BUwqSG
	sA2B9U5FDQNOuS24SpEe/CMDZSvOTj6yXQ+qGtJmUZWaP7IYZm6oVfN844v25JlS
	cy+8c6TIRuyCXp1G3rDRpQPnqCiCtI+6dRYZBvtFnRN/8LQYcYq2ZIJaqPUeFX1R
	DG5VX2vJDNwgr9r7q7EJ9njJa9gAXowctcBJ1vz03Lj8A07NVW6o2YrXo5hnP51g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46avpk9x5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 16:50:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53TEj3Nk024644;
	Tue, 29 Apr 2025 16:50:45 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 469c1m3wdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 16:50:45 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53TGoi7L34013810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 16:50:44 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 765FA58054;
	Tue, 29 Apr 2025 16:50:44 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E11095805A;
	Tue, 29 Apr 2025 16:50:42 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Apr 2025 16:50:42 +0000 (GMT)
Message-ID: <e1bd032b-8433-4e07-a940-7e020d7cecd0@linux.ibm.com>
Date: Tue, 29 Apr 2025 12:50:42 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 5/9] ima: kexec: define functions to copy IMA log at
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
References: <20250421222516.9830-1-chenste@linux.microsoft.com>
 <20250421222516.9830-6-chenste@linux.microsoft.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20250421222516.9830-6-chenste@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=68110366 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=yMhMjlubAAAA:8 a=PtDNVHqPAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=gp-jI7jXbnyn_jZY2ukA:9 a=QEXdDO2ut3YA:10 a=BpimnaHY1jUKGyF_4-AF:22
X-Proofpoint-ORIG-GUID: yItTAUl1fOti25qude2z2zRcfwXrUXCL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDEyMyBTYWx0ZWRfXygCIbTNTdcDM TXWRIkPvCV12OmAzMsLFXfRIWiV4Ml9P5OqfDTj3aeI6QFobKvXZeIemd8PNZPBl/iLDNElAk4r xcl703AHCRr9/8ZIhRtS7bA3GeeCLgnUvEpJ/CpdiyjtloBADb2K+ZJtgFKrvAUBffttFDk1pn/
 +6DBYWZebKiHeJQTn8TyEdZgmGqG3Bcx/5Xp5CJjsrm3pN5DR1ZNjRq9mk5ZFF/WzYkggE2G/l+ Dqhq/R7Jr+vpIIjqg+51rkzbugMTt4cJOsNLB07RZup45GWvu1I8sXpDLXLknYrNnIsWfUO6CrB rBhdnmWIifPaDI255WxMD8y3xBN+vsDC/54qIxydl1Vx12uwFkOCX6z5GI3A0lsqhPrcejry+q/
 l+rO0IqtAy/W6ueH/J1uVW6mAqVXY4fMKtmROiZ1B4F06sUh7C9DGg2Wfg9U34CfD2JQQ7st
X-Proofpoint-GUID: yItTAUl1fOti25qude2z2zRcfwXrUXCL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290123



On 4/21/25 6:25 PM, steven chen wrote:
> From: Steven Chen <chenste@linux.microsoft.com>
> 
> The IMA log is currently copied to the new kernel during kexec 'load'
> using ima_dump_measurement_list(). However, the log copied at kexec
> 'load' may result in loss of IMA measurements that only occurred after
> kexec "load'. Setup the needed infrastructure to move the IMA log copy
> from kexec 'load' to 'execute'.
> 
> Define a new IMA hook ima_update_kexec_buffer() as a stub function.
> It will be used to call ima_dump_measurement_list() during kexec 'execute'.
> 
> Implement ima_kexec_post_load() function to be invoked after the new
> Kernel image has been loaded for kexec. ima_kexec_post_load() maps the
> IMA buffer to a segment in the newly loaded Kernel.  It also registers
> the reboot notifier_block to trigger ima_update_kexec_buffer() at
> kexec 'execute'.
> 
> Set the priority of register_reboot_notifier to INT_MIN to ensure that the
> IMA log copy operation will happen at the end of the operation chain, so
> that all the IMA measurement records extended into the TPM are copied
> 
> Co-developed-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Acked-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   include/linux/ima.h                |  3 ++
>   security/integrity/ima/ima_kexec.c | 47 ++++++++++++++++++++++++++++++
>   2 files changed, 50 insertions(+)
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
> index 7e0a19c3483f..e79f6caf895b 100644
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
> +static bool ima_kexec_update_registered;
>   static struct seq_file ima_kexec_file;
> +static void *ima_kexec_buffer;
>   
>   static void ima_free_kexec_file_buf(struct seq_file *sf)
>   {
> @@ -162,6 +166,49 @@ void ima_add_kexec_buffer(struct kimage *image)
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
> +static struct notifier_block update_buffer_nb = {
> +	.notifier_call = ima_update_kexec_buffer,
> +	.priority = INT_MIN
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


