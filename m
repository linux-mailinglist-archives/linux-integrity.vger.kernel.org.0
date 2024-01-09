Return-Path: <linux-integrity+bounces-708-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D21D828A0F
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jan 2024 17:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1420B21A9E
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jan 2024 16:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA40337144;
	Tue,  9 Jan 2024 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BgHa599h"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE38A958
	for <linux-integrity@vger.kernel.org>; Tue,  9 Jan 2024 16:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 409GLkhP011991
	for <linux-integrity@vger.kernel.org>; Tue, 9 Jan 2024 16:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=JTQTcBrvL36Gnrzaf76rxjrLz9mUSQ2QrVLU6qwGXiQ=;
 b=BgHa599hnpirf6GON3v3rEZofqmajiRUVuBEUsRJrvr/Hi+/58oSiGjpOcNC/5otxyjB
 09woCLtf0h9aTFWUrdkIVlEoTzBC4aYOXBi9LKVIp2t7cQzUoXDY2N3NZ3DWFV0smNYq
 3p7yYly6h9EYfzKWusT+rKuzas7HiPDJemEjaryQzDrHxP3nqnB6lTsoqfLXX/w6d2iS
 jzXoHIk9S5N11pKUkyG5EPati16im4v4TEkZVeFA0W20VPjk/WxsFohSO+l2Z8UThTiO
 Wnhwd+7lTYJ1P37/2CGPQPGII5Jg8ISmbuWDPixp9Szbz0GHzVc0r5722C77kGnBDPZb zg== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vh9f8rm36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 09 Jan 2024 16:34:36 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 409EN7sc004388
	for <linux-integrity@vger.kernel.org>; Tue, 9 Jan 2024 16:34:35 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vfjpkqmk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 09 Jan 2024 16:34:35 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 409GYYT431195668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jan 2024 16:34:35 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5A0B5805A;
	Tue,  9 Jan 2024 16:34:34 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 057DD58051;
	Tue,  9 Jan 2024 16:34:31 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jan 2024 16:34:30 +0000 (GMT)
Message-ID: <d3b43368-6c5f-4e81-8e01-e95735bb26e6@linux.ibm.com>
Date: Tue, 9 Jan 2024 11:34:20 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ima-evm-utils PATCH v3 04/13] Update imaevm_verify_hash()
 definition to include "hash_algo" parameter
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <20240104190558.3674008-1-zohar@linux.ibm.com>
 <20240104190558.3674008-5-zohar@linux.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240104190558.3674008-5-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: REvn-fPiFVDYKGRUOKr2SheIfafvMpAs
X-Proofpoint-ORIG-GUID: REvn-fPiFVDYKGRUOKr2SheIfafvMpAs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_07,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401090133



On 1/4/24 14:05, Mimi Zohar wrote:
> Instead of relying on a global static "hash_algo" variable, which is not
> concurrency-safe, update the imaevm_verify_hash() function definition
> and callers to include a "hash_algo" parameter as a place holder.
> 
> Now with the "hash_algo" parameter, export the imaevm_verify_hash()
> definition.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   src/imaevm.h    |  3 +++
>   src/libimaevm.c | 15 ++++++++-------
>   2 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/src/imaevm.h b/src/imaevm.h
> index 4fd421f5cd1d..0b86d28944b3 100644
> --- a/src/imaevm.h
> +++ b/src/imaevm.h
> @@ -261,6 +261,9 @@ IMAEVM_DEPRECATED int ima_verify_signature(const char *file, unsigned char *sig,
>   					   int digestlen);
>   IMAEVM_DEPRECATED void init_public_keys(const char *keyfiles);
>   
> +int imaevm_verify_hash(struct public_key_entry *public_keys, const char *file,
> +		       const char *hash_algo, const unsigned char *hash,
> +		       int size, unsigned char *sig, int siglen);
>   int ima_verify_signature2(struct public_key_entry *public_keys, const char *file,
>   			  unsigned char *sig, int siglen,
>   			  unsigned char *digest, int digestlen);
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index 9cc83e071610..a5e9fd5080ac 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -729,9 +729,9 @@ int imaevm_hash_algo_from_sig(unsigned char *sig)
>   		return -1;
>   }
>   
> -int imaevm_verify_hash(void *public_keys, const char *file,
> -		       const unsigned char *hash, int size,
> -		       unsigned char *sig, int siglen)
> +int imaevm_verify_hash(struct public_key_entry *public_keys, const char *file,
> +		       const char *hash_algo, const unsigned char *hash,
> +		       int size, unsigned char *sig, int siglen)

With patch 3 fixed, this will disappear.

>   {
>   	/* Get signature type from sig header */
>   	if (sig[1] == DIGSIG_VERSION_1) {
> @@ -762,7 +762,8 @@ int imaevm_verify_hash(void *public_keys, const char *file,
>   int verify_hash(const char *file, const unsigned char *hash, int size,
>   		unsigned char *sig, int siglen)
>   {
> -	return imaevm_verify_hash(g_public_keys, file, hash, size, sig, siglen);
> +	return imaevm_verify_hash(g_public_keys, file, NULL, hash, size,
> +				  sig, siglen);
>   }
>   
>   int ima_verify_signature2(struct public_key_entry *public_keys, const char *file,
> @@ -795,15 +796,15 @@ int ima_verify_signature2(struct public_key_entry *public_keys, const char *file
>   	 * measurement list, not by calculating the local file digest.
>   	 */
>   	if (digest && digestlen > 0)
> -		return imaevm_verify_hash(public_keys, file, digest, digestlen,
> -					  sig, siglen);
> +		return imaevm_verify_hash(public_keys, file, NULL, digest,
> +					  digestlen, sig, siglen);
>   
>   	hashlen = ima_calc_hash(file, hash);
>   	if (hashlen <= 1)
>   		return hashlen;
>   	assert(hashlen <= sizeof(hash));
>   
> -	return imaevm_verify_hash(public_keys, file, hash, hashlen,
> +	return imaevm_verify_hash(public_keys, file, NULL, hash, hashlen,
>   				  sig, siglen);
>   }
>   

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

