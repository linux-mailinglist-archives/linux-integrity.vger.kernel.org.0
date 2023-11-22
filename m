Return-Path: <linux-integrity+bounces-185-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F6B7F4685
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 13:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC532280C31
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 12:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22E44D119;
	Wed, 22 Nov 2023 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XmKRyW+7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BF9E7
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 04:44:09 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMBl5M9025023
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 12:44:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5N+8cPGqrHVxE0n26HGMSljGeu5Ms4t6xGQvQ678g/8=;
 b=XmKRyW+7/aN2ypLX2CpuXzB5kq7/OqsQXjQYCN+DgumiuMxqPqubUKatWxM/kI/e8b6F
 iMgLxsGdzwje9lAXVflxyRVA5oPYe7cBmj9mZX7n2WhuOfwGtGzx82cpOS5ciFZGn/2G
 g0oJx8pc4Q+vaXFZRE8EflDG047cs1tyeZP/JJ83voOkl3aAN742EyiCr8oB4HFhufVb
 ubQBjMxeW9wCIvWlRepI6kzkfrqQQMU9ofKKI1RTSeMCli9ed1ZmHcfAprQbqjk1RlaF
 URYOsbHD33mX5PpgogiAgQF+JzKfpTBvrgGW/q+m77GTu41/rJhk7YMUGb1kLXWjNyze tA== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhh2u1ayf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 12:44:09 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMAJddv001628
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 12:44:08 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf9tkfff7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 12:44:08 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AMCi7OP23134820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Nov 2023 12:44:07 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B66CC5803F;
	Wed, 22 Nov 2023 12:44:07 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8679E5805A;
	Wed, 22 Nov 2023 12:44:07 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Nov 2023 12:44:07 +0000 (GMT)
Message-ID: <29868feb-dbeb-4322-9cf2-ad49f468385a@linux.ibm.com>
Date: Wed, 22 Nov 2023 07:44:07 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ima-evm-utils PATCH 01/12] Rename "public_keys" to
 "g_public_keys"
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <20231119165043.46960-1-zohar@linux.ibm.com>
 <20231119165043.46960-2-zohar@linux.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231119165043.46960-2-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LyneCPQ-RRRIQF2yKj7dJt9stIVRtLOV
X-Proofpoint-ORIG-GUID: LyneCPQ-RRRIQF2yKj7dJt9stIVRtLOV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_08,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 impostorscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311220089



On 11/19/23 11:50, Mimi Zohar wrote:
> In preparation for replacing the library global public_keys variable,
> which is not concurrency-safe, with a local variable, rename public_keys
> to g_public_keys.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   src/libimaevm.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index 5b224625644e..117a1a72b60c 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -370,14 +370,14 @@ struct public_key_entry {
>   	char name[9];
>   	EVP_PKEY *key;
>   };
> -static struct public_key_entry *public_keys = NULL;
> +static struct public_key_entry *g_public_keys = NULL;
>   
>   static EVP_PKEY *find_keyid(uint32_t keyid)
>   {
> -	struct public_key_entry *entry, *tail = public_keys;
> +	struct public_key_entry *entry, *tail = g_public_keys;
>   	int i = 1;
>   
> -	for (entry = public_keys; entry != NULL; entry = entry->next) {
> +	for (entry = g_public_keys; entry != NULL; entry = entry->next) {
>   		if (entry->keyid == keyid)
>   			return entry->key;
>   		i++;
> @@ -394,7 +394,7 @@ static EVP_PKEY *find_keyid(uint32_t keyid)
>   	if (tail)
>   		tail->next = entry;
>   	else
> -		public_keys = entry;
> +		g_public_keys = entry;
>   	log_err("key %d: %x (unknown keyid)\n", i, __be32_to_cpup(&keyid));
>   	return 0;
>   }
> @@ -429,8 +429,8 @@ void init_public_keys(const char *keyfiles)
>   		calc_keyid_v2(&entry->keyid, entry->name, entry->key);
>   		sprintf(entry->name, "%x", __be32_to_cpup(&entry->keyid));
>   		log_info("key %d: %s %s\n", i++, entry->name, keyfile);
> -		entry->next = public_keys;
> -		public_keys = entry;
> +		entry->next = g_public_keys;
> +		g_public_keys = entry;
>   	}
>   	free(keyfiles_free);
>   }

