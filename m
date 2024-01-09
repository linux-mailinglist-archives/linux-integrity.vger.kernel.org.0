Return-Path: <linux-integrity+bounces-710-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7411828A9E
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jan 2024 18:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18F251C23A66
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jan 2024 17:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54E73A8C5;
	Tue,  9 Jan 2024 17:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="flNUhxH6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D8A38DC7
	for <linux-integrity@vger.kernel.org>; Tue,  9 Jan 2024 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 409GCHVM002207
	for <linux-integrity@vger.kernel.org>; Tue, 9 Jan 2024 17:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=sYFaik/wOZsl3JyPphXKs6eO17FZUOVd/sjEn6LmUfY=;
 b=flNUhxH6/kpNSz1+Vev6NUREm9t79EzLRKuTcX17WAgi1f0VuYvOGHxQ2utSyrdtRooQ
 2wM4+zo4mLdOkCZHmtCiuTeSkb9r5yfSIxbeKcFEJJr0gESqabQbL0EWRhCQzhntpR1S
 WiRfhnLlztQj/ZZCBg/CkDqwTCPn9HV+bs4s44B3qxRFWUQwHZXLofWnN2NJyQ0Xlsvu
 ZJMUva7iB7+Fv2hHQMT6DoWUpjFOr5kCLUUzxuz7HlifuZBxoSNCZepf3aZXIsI7PDWC
 FK582oE/RnXdM1zGERgpKrbLSIBgeLbbXj6dLH7dgQtQnVw1UFHY09Rm7Zruy/8g3sZ1 eQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vh9f11avx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 09 Jan 2024 17:00:33 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 409FqfVj027872
	for <linux-integrity@vger.kernel.org>; Tue, 9 Jan 2024 17:00:32 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vgwfskw0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 09 Jan 2024 17:00:32 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 409H0W5v21693112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jan 2024 17:00:32 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D2F258051;
	Tue,  9 Jan 2024 17:00:32 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA88A58066;
	Tue,  9 Jan 2024 17:00:25 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jan 2024 17:00:25 +0000 (GMT)
Message-ID: <18b3fa5f-746e-486f-af92-1cf074a92a3a@linux.ibm.com>
Date: Tue, 9 Jan 2024 12:00:07 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ima-evm-utils PATCH v3 06/13] Update cmd_verify_evm to define
 and use a local list of public keys
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <20240104190558.3674008-1-zohar@linux.ibm.com>
 <20240104190558.3674008-7-zohar@linux.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240104190558.3674008-7-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9oQF-VCDj27RScYeq1zwwkLKGqAFsqJU
X-Proofpoint-ORIG-GUID: 9oQF-VCDj27RScYeq1zwwkLKGqAFsqJU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_08,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401090138



On 1/4/24 14:05, Mimi Zohar wrote:
> Replace calling init_public_keys() with the imaevm_init_public_keys()
> version. Similarly replace verify_hash() with the imaevm_verify_hash()
> version.
> 
> Update the static function verify_evm() definition to include a
> "public_keys" parameter.
> 
> Free the local public keys list.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   src/evmctl.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 5d84a41a0762..29c4d1dc1f0d 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -905,7 +905,7 @@ static int cmd_sign_evm(struct command *cmd)
>   	return do_cmd(cmd, sign_evm_path);
>   }
>   
> -static int verify_evm(const char *file)
> +static int verify_evm(struct public_key_entry *public_keys, const char *file)
>   {
>   	unsigned char hash[MAX_DIGEST_SIZE];
>   	unsigned char sig[MAX_SIGNATURE_SIZE];
> @@ -945,11 +945,13 @@ static int verify_evm(const char *file)
>   		return mdlen;
>   	assert(mdlen <= sizeof(hash));
>   
> -	return verify_hash(file, hash, mdlen, sig, len);
> +	return imaevm_verify_hash(public_keys, file, imaevm_params.hash_algo,
> +				  hash, mdlen, sig, len);
>   }
>   
>   static int cmd_verify_evm(struct command *cmd)
>   {
> +	struct public_key_entry *public_keys = NULL;
>   	char *file = g_argv[optind++];
>   	int err;
>   
> @@ -961,14 +963,22 @@ static int cmd_verify_evm(struct command *cmd)
>   
>   	if (imaevm_params.x509) {
>   		if (imaevm_params.keyfile) /* Support multiple public keys */
> -			init_public_keys(imaevm_params.keyfile);
> +			err = imaevm_init_public_keys(imaevm_params.keyfile,
> +						      &public_keys);
>   		else			   /* assume read pubkey from x509 cert */
> -			init_public_keys("/etc/keys/x509_evm.der");
> +			err = imaevm_init_public_keys("/etc/keys/x509_evm.der",
> +						      &public_keys);
> +		if (err < 0) {
> +			log_info("Failed loading public keys");
> +			return err;
> +		}
>   	}
>   
> -	err = verify_evm(file);
> +	err = verify_evm(public_keys, file);
>   	if (!err && imaevm_params.verbose >= LOG_INFO)
>   		log_info("%s: verification is OK\n", file);
> +
> +	imaevm_free_public_keys(public_keys);
>   	return err;
>   }
>   

