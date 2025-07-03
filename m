Return-Path: <linux-integrity+bounces-6609-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4715DAF81DD
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jul 2025 22:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BEB31674F5
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jul 2025 20:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C8D29B790;
	Thu,  3 Jul 2025 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Iz0s078F"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815022DE716;
	Thu,  3 Jul 2025 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751574082; cv=none; b=vEbsR6LP9H3hXeY/xXpAaTYLxb3Zouw7E5W88xVckupTnWCJLo1MzibmfpsQBZCCmrdqB8bZXrf31l9PS7z4zi7giwTNHTqjZQ0aKoBvwvRTtkIks8z0Dsc9YueG1+ftGiLleU54bKi5+Qyex9zrVICtEiVSRhl3k0bSS4ThPQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751574082; c=relaxed/simple;
	bh=Jfr8JdW39USFVD5rVEGkztLqXwMVGiYT2JVULiNeHPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=arqG2aiD5wmO7a9ZT5pxsr0jhxZF2N7ehUE63ARIupzVb+l1mhHCHr7iWjQLqFkAifD9+RUYLZmipuij+Trl6nDByBQzG264Gc8gq7XOG+nTnrDjcE58/0XwPaUgx9XOEwn0lQneTC5TFtCHY/iPBTIyiLHkXtxojsnMP7BUJVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Iz0s078F; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 563EofZL029218;
	Thu, 3 Jul 2025 20:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mOhcQc
	e1/REOOAGksLQLRh7WXaZMOzoFQV9AhXqsYwg=; b=Iz0s078FPXx0lWSdrfluoq
	zaITAzAeXx65N2dMmlnN2HiyPia99bcfmWg0FpA5oJChI5WG1myhtxHvc9hkezh9
	H1Yg9Cj2t2zLuGwLXP9B1jRRUHEQ3f//0nLpy+vNB8DDWc4V1VxYTiI6nFJuShLg
	I2BsD1CNVv7HZGvPVc3CtteptLFu+bcfJszXuZE7KdTvgNzTtArsiMtdr78cHdP0
	0vjiRLbgaveT2FXuDb4u6jPBKaC09INQSyx95atiBHi/MUb47gjKORpIwEIsTFJL
	nmJjPxP+oI35E83rSP8n3lDO7R5UqCVzO6BoQrzMRLvebyB01gWqqh4OojRLMGzg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j5ttny10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 20:21:08 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 563KKOF8013661;
	Thu, 3 Jul 2025 20:21:08 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j5ttny0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 20:21:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 563KH4E7021084;
	Thu, 3 Jul 2025 20:21:07 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jtqupux5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 20:21:07 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 563KL6up19661450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Jul 2025 20:21:06 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4142858068;
	Thu,  3 Jul 2025 20:21:06 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 865A658064;
	Thu,  3 Jul 2025 20:21:05 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Jul 2025 20:21:05 +0000 (GMT)
Message-ID: <be1c5bef-7c97-4173-b417-986dc90d779c@linux.ibm.com>
Date: Thu, 3 Jul 2025 16:21:05 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] tpm: Managed allocations for tpm_buf instances
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org
Cc: keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
References: <20250703181712.923302-1-jarkko@kernel.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20250703181712.923302-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lp-aR4ky0_U7sUonk1QXmKBppoXIZM9X
X-Authority-Analysis: v=2.4 cv=UtNjN/wB c=1 sm=1 tr=0 ts=6866e634 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=rMIA4TsMAAAA:8 a=VnNF1IyMAAAA:8 a=zK6BKokPSosMEhBhtdYA:9 a=QEXdDO2ut3YA:10
 a=hVBJ2aql8SDTymIzffKL:22
X-Proofpoint-ORIG-GUID: iUZRldA-a_LVj1MWDmYg5DBuych4SL60
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDE2NyBTYWx0ZWRfX7KAE7n9gTdrK IpXmGbFa/BWQrauxMkK/uhcL3O4K+eN6qrtraZ1DGtf6914KwLjRPkg5okXPWTRhEIjOBHtvA30 zLlR8DAD8NnjV6WABppRhF1kB6VtTHkGIK0Eyf/sYwJn619NzZK3bumoKpdn1xcEA4WTSY5k6uB
 1/M76UO9tiHasyx34Zg5MfdvsI1lUYvvChczornhFIvWYM+Bd418Dw2X+HwPQzhSu5n3VsQQ1KP 5po+1ImBg1dkdNjCBCEcLc4G/RT3v5n0JUJEL7wmLzfRe/7RC96LzbK9PrQrLDzOjTWMyTaV2I8 UZWu5zuexk/sN5vqyEYiEn7UBolVo7zIvMTPJ/MHJxxqNeW5ubo3SwCGS09IfQYl0wcMsHVpXaI
 CMZkQFs5840xPMWujBrhwoqerLJger/eZjzztXlFn9Sfnmgm+IKUELLFicWpD3OI5/XzG4q5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_05,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=852
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030167



On 7/3/25 2:17 PM, Jarkko Sakkinen wrote:
> From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> 
> Repeal and replace tpm_buf_init() and tpm_buf_init_sized() with
> tpm_buf_alloc(), which returns a buffer of  memory with the struct tpm_buf
> header at the beginning of the returned buffer. This leaves 4092 bytes of
> free space for the payload.
> 
> Given that kfree() becomes the destructor for struct tpm_buf instances,
> tpm_buf_destroy() is now obsolete, and can be removed.
> 
> The actual gist is that a struct tpm_buf instance can be declared using
> __free(kfree) from linux/slab.h:
> 
> 	struct tpm_buf *buf __free(kfree) buf = tpm_buf_alloc();
> 
> Doing this has two-folded benefits associated with struct tpm_buf:
> 
> 1. New features will not introduce memory leaks.
> 2. It addresses undiscovered memory leaks.
> 
> In addition, the barrier to contribute is lowered given that managing
> memory is a factor easier.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> ---

> @@ -374,20 +362,18 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
>    */
>   void tpm2_flush_context(struct tpm_chip *chip, u32 handle)
>   {
> -	struct tpm_buf buf;
> -	int rc;
> +	struct tpm_buf *buf __free(kfree) = tpm_buf_alloc();
 >

Remove empty line?

> -	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_FLUSH_CONTEXT);
> -	if (rc) {
> +	if (!buf) {
>   		dev_warn(&chip->dev, "0x%08x was not flushed, out of memory\n",
>   			 handle);
>   		return;
>   	}
>   
> -	tpm_buf_append_u32(&buf, handle);
> +	tpm_buf_reset(buf, TPM2_ST_NO_SESSIONS, TPM2_CC_FLUSH_CONTEXT);
> +	tpm_buf_append_u32(buf, handle);
>   
> -	tpm_transmit_cmd(chip, &buf, 0, "flushing context");
> -	tpm_buf_destroy(&buf);
> +	tpm_transmit_cmd(chip, buf, 0, "flushing context");
>   }
>   EXPORT_SYMBOL_GPL(tpm2_flush_context);
>   
> @@ -414,19 +400,20 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,  u32 *value,
>   			const char *desc)
>   {
>   	struct tpm2_get_cap_out *out;
> -	struct tpm_buf buf;
>   	int rc;
>   
> -	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
> -	if (rc)
> -		return rc;
> -	tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
> -	tpm_buf_append_u32(&buf, property_id);
> -	tpm_buf_append_u32(&buf, 1);
> -	rc = tpm_transmit_cmd(chip, &buf, 0, NULL);
> +	struct tpm_buf *buf __free(kfree) = tpm_buf_alloc();
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	tpm_buf_reset(buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
> +	tpm_buf_append_u32(buf, TPM2_CAP_TPM_PROPERTIES);
> +	tpm_buf_append_u32(buf, property_id);
> +	tpm_buf_append_u32(buf, 1);
> +	rc = tpm_transmit_cmd(chip, buf, 0, NULL);
>   	if (!rc) {
>   		out = (struct tpm2_get_cap_out *)
> -			&buf.data[TPM_HEADER_SIZE];
> +			&buf->data[TPM_HEADER_SIZE];
>   		/*
>   		 * To prevent failing boot up of some systems, Infineon TPM2.0
>   		 * returns SUCCESS on TPM2_Startup in field upgrade mode. Also
> @@ -438,7 +425,6 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,  u32 *value,
>   		else
>   			rc = -ENODATA;
>   	}
> -	tpm_buf_destroy(&buf);
>   	return rc;
>   }
>   EXPORT_SYMBOL_GPL(tpm2_get_tpm_pt);
> @@ -455,15 +441,14 @@ EXPORT_SYMBOL_GPL(tpm2_get_tpm_pt);
>    */
>   void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type)
>   {
> -	struct tpm_buf buf;
> -	int rc;
> +	struct tpm_buf *buf __free(kfree) = tpm_buf_alloc();
>   

Remove empty line here.

With this nit fixed:
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


