Return-Path: <linux-integrity+bounces-709-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1512F828A20
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jan 2024 17:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77A34B2327F
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jan 2024 16:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FF238F9A;
	Tue,  9 Jan 2024 16:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="caRuVxpY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2718939AFD
	for <linux-integrity@vger.kernel.org>; Tue,  9 Jan 2024 16:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 409GOBD3004161
	for <linux-integrity@vger.kernel.org>; Tue, 9 Jan 2024 16:37:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=eIu+XAPaT9nW+gZFOqXwnuzMsFMh7BGtnUqCGhUi2VM=;
 b=caRuVxpYcgUdB1I6CU0wVxh7C7fbJg+BJyzgHZnfE+P8YJQ7FxpqDH8a/UwZyb2k1HzT
 n2lSIiG6MbLc0gVfEO4ci2Y0FUdMCZifvClBejhQVcT1KwYdR3LXzDAThYqBds1T9Q7V
 6QzsH/z61ipw1grS4hzFQ5S+tpyw+tZCNN0Rqdb4k0TSPBDeZYGqJ95HZBejPZMwnyTx
 QareK59E9jeLoKLuDDEaLGRbTz9QVPkc7/SI8lrMwWEXZn+7LYljv4akQAZzss7ko6pC
 4x8MobPE2eSYDvnlHfw+59wVfT+qpGmRYXhq0ZFjhdk6cmBQ8gsdeuMfR0NNkLc214PI DA== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vh91asmpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 09 Jan 2024 16:37:39 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 409FU1Qa027253
	for <linux-integrity@vger.kernel.org>; Tue, 9 Jan 2024 16:37:39 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vfkw1y9yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 09 Jan 2024 16:37:39 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 409GbcCu16646714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jan 2024 16:37:38 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C24658060;
	Tue,  9 Jan 2024 16:37:38 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35E905805E;
	Tue,  9 Jan 2024 16:37:35 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jan 2024 16:37:34 +0000 (GMT)
Message-ID: <258a0b93-c8ca-4321-a777-42f6a531739c@linux.ibm.com>
Date: Tue, 9 Jan 2024 11:37:31 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ima-evm-utils PATCH v3 05/13] Update cmd_verify_ima() to define
 and use a local list of public keys
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <20240104190558.3674008-1-zohar@linux.ibm.com>
 <20240104190558.3674008-6-zohar@linux.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240104190558.3674008-6-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: m6Ufc_-L2gPBgPbTFf65JDfskQ_TNP-R
X-Proofpoint-ORIG-GUID: m6Ufc_-L2gPBgPbTFf65JDfskQ_TNP-R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_08,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401090134



On 1/4/24 14:05, Mimi Zohar wrote:
> Update the static verify_ima() function definition to include
> "public_keys".
> 
> Replace calling init_public_keys() with the imaevm_init_public_keys()
> version.  Similarly replace ima_verify_signature() with the
> ima_verify_signature2() version.
> 
> Free the local public keys list.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   src/evmctl.c | 29 +++++++++++++++++++----------
>   1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 2710a27cb305..5d84a41a0762 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -972,7 +972,7 @@ static int cmd_verify_evm(struct command *cmd)
>   	return err;
>   }
>   
> -static int verify_ima(const char *file)
> +static int verify_ima(struct public_key_entry *public_keys, const char *file)
>   {
>   	unsigned char sig[MAX_SIGNATURE_SIZE];
>   	int len;
> @@ -999,34 +999,43 @@ static int verify_ima(const char *file)
>   		}
>   	}
>   
> -	return ima_verify_signature(file, sig, len, NULL, 0);
> +	return ima_verify_signature2(public_keys, file, sig, len, NULL, 0);
>   }
>   
>   static int cmd_verify_ima(struct command *cmd)
>   {
> +	struct public_key_entry *public_keys = NULL;
>   	char *file = g_argv[optind++];
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
> +			err = imaevm_init_public_keys(imaevm_params.keyfile,
> +						      &public_keys);
> +		else			   /* assume read pubkey from x509 cert */
> +			err = imaevm_init_public_keys("/etc/keys/x509_evm.der",
> +						      &public_keys);
> +		if (err < 0) {
> +			log_info("Failed loading public keys");
> +			return err;
> +		}
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
> +	imaevm_free_public_keys(public_keys);
>   	return fails > 0;
>   }
>   

