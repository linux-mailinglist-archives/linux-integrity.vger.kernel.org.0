Return-Path: <linux-integrity+bounces-582-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 506FD821C77
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jan 2024 14:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E065E280EB2
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jan 2024 13:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD0BF9EB;
	Tue,  2 Jan 2024 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iQWcFRty"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3AFF9E9
	for <linux-integrity@vger.kernel.org>; Tue,  2 Jan 2024 13:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 402ChEkC007023
	for <linux-integrity@vger.kernel.org>; Tue, 2 Jan 2024 13:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=9KNqaKcoXijBHetRkPqOE5YribcZdD+JrEJgsL93wMU=;
 b=iQWcFRtyoMpT3uHH2MqsFGXT2ckYC1Gh+DEeGj3VDsZulBMindjkCNxju/9dK+Nbnk9H
 blOMPeK5sCmeQEYAZw0ojW/6C3YGLFivkqIaqcbFXotdQt3czcF8XZu3XKQ0cOoeq8iX
 U/VPw3cnAUzGA5fBA+9v2bseh6PzTXmQfw578n1jqvVKYg18oGGPx1ny3l8YIjOv866k
 x+4tNl0eJRKGfB3XNfSWo41mAHcXRTn04VgUhZJTawNXbGWxOMWtVkcH2aTeU/o8plMN
 sFJU8TDA8srbKA7aMC6JjVyzjga6Rpn6ThOs32i+qV0f2Q6zP9PxUvs5+5Z9kz8TS54Y Kg== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vcfv9mxav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 02 Jan 2024 13:18:27 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 402AfdJM019345
	for <linux-integrity@vger.kernel.org>; Tue, 2 Jan 2024 13:18:26 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vc30sc38x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 02 Jan 2024 13:18:26 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 402DIPiA55706030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jan 2024 13:18:25 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C174058055;
	Tue,  2 Jan 2024 13:18:25 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F03C5805B;
	Tue,  2 Jan 2024 13:18:25 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jan 2024 13:18:25 +0000 (GMT)
Message-ID: <ac5faca5-74f4-4faa-8b9a-91d1fbac8e0b@linux.ibm.com>
Date: Tue, 2 Jan 2024 08:18:25 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ima-evm-utils PATCH v2 05/13] Update cmd_verify_ima() to define
 and use a local list of public keys
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <20231206192734.339999-1-zohar@linux.ibm.com>
 <20231206192734.339999-6-zohar@linux.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231206192734.339999-6-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PSjchEniHncW_4OZmZAz-HEmyK-tijit
X-Proofpoint-ORIG-GUID: PSjchEniHncW_4OZmZAz-HEmyK-tijit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-02_03,2024-01-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401020102



On 12/6/23 14:27, Mimi Zohar wrote:
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
> ---
>   src/evmctl.c | 29 +++++++++++++++++++----------
>   1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 2710a27cb305..3ae79262efbb 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -972,7 +972,7 @@ static int cmd_verify_evm(struct command *cmd)
>   	return err;
>   }
>   
> -static int verify_ima(const char *file) > +static int verify_ima(void *public_keys, const char *file)

Use struct public_key_entry *.

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
>   	char *file = g_argv[optind++];
> +	void *public_keys = NULL;

Use struct public_key_entry *.

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

Rest LGTM.

