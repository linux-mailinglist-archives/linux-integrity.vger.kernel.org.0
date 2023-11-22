Return-Path: <linux-integrity+bounces-188-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEE47F477F
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 14:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5153B1C2082B
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 13:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E7A219E2;
	Wed, 22 Nov 2023 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S0GcJVIq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D377D1A5
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 05:16:16 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMCdC5w028533
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 13:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=C97T9i10yKFKIfyU7GekOWDMIrM+Rp2OogmgLout+Fc=;
 b=S0GcJVIqRC+dBklJjBYM6mQ9xUpd7GxuwUiqEX1KzfaOzBhJSJhh0O2zuzmPkWf6nOEv
 9OEcdwKNrTlNjvn3y5RZwx22ZZKH/TWfgz58FTWWMTk5H0pQHf33fPopPR5J73fGydnp
 K6Ba+LnJKV5uIj8scHbVoH+LVmfILqrJHzhvm0w0YG/2CrYIbc+lXxJyqJA6mjfa0oMZ
 Z2z4I0d+nxTjLLTaWa52juZj29KqT7PgdW+lcw5K4OZXSTFSGVWtjehHEIPYiUOEAvux
 8iZwBu3W+HBwUtXyCuzQSBjJPf7ue0fwOGmQds6+V1ISEBnuq+rkv1kts8u1LcKeOwDk hw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhhu9h0kf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 13:16:10 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMAJm0Z032440
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 13:14:55 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf8kp00ad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 13:14:55 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AMDEsn464684516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Nov 2023 13:14:54 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6915458053;
	Wed, 22 Nov 2023 13:14:54 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 274EF58043;
	Wed, 22 Nov 2023 13:14:54 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Nov 2023 13:14:54 +0000 (GMT)
Message-ID: <917fabdd-382b-472c-8b0b-7e4dc4273535@linux.ibm.com>
Date: Wed, 22 Nov 2023 08:14:53 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ima-evm-utils PATCH 04/12] Update a library function definition
 to include a "hash_algo" parameter
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <20231119165043.46960-1-zohar@linux.ibm.com>
 <20231119165043.46960-5-zohar@linux.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231119165043.46960-5-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JONVfLpcvzWe8x0L75VVdSCs0x62g59W
X-Proofpoint-ORIG-GUID: JONVfLpcvzWe8x0L75VVdSCs0x62g59W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_09,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311220093



On 11/19/23 11:50, Mimi Zohar wrote:
> Instead of relying on a global "hash_algo" variable, which is not
> concurrency-safe, update the verify_hash2() function definition to
> include a "hash_algo" parameter as a place holder.
> 
> Export the verify_hash2() definition.
> 
> Define verify_hash2().  To avoid library incompatablity, make the existing

-> incompatibility

> function verify_hash() a function wrapper for verify_hash2().
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   src/imaevm.h    | 1 +
>   src/libimaevm.c | 9 +++++----
>   2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/src/imaevm.h b/src/imaevm.h
> index 146123ba5c42..1ed2c81d510d 100644
> --- a/src/imaevm.h
> +++ b/src/imaevm.h
> @@ -248,6 +248,7 @@ uint32_t imaevm_read_keyid(const char *certfile);
>   
>   int sign_hash(const char *algo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig);
>   int verify_hash(const char *file, const unsigned char *hash, int size, unsigned char *sig, int siglen);
> +int verify_hash2(void *public_keys, const char *file, const char *hash_algo, const unsigned char *hash, int size, unsigned char *sig, int siglen);
>   int ima_verify_signature(const char *file, unsigned char *sig, int siglen, unsigned char *digest, int digestlen);
>   int ima_verify_signature2(void *public_keys, const char *file, unsigned char *sig, int siglen, unsigned char *digest, int digestlen);
>   void free_public_keys(void *public_keys);
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index bf8c99770ddc..e64d167a2a8a 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -732,7 +732,7 @@ int imaevm_hash_algo_from_sig(unsigned char *sig)
>   		return -1;
>   }
>   
> -int verify_hash2(void *public_keys, const char *file,
> +int verify_hash2(void *public_keys, const char *file, const char *hash_algo,
>   		 const unsigned char *hash, int size,
>   		 unsigned char *sig, int siglen)
>   {
> @@ -770,7 +770,7 @@ int verify_hash2(void *public_keys, const char *file,
>   int verify_hash(const char *file, const unsigned char *hash, int size,
>   		unsigned char *sig, int siglen)
>   {
> -	return verify_hash2(g_public_keys, file, hash, size, sig, siglen);
> +	return verify_hash2(g_public_keys, file, NULL, hash, size, sig, siglen);
>   }
>   
>   int ima_verify_signature2(void *public_keys, const char *file,
> @@ -803,7 +803,7 @@ int ima_verify_signature2(void *public_keys, const char *file,
>   	 * measurement list, not by calculating the local file digest.
>   	 */
>   	if (digest && digestlen > 0)
> -		return verify_hash2(public_keys, file, digest, digestlen,
> +		return verify_hash2(public_keys, file, NULL, digest, digestlen,
>   				   sig, siglen);
>   
>   	hashlen = ima_calc_hash(file, hash);
> @@ -811,7 +811,8 @@ int ima_verify_signature2(void *public_keys, const char *file,
>   		return hashlen;
>   	assert(hashlen <= sizeof(hash));
>   
> -	return verify_hash2(public_keys, file, hash, hashlen, sig, siglen);
> +	return verify_hash2(public_keys, file, NULL, hash, hashlen,
> +			    sig, siglen);
>   }
>   
>   /*

At this points verify_hash2 becomes a public function (by adding it to 
imaevm.h) and it gets an additional parameter but the parameter is not 
used at all...

