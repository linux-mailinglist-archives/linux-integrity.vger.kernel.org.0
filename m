Return-Path: <linux-integrity+bounces-3731-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DD398F1F5
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Oct 2024 16:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8EB1C20A6A
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Oct 2024 14:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84862E62C;
	Thu,  3 Oct 2024 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T1TcT3Mb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2996E26ACD;
	Thu,  3 Oct 2024 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967506; cv=none; b=pKDgf/wAY36pbw17SvXW0eU2Xk3IO14SGTnA2ymYdyUv5hSRVIWLpxhum+7qjn5R50kUlB+iEewbAzlWRABrTTwyjOO6jG27Yl8qRkL50g0y2yYVLeN2C7lOdtYAsHX3E9pORgArEIEvoGs48ZoPhiz4orHkHGY+bv5Dj965bN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967506; c=relaxed/simple;
	bh=qlXMXW2vFLKrkpMebmH/XKuu9Q6WXuTRK03cSoPBfUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hii1jyvrhNaeBjHB0S+jqgUqmINc6Fxs/ceSqnweuaVSLf8LFcOF/aUSGbvI04/Gpip4g+RKD5w/q+pFtjLdkdT+bnDJ9tonCY8sNHaaUsjEo7d4Nn9Lo4Z5xUpixT1SNOeNAp+qrge0XHBi5keGQ828WgkgeLgKKYKX664/PPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T1TcT3Mb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 493EiURE009626;
	Thu, 3 Oct 2024 14:57:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=/
	etH9hm0berpHXbq1eIePIo22X3OIjzd6weouRDdhQg=; b=T1TcT3MbpMfe/IjTi
	GlbMFK3C5nXnP4LKFMtkCH/hxn57h8uwxsDlUDKJnq89RRc00bGBgDVzmcvztjMj
	eK+p9QKhsjAfqlY+bAFsvOYd9RlZtWTJkhd8yax6NvuizBbY3NJ3mNviWdpNmjdd
	TleFF9vFqB66rT4pnVtt0LnZ60TOcB0f/sN5NAnQ7Lf7AgSxVWTD2OCTDxEikzua
	FQtlhp+QkSEwREMMSBy2NYi4hxdJzaKxF5jRAeCCfT2S0/REVbDVER4C7mw4om0R
	63cJ/TA4E/Rwqnq3GXeuWJd7MpC3Dj9mMZsv9XHBwKjn6TiKME33ved51D0C1sbe
	w5/xA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 421vvd85th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 14:57:57 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 493EtnVf005425;
	Thu, 3 Oct 2024 14:57:56 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 421vvd85tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 14:57:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 493BhuSS007923;
	Thu, 3 Oct 2024 14:57:56 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xvgy8fp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 14:57:56 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 493Evt1645416948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Oct 2024 14:57:55 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DF0058051;
	Thu,  3 Oct 2024 14:57:55 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61B295805A;
	Thu,  3 Oct 2024 14:57:54 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Oct 2024 14:57:54 +0000 (GMT)
Message-ID: <69c893e7-6b87-4daa-80db-44d1120e80fe@linux.ibm.com>
Date: Thu, 3 Oct 2024 10:57:53 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] tpm: Return on tpm2_create_null_primary() failure
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, roberto.sassu@huawei.com,
        mapengyu@gmail.com, stable@vger.kernel.org,
        Mimi Zohar
 <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240921120811.1264985-1-jarkko@kernel.org>
 <20240921120811.1264985-2-jarkko@kernel.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240921120811.1264985-2-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5EFp1r8e1EzEFn9PkcBzzuGPMZjq4zHA
X-Proofpoint-GUID: ZIlKVpXqsoC0O4SLuVxiv0Zt8P8eHBaV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0
 clxscore=1011 impostorscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2410030107



On 9/21/24 8:08 AM, Jarkko Sakkinen wrote:
> tpm2_sessions_init() does not ignores the result of

s/ignores/ignore

> tpm2_create_null_primary(). Address this by returning -ENODEV to the
> caller.

I am not sure why mapping all errors to -ENODEV resolves the fact that 
tpm2_sessions_init() does not ignore the result of 
tpm2_create_null_primary(). I think what you want is to return -ENODEV 
from tpm2_auto_startup.

> 
> Cc: stable@vger.kernel.org # v6.10+
> Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v5:
> - Do not print klog messages on error, as tpm2_save_context() already
>    takes care of this.
> v4:
> - Fixed up stable version.
> v3:
> - Handle TPM and POSIX error separately and return -ENODEV always back
>    to the caller.
> v2:
> - Refined the commit message.
> ---
>   drivers/char/tpm/tpm2-sessions.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> index d3521aadd43e..0f09ac33ae99 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -1338,7 +1338,8 @@ static int tpm2_create_null_primary(struct tpm_chip *chip)
>   		tpm2_flush_context(chip, null_key);
>   	}
>   
> -	return rc;
> +	/* Map all errors to -ENODEV: */
> +	return rc ? -ENODEV : rc;

return rc ? -ENODEV : 0;

>   }
>   
>   /**
> @@ -1354,7 +1355,7 @@ int tpm2_sessions_init(struct tpm_chip *chip)
>   
>   	rc = tpm2_create_null_primary(chip);
>   	if (rc)
> -		dev_err(&chip->dev, "TPM: security failed (NULL seed derivation): %d\n", rc);
> +		return rc;
>   
>   	chip->auth = kmalloc(sizeof(*chip->auth), GFP_KERNEL);
>   	if (!chip->auth)

