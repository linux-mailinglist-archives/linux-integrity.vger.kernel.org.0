Return-Path: <linux-integrity+bounces-4572-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A523AA12E11
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jan 2025 23:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB03E1654E1
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jan 2025 22:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5871DA309;
	Wed, 15 Jan 2025 22:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JioHDwVw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ACE1DB551;
	Wed, 15 Jan 2025 22:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736978601; cv=none; b=kAHEXLMUJxt6XAaq2k+SiV4l50HF+cbzknyBfUCc1Z7+9xsTKCllE/IDfPT1la/1qDMI7JV5v6vPa1VEiUx4EAej4LdYkYgjzpHA6tJE3FXynschsJBMJELF+soiNCDZY+OF6s+Pq84E6LZygURJCCzoiI8epTIkpk8bhhOmbuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736978601; c=relaxed/simple;
	bh=CgnU1/sySP0w+lwgzV2NxQUKxGmhLTz6BwTnXdFvWmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SipZ2GlQfaahbbdDqoXw0q6RxPwOtHoH3GaZibBlIRjEcCBifj/jAN1vYlS0pLyRAMZ2RweBR3RBKaHOD4IisIH9TuLM2pZm4jzyemnKx8/HO+keG5xsK4XGfGt769gxeSxwq58LRgIcL/K7hNSELFLcIUbG5a1BUkWP26jDR8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JioHDwVw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FHX6W2027772;
	Wed, 15 Jan 2025 22:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=60t2bc
	CzpdqhCujC0lvE1ElDiSacn4+HB3fNhYfqdNA=; b=JioHDwVwJ3vYzVNK2auuS1
	31w81oBZaj6tMkQk/1xYRels1TuDeqKGq0OcU9BQYaZQdSp+qlTaI5riaaFcnfEz
	yJpVvHTUJr1wRinYheRElRC79AiZJO3LGi2I1/JNEt91744cB+Hub9m1Xhjvua3K
	Qk5IeLkEQNIJyjg02V+CY5lckc8iMw7j5meHiZzj4J5fNfD6NwOgNo9F8K3qtNpV
	vbb/RbP/10lf9woX7XosPVTVEWlzpqLrZJZw6XbJs8WZJRjyHvAeBXGCPhoIkxH/
	/t/+MbGNcIoAyJqXiwUDNeQhtABk7RSrK8iftMM11ICXTnn84zJ9n+rFbQeTxjSQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4465gjvuka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 22:03:13 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50FM0lgb004911;
	Wed, 15 Jan 2025 22:03:13 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4465gjvuk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 22:03:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50FLDokM007364;
	Wed, 15 Jan 2025 22:03:12 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443ynana2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 22:03:12 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50FM37bc19857848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 22:03:07 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DC4258054;
	Wed, 15 Jan 2025 22:03:07 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C2615805C;
	Wed, 15 Jan 2025 22:03:06 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Jan 2025 22:03:05 +0000 (GMT)
Message-ID: <583ca33e-aeb3-4401-8f72-9ad1a26d895d@linux.ibm.com>
Date: Wed, 15 Jan 2025 17:03:04 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9] tpm: Map the ACPI provided event log
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Colin Ian King <colin.i.king@gmail.com>,
        Reiner Sailer <sailer@us.ibm.com>, Seiji Munetoh <munetoh@jp.ibm.com>,
        Kylene Jo Hall <kjhall@us.ibm.com>, Stefan Berger <stefanb@us.ibm.com>,
        Andrew Morton <akpm@osdl.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, stable@vger.kernel.org,
        Andy Liang <andy.liang@hpe.com>, linux-kernel@vger.kernel.org
References: <20250115212237.57436-1-jarkko@kernel.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20250115212237.57436-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0uAMK3IBFuBB6JP3F8mjkdeJAUkYceBA
X-Proofpoint-GUID: UaQQTGyZ6TM_QIThGsR9uP7ZftMkQls2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_09,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 clxscore=1011 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501150157



On 1/15/25 4:22 PM, Jarkko Sakkinen wrote:
> The following failure was reported:
> 
> [   10.693310][    T1] tpm_tis STM0925:00: 2.0 TPM (device-id 0x3, rev-id 0)
> [   10.848132][    T1] ------------[ cut here ]------------
> [   10.853559][    T1] WARNING: CPU: 59 PID: 1 at mm/page_alloc.c:4727 __alloc_pages_noprof+0x2ca/0x330
> [   10.862827][    T1] Modules linked in:
> [   10.866671][    T1] CPU: 59 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-lp155.2.g52785e2-default #1 openSUSE Tumbleweed (unreleased) 588cd98293a7c9eba9013378d807364c088c9375
> [   10.882741][    T1] Hardware name: HPE ProLiant DL320 Gen12/ProLiant DL320 Gen12, BIOS 1.20 10/28/2024
> [   10.892170][    T1] RIP: 0010:__alloc_pages_noprof+0x2ca/0x330
> [   10.898103][    T1] Code: 24 08 e9 4a fe ff ff e8 34 36 fa ff e9 88 fe ff ff 83 fe 0a 0f 86 b3 fd ff ff 80 3d 01 e7 ce 01 00 75 09 c6 05 f8 e6 ce 01 01 <0f> 0b 45 31 ff e9 e5 fe ff ff f7 c2 00 00 08 00 75 42 89 d9 80 e1
> [   10.917750][    T1] RSP: 0000:ffffb7cf40077980 EFLAGS: 00010246
> [   10.923777][    T1] RAX: 0000000000000000 RBX: 0000000000040cc0 RCX: 0000000000000000
> [   10.931727][    T1] RDX: 0000000000000000 RSI: 000000000000000c RDI: 0000000000040cc0
> 
> Above shows that ACPI pointed a 16 MiB buffer for the log events because
> RSI maps to the 'order' parameter of __alloc_pages_noprof(). Address the
> bug with kvmalloc() and devm_add_action_or_reset().

Before at it was (at least) failing when the BIOS requested an excessive 
size. Now since you don't want to limit the size of the log I suppose 
you wouldn't also want to set a size of what is excessive so that the 
driver could dev_warn() the user of an excessive-sized buffer ...

> 
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Cc: stable@vger.kernel.org # v2.6.16+
> Fixes: 55a82ab3181b ("[PATCH] tpm: add bios measurement log")
> Reported-by: Andy Liang <andy.liang@hpe.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219495
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
> v9:
> * Call devm_add_action() as the last step and execute the plain action
>    in the fallback path:
>    https://lore.kernel.org/linux-integrity/87frlzzx14.wl-tiwai@suse.de/
> v8:
> * Reduced to only to this quick fix. Let HPE reserve 16 MiB if they want
>    to. We have mapping approach backed up in lore.
> v7:
> * Use devm_add_action_or_reset().
> * Fix tags.
> v6:
> * A new patch.
> ---
>   drivers/char/tpm/eventlog/acpi.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
> index 69533d0bfb51..cf02ec646f46 100644
> --- a/drivers/char/tpm/eventlog/acpi.c
> +++ b/drivers/char/tpm/eventlog/acpi.c
> @@ -63,6 +63,11 @@ static bool tpm_is_tpm2_log(void *bios_event_log, u64 len)
>   	return n == 0;
>   }
>   
> +static void tpm_bios_log_free(void *data)
> +{
> +	kvfree(data);
> +}
> +
>   /* read binary bios log */
>   int tpm_read_log_acpi(struct tpm_chip *chip)
>   {
> @@ -136,7 +141,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>   	}
>   
>   	/* malloc EventLog space */
> -	log->bios_event_log = devm_kmalloc(&chip->dev, len, GFP_KERNEL);
> +	log->bios_event_log = kvmalloc(len, GFP_KERNEL);
 >   	if (!log->bios_event_log)>   		return -ENOMEM;
>   
> @@ -161,10 +166,16 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>   		goto err;
>   	}
>   
> +	ret = devm_add_action(&chip->dev, tpm_bios_log_free, log->bios_event_log);
> +	if (ret) {
> +		log->bios_event_log = NULL;
> +		goto err;
> +	}
> +
>   	return format;
>   
>   err:
> -	devm_kfree(&chip->dev, log->bios_event_log);
> +	tpm_bios_log_free(log->bios_event_log);
>   	log->bios_event_log = NULL;
>   	return ret;
>   }


