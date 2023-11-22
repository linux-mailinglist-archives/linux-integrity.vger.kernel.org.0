Return-Path: <linux-integrity+bounces-194-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9747F4858
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 14:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30DE01C2033F
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 13:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A3C4E621;
	Wed, 22 Nov 2023 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Yblqfq1f"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6086197
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 05:55:21 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMDrWJc024137
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 13:55:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cIDjQUds2tW/4arsbvcaCGg/d6fCd+SXp0ziSOiXpBU=;
 b=Yblqfq1fUkijhiEO7D9KBXAp6rLV/Z/UohOQc6v+ajy3+UgGU+Ei+KLSEpjyVHN3QCm+
 B+VMTQSzqFMkxEmKrbSPtIjrExOJfciDaLQ0XUA9YZwJ1/HJFMfPflKabsLLxsTrw8Cm
 FRF3o+nOSnyrCB5zgmosHYRsynz5xYEDoDszqudLTiiZDna2Q2j8CUy9FwCqswS5b+SU
 /9WIV+GGHr9o7NqTUYMCOF+0Jl1NkoXiMBLU1/X2xkFaQd6glufm/YsN5dP9/K7C22SR
 pYYFWDaONCfKQlfdrUTaMUJsiHSzcZGLxMhGuM24MBwfvLmz0Evdy4YXjKGwRxrwb8v2 JA== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhjwwr16r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 13:55:20 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMDJZ4B001628
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 13:55:20 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf9tkftbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 13:55:20 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AMDtIXA28508894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Nov 2023 13:55:19 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E02F458059;
	Wed, 22 Nov 2023 13:55:18 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C1F85805B;
	Wed, 22 Nov 2023 13:55:18 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Nov 2023 13:55:18 +0000 (GMT)
Message-ID: <d41c101f-2acd-4f4d-a32a-aa4c063c4f3b@linux.ibm.com>
Date: Wed, 22 Nov 2023 08:55:18 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ima-evm-utils PATCH 10/12] Update EVM signature verification to
 use a local hash algorithm variable
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <20231119165043.46960-1-zohar@linux.ibm.com>
 <20231119165043.46960-11-zohar@linux.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231119165043.46960-11-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: T_Kln6cY354ynJiFLR18M6T5L2VEDX3e
X-Proofpoint-ORIG-GUID: T_Kln6cY354ynJiFLR18M6T5L2VEDX3e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_09,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220098



On 11/19/23 11:50, Mimi Zohar wrote:
> Instead of relying on the "imaevm_params.algo" global variable, which
> is not concurrency-safe, define and use a local file hash algorithm
> variable.
> 
> Update calc_evm_hash(), verify_hash2().
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   src/evmctl.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index ad4565b3ee52..7ae897d8b8b3 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -340,7 +340,8 @@ err:
>    * Returns 0 for EVP_ function failures. Return -1 for other failures.
>    * Return hash algorithm size on success.
>    */
> -static int calc_evm_hash(const char *file, unsigned char *hash)
> +static int calc_evm_hash(const char *file, const char *hash_algo,
> +			 unsigned char *hash)
>   {
>           const EVP_MD *md;
>   	struct stat st;
> @@ -408,10 +409,9 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
>   	}
>   #endif
>   
> -	md = EVP_get_digestbyname(imaevm_params.hash_algo);
> +	md = EVP_get_digestbyname(hash_algo);
>   	if (!md) {
> -		log_err("EVP_get_digestbyname(%s) failed\n",
> -			imaevm_params.hash_algo);
> +		log_err("EVP_get_digestbyname(%s) failed\n", hash_algo);
>   		err = 0;
>   		goto out;
>   	}
> @@ -570,7 +570,7 @@ static int sign_evm(const char *file, const char *key)
>   	unsigned char sig[MAX_SIGNATURE_SIZE];
>   	int len, err;
>   
> -	len = calc_evm_hash(file, hash);
> +	len = calc_evm_hash(file, imaevm_params.hash_algo, hash);
>   	if (len <= 1)
>   		return len;
>   	assert(len <= sizeof(hash));
> @@ -909,6 +909,7 @@ static int verify_evm(void *public_keys, const char *file)
>   {
>   	unsigned char hash[MAX_DIGEST_SIZE];
>   	unsigned char sig[MAX_SIGNATURE_SIZE];
> +	const char *hash_algo = NULL;
>   	int sig_hash_algo;
>   	int mdlen;
>   	int len;
> @@ -938,15 +939,15 @@ static int verify_evm(void *public_keys, const char *file)
>   		log_err("unknown hash algo: %s\n", file);
>   		return -1;
>   	}
> -	imaevm_params.hash_algo = imaevm_hash_algo_by_id(sig_hash_algo);
> +	hash_algo = imaevm_hash_algo_by_id(sig_hash_algo);
>   
> -	mdlen = calc_evm_hash(file, hash);
> +	mdlen = calc_evm_hash(file, hash_algo, hash);
>   	if (mdlen <= 1)
>   		return mdlen;
>   	assert(mdlen <= sizeof(hash));
>   
> -	return verify_hash2(public_keys, file, imaevm_params.hash_algo,
> -			    hash, mdlen, sig, len);
> +	return verify_hash2(public_keys, file, hash_algo, hash,
> +			    mdlen, sig, len);
>   }
>   
>   static int cmd_verify_evm(struct command *cmd)

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

