Return-Path: <linux-integrity+bounces-192-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD5C7F47C9
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 14:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0FEDB20DC2
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 13:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316824BA87;
	Wed, 22 Nov 2023 13:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XvaRCocw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5741FC1
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 05:26:42 -0800 (PST)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMDHKbO025352
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 13:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=o/Y34U6QIfRdcfFLMCsYWbTzWZ78H2f9u073ty4wcsQ=;
 b=XvaRCocww+Te7DEqyz2o2RRlbLvGvlpfkv8fLtkY7r8O0Z658eY4cHyhjBljv8NgZFaZ
 r7wY1vf9Gs/AF3abWdxvIEWdrZ2jaqX5qBzYLjyC8MvwZ15KnfYCX/7P8WzmJGxKmSUk
 +nBozPRXNmXS/fSMxLcG22lgidg+nipaSo0SO2eGgTF6jKRCLI5Q0OKqr6kPhq/RPXgR
 3JgBa0uf0DDhby4xavaNnxzm5uo87L7zT5GEt0ivb8qRb+Vkb0lvu/ANdDG/JhKjBOeR
 fpB2WEp7sW9bToSv4j+ZXyFu8peA3Go6PWs5Sx+ZpvnGNsPZ+kQhoqQfdIDY8V2LyEuX jQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhjd0g9d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 13:26:41 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMDPa3I012049
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 13:26:41 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf7kt8aa9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 13:26:41 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AMDQd7l45285902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Nov 2023 13:26:39 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D142358059;
	Wed, 22 Nov 2023 13:26:39 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F0A358058;
	Wed, 22 Nov 2023 13:26:39 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Nov 2023 13:26:39 +0000 (GMT)
Message-ID: <d403b7d4-88ca-431f-8ac7-71f3ee364403@linux.ibm.com>
Date: Wed, 22 Nov 2023 08:26:39 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ima-evm-utils PATCH 08/12] Define library ima_calc_hash2()
 function with a hash algorithm parameter
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <20231119165043.46960-1-zohar@linux.ibm.com>
 <20231119165043.46960-9-zohar@linux.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231119165043.46960-9-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UppmBMIkDUo_8nfzoU2c_TrN0ua5PI1M
X-Proofpoint-ORIG-GUID: UppmBMIkDUo_8nfzoU2c_TrN0ua5PI1M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_09,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220095



On 11/19/23 11:50, Mimi Zohar wrote:
> Instead of relying on the "imaevm_params.algo" global variable, which
> is not concurrency-safe, define a new library ima_calc_hash2() function
> with the hash algorithm as a parameter.
> 
> To avoid library incompatablity, make the existing ima_calc_hash()

-> incompatibility

> function a wrapper for ima_calc_hash2().
> 
> Deprecate ima_calc_hash().

Same comment about possible __attribute__((deprecated)).

> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   src/imaevm.h    |  1 +
>   src/libimaevm.c | 12 ++++++++----
>   2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/src/imaevm.h b/src/imaevm.h
> index 1ed2c81d510d..81acd8df41cb 100644
> --- a/src/imaevm.h
> +++ b/src/imaevm.h
> @@ -237,6 +237,7 @@ extern struct libimaevm_params imaevm_params;
>   void imaevm_do_hexdump(FILE *fp, const void *ptr, int len, bool cr);
>   void imaevm_hexdump(const void *ptr, int len);
>   int ima_calc_hash(const char *file, uint8_t *hash);
> +int ima_calc_hash2(const char *file, const char *hash_algo, uint8_t *hash);
>   int imaevm_get_hash_algo(const char *algo);
>   RSA *read_pub_key(const char *keyfile, int x509);
>   EVP_PKEY *read_pub_pkey(const char *keyfile, int x509);
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index e64d167a2a8a..4c9da7a2f06b 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -181,7 +181,7 @@ out:
>   	return err;
>   }
>   
> -int ima_calc_hash(const char *file, uint8_t *hash)
> +int ima_calc_hash2(const char *file, const char *hash_algo, uint8_t *hash)
>   {
>   	const EVP_MD *md;
>   	struct stat st;
> @@ -202,10 +202,9 @@ int ima_calc_hash(const char *file, uint8_t *hash)
>   		goto err;
>   	}
>   
> -	md = EVP_get_digestbyname(imaevm_params.hash_algo);
> +	md = EVP_get_digestbyname(hash_algo);
>   	if (!md) {
> -		log_err("EVP_get_digestbyname(%s) failed\n",
> -			imaevm_params.hash_algo);
> +		log_err("EVP_get_digestbyname(%s) failed\n", hash_algo);
>   		err = 1;
>   		goto err;
>   	}
> @@ -246,6 +245,11 @@ err:
>   	return err;
>   }
>   
> +int ima_calc_hash(const char *file, uint8_t *hash)
> +{
> +	return ima_calc_hash2(file, imaevm_params.hash_algo, hash);
> +}
> +
>   EVP_PKEY *read_pub_pkey(const char *keyfile, int x509)
>   {
>   	FILE *fp;

Rest looks good to me.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

