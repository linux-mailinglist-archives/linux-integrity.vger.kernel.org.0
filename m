Return-Path: <linux-integrity+bounces-186-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD2C7F46F6
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 13:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C072810A9
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 12:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF074D11B;
	Wed, 22 Nov 2023 12:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="piFqOmbA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2661E7
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 04:52:40 -0800 (PST)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMBrcKI019919
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 12:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ucb7aoBpa8ibhP3JvSg0BtE8lhJq0PWO3MYViFIm0nA=;
 b=piFqOmbAK0E1zvfw80ebY7mR+5UFsHwhSm+flnvlweGDZLKvRvh5SJ2KvS5zDycsUpov
 4L/sLESx9PFAeHN5BFiytWIky/GI2GBjswAev2AWcF8mt22nYNXcMWlDzIyxrsUJrK/C
 VLR8hS81IKq3mPbJ6Ddc5Y7S9wfURGoqoHFFYHpBbXl3UIdzNCvX/Tg9AmcX5zIyXAPa
 nyENHxHQh35i44wbIgu2lBZhVW1oz5Tfg13qIe8E/XU6VmyiSD5Hw7M63DnlcofKbjLb
 Njq5aShmt+1rdRU9uo/QTfdhTlumUo58lZiwmWHPFJSYzb924Y6eYDPJ/TApEyglL2uD Jg== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhggt2tbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 12:52:39 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMAJtkL028673
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 12:52:38 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ufaa27bgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 12:52:38 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AMCqcQZ22610466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Nov 2023 12:52:38 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDD5C58043;
	Wed, 22 Nov 2023 12:52:37 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB24958059;
	Wed, 22 Nov 2023 12:52:37 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Nov 2023 12:52:37 +0000 (GMT)
Message-ID: <5bd2569f-9aa6-4938-88f1-513451427e81@linux.ibm.com>
Date: Wed, 22 Nov 2023 07:52:37 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ima-evm-utils PATCH 02/12] Free public keys list
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <20231119165043.46960-1-zohar@linux.ibm.com>
 <20231119165043.46960-3-zohar@linux.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231119165043.46960-3-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dNOmWVhqr2Bv0W4JfPk8JZpI7rd0l8a5
X-Proofpoint-ORIG-GUID: dNOmWVhqr2Bv0W4JfPk8JZpI7rd0l8a5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_08,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220091



On 11/19/23 11:50, Mimi Zohar wrote:
> On failure to allocate memory, free the public keys list.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   src/imaevm.h    |  1 +
>   src/libimaevm.c | 17 +++++++++++++++++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/src/imaevm.h b/src/imaevm.h
> index 18d7b0e447e1..828976e52881 100644
> --- a/src/imaevm.h
> +++ b/src/imaevm.h
> @@ -249,6 +249,7 @@ uint32_t imaevm_read_keyid(const char *certfile);
>   int sign_hash(const char *algo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig);
>   int verify_hash(const char *file, const unsigned char *hash, int size, unsigned char *sig, int siglen);
>   int ima_verify_signature(const char *file, unsigned char *sig, int siglen, unsigned char *digest, int digestlen);
> +void free_public_keys(void *public_keys);
>   void init_public_keys(const char *keyfiles);
>   int imaevm_hash_algo_from_sig(unsigned char *sig);
>   const char *imaevm_hash_algo_by_id(int algo);
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index 117a1a72b60c..74e9d09b1f05 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -399,11 +399,25 @@ static EVP_PKEY *find_keyid(uint32_t keyid)
>   	return 0;
>   }
>   
> +void free_public_keys(void *public_keys)
> +{
> +	struct public_key_entry *entry = public_keys, *next;
> +
> +	while (entry != NULL) {
> +		next = entry->next;
> +		if (entry->key)
> +			free(entry->key);
> +		free(entry);
> +		entry = next;
> +	}
> +}
> +
>   void init_public_keys(const char *keyfiles)
>   {
>   	struct public_key_entry *entry;
>   	char *tmp_keyfiles, *keyfiles_free;
>   	char *keyfile;
> +	int err = 0;
>   	int i = 1;
>   
>   	tmp_keyfiles = strdup(keyfiles);
> @@ -417,6 +431,7 @@ void init_public_keys(const char *keyfiles)
>   		entry = malloc(sizeof(struct public_key_entry));
>   		if (!entry) {
>   			perror("malloc");
> +			err = -ENOMEM;
>   			break;
>   		}
>   
> @@ -433,6 +448,8 @@ void init_public_keys(const char *keyfiles)
>   		g_public_keys = entry;
>   	}
>   	free(keyfiles_free);
> +	if (err < 0)
> +		free_public_keys(g_public_keys);
>   }
>   
>   /*

Unfortunately you cannot return the err to callers...

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

