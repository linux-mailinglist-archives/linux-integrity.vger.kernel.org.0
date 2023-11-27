Return-Path: <linux-integrity+bounces-254-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337A97FAC7A
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Nov 2023 22:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2198B213F7
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Nov 2023 21:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D38F446DF;
	Mon, 27 Nov 2023 21:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F+/a3vOB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0B019D;
	Mon, 27 Nov 2023 13:21:13 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARL1VW2006959;
	Mon, 27 Nov 2023 21:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=l+7+M/0gb1ATsm7VOGeZkQWKl0V4m94x0wyRm4H4lGk=;
 b=F+/a3vOBMRR2P2In6bRousezYrL3gldB640HYFoGbJECqCBRUHB0kA55XUAgcdbJSQ8l
 0Otozo1a+LDkD0hAMcPW9pQ0Q5q5PB+xVaa8qtGjX9spdAmltIM1bcXaWQxt15aLK3ax
 86whnpPSL+jxkLJbWDv8d8nmr5mgx/kkTxT035qiemRKeZQELW1EbI6bGWeQukkrUPwO
 j7OUjixoIHWVrHA9arW4GarFqvCIvugUAmIJBlsY/sC9XLlj+jHrVII8iWz9kYdya2HL
 SU/pEndHXjqfriV/9WXuzn5DjEsl3LQUshrGhjoZfwi4KB/O4nrP6uzB5sLRyoFR1uhF vw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umwyns1y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Nov 2023 21:21:09 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ARL1oRT008421;
	Mon, 27 Nov 2023 21:21:08 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umwyns1xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Nov 2023 21:21:08 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARJThhP009185;
	Mon, 27 Nov 2023 21:21:07 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukumybmb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Nov 2023 21:21:07 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ARLL68k12452434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Nov 2023 21:21:06 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C9CD58056;
	Mon, 27 Nov 2023 21:21:06 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7631858052;
	Mon, 27 Nov 2023 21:21:05 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Nov 2023 21:21:05 +0000 (GMT)
Message-ID: <7f1cc222-3b39-4090-a39f-c477c7a39137@linux.ibm.com>
Date: Mon, 27 Nov 2023 16:21:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/8] KEYS: trusted: tpm2: Use struct tpm_buf for sized
 buffers
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        William Roberts <bill.c.roberts@gmail.com>,
        David Howells <dhowells@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
References: <20231124020237.27116-1-jarkko@kernel.org>
 <20231124020237.27116-9-jarkko@kernel.org>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231124020237.27116-9-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2Nuew-6Xv_vZA4N1SFN5SWqNDgeB20ne
X-Proofpoint-ORIG-GUID: a5mXf5JH9Ncfns1vkY5XENIJjzkHRYJk
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_19,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=867
 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311270149



On 11/23/23 21:02, Jarkko Sakkinen wrote:
> Take advantage of the new sized buffer (TPM2B) mode of struct tpm_buf in
> tpm2_seal_trusted(). This allows to add robustness to the command
> construction without requiring to calculate buffer sizes manually.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
> v3 [2023-11-21]: A boundary error check as response for the feeedback
> from Mario Limenciello:
> https://lore.kernel.org/linux-integrity/3f9086f6-935f-48a7-889b-c71398422fa1@amd.com/
> v2: Use tpm_buf_read_*
> ---
>   security/keys/trusted-keys/trusted_tpm2.c | 54 +++++++++++++----------
>   1 file changed, 31 insertions(+), 23 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index bc700f85f80b..97b1dfca2dba 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -228,8 +228,9 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>   		      struct trusted_key_payload *payload,
>   		      struct trusted_key_options *options)
>   {
> +	off_t offset = TPM_HEADER_SIZE;
> +	struct tpm_buf buf, sized;
>   	int blob_len = 0;
> -	struct tpm_buf buf;
>   	u32 hash;
>   	u32 flags;
>   	int i;
> @@ -258,6 +259,14 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>   		return rc;
>   	}
>   
> +	rc = tpm_buf_init_sized(&sized);
> +	if (rc) {
> +		tpm_buf_destroy(&buf);
> +		tpm_put_ops(chip);
> +		return rc;
> +	}
> +
> +	tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
>   	tpm_buf_append_u32(&buf, options->keyhandle);
>   	tpm2_buf_append_auth(&buf, TPM2_RS_PW,
>   			     NULL /* nonce */, 0,
> @@ -266,36 +275,36 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>   			     TPM_DIGEST_SIZE);
>   
>   	/* sensitive */
> -	tpm_buf_append_u16(&buf, 4 + options->blobauth_len + payload->key_len);
> +	tpm_buf_append_u16(&sized, options->blobauth_len);
>   
> -	tpm_buf_append_u16(&buf, options->blobauth_len);
>   	if (options->blobauth_len)
> -		tpm_buf_append(&buf, options->blobauth, options->blobauth_len);
> +		tpm_buf_append(&sized, options->blobauth, options->blobauth_len);
>   
> -	tpm_buf_append_u16(&buf, payload->key_len);
> -	tpm_buf_append(&buf, payload->key, payload->key_len);
> +	tpm_buf_append_u16(&sized, payload->key_len);
> +	tpm_buf_append(&sized, payload->key, payload->key_len);
> +	tpm_buf_append(&buf, sized.data, sized.length);
>   
>   	/* public */
> -	tpm_buf_append_u16(&buf, 14 + options->policydigest_len);
> -	tpm_buf_append_u16(&buf, TPM_ALG_KEYEDHASH);
> -	tpm_buf_append_u16(&buf, hash);
> +	tpm_buf_reset_sized(&sized);
> +	tpm_buf_append_u16(&sized, TPM_ALG_KEYEDHASH);
> +	tpm_buf_append_u16(&sized, hash);
>   
>   	/* key properties */
>   	flags = 0;
>   	flags |= options->policydigest_len ? 0 : TPM2_OA_USER_WITH_AUTH;
> -	flags |= payload->migratable ? 0 : (TPM2_OA_FIXED_TPM |
> -					    TPM2_OA_FIXED_PARENT);
> -	tpm_buf_append_u32(&buf, flags);
> +	flags |= payload->migratable ? 0 : (TPM2_OA_FIXED_TPM | TPM2_OA_FIXED_PARENT);
> +	tpm_buf_append_u32(&sized, flags);
>   
>   	/* policy */
> -	tpm_buf_append_u16(&buf, options->policydigest_len);
> +	tpm_buf_append_u16(&sized, options->policydigest_len);
>   	if (options->policydigest_len)
> -		tpm_buf_append(&buf, options->policydigest,
> -			       options->policydigest_len);
> +		tpm_buf_append(&sized, options->policydigest, options->policydigest_len);
>   
>   	/* public parameters */
> -	tpm_buf_append_u16(&buf, TPM_ALG_NULL);
> -	tpm_buf_append_u16(&buf, 0);
> +	tpm_buf_append_u16(&sized, TPM_ALG_NULL);
> +	tpm_buf_append_u16(&sized, 0);
> +
> +	tpm_buf_append(&buf, sized.data, sized.length);
>   
>   	/* outside info */
>   	tpm_buf_append_u16(&buf, 0);
> @@ -312,21 +321,20 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>   	if (rc)
>   		goto out;
>   
> -	blob_len = be32_to_cpup((__be32 *) &buf.data[TPM_HEADER_SIZE]);
> -	if (blob_len > MAX_BLOB_SIZE) {
> +	blob_len = tpm_buf_read_u32(&buf, &offset);
> +	if (blob_len > MAX_BLOB_SIZE || buf.flags & TPM_BUF_BOUNDARY_ERROR) {
>   		rc = -E2BIG;
>   		goto out;
>   	}
> -	if (tpm_buf_length(&buf) < TPM_HEADER_SIZE + 4 + blob_len) {
> +	if (buf.length - offset < blob_len) {
>   		rc = -EFAULT;
>   		goto out;
>   	}
>   
> -	blob_len = tpm2_key_encode(payload, options,
> -				   &buf.data[TPM_HEADER_SIZE + 4],
> -				   blob_len);
> +	blob_len = tpm2_key_encode(payload, options, &buf.data[offset], blob_len);
>   
>   out:
> +	tpm_buf_destroy(&sized);
>   	tpm_buf_destroy(&buf);
>   
>   	if (rc > 0) {

