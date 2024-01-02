Return-Path: <linux-integrity+bounces-583-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E690821CEF
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jan 2024 14:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98395B207F0
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jan 2024 13:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1D4FBE4;
	Tue,  2 Jan 2024 13:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NJLSvn/0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0716DFBEF
	for <linux-integrity@vger.kernel.org>; Tue,  2 Jan 2024 13:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 402CPo2U012377
	for <linux-integrity@vger.kernel.org>; Tue, 2 Jan 2024 13:42:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=6Gk00+EPTeZNw3CWUyfh3e0/04685C1agkEbVP+R/w0=;
 b=NJLSvn/0AOistacW3UjNoK3DwxytXcYkBbR4pKuIol5T8yo8IfNmTtFR45eZEJr7lrV5
 11VcSiYb8GSINSQHEg2x/Vm3Eu/L0/hsU2a0qZyQK1nZ8LWU2k9/X9Z2QBBMalwHX9Kp
 kFa9bBVVDIAo7AnR7ZHH7yAWxfUD3fZBSdbJEOWmOxwJITwHkfvzj+bM7UO+KkmI60aN
 BXkUJuZ0geF7RWCGc+W97hjJ5i/ksiFtmA6l9Q8wpFoJJmmbAT+DOPwH+s9zH+zQmvtF
 4RQL01EfDg3zvoTVZ4hZbsvGuULe/tuyISDtODyfc1LEGjjYX5eqAtX7ilMSam1/MRwe Ew== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vcf2j5svh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 02 Jan 2024 13:42:15 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 402Bv35n017981
	for <linux-integrity@vger.kernel.org>; Tue, 2 Jan 2024 13:42:15 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vayrkcqnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 02 Jan 2024 13:42:15 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 402DgE6M46269138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jan 2024 13:42:14 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BEF658055;
	Tue,  2 Jan 2024 13:42:14 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C82435804B;
	Tue,  2 Jan 2024 13:42:13 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jan 2024 13:42:13 +0000 (GMT)
Message-ID: <70ce6c8e-308d-4473-90d1-b597d27b493c@linux.ibm.com>
Date: Tue, 2 Jan 2024 08:42:13 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ima-evm-utils PATCH v2 11/13] Use a file specific hash algorithm
 variable for signing files
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <20231206192734.339999-1-zohar@linux.ibm.com>
 <20231206192734.339999-12-zohar@linux.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231206192734.339999-12-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3CgJ-OxHZLE3nPmsICsYOW3izfJKUTwx
X-Proofpoint-ORIG-GUID: 3CgJ-OxHZLE3nPmsICsYOW3izfJKUTwx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-02_04,2024-01-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401020105



On 12/6/23 14:27, Mimi Zohar wrote:
> Instead of relying on the library "imaevm_params.algo" global variable,
> which is not concurrency-safe, define and use an evmctl file specific
> hash algorithm variable.
> 
> Propagate using the file specific hash algorithm variable in sign_evm(),
> sign_ima(), hash_ima(), and sign_hash() function.
> 
> Replace using the library function ima_calc_hash() with ima_calc_hash2().
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   src/evmctl.c | 34 +++++++++++++++++-----------------
>   1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 9e1f4e33bc01..8eb2c46fbff0 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -140,6 +140,7 @@ static bool evm_immutable;
>   static bool evm_portable;
>   static bool veritysig;
>   static bool hwtpm;
> +static char *g_hash_algo = DEFAULT_HASH_ALGO;
>   
>   #define HMAC_FLAG_NO_UUID	0x0001
>   #define HMAC_FLAG_CAPS_SET	0x0002
> @@ -564,18 +565,18 @@ out:
>   	return err;
>   }
>   
> -static int sign_evm(const char *file, const char *key)
> +static int sign_evm(const char *file, char *hash_algo, const char *key)
>   {
>   	unsigned char hash[MAX_DIGEST_SIZE];
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
> +	int algo = imaevm_get_hash_algo(g_hash_algo);
>   
>   	if (algo < 0) {
> -		log_err("Unknown hash algo: %s\n", imaevm_params.hash_algo);
> +		log_err("Unknown hash algo: %s\n", g_hash_algo);
>   		return -1;
>   	}
>   	if (algo > PKEY_HASH_SHA1) {
> @@ -624,7 +625,7 @@ static int hash_ima(const char *file)
>   		offset = 1;
>   	}
>   
> -	len = ima_calc_hash(file, hash + offset);
> +	len = ima_calc_hash2(file, g_hash_algo, hash + offset);
>   	if (len <= 1)
>   		return len;
>   	assert(len + offset <= sizeof(hash));
> @@ -632,7 +633,7 @@ static int hash_ima(const char *file)
>   	len += offset;
>   
>   	if (imaevm_params.verbose >= LOG_INFO)
> -		log_info("hash(%s): ", imaevm_params.hash_algo);
> +		log_info("hash(%s): ", g_hash_algo);
>   
>   	if (sigdump || imaevm_params.verbose >= LOG_INFO)
>   		imaevm_hexdump(hash, len);
> @@ -650,18 +651,18 @@ static int hash_ima(const char *file)
>   	return 0;
>   }
>   
> -static int sign_ima(const char *file, const char *key)
> +static int sign_ima(const char *file, char *hash_algo, const char *key)
>   {
>   	unsigned char hash[MAX_DIGEST_SIZE];
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
> @@ -751,7 +752,7 @@ static int sign_ima_file(const char *file)
>   
>   	key = imaevm_params.keyfile ? : "/etc/keys/privkey_evm.pem";
>   
> -	return sign_ima(file, key);
> +	return sign_ima(file, g_hash_algo, key);
>   }
>   
>   static int cmd_sign_ima(struct command *cmd)
> @@ -854,7 +855,7 @@ static int cmd_sign_hash(struct command *cmd)
>   			assert(hashlen / 2 <= sizeof(hash));
>   			hex2bin(hash, line, hashlen / 2);
>   
> -			siglen = sign_hash(imaevm_params.hash_algo, hash,
> +			siglen = sign_hash(g_hash_algo, hash,
>   					   hashlen / 2, key, NULL, sig + 1);
>   			sig[0] = EVM_IMA_XATTR_DIGSIG;
>   		}
> @@ -874,7 +875,6 @@ static int cmd_sign_hash(struct command *cmd)
>   		print_usage(cmd);
>   		return -1;
>   	}
> -
>   	return 0;
>   }
>   
> @@ -886,7 +886,7 @@ static int sign_evm_path(const char *file)
>   	key = imaevm_params.keyfile ? : "/etc/keys/privkey_evm.pem";
>   
>   	if (digsig) {
> -		err = sign_ima(file, key);
> +		err = sign_ima(file, g_hash_algo, key);
>   		if (err)
>   			return err;
>   	}
> @@ -897,7 +897,7 @@ static int sign_evm_path(const char *file)
>   			return err;
>   	}
>   
> -	return sign_evm(file, key);
> +	return sign_evm(file, g_hash_algo, key);
>   }
>   
>   static int cmd_sign_evm(struct command *cmd)
> @@ -1426,7 +1426,7 @@ static int cmd_hmac_evm(struct command *cmd)
>   	key = imaevm_params.keyfile ? : "/etc/keys/privkey_evm.pem";
>   
>   	if (digsig) {
> -		err = sign_ima(file, key);
> +		err = sign_ima(file, g_hash_algo, key);
>   		if (err)
>   			return err;
>   	}
> @@ -3087,7 +3087,7 @@ int main(int argc, char *argv[])
>   			sigdump = 1;
>   			break;
>   		case 'a':
> -			imaevm_params.hash_algo = optarg;
> +			g_hash_algo = optarg;
>   			break;
>   		case 'p':
>   			if (optarg)

