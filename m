Return-Path: <linux-integrity+bounces-191-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB4C7F47BD
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 14:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE80EB20C82
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 13:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334991C6A2;
	Wed, 22 Nov 2023 13:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZJyfD2bo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E95B1BB
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 05:24:17 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMBS2iG024115
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 13:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=c7QQbEhN4DCuqGdazFUr244u7nT+My6AB/KqA7X/5Os=;
 b=ZJyfD2boIWiZEwhCE9JgGAA/CFlKKV+goHAdERzFK13cdUti+59MNNYD1Y3hZ6Xf1J6q
 qnN81/OtDoOaYt0M+x8Pe2lFSu/pfw32G6j+t3JhV5DdXnJJgLywjYnhE6mufN/Xbvce
 eS2S4TLwknfNxeKzdEmu931hSh1HQSpYmwNX8vCbnnvdU707eBtSQbTzAOGMpZLS1hr/
 KzzHphgZ/nX2hZmz9B43Qc79+nePvhgvL3u3zPGqHE0arjGgxLhwtezlNLp8Yt15mctW
 lUW9tgjwO9tUBla3TUZbPXRdN+zzDWmRqJlqjK2oBZ2s83k/tB5rYxeIQsIlRsegkuxW Nw== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhgsutnns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 13:24:16 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMAJdCe012043
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 13:24:15 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf7kt8a0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 13:24:15 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AMDOEsq18874972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Nov 2023 13:24:14 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 865CC58059;
	Wed, 22 Nov 2023 13:24:14 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44C3258058;
	Wed, 22 Nov 2023 13:24:14 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Nov 2023 13:24:14 +0000 (GMT)
Message-ID: <5ccec73c-82c1-497b-9528-4494b054c9eb@linux.ibm.com>
Date: Wed, 22 Nov 2023 08:24:13 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ima-evm-utils PATCH 07/12] Update ima_measurements to define and
 use a local list of public keys
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <20231119165043.46960-1-zohar@linux.ibm.com>
 <20231119165043.46960-8-zohar@linux.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231119165043.46960-8-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hUyIN-H7MXEbhHJ0QOSAbWr34A37WPNP
X-Proofpoint-GUID: hUyIN-H7MXEbhHJ0QOSAbWr34A37WPNP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_09,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220094



On 11/19/23 11:50, Mimi Zohar wrote:
> Replace calling init_public_keys() with the init_public_keys2() version.
> Similarly replace ima_verify_signature() with the ima_verify_signature2()
> version.
> 
> Update the static ima_ng_show() function definition to include a
> "public_keys" parameter.
> 
> Free the local public keys list.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   src/evmctl.c | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index f796edfce5f1..ad4565b3ee52 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -1614,7 +1614,7 @@ static int lookup_template_name_entry(char *template_name)
>   	return 0;
>   }
>   
> -void ima_ng_show(struct template_entry *entry)
> +static void ima_ng_show(void *public_keys, struct template_entry *entry)
>   {
>   	uint8_t *fieldp = entry->template;
>   	uint32_t field_len;
> @@ -1740,10 +1740,12 @@ void ima_ng_show(struct template_entry *entry)
>   		 * the measurement list or calculate the hash.
>   		 */
>   		if (verify_list_sig)
> -			err = ima_verify_signature(path, sig, sig_len,
> -						   digest, digest_len);
> +			err = ima_verify_signature2(public_keys, path,
> +						    sig, sig_len,
> +						    digest, digest_len);
>   		else
> -			err = ima_verify_signature(path, sig, sig_len, NULL, 0);
> +			err = ima_verify_signature2(public_keys, path,
> +						    sig, sig_len, NULL, 0);
>   
>   		if (!err && imaevm_params.verbose > LOG_INFO)
>   			log_info("%s: verification is OK\n", path);
> @@ -2223,6 +2225,7 @@ static int ima_measurement(const char *file)
>   	int first_record = 1;
>   	unsigned int pseudo_padded_banks_mask, pseudo_banks_mask;
>   	unsigned long entry_num = 0;
> +	void *public_keys = NULL;
>   	int c;
>   
>   	struct template_entry entry = { .template = NULL };
> @@ -2252,9 +2255,9 @@ static int ima_measurement(const char *file)
>   	}
>   
>   	if (imaevm_params.keyfile)	/* Support multiple public keys */
> -		init_public_keys(imaevm_params.keyfile);
> +		init_public_keys2(imaevm_params.keyfile, &public_keys);
>   	else				/* assume read pubkey from x509 cert */
> -		init_public_keys("/etc/keys/x509_evm.der");
> +		init_public_keys2("/etc/keys/x509_evm.der", &public_keys);
>   	if (errno)

Hm, a failing malloc() sets errno, so this would be ok. I would change 
this to check for return value != 0 from init_public_keys2().

>   		log_errno_reset(LOG_DEBUG,
>   				"Failure in initializing public keys");
> @@ -2405,7 +2408,7 @@ static int ima_measurement(const char *file)
>   		if (is_ima_template)
>   			ima_show(&entry);
>   		else
> -			ima_ng_show(&entry);
> +			ima_ng_show(public_keys, &entry);
>   
>   		if (!tpmbanks)
>   			continue;
> @@ -2464,6 +2467,7 @@ out_free:
>   	free(pseudo_banks);
>   	free(pseudo_padded_banks);
>   	free(entry.template);
> +	free_public_keys(public_keys);
>   
>   	return err;
>   }

