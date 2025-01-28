Return-Path: <linux-integrity+bounces-4662-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60135A20D06
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jan 2025 16:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22683188976A
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jan 2025 15:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01201B0F17;
	Tue, 28 Jan 2025 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ExiFd+DN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F10B1C5F3F;
	Tue, 28 Jan 2025 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738078177; cv=none; b=iMo6134lLVVyIIY6t1fmaFTgFVuDkrGsb28b/TGaUiYA8kIYK83x4tg04+tWEOgQErN9aSqJFyKnOpGZ00Vk5PgdhbJVVdgv5xPbjLThoghS3sW6RWYVFZqdjectueDdY3J6+rjxAVIbcOrE7vuYEVaSOnU1Jla8SYOUSTr7Vos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738078177; c=relaxed/simple;
	bh=oM1YWUgUl3AsmIu0LueqLZcQr5blNSM40Z+qjEIUH+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3O6FPhT7C1wocYCQJEsiKjcxweOCC31ZWX1wEak3oF8G95kcusVBFro4AgU/IGvaGvHkXT8hLikDapu76uLy9ETPz4oU6Ngm+HCYbAlrlD9YUTdv2Iam+C/sbPwhCJt115QoAYUg1VQjf0NJBde0pSYKgkgTkd9sgWOSmZPFSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ExiFd+DN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SDDDXY011061;
	Tue, 28 Jan 2025 15:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2FnnIP
	1HhSpVXxw3xc5YWwEHhGO8GV7r5UFt4tgI0XM=; b=ExiFd+DN/S1Ac92//bzEI+
	i272uKE/l4rgo95YKUXb1lHaPZr9Nkft+xPEYW8qtnGyQiohuqdDE7HGJpY4sK60
	e3bKOGvMl/KCvJu6DJ3FIMYCx7RRLzuKK3GjA9bfP3JvQSD+QoMg2ovSIYyqlOJK
	N5tO8VKTjxc8tNYFZTldWcYh/LO8prWdreTq/N+Q5EUyjDL72I9Y32+rCKNKLWAv
	n13pH5ZSsX/jjFQjvCfQx+FeAV3AX7jAU0g7XgEeaqd0vk59KiPV2ixuQqe2mbjn
	jyTnKh6eM+Z1jFR3vXbc9viNWqLG+WglLYIOFn2+zG+8dm26KlNHqOiejP2SUfzg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ena9uj1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 15:28:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50SFDa0m018886;
	Tue, 28 Jan 2025 15:28:23 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44dd01bfwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 15:28:23 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50SFSN1w10093100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 15:28:23 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3EE65805D;
	Tue, 28 Jan 2025 15:28:22 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C23575805F;
	Tue, 28 Jan 2025 15:28:21 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jan 2025 15:28:21 +0000 (GMT)
Message-ID: <4efc1c73-6dc9-43ed-8143-74bb270f7fe7@linux.ibm.com>
Date: Tue, 28 Jan 2025 10:28:21 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] ima: measure kexec load and exec events as critical
 data
To: steven chen <chenste@linux.microsoft.com>, zohar@linux.ibm.com,
        roberto.sassu@huaweicloud.com, petr@tesarici.cz,
        eric.snowberg@oracle.com, paul@paul-moore.com, code@tyhicks.com,
        nramas@linux.microsoft.com, James.Bottomley@HansenPartnership.com,
        madvenka@linux.microsoft.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250124225547.22684-1-chenste@linux.microsoft.com>
 <20250124225547.22684-8-chenste@linux.microsoft.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20250124225547.22684-8-chenste@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AEZLSZcD5v2INHUJN6M9zsBHmE3Vrjis
X-Proofpoint-GUID: AEZLSZcD5v2INHUJN6M9zsBHmE3Vrjis
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280111



On 1/24/25 5:55 PM, steven chen wrote:
> The amount of memory allocated at kexec load, even with the extra memory
> allocated, might not be large enough for the entire measurement list.  The
> indeterminate interval between kexec 'load' and 'execute' could exacerbate
> this problem.
> 
> Define two new IMA events, 'kexec_load' and 'kexec_execute', to be
> measured as critical data at kexec 'load' and 'execute' respectively.
> Report the allocated kexec segment size, IMA binary log size and the
> runtime measurements count as part of those events.
> 
> These events, and the values reported through them, serve as markers in
> the IMA log to verify the IMA events are captured during kexec soft
> reboot.  The presence of a 'kexec_load' event in between the last two
> 'boot_aggregate' events in the IMA log implies this is a kexec soft
> reboot, and not a cold-boot. And the absence of 'kexec_execute' event
> after kexec soft reboot implies missing events in that window which
> results in inconsistency with TPM PCR quotes, necessitating a cold boot
> for a successful remote attestation.
> 
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> ---
>   security/integrity/ima/ima_kexec.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index c9c916f69ca7..d416ca0382cb 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -17,6 +17,8 @@
>   #include "ima.h"
>   
>   #ifdef CONFIG_IMA_KEXEC
> +#define IMA_KEXEC_EVENT_LEN 256
> +
>   static struct seq_file ima_kexec_file;
>   static void *ima_kexec_buffer;
>   static size_t kexec_segment_size;
> @@ -36,6 +38,24 @@ static void ima_free_kexec_file_buf(struct seq_file *sf)
>   	ima_reset_kexec_file(sf);
>   }
>   
> +static void ima_measure_kexec_event(const char *event_name)
> +{
> +	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
> +	size_t buf_size = 0;
> +	long len;
> +
> +	buf_size = ima_get_binary_runtime_size();
> +	len = atomic_long_read(&ima_htable.len);
> +
> +	scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
> +			"kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
> +			"ima_runtime_measurements_count=%ld;",
> +				kexec_segment_size, buf_size, len);
> +
> +	ima_measure_critical_data("ima_kexec", event_name, ima_kexec_event,
> +					strlen(ima_kexec_event), false, NULL, 0);
> +}
> +
>   static int ima_alloc_kexec_file_buf(size_t segment_size)
>   {
>   	/*
> @@ -60,6 +80,7 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
>   out:
>   	ima_kexec_file.read_pos = 0;
>   	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
> +	ima_measure_kexec_event("kexec_load");
>   
>   	return 0;
>   }
> @@ -206,6 +227,8 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
>   
>   	if (ret)
>   		pr_err("Dump measurements failed. Error:%d\n", ret);
> +	else
> +		ima_measure_kexec_event("kexec_execute");
>   
>   	if (buf_size != 0)
>   		memcpy(ima_kexec_buffer, buf, buf_size);


I have been doing kexec's (on ppc64 KVM) applying one patch after 
another in this series and then testing with this command:

evmctl ima_measurement --ignore-violations 
/sys/kernel/security/ima/binary_runtime_measurements

Unfortunately it breaks at this patch. I am not sure what it is due to.


