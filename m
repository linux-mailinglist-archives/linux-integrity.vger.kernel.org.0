Return-Path: <linux-integrity+bounces-193-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D457F47E4
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 14:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05A60B20E6A
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 13:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6114BAA8;
	Wed, 22 Nov 2023 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="amsDHkpl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC49D47
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 05:37:11 -0800 (PST)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMDHCSo025101
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 13:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ix3ScaNAyCmKmDeMCKcASnoM7IIoaMMHJQ3/3pnV6Ko=;
 b=amsDHkplcP8789FGvLjb5VHEdcpdk57pYgaGuMwViaOX+rORmEsootUGEpPIugY+gQiE
 SWePKzu5N0HYdFw9iE2YSeVrgJGL72fXPSRqNgNan5DFc+FtJWQBz3F9TbhY6lz2rCyY
 j5Pn/cwBi1OsQfGGbWjFq/UYk9QYRj/NEEERoEoAjNgGTCxu9RCnymSut9w5UUwVig2l
 O9Z1squEf9Y/o1d487Ds5vtVGCFrT/iAJ9k2NG5HTNI8OJY+5+d7iuk38gOXq9Z6nDY5
 NJWu755yivzywB4sLcEx0e7/NEwNm/IbfcBuvT3qPsTbBUaRPq/AmzLH2PT2yYNcbbcI Iw== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhjd0gkvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 13:37:11 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMDRTxq001707
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 13:37:09 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf93kyxch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 13:37:09 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AMDb8Zg6947484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Nov 2023 13:37:08 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6487F5805D;
	Wed, 22 Nov 2023 13:37:08 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AD705805B;
	Wed, 22 Nov 2023 13:37:08 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Nov 2023 13:37:07 +0000 (GMT)
Message-ID: <93aa5f57-fd8a-475f-a1b8-c8d00772b251@linux.ibm.com>
Date: Wed, 22 Nov 2023 08:37:07 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ima-evm-utils PATCH 09/12] Use a local hash algorithm variable
 when verifying file signatures
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <20231119165043.46960-1-zohar@linux.ibm.com>
 <20231119165043.46960-10-zohar@linux.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231119165043.46960-10-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mubREWsq8dcZ7j43KXfyQUgV-FT0VJ3I
X-Proofpoint-ORIG-GUID: mubREWsq8dcZ7j43KXfyQUgV-FT0VJ3I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_09,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220096



On 11/19/23 11:50, Mimi Zohar wrote:
> Instead of relying on the "imaevm_params.algo" global variable, which
> is not concurrency-safe, define and use a local variable.
> 
> Update static verify_hash_v2(), verify_hash_v3(), and verify_hash_common()
> function definitions to include a hash algorithm argument.
> 
> Similarly update ima_verify_signature2() and ima_calc_hash2() to define
> and use a local hash algorithm variable.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   src/libimaevm.c | 40 ++++++++++++++++++++++++----------------
>   1 file changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index 4c9da7a2f06b..18b6a6f27237 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -488,6 +488,7 @@ void init_public_keys(const char *keyfiles)
>    * (Note: signature_v2_hdr struct does not contain the 'type'.)
>    */
>   static int verify_hash_common(void *public_keys, const char *file,
> +			      const char *hash_algo,
>   			      const unsigned char *hash,
>   			      int size, unsigned char *sig, int siglen)
>   {
> @@ -499,7 +500,7 @@ static int verify_hash_common(void *public_keys, const char *file,
>   	const char *st;
>   
>   	if (imaevm_params.verbose > LOG_INFO) {
> -		log_info("hash(%s): ", imaevm_params.hash_algo);
> +		log_info("hash(%s): ", hash_algo);
>   		log_dump(hash, size);
>   	}
>   
> @@ -530,7 +531,7 @@ static int verify_hash_common(void *public_keys, const char *file,
>   	if (!EVP_PKEY_verify_init(ctx))
>   		goto err;
>   	st = "EVP_get_digestbyname";
> -	if (!(md = EVP_get_digestbyname(imaevm_params.hash_algo)))
> +	if (!(md = EVP_get_digestbyname(hash_algo)))
>   		goto err;
>   	st = "EVP_PKEY_CTX_set_signature_md";
>   	if (!EVP_PKEY_CTX_set_signature_md(ctx, md))
> @@ -566,11 +567,12 @@ err:
>    * Return: 0 verification good, 1 verification bad, -1 error.
>    */
>   static int verify_hash_v2(void *public_keys, const char *file,
> +			  const char *hash_algo,
>   			  const unsigned char *hash,
>   			  int size, unsigned char *sig, int siglen)
>   {
>   	/* note: signature_v2_hdr does not contain 'type', use sig + 1 */
> -	return verify_hash_common(public_keys, file, hash, size,
> +	return verify_hash_common(public_keys, file, hash_algo, hash, size,
>   				  sig + 1, siglen - 1);
>   }
>   
> @@ -581,19 +583,20 @@ static int verify_hash_v2(void *public_keys, const char *file,
>    * Return: 0 verification good, 1 verification bad, -1 error.
>    */
>   static int verify_hash_v3(void *public_keys, const char *file,
> +			  const char *hash_algo,
>   			  const unsigned char *hash,
>   			  int size, unsigned char *sig, int siglen)
>   {
>   	unsigned char sigv3_hash[MAX_DIGEST_SIZE];
>   	int ret;
>   
> -	ret = calc_hash_sigv3(sig[0], NULL, hash, sigv3_hash);
> +	ret = calc_hash_sigv3(sig[0], hash_algo, hash, sigv3_hash);
>   	if (ret < 0)
>   		return ret;
>   
>   	/* note: signature_v2_hdr does not contain 'type', use sig + 1 */
> -	return verify_hash_common(public_keys, file, sigv3_hash, size,
> -				  sig + 1, siglen - 1);
> +	return verify_hash_common(public_keys, file, hash_algo, sigv3_hash,
> +				  size, sig + 1, siglen - 1);
>   }
>   
>   #define HASH_MAX_DIGESTSIZE 64	/* kernel HASH_MAX_DIGESTSIZE is 64 bytes */
> @@ -636,8 +639,10 @@ int calc_hash_sigv3(enum evm_ima_xattr_type type, const char *algo,
>   		return -EINVAL;
>   	}
>   
> -	if (!algo)
> -		algo = imaevm_params.hash_algo;
> +	if (!algo) {
> +		log_err("Hash algorithm unspecified\n");
> +		return -EINVAL;
> +	}
>   
>   	if ((hash_algo = imaevm_get_hash_algo(algo)) < 0) {
>   		log_err("Hash algorithm %s not supported\n", algo);
> @@ -757,10 +762,10 @@ int verify_hash2(void *public_keys, const char *file, const char *hash_algo,
>   		return -1;
>   #endif
>   	} else if (sig[1] == DIGSIG_VERSION_2) {
> -		return verify_hash_v2(public_keys, file, hash, size,
> +		return verify_hash_v2(public_keys, file, hash_algo, hash, size,
>   				      sig, siglen);
>   	} else if (sig[1] == DIGSIG_VERSION_3) {
> -		return verify_hash_v3(public_keys, file, hash, size,
> +		return verify_hash_v3(public_keys, file, hash_algo, hash, size,
>   				      sig, siglen);
>   	} else
>   		return -1;
> @@ -774,7 +779,8 @@ int verify_hash2(void *public_keys, const char *file, const char *hash_algo,
>   int verify_hash(const char *file, const unsigned char *hash, int size,
>   		unsigned char *sig, int siglen)
>   {
> -	return verify_hash2(g_public_keys, file, NULL, hash, size, sig, siglen);
> +	return verify_hash2(g_public_keys, file, imaevm_params.hash_algo,
> +			    hash, size, sig, siglen);

Now you are passing valid parameters into verify_hash2(). Would it not 
be possible to drop 4/12?


