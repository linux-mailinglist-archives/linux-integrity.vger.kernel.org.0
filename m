Return-Path: <linux-integrity+bounces-187-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BECC7F475C
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 14:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C65EB20C24
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 13:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57244BAA5;
	Wed, 22 Nov 2023 13:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mxThxQRR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DD8100
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 05:07:27 -0800 (PST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMCHPDQ012721
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 13:07:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DaxZnqavzWsQOO52417qHJuD7ebCNO6kWIpnp5NC4iI=;
 b=mxThxQRRwdV7jf0xzNGBDyKSoc8MAYxjGunn7bUIRvefykD5TCC9cyvt93fWXLqKIJfZ
 ZxcTKvLsS8qVsbgjoYE9mOcBMIvdS7HAOMcZby2NlRK7+WelrWePVSR3kVUiA+1ry4aw
 JqZhNAeGINWbpzz+tDbfDHECr/7Kxw8JQFhV1pd6ELtuecd0Hz7nKAzElKgYV22EVAhY
 pLPu208/rWecr0+tZBjjMxsH/PNBYpTcICvhizCI8CpMP7u4lP9Rzas6g/54UwcJpEl+
 su56Kuf7wbe5f0yvzN+6brWRcfRSiH2AHTmlr4HNDvG0P/kjx7u87DB6uZ7ufw6fayo7 cw== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhgsvakam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 13:07:26 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMAJdIP001622
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 13:07:25 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf9tkfke2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 13:07:25 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AMD7ONU12911162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Nov 2023 13:07:24 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A85958053;
	Wed, 22 Nov 2023 13:07:24 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 101DE5805F;
	Wed, 22 Nov 2023 13:07:24 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Nov 2023 13:07:23 +0000 (GMT)
Message-ID: <ae1a5c60-7394-42ca-a357-add1024af04b@linux.ibm.com>
Date: Wed, 22 Nov 2023 08:07:23 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ima-evm-utils PATCH 03/12] Update library function definitions
 to include a "public_keys" parameter
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <20231119165043.46960-1-zohar@linux.ibm.com>
 <20231119165043.46960-4-zohar@linux.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231119165043.46960-4-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sl_i_rIwjhbFYy2zUvWTeCTGoInAPkQP
X-Proofpoint-ORIG-GUID: sl_i_rIwjhbFYy2zUvWTeCTGoInAPkQP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_08,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220091



On 11/19/23 11:50, Mimi Zohar wrote:
> Instead of relying on a global static "public_keys" variable, which is
> not concurrency-safe, update static library function definitions to
> include it as a parameter, define new library functions with it as
> a parameter, and deprecate existing functions.
> 
> Define init_public_keys2(), verify_hash2(), and ima_verify_signature2()
> functions. Update static function defintions to include "public_keys".

-> definitions

> 
> To avoid library incompatablity, make the existing functions -

-> incompatibility

> init_public_keys(), verify_hash(), ima_verify_signature() - wrappers
> for the new function versions.
> 
> Deprecate init_public_keys(), verify_hash(), ima_verify_signature()
> functions.

It may be worth considering adding __attribute__((deprecated)) to those 
functions.

> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   src/imaevm.h    |  2 ++
>   src/libimaevm.c | 94 +++++++++++++++++++++++++++++++++++++------------
>   2 files changed, 74 insertions(+), 22 deletions(-)
> 
> diff --git a/src/imaevm.h b/src/imaevm.h
> index 828976e52881..146123ba5c42 100644
> --- a/src/imaevm.h
> +++ b/src/imaevm.h
> @@ -249,8 +249,10 @@ uint32_t imaevm_read_keyid(const char *certfile);
>   int sign_hash(const char *algo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig);
>   int verify_hash(const char *file, const unsigned char *hash, int size, unsigned char *sig, int siglen);
>   int ima_verify_signature(const char *file, unsigned char *sig, int siglen, unsigned char *digest, int digestlen);
> +int ima_verify_signature2(void *public_keys, const char *file, unsigned char *sig, int siglen, unsigned char *digest, int digestlen);
>   void free_public_keys(void *public_keys);
>   void init_public_keys(const char *keyfiles);
> +int init_public_keys2(const char *keyfiles, void **public_keys);
>   int imaevm_hash_algo_from_sig(unsigned char *sig);
>   const char *imaevm_hash_algo_by_id(int algo);
>   int calc_hash_sigv3(enum evm_ima_xattr_type type, const char *algo, const unsigned char *in_hash, unsigned char *out_hash);
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index 74e9d09b1f05..bf8c99770ddc 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -372,12 +372,12 @@ struct public_key_entry {
>   };
>   static struct public_key_entry *g_public_keys = NULL;
>   
> -static EVP_PKEY *find_keyid(uint32_t keyid)
> +static EVP_PKEY *find_keyid(void *public_keys, uint32_t keyid)
>   {
> -	struct public_key_entry *entry, *tail = g_public_keys;
> +	struct public_key_entry *entry, *tail = public_keys;
>   	int i = 1;
>   
> -	for (entry = g_public_keys; entry != NULL; entry = entry->next) {
> +	for (entry = public_keys; entry != NULL; entry = entry->next) {
>   		if (entry->keyid == keyid)
>   			return entry->key;
>   		i++;
> @@ -394,7 +394,7 @@ static EVP_PKEY *find_keyid(uint32_t keyid)
>   	if (tail)
>   		tail->next = entry;
>   	else
> -		g_public_keys = entry;
> +		public_keys = (void *) entry;
>   	log_err("key %d: %x (unknown keyid)\n", i, __be32_to_cpup(&keyid));
>   	return 0;
>   }
> @@ -412,7 +412,7 @@ void free_public_keys(void *public_keys)
>   	}
>   }
>   
> -void init_public_keys(const char *keyfiles)
> +int init_public_keys2(const char *keyfiles, void **public_keys)

Even though callers of the public APIs may get void *, inside the 
library this can be passed around with its concrete type.


