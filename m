Return-Path: <linux-integrity+bounces-195-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76327F488D
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 15:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9861C20A6E
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 14:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD144E637;
	Wed, 22 Nov 2023 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aNpMVFU9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A28AD45
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 06:09:44 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMDjOLZ017900
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 14:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=VvOwHCJ4//4p1S01oMD3cngjm9dFB/+E0GvbzUKDkg0=;
 b=aNpMVFU9lt6u0z4tdvmxc5nZQPxMi4h2U7MiNJiTVlKXCO8w1JcXd+VgQUNbOxDFXYAc
 uq/yOxg2eZhCKTp5M8IrTqfZNmaBE9UT/A5mKH59BC17Wlu0PfD4XMk6QMOznnq1mKxn
 rOBeNZmklbPdW0pVZTXwWe+eQixvo2cEuqgJbDC/hdXXGSIWsrECCxDKRydxvxI1ALj/
 e/9I1ecEejdW9CtcYpSBJEN3mAAk8m+kzkHH+1wnRplmPZ0WbJJd+rOzO49s+Qm11E/e
 GW3I5j6DUbG+lsXi67JuMKMwEQ5VH1ywSj/NGt3knWoibdog5UDncNar4NYJo6zfk7aA VA== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhj9jsjt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 14:09:43 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMDSBAc028672
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 14:09:42 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ufaa27qx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 14:09:42 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AME9frw9110248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Nov 2023 14:09:42 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE9135805C;
	Wed, 22 Nov 2023 14:09:41 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C4E658059;
	Wed, 22 Nov 2023 14:09:41 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Nov 2023 14:09:41 +0000 (GMT)
Message-ID: <245380cd-7def-4f4a-8c2c-99cd6b9294be@linux.ibm.com>
Date: Wed, 22 Nov 2023 09:09:40 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ima-evm-utils PATCH 11/12] Use a file specific hash algorithm
 variable for signing files
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <20231119165043.46960-1-zohar@linux.ibm.com>
 <20231119165043.46960-12-zohar@linux.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231119165043.46960-12-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AnE6oxlzlAKgiqjz4Mfn-FB8tu60gpTF
X-Proofpoint-GUID: AnE6oxlzlAKgiqjz4Mfn-FB8tu60gpTF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_09,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220100



On 11/19/23 11:50, Mimi Zohar wrote:
> Instead of relying on the library "imaevm_params.algo" global variable,
> which is not concurrency-safe, define and use an evmctl file specific
> hash algorithm variable.
> 
> Propogate using the file specific hash algorithm variable in sign_evm(),

-> Propagate

> sign_ima(), hash_ima(), and sign_hash() function.
> 
> Replace using the library function ima_calc_hash() with ima_calc_hash2().
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   src/evmctl.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 7ae897d8b8b3..b802eeb1bf15 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -140,6 +140,7 @@ static bool evm_immutable;
>   static bool evm_portable;
>   static bool veritysig;
>   static bool hwtpm;
> +static char *hash_algo;

g_hash_algo to avoid shadowing this variable in some cases where there 
is a function parameter of the same name?


>   
>   #define HMAC_FLAG_NO_UUID	0x0001
>   #define HMAC_FLAG_CAPS_SET	0x0002
> @@ -570,12 +571,12 @@ static int sign_evm(const char *file, const char *key)

Add hash_algo to the parameters here and call it sign_evm(file, key, 
g_hash_algo)? It makes sense to pass the hash_algo into this function 
that needs to know this for the signature and pushed the usage of global 
variables further out.

>   	unsigned char sig[MAX_SIGNATURE_SIZE];
>   	int len, err;
>   
> -	len = calc_evm_hash(file, imaevm_params.hash_algo, hash);
> +	len = calc_evm_hash(file, hash_algo, hash);
>   	if (len <= 1)
>   		return len;
>   	assert(len <= sizeof(hash));
>   
> -	len = sign_hash(imaevm_params.hash_algo, hash, len, key, NULL, sig + 1);
> +	len = sign_hash(hash_algo, hash, len, key, NULL, sig + 1);
>   	if (len <= 1)
>   		return len;
>   	assert(len < sizeof(sig));
> @@ -609,10 +610,10 @@ static int hash_ima(const char *file)
>   {
>   	unsigned char hash[MAX_DIGEST_SIZE + 2]; /* +2 byte xattr header */
>   	int len, err, offset;
> -	int algo = imaevm_get_hash_algo(imaevm_params.hash_algo);
> +	int algo = imaevm_get_hash_algo(hash_algo);
>   
>   	if (algo < 0) {
> -		log_err("Unknown hash algo: %s\n", imaevm_params.hash_algo);
> +		log_err("Unknown hash algo: %s\n", hash_algo);
>   		return -1;
>   	}
>   	if (algo > PKEY_HASH_SHA1) {
> @@ -624,7 +625,7 @@ static int hash_ima(const char *file)
>   		offset = 1;
>   	}
>   
> -	len = ima_calc_hash(file, hash + offset);
> +	len = ima_calc_hash2(file, hash_algo, hash + offset);
>   	if (len <= 1)
>   		return len;
>   	assert(len + offset <= sizeof(hash));
> @@ -632,7 +633,7 @@ static int hash_ima(const char *file)
>   	len += offset;
>   
>   	if (imaevm_params.verbose >= LOG_INFO)
> -		log_info("hash(%s): ", imaevm_params.hash_algo);
> +		log_info("hash(%s): ", hash_algo);
>   
>   	if (sigdump || imaevm_params.verbose >= LOG_INFO)
>   		imaevm_hexdump(hash, len);
> @@ -656,12 +657,12 @@ static int sign_ima(const char *file, const char *key)
>   	unsigned char sig[MAX_SIGNATURE_SIZE];
>   	int len, err;
>   
> -	len = ima_calc_hash(file, hash);
> +	len = ima_calc_hash2(file, hash_algo, hash);
>   	if (len <= 1)
>   		return len;
>   	assert(len <= sizeof(hash));
>   
> -	len = sign_hash(imaevm_params.hash_algo, hash, len, key, NULL, sig + 1);
> +	len = sign_hash(hash_algo, hash, len, key, NULL, sig + 1);
>   	if (len <= 1)
>   		return len;
>   	assert(len < sizeof(sig));
> @@ -854,7 +855,7 @@ static int cmd_sign_hash(struct command *cmd)
>   			assert(hashlen / 2 <= sizeof(hash));
>   			hex2bin(hash, line, hashlen / 2);
>   
> -			siglen = sign_hash(imaevm_params.hash_algo, hash,
> +			siglen = sign_hash(hash_algo, hash,
>   					   hashlen / 2, key, NULL, sig + 1);
>   			sig[0] = EVM_IMA_XATTR_DIGSIG;
>   		}
> @@ -3077,7 +3078,7 @@ int main(int argc, char *argv[])
>   			sigdump = 1;
>   			break;
>   		case 'a':
> -			imaevm_params.hash_algo = optarg;
> +			hash_algo = optarg;
>   			break;
>   		case 'p':
>   			if (optarg)

