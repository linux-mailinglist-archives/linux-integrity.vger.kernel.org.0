Return-Path: <linux-integrity+bounces-584-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3018A821D02
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jan 2024 14:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3C5286B37
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jan 2024 13:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33CFFBF2;
	Tue,  2 Jan 2024 13:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aUuI1gSF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C490FBFC
	for <linux-integrity@vger.kernel.org>; Tue,  2 Jan 2024 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 402CLA1F013325
	for <linux-integrity@vger.kernel.org>; Tue, 2 Jan 2024 13:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=49JOxrsf4nCOSUlEnhl4KynTwNuLzy+jfV+A7r5Y6V8=;
 b=aUuI1gSF1e5nObM22PNRb3muqiqCgMSvTAuScKkag1xfud9aOEmul/ZmHaV6mPOgqmpQ
 G4mSvWRlePG4h3f4GFIIrmwCARtxGauV9/nFPyncaQYV+tPQ/RU85zvhtBzfocl4uCj7
 49IYKKdyBxSTQtIZi07msHu7F1A0Zzz9pZudsOYaDJ2Dmmv15dIxJD/j7pEMLlIsytyo
 Wz/Qk2T52lo8mfeBvZ9Kqk3dof+pFX5AlNycBNqtb8Nl1vu8TDCVwn64AEkjj6sTQ1e8
 tx3kf9HhAOdb+2Doq3yKl+vUQIUjwIl8/Mn3vxgvAiv6uyKWi+KKDd7po38uocdiNlVW jA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vbxkc3uh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 02 Jan 2024 13:44:26 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 402At9Mg019327
	for <linux-integrity@vger.kernel.org>; Tue, 2 Jan 2024 13:44:25 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vc30sc6we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 02 Jan 2024 13:44:25 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 402DiNN812386960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jan 2024 13:44:24 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5D1758059;
	Tue,  2 Jan 2024 13:44:23 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A6A55804B;
	Tue,  2 Jan 2024 13:44:23 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jan 2024 13:44:23 +0000 (GMT)
Message-ID: <e530b4ab-dcd1-449a-a66e-83ae671655c9@linux.ibm.com>
Date: Tue, 2 Jan 2024 08:44:22 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ima-evm-utils PATCH v2 12/13] Update sign_hash_v*() definition
 to include the key password
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <20231206192734.339999-1-zohar@linux.ibm.com>
 <20231206192734.339999-13-zohar@linux.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231206192734.339999-13-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HWRKucouZvjUfTTvdA_80PT5S8KT1iDm
X-Proofpoint-GUID: HWRKucouZvjUfTTvdA_80PT5S8KT1iDm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-02_04,2024-01-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401020105



On 12/6/23 14:27, Mimi Zohar wrote:
> The library sign_hash() definition already includes a key password as a
> parameter, but it isn't passed on to sign_hash_v*() functions.  Update
> the sign_hash_v*() function definitions and callers.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   src/libimaevm.c | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index 10e1ed3eab4d..9d8f419ae64d 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -1115,7 +1115,8 @@ static int get_hash_algo_v1(const char *algo)
>   }
>   
>   static int sign_hash_v1(const char *hashalgo, const unsigned char *hash,
> -			int size, const char *keyfile, unsigned char *sig)
> +			int size, const char *keyfile, const char *keypass,
> +			unsigned char *sig)
>   {
>   	int len = -1, hashalgo_idx;
>   	SHA_CTX ctx;
> @@ -1149,7 +1150,7 @@ static int sign_hash_v1(const char *hashalgo, const unsigned char *hash,
>   	log_info("hash(%s): ", hashalgo);
>   	log_dump(hash, size);
>   
> -	key = read_priv_key(keyfile, imaevm_params.keypass);
> +	key = read_priv_key(keyfile, keypass);
>   	if (!key)
>   		return -1;
>   
> @@ -1202,7 +1203,8 @@ out:
>    * Return: -1 signing error, >0 length of signature
>    */
>   static int sign_hash_v2(const char *algo, const unsigned char *hash,
> -			int size, const char *keyfile, unsigned char *sig)
> +			int size, const char *keyfile, const char *keypass,
> +			unsigned char *sig)
>   {
>   	struct signature_v2_hdr *hdr;
>   	int len = -1;
> @@ -1237,7 +1239,7 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
>   	log_info("hash(%s): ", algo);
>   	log_dump(hash, size);
>   
> -	pkey = read_priv_pkey(keyfile, imaevm_params.keypass);
> +	pkey = read_priv_pkey(keyfile, keypass);
>   	if (!pkey)
>   		return -1;
>   
> @@ -1307,14 +1309,14 @@ err:
>   
>   int sign_hash(const char *hashalgo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig)
>   {
> -	if (keypass)
> -		imaevm_params.keypass = keypass;
> +	if (!keypass)	/* Avoid breaking existing libimaevm usage */
> +		keypass = imaevm_params.keypass;
>   
>   	if (imaevm_params.x509)
> -		return sign_hash_v2(hashalgo, hash, size, keyfile, sig);
> +		return sign_hash_v2(hashalgo, hash, size, keyfile, keypass, sig);
>   #if CONFIG_SIGV1
>   	else
> -		return sign_hash_v1(hashalgo, hash, size, keyfile, sig);
> +		return sign_hash_v1(hashalgo, hash, size, keyfile, keypass, sig);
>   #endif
>   	log_info("Signature version 1 deprecated.");
>   	return -1;

