Return-Path: <linux-integrity+bounces-585-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0CB821D07
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jan 2024 14:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8085DB21772
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jan 2024 13:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F11F10942;
	Tue,  2 Jan 2024 13:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Dkst2WDq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9603A10955
	for <linux-integrity@vger.kernel.org>; Tue,  2 Jan 2024 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 402DHqcp003214
	for <linux-integrity@vger.kernel.org>; Tue, 2 Jan 2024 13:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=oF7VwaVxTGE+kAcj26gG7QM7Z6AHHVYIzWuyMUs2jyU=;
 b=Dkst2WDqp/+zlHJ3svV/7gSpV4E+ygwAJnHRfl9va9cN7d56t4ThT5WH+b3h5kXXSYKe
 g2VHGmiiyZnYLJMML1feDmFIqVkbu1pSDqx7MZGXDXgWLlFaASa7vNs0UHFiBExaZzUv
 kz1F56NxzY5pkAlNzwr+oQzvk1gHV+qoz2V6E0xxn6KRyrbW4fAM3OETQqJnWoskb83x
 AJ0LA264nywsEu/4kO5rSde5MQIFNgtKUDQ3iwxTwmCxY1KvlHtCoVG/C4r1NT06B9jv
 MVVPkB3DV3ZhQcLP5C3v0OKy/2mL6kadO5c0DmmJw4NgrM/ElNM6KJ+ucSuKmDIrUOoP NQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vck8drk2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 02 Jan 2024 13:47:19 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 402DSfMD027284
	for <linux-integrity@vger.kernel.org>; Tue, 2 Jan 2024 13:47:00 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vawht5a62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 02 Jan 2024 13:47:00 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 402DkxRD24969860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jan 2024 13:46:59 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6982758063;
	Tue,  2 Jan 2024 13:46:59 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E4DD5804B;
	Tue,  2 Jan 2024 13:46:59 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jan 2024 13:46:58 +0000 (GMT)
Message-ID: <26f9c974-9ed5-44e8-a121-546a4d29758e@linux.ibm.com>
Date: Tue, 2 Jan 2024 08:46:58 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ima-evm-utils PATCH v2 13/13] Define and use a file specific
 "keypass" variable
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <20231206192734.339999-1-zohar@linux.ibm.com>
 <20231206192734.339999-14-zohar@linux.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231206192734.339999-14-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iL-AiYWT5lbpCR295EEcdWxUHCnglh_2
X-Proofpoint-ORIG-GUID: iL-AiYWT5lbpCR295EEcdWxUHCnglh_2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-02_04,2024-01-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401020106



On 12/6/23 14:27, Mimi Zohar wrote:
> Instead of relying on the "imaevm_parrams.keypass" global variable,
> which is not concurrency-safe, define and use a file specific variable.
> 
> To avoid library incompatibility, don't remove imaevm_params.keypass
> variable.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


> ---
>   src/evmctl.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 8eb2c46fbff0..72b800f6884c 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -141,6 +141,7 @@ static bool evm_portable;
>   static bool veritysig;
>   static bool hwtpm;
>   static char *g_hash_algo = DEFAULT_HASH_ALGO;
> +static char *g_keypass;
>   
>   #define HMAC_FLAG_NO_UUID	0x0001
>   #define HMAC_FLAG_CAPS_SET	0x0002
> @@ -576,7 +577,7 @@ static int sign_evm(const char *file, char *hash_algo, const char *key)
>   		return len;
>   	assert(len <= sizeof(hash));
>   
> -	len = sign_hash(hash_algo, hash, len, key, NULL, sig + 1);
> +	len = sign_hash(hash_algo, hash, len, key, g_keypass, sig + 1);
>   	if (len <= 1)
>   		return len;
>   	assert(len < sizeof(sig));
> @@ -662,7 +663,7 @@ static int sign_ima(const char *file, char *hash_algo, const char *key)
>   		return len;
>   	assert(len <= sizeof(hash));
>   
> -	len = sign_hash(hash_algo, hash, len, key, NULL, sig + 1);
> +	len = sign_hash(hash_algo, hash, len, key, g_keypass, sig + 1);
>   	if (len <= 1)
>   		return len;
>   	assert(len < sizeof(sig));
> @@ -844,7 +845,7 @@ static int cmd_sign_hash(struct command *cmd)
>   			}
>   
>   			siglen = sign_hash(algo, sigv3_hash, hashlen / 2,
> -					   key, NULL, sig + 1);
> +					   key, g_keypass, sig + 1);
>   
>   			sig[0] = IMA_VERITY_DIGSIG;
>   			sig[1] = DIGSIG_VERSION_3;	/* sigv3 */
> @@ -856,7 +857,7 @@ static int cmd_sign_hash(struct command *cmd)
>   			hex2bin(hash, line, hashlen / 2);
>   
>   			siglen = sign_hash(g_hash_algo, hash,
> -					   hashlen / 2, key, NULL, sig + 1);
> +					   hashlen / 2, key, g_keypass, sig + 1);
>   			sig[0] = EVM_IMA_XATTR_DIGSIG;
>   		}
>   
> @@ -3091,9 +3092,9 @@ int main(int argc, char *argv[])
>   			break;
>   		case 'p':
>   			if (optarg)
> -				imaevm_params.keypass = optarg;
> +				g_keypass = optarg;
>   			else
> -				imaevm_params.keypass = get_password();
> +				g_keypass = get_password();
>   			break;
>   		case 'f':
>   			sigfile = 1;
> @@ -3235,8 +3236,8 @@ int main(int argc, char *argv[])
>   		}
>   	}
>   
> -	if (!imaevm_params.keypass)
> -		imaevm_params.keypass = getenv("EVMCTL_KEY_PASSWORD");
> +	if (!g_keypass)
> +		g_keypass = getenv("EVMCTL_KEY_PASSWORD");
>   
>   	if (imaevm_params.keyfile != NULL &&
>   	    imaevm_params.eng == NULL &&

