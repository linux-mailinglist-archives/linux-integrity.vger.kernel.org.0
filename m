Return-Path: <linux-integrity+bounces-198-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EECA07F48D0
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 15:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772C41F218BA
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 14:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC574E1AA;
	Wed, 22 Nov 2023 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Leo57J6r"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4579A18E
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 06:22:49 -0800 (PST)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMDdA3J009258
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 14:22:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=X6qHZECofa4JwKee+zajo+UP1AUCF0jumYpXwG2B6Ak=;
 b=Leo57J6rF+3JlA1dpnROQj490wI2PWszpqzLIpVkNZJv8HR6lkLlb0QcCgR4fAH6/2ix
 9wodhk+KoZJmofzsfALjxAi39uux/4AlNH0q6yca70iC3KusCrYhC3vgEvIKGFCC0Mkp
 sEDwA1GxJl7bnNMgmowGoUkisl1BW9vaMky/7DYDEpGP2/8W/cnfWKfUPaF+iAtyXGd7
 g/C2i/Evu/oIFAoLCfkVugbBrvd3CvMMBHEobTj2kooKSrdfks7ZwHiDX2dCzXDBMcwG
 WRGsjQvDZq9AERYHUvB5AM1nq3ArmH0J/KGsLt5NMCP2G+xAufAaJc4z6DwcyqBUqQvG 0A== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhjd0hv91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 14:22:48 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMDVATg001640
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 14:22:47 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf9tkfy75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 14:22:47 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AMEMkIS49349052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Nov 2023 14:22:46 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A40F15805B;
	Wed, 22 Nov 2023 14:22:46 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E95A58059;
	Wed, 22 Nov 2023 14:22:46 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Nov 2023 14:22:46 +0000 (GMT)
Message-ID: <117e3af9-3372-42ea-bdaf-d5e190ddf196@linux.ibm.com>
Date: Wed, 22 Nov 2023 09:22:45 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ima-evm-utils PATCH 12/12] Define and use a file specific
 "keypass" variable
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <20231119165043.46960-1-zohar@linux.ibm.com>
 <20231119165043.46960-13-zohar@linux.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231119165043.46960-13-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: q8tpd4vpd3sHmkDvoHVogX4uuEKu7hQa
X-Proofpoint-ORIG-GUID: q8tpd4vpd3sHmkDvoHVogX4uuEKu7hQa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_10,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220102



On 11/19/23 11:50, Mimi Zohar wrote:
> Instead of relying on the "imaevm_params.keypass" global variable, which
> is not concurrency-safe, add keypass as a parameter to the static library
> functions definitions.  Update function callers.
> 
> To avoid library incompatablity, don't remove imaevm_params.keypass
> variable.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   src/evmctl.c    |  9 +++++----
>   src/libimaevm.c | 17 ++++++++---------
>   2 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index b802eeb1bf15..6d6160159a1f 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -141,6 +141,7 @@ static bool evm_portable;
>   static bool veritysig;
>   static bool hwtpm;
>   static char *hash_algo;
> +static char *keypass;
>   
>   #define HMAC_FLAG_NO_UUID	0x0001
>   #define HMAC_FLAG_CAPS_SET	0x0002
> @@ -3082,9 +3083,9 @@ int main(int argc, char *argv[])
>   			break;
>   		case 'p':
>   			if (optarg)
> -				imaevm_params.keypass = optarg;
> +				keypass = optarg;
>   			else
> -				imaevm_params.keypass = get_password();
> +				keypass = get_password();
>   			break;
>   		case 'f':
>   			sigfile = 1;
> @@ -3226,8 +3227,8 @@ int main(int argc, char *argv[])
>   		}
>   	}
>   
> -	if (!imaevm_params.keypass)
> -		imaevm_params.keypass = getenv("EVMCTL_KEY_PASSWORD");
> +	if (!keypass)
> +		keypass = getenv("EVMCTL_KEY_PASSWORD");
>   
>   	if (imaevm_params.keyfile != NULL &&
>   	    imaevm_params.eng == NULL &&


The problem at this point in evmctl is that keypass is never passed to 
anywhere. You have to pass it to sign_hash().

> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index 18b6a6f27237..10ec847da08a 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -1124,7 +1124,8 @@ static int get_hash_algo_v1(const char *algo)
>   }
>   
>   static int sign_hash_v1(const char *hashalgo, const unsigned char *hash,
> -			int size, const char *keyfile, unsigned char *sig)
> +			int size, const char *keyfile, const char *keypass,
> +			unsigned char *sig)
>   {
>   	int len = -1, hashalgo_idx;
>   	SHA_CTX ctx;
> @@ -1158,7 +1159,7 @@ static int sign_hash_v1(const char *hashalgo, const unsigned char *hash,
>   	log_info("hash(%s): ", hashalgo);
>   	log_dump(hash, size);
>   
> -	key = read_priv_key(keyfile, imaevm_params.keypass);
> +	key = read_priv_key(keyfile, keypass);
>   	if (!key)
>   		return -1;
>   
> @@ -1211,7 +1212,8 @@ out:
>    * Return: -1 signing error, >0 length of signature
>    */
>   static int sign_hash_v2(const char *algo, const unsigned char *hash,
> -			int size, const char *keyfile, unsigned char *sig)
> +			int size, const char *keyfile, const char *keypass,
> +			unsigned char *sig)
>   {
>   	struct signature_v2_hdr *hdr;
>   	int len = -1;
> @@ -1246,7 +1248,7 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
>   	log_info("hash(%s): ", algo);
>   	log_dump(hash, size);
>   
> -	pkey = read_priv_pkey(keyfile, imaevm_params.keypass);
> +	pkey = read_priv_pkey(keyfile, keypass);
>   	if (!pkey)
>   		return -1;
>   
> @@ -1316,14 +1318,11 @@ err:
>   
>   int sign_hash(const char *hashalgo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig)
>   {
> -	if (keypass)
> -		imaevm_params.keypass = keypass;
> -

I hope all library callers, other than evmctl, passed the keypass in 
already, otherwise they could have set the password via 
imaevm_params.keypass global and passed in NULL and for them this will 
be a behavioral change. Anyway, you have no other choice to get rid of 
imaevm_params as much as possible, so I guess it's ok.

It looks like at this point imaevm_params.keypass doesn't have a single 
user anymore so you could rename it to 'unused1' or so in the stucture 
since it will have zero effect for anyone to set it.

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

