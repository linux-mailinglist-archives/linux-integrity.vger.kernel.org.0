Return-Path: <linux-integrity+bounces-190-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 875EB7F479C
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 14:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8447FB20D2B
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 13:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421A21A597;
	Wed, 22 Nov 2023 13:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OZJ90+Wm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C79C191
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 05:20:44 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMD85JN031293
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 13:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Tz9LTHJ6yFV2rdBkMEqreZB8NpNZHZ8X/uEVul1q4Kw=;
 b=OZJ90+Wm6OmiuV9IfkRZIaPQSoWbC6H4lOQrBGroDHtg4fIQ43nhEkarwz7IYWVccanp
 uKtI+GawhRoAQCHdnbkYoyhYmiifr9JiPfYTeujGw9zLC/m2gcBN0K4AXu6s9sVRbZ2Q
 yNfMh4BADnzhfb8xFOBcvr4G5yU9ZrlKffmPMnxYvGFlzJcKGnhDFyrnSN6EA/dv1owf
 Maq2rAFtHqMpJxO7wi+cxq2XxNyQe6ODVlgNyndXunWpNtCM6GJ834mF3Xtn89J56r4D
 YCGlph9IfqkVi7a6nGSgnl2LvrP8Hi/24XUH6p4KHibu+CMKS+Imvxcq+QUCdbypH7+l vw== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhj8qg8ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 13:20:37 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMAJmrJ001707
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 13:16:48 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf93kyug6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 13:16:48 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AMDGltM23200508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Nov 2023 13:16:47 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BD2D5805D;
	Wed, 22 Nov 2023 13:16:47 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0655F58053;
	Wed, 22 Nov 2023 13:16:47 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Nov 2023 13:16:46 +0000 (GMT)
Message-ID: <7395834e-d28f-478c-8d80-79e8951ee288@linux.ibm.com>
Date: Wed, 22 Nov 2023 08:16:46 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ima-evm-utils PATCH 05/12] Update cmd_verify_ima() to define and
 use a local list of public keys
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <20231119165043.46960-1-zohar@linux.ibm.com>
 <20231119165043.46960-6-zohar@linux.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231119165043.46960-6-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Xw5cmgURE9t6cRyIhgVWXl_ty-AvczeO
X-Proofpoint-ORIG-GUID: Xw5cmgURE9t6cRyIhgVWXl_ty-AvczeO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_09,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311220094



On 11/19/23 11:50, Mimi Zohar wrote:
> Update the static verify_ima() fucntion definition to include "public_keys".
> 
-> function

> Replace calling init_public_keys() with the init_public_keys2() version.
> Similarly replace ima_verify_signature() with the ima_verify_signature2()
> version.
> 
> Free the local public keys list.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   src/evmctl.c | 23 +++++++++++++----------
>   1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 4190913f0295..bf1f8f07e9ca 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -972,7 +972,7 @@ static int cmd_verify_evm(struct command *cmd)
>   	return err;
>   }
>   
> -static int verify_ima(const char *file)
> +static int verify_ima(void *public_keys, const char *file)
>   {
>   	unsigned char sig[MAX_SIGNATURE_SIZE];
>   	int len;
> @@ -999,34 +999,37 @@ static int verify_ima(const char *file)
>   		}
>   	}
>   
> -	return ima_verify_signature(file, sig, len, NULL, 0);
> +	return ima_verify_signature2(public_keys, file, sig, len, NULL, 0);
>   }
>   
>   static int cmd_verify_ima(struct command *cmd)
>   {
>   	char *file = g_argv[optind++];
> +	void *public_keys = NULL;
>   	int err, fails = 0;
>   
> -	if (imaevm_params.x509) {
> -		if (imaevm_params.keyfile) /* Support multiple public keys */
> -			init_public_keys(imaevm_params.keyfile);
> -		else			   /* assume read pubkey from x509 cert */
> -			init_public_keys("/etc/keys/x509_evm.der");
> -	}
> -
>   	if (!file) {
>   		log_err("Parameters missing\n");
>   		print_usage(cmd);
>   		return -1;
>   	}
>   
> +	if (imaevm_params.x509) {
> +		if (imaevm_params.keyfile) /* Support multiple public keys */
> +			init_public_keys2(imaevm_params.keyfile, &public_keys);
> +		else			   /* assume read pubkey from x509 cert */
> +			init_public_keys2("/etc/keys/x509_evm.der", &public_keys);

You should probably check the return code of this function.

> +	}
> +
>   	do {
> -		err = verify_ima(file);
> +		err = verify_ima(public_keys, file);
>   		if (err)
>   			fails++;
>   		if (!err && imaevm_params.verbose >= LOG_INFO)
>   			log_info("%s: verification is OK\n", file);
>   	} while ((file = g_argv[optind++]));
> +
> +	free_public_keys(public_keys);
>   	return fails > 0;
>   }
>   

