Return-Path: <linux-integrity+bounces-6579-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E7DAF05E1
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Jul 2025 23:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE0B48501F
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Jul 2025 21:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BC42701D6;
	Tue,  1 Jul 2025 21:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VPvIxuxS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC3C2652BF;
	Tue,  1 Jul 2025 21:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751406205; cv=none; b=ZFD3+e6twSorddCHmknMqqm2x6TbVOx7t3EoZVBSPN3T9tWdb/MB5CLOlqvT8K5FmRhXYWYvDjvXjy9RWugpTYZX97PvtHa1pI0Mbk+qa9R62WksdNWM9lE8f/5YtGKiPPkcQCGFcmvuRtdNv4Ji50o6Oz7C+6HF+97DZpg191s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751406205; c=relaxed/simple;
	bh=vromciS9HYSh8lr7oFcSyGlFwxSrQwZOMiP6JjeHiOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hGLdch09M1brIU4Mtr2J3Ajk+ofwZPDfOeefUUAk9ekTjzjevU2l7QSHgTkUpwBuhKcJ9rEFkDJR/TkAPtbA/JpCUaC0t6PbyZ24m4FjER5NzFv8v6BO3rPa+mGdIb+xXmCtcs0JKnUBCbxC3vwI42/vZzDk7KevsDgumkDr48I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VPvIxuxS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561F1tmh019886;
	Tue, 1 Jul 2025 21:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rPNeGP
	oPozXxtz9O4rF0CE5O1zQ2C5dXoEzmDgpE/L8=; b=VPvIxuxSEvUJgLOLQ9pUXL
	wBFKk/0DdcnpubaBVIr+U4nBimh376HJMooNRH1dIuuGOeF+QAkCSQASE7hinuvd
	gS2FBk0Jb4HaXvi8siDtffX1NX0i3/AJxuM0gnsItpn3MhDKN7TTdysmcDdwayPR
	e80Qt56glb/pvDmG8Oit/IcvxuEx7B66ulPFT/C1Xjc/4OsBNEV3vaMg0jQT3EFQ
	+1YLnLdJeEGpDjuEPVbcHlcxvqw/Um55/aFSE0MW/azvtgvaeqcvK4n67tLqtt9L
	VzfUvt6oahNm2JQPFvECC5JcVvO+IX4H724WlRhcDuuEZZwPA4l1Y7vZ70Frrp3A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j830subn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 21:42:51 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 561LfZls007006;
	Tue, 1 Jul 2025 21:42:51 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j830subk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 21:42:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 561KD1fQ021928;
	Tue, 1 Jul 2025 21:42:49 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47juqpmkdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 21:42:49 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 561LgnoA25953006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Jul 2025 21:42:49 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EDB55805A;
	Tue,  1 Jul 2025 21:42:49 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1716C58056;
	Tue,  1 Jul 2025 21:42:48 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Jul 2025 21:42:48 +0000 (GMT)
Message-ID: <29f206ec-1d9e-4c2f-b051-3af458173692@linux.ibm.com>
Date: Tue, 1 Jul 2025 17:42:47 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] tpm: Managed allocations for tpm_buf instances
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org
Cc: keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
References: <20250701145136.82726-1-jarkko@kernel.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20250701145136.82726-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: muQJF8qVxDSkTzYcvafRx4hdvJ-3M3-I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDE1MSBTYWx0ZWRfX1pGSpLWact9m YS+isWA/3acIgArjx/f8tgmnyOsEfyy1bf2FnMsif7UPQnI1ZJA1SiFLAmGj15ua9xzJKeFFoT3 crJTpvHgnMdpINDnhvmwI1vRxoonUvhvyAzsD24BxnxAiuVRwjuIu0wBOhmgnSgsz9Uwvhi/w4R
 jqXFpgWV7ePksfBTLom7W3xdhNZDnT9trev9t62iV5EVPjx94X3dLw+DEcH/r6CxQ9cI9N+X9pr CljU1d0oSo/7908262rvS4dE/JkzXiYPsk10OJIktV1LqA+NFUS8Pboh7VWo4mVYVlL0ddmV6eu 5iB+9VWmvEGFRQWW/Ovc7FhASLSMZDc8e1HAbM67hwZwxDVzZZQS/hZhG4p+bp0LrmTWitXT+yy
 KYHz/gqK7PRD0A9kPsROdxkmEmhYkFJUOYPwQTb/168tDcF+FWh4owB+y15zJYs8oVVKdO66
X-Authority-Analysis: v=2.4 cv=MOlgmNZl c=1 sm=1 tr=0 ts=6864565b cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=rMIA4TsMAAAA:8 a=H16EuEqh4d1CqoSb5zkA:9 a=QEXdDO2ut3YA:10
 a=hVBJ2aql8SDTymIzffKL:22
X-Proofpoint-GUID: s97CyYwZVXvh-Pk6CyGoyFaFbHHeooGt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010151



On 7/1/25 10:51 AM, Jarkko Sakkinen wrote:
> From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> 
> Repeal and replace tpm_buf_init() and tpm_buf_init_sized() with
> tpm_buf_alloc(), which returns a buffer of  memory with the struct tpm_buf
> header at the beginning of the returned buffer. This leaves 4090 bytes of
> free space for the payload.
> 
> Given that kfree() is now the destructor for struct tpm_buf instances,
> tpm_buf_destroy() becomes obsolete, and can be safely wiped of too.

s/of/off/  or s/wiped of/remove,/

> 
> The actual gist is that now a tpm_buf can be now declared using

s/that now a/that a/

> __free(kfree) declared in linux/slab.h:
> 
> 	struct tpm_buf *buf __free(kfree) = NULL;
> 
> 	/* ... */
> 
> 	buf = tpm_buf_alloc();
> 
> Doing this has two-folded benefits:
> 
> 1. Yet to be discoverd memory leaks in the pre-existing code base.

-> discovered


A couple of nits below and one stray 'return rc;' that should not be 
there...

> 2. Memory leaks concerning  new features and other contributions.
> 
> In addition, the barrier to contribute is lowered given that managing
> memory is a factor easier.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 524d802ede26..86b961f4027b 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -165,14 +165,18 @@ struct tpm2_pcr_read_out {
>   int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
>   		  struct tpm_digest *digest, u16 *digest_size_ptr)
>   {
> +	struct tpm_buf *buf __free(kfree) = NULL;
>   	int i;
>   	int rc;
> -	struct tpm_buf buf;
>   	struct tpm2_pcr_read_out *out;
>   	u8 pcr_select[TPM2_PCR_SELECT_MIN] = {0};
>   	u16 digest_size;
>   	u16 expected_digest_size = 0;
>   
> +	buf = tpm_buf_alloc();
> +	if (!buf)
> +		return -ENOMEM;
> +
>   	if (pcr_idx >= TPM2_PLATFORM_PCR)
>   		return -EINVAL;
>   
> @@ -187,23 +191,21 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
>   		expected_digest_size = chip->allocated_banks[i].digest_size;
>   	}
>   
> -	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_PCR_READ);
> -	if (rc)
> -		return rc;
> +	tpm_buf_reset(buf, TPM2_ST_NO_SESSIONS, TPM2_CC_PCR_READ);
>   
>   	pcr_select[pcr_idx >> 3] = 1 << (pcr_idx & 0x7);
>   
> -	tpm_buf_append_u32(&buf, 1);
> -	tpm_buf_append_u16(&buf, digest->alg_id);
> -	tpm_buf_append_u8(&buf, TPM2_PCR_SELECT_MIN);
> -	tpm_buf_append(&buf, (const unsigned char *)pcr_select,
> +	tpm_buf_append_u32(buf, 1);
> +	tpm_buf_append_u16(buf, digest->alg_id);
> +	tpm_buf_append_u8(buf, TPM2_PCR_SELECT_MIN);
> +	tpm_buf_append(buf, (const unsigned char *)pcr_select,
>   		       sizeof(pcr_select));
>   
> -	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to read a pcr value");
> +	rc = tpm_transmit_cmd(chip, buf, 0, "attempting to read a pcr value");
>   	if (rc)
>   		goto out;

nit: -> return rc; ?

>   
> -	out = (struct tpm2_pcr_read_out *)&buf.data[TPM_HEADER_SIZE];
> +	out = (struct tpm2_pcr_read_out *)&buf->data[TPM_HEADER_SIZE];
>   	digest_size = be16_to_cpu(out->digest_size);
>   	if (digest_size > sizeof(digest->digest) ||
>   	    (!digest_size_ptr && digest_size != expected_digest_size)) {
> @@ -216,7 +218,6 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
>   
>   	memcpy(digest->digest, out->digest, digest_size);
>   out:

probably can remove this label

> -	tpm_buf_destroy(&buf);
>   	return rc;
>   }
>   
> @@ -574,8 +569,8 @@ struct tpm2_pcr_selection {
>   
>   ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
>   {
> +	struct tpm_buf *buf __free(kfree) = NULL;
>   	struct tpm2_pcr_selection pcr_selection;
> -	struct tpm_buf buf;
>   	void *marker;
>   	void *end;
>   	void *pcr_select_offset;
> @@ -587,41 +582,39 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
>   	int rc;
>   	int i = 0;
>   
> -	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
> -	if (rc)
> -		return rc;
> +	buf = tpm_buf_alloc();
> +	if (!buf)
> +		return -ENOMEM;
>   
> -	tpm_buf_append_u32(&buf, TPM2_CAP_PCRS);
> -	tpm_buf_append_u32(&buf, 0);
> -	tpm_buf_append_u32(&buf, 1);
> +	tpm_buf_reset(buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
> +	tpm_buf_append_u32(buf, TPM2_CAP_PCRS);
> +	tpm_buf_append_u32(buf, 0);
> +	tpm_buf_append_u32(buf, 1);
>   
> -	rc = tpm_transmit_cmd(chip, &buf, 9, "get tpm pcr allocation");
> +	rc = tpm_transmit_cmd(chip, buf, 9, "get tpm pcr allocation");
>   	if (rc)
> -		goto out;
> +		return rc;
>   
>   	nr_possible_banks = be32_to_cpup(
> -		(__be32 *)&buf.data[TPM_HEADER_SIZE + 5]);
> +		(__be32 *)&buf->data[TPM_HEADER_SIZE + 5]);
>   
>   	chip->allocated_banks = kcalloc(nr_possible_banks,
>   					sizeof(*chip->allocated_banks),
>   					GFP_KERNEL);
> -	if (!chip->allocated_banks) {
> -		rc = -ENOMEM;
> -		goto out;
> -	}
> +	if (!chip->allocated_banks)
> +		return -ENOMEM;
>   
> -	marker = &buf.data[TPM_HEADER_SIZE + 9];
> +	marker = &buf->data[TPM_HEADER_SIZE + 9];
>   
> -	rsp_len = be32_to_cpup((__be32 *)&buf.data[2]);
> -	end = &buf.data[rsp_len];
> +	rsp_len = be32_to_cpup((__be32 *)&buf->data[2]);
> +	end = &buf->data[rsp_len];
>   
> +	return rc;


this doesn't look right...


>   	for (i = 0; i < nr_possible_banks; i++) {
>   		pcr_select_offset = marker +
>   			offsetof(struct tpm2_pcr_selection, size_of_select);
> -		if (pcr_select_offset >= end) {
> -			rc = -EFAULT;
> -			break;
> -		}
> +		if (pcr_select_offset >= end)
> +			return -EFAULT;
>   
>   		memcpy(&pcr_selection, marker, sizeof(pcr_selection));
>   		hash_alg = be16_to_cpu(pcr_selection.hash_alg);
> @@ -633,7 +626,7 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 024be262702f..54bcd8d0621e 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -241,14 +241,23 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>   		      struct trusted_key_payload *payload,
>   		      struct trusted_key_options *options)
>   {
> +	struct tpm_buf *buf __free(kfree) = NULL;
> +	struct tpm_buf *sized __free(kfree) = NULL;

Revert order of the above two lines.

>   	off_t offset = TPM_HEADER_SIZE;
> -	struct tpm_buf buf, sized;
>   	int blob_len = 0;
>   	u32 hash;
>   	u32 flags;
>   	int i;
>   	int rc;
>   
> +	buf = tpm_buf_alloc();
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	sized = tpm_buf_alloc();
> +	if (!sized)
> +		return -ENOMEM;
> +
 >   	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {>   		if 
(options->hash == tpm2_hash_map[i].crypto_id) {
>   			hash = tpm2_hash_map[i].tpm_id;
> @@ -270,89 +279,76 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>   	if (rc)
>   		goto out_put;
>   
> -	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
> -	if (rc) {
> -		tpm2_end_auth_session(chip);
> -		goto out_put;
> -	}
> -
> -	rc = tpm_buf_init_sized(&sized);
> -	if (rc) {
> -		tpm_buf_destroy(&buf);
> -		tpm2_end_auth_session(chip);
> -		goto out_put;
> -	}
> -
> -	tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
> -	tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_DECRYPT,
> +	tpm_buf_reset(buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
> +	tpm_buf_reset_sized(sized);
> +	tpm_buf_append_name(chip, buf, options->keyhandle, NULL);
> +	tpm_buf_append_hmac_session(chip, buf, TPM2_SA_DECRYPT,
>   				    options->keyauth, TPM_DIGEST_SIZE);
>   
>   	/* sensitive */
> -	tpm_buf_append_u16(&sized, options->blobauth_len);
> +	tpm_buf_append_u16(sized, options->blobauth_len);
>   
>   	if (options->blobauth_len)
> -		tpm_buf_append(&sized, options->blobauth, options->blobauth_len);
> +		tpm_buf_append(sized, options->blobauth, options->blobauth_len);
>   
> -	tpm_buf_append_u16(&sized, payload->key_len);
> -	tpm_buf_append(&sized, payload->key, payload->key_len);
> -	tpm_buf_append(&buf, sized.data, sized.length);
> +	tpm_buf_append_u16(sized, payload->key_len);
> +	tpm_buf_append(sized, payload->key, payload->key_len);
> +	tpm_buf_append(buf, sized->data, sized->length);
>   
>   	/* public */
> -	tpm_buf_reset_sized(&sized);
> -	tpm_buf_append_u16(&sized, TPM_ALG_KEYEDHASH);
> -	tpm_buf_append_u16(&sized, hash);
> +	tpm_buf_reset_sized(sized);
> +	tpm_buf_append_u16(sized, TPM_ALG_KEYEDHASH);
> +	tpm_buf_append_u16(sized, hash);
>   
>   	/* key properties */
>   	flags = 0;
>   	flags |= options->policydigest_len ? 0 : TPM2_OA_USER_WITH_AUTH;
>   	flags |= payload->migratable ? 0 : (TPM2_OA_FIXED_TPM | TPM2_OA_FIXED_PARENT);
> -	tpm_buf_append_u32(&sized, flags);
> +	tpm_buf_append_u32(sized, flags);
>   
>   	/* policy */
> -	tpm_buf_append_u16(&sized, options->policydigest_len);
> +	tpm_buf_append_u16(sized, options->policydigest_len);
>   	if (options->policydigest_len)
> -		tpm_buf_append(&sized, options->policydigest, options->policydigest_len);
> +		tpm_buf_append(sized, options->policydigest, options->policydigest_len);
>   
>   	/* public parameters */
> -	tpm_buf_append_u16(&sized, TPM_ALG_NULL);
> -	tpm_buf_append_u16(&sized, 0);
> +	tpm_buf_append_u16(sized, TPM_ALG_NULL);
> +	tpm_buf_append_u16(sized, 0);
>   
> -	tpm_buf_append(&buf, sized.data, sized.length);
> +	tpm_buf_append(buf, sized->data, sized->length);
>   
>   	/* outside info */
> -	tpm_buf_append_u16(&buf, 0);
> +	tpm_buf_append_u16(buf, 0);
>   
>   	/* creation PCR */
> -	tpm_buf_append_u32(&buf, 0);
> +	tpm_buf_append_u32(buf, 0);
>   
> -	if (buf.flags & TPM_BUF_OVERFLOW) {
> +	if (buf->flags & TPM_BUF_OVERFLOW) {
>   		rc = -E2BIG;
>   		tpm2_end_auth_session(chip);
>   		goto out;
>   	}
>   
> -	tpm_buf_fill_hmac_session(chip, &buf);
> -	rc = tpm_transmit_cmd(chip, &buf, 4, "sealing data");
> -	rc = tpm_buf_check_hmac_response(chip, &buf, rc);
> +	tpm_buf_fill_hmac_session(chip, buf);
> +	rc = tpm_transmit_cmd(chip, buf, 4, "sealing data");
> +	rc = tpm_buf_check_hmac_response(chip, buf, rc);
>   	if (rc)
>   		goto out;
>   
> -	blob_len = tpm_buf_read_u32(&buf, &offset);
> -	if (blob_len > MAX_BLOB_SIZE || buf.flags & TPM_BUF_BOUNDARY_ERROR) {
> +	blob_len = tpm_buf_read_u32(buf, &offset);
> +	if (blob_len > MAX_BLOB_SIZE || buf->flags & TPM_BUF_BOUNDARY_ERROR) {
>   		rc = -E2BIG;
>   		goto out;
>   	}
> -	if (buf.length - offset < blob_len) {
> +	if (buf->length - offset < blob_len) {
>   		rc = -EFAULT;
>   		goto out;
>   	}
>   
> -	blob_len = tpm2_key_encode(payload, options, &buf.data[offset], blob_len);
> +	blob_len = tpm2_key_encode(payload, options, &buf->data[offset],
> +				   blob_len);
>   
>   out:
> -	tpm_buf_destroy(&sized);
> -	tpm_buf_destroy(&buf);
> -
>   	if (rc > 0) {
>   		if (tpm2_rc_value(rc) == TPM2_RC_HASH)
>   			rc = -EINVAL;

