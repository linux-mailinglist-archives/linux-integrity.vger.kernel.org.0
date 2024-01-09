Return-Path: <linux-integrity+bounces-707-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1F18289D7
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jan 2024 17:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F5CAB236BC
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jan 2024 16:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32BA3A1BC;
	Tue,  9 Jan 2024 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jrd6fj/w"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA423A1BB
	for <linux-integrity@vger.kernel.org>; Tue,  9 Jan 2024 16:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 409Fh6kh010289
	for <linux-integrity@vger.kernel.org>; Tue, 9 Jan 2024 16:18:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=lMUvoGH7qwqauytwbZ3qblILSyc4WqoNQoEasP+bRZg=;
 b=Jrd6fj/wy9gIuYdzPjxqKXTCTs8osfjzkaVGNVk4S0afCZAWUKE+Qi/dfZrPuJ9z559N
 RXAlZHoor8uuInhoDeRFMyfuDeyQB96Xy97Xvh6UKv7+cAO2/3r65wt7Lg44T9HBI2V7
 uwgfGI/rh/ab6Ld18zgSKElOexQyfS0ydMBG0riqNtoDEz/SDx6rukTqnjHIrU65GMtU
 fC0ayuObkVG4vLFrtGAFcuCCStEeSnbxwGvRx3RMZZhPWhMQBZRlt/+/yZ4jt8k5p/Lu
 72Xqd6rKk8zDhu1ZmmYOw09UUyER5Q3y8Of8UbMP46FnuJMUvZ0/VhNjT9C65uK2+PBd VA== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vh91as229-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 09 Jan 2024 16:18:56 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 409F8FQL000954
	for <linux-integrity@vger.kernel.org>; Tue, 9 Jan 2024 16:18:56 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vfkdk7aw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 09 Jan 2024 16:18:56 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 409GIsTk16974402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jan 2024 16:18:55 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1F8D5805A;
	Tue,  9 Jan 2024 16:18:54 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A117E58051;
	Tue,  9 Jan 2024 16:18:52 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jan 2024 16:18:52 +0000 (GMT)
Message-ID: <6a14b1c0-dcf0-465f-8867-e45c674dc249@linux.ibm.com>
Date: Tue, 9 Jan 2024 11:18:49 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ima-evm-utils PATCH v3 03/13] Update library function
 definitions to include a "public_keys" parameter
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <20240104190558.3674008-1-zohar@linux.ibm.com>
 <20240104190558.3674008-4-zohar@linux.ibm.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240104190558.3674008-4-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4Qig_g5PMez_RBVRIAeDPqEcCSRHLVyF
X-Proofpoint-ORIG-GUID: 4Qig_g5PMez_RBVRIAeDPqEcCSRHLVyF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_07,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1011
 mlxlogscore=999 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401090132



On 1/4/24 14:05, Mimi Zohar wrote:
> Instead of relying on a global static "public_keys" variable, which is
> not concurrency-safe, update static library function definitions to
> include it as a parameter, define new library functions with it as
> a parameter, and deprecate existing functions.
> 
> Define imaevm_init_public_keys(), imaevm_verify_hash(), and
> ima_verify_signature2() functions. Update static function definitions
> to include "public_keys".
> 
> To avoid library incompatibility, make the existing functions -
> init_public_keys(), verify_hash(), ima_verify_signature() - wrappers
> for the new function versions.
> 
> Deprecate init_public_keys(), verify_hash(), ima_verify_signature()
> functions.
> 
> Allow suppressing just the libimevm deprecate warnings by enabling
> IMAEVM_SUPPRESS_DEPRECATED.
>      e.g. configure CFLAGS="-DIMAEVM_SUPPRESS_DEPRECATED"
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   src/imaevm.h    | 21 +++++++++++--
>   src/libimaevm.c | 82 ++++++++++++++++++++++++++++++++++++-------------
>   2 files changed, 78 insertions(+), 25 deletions(-)
> 


> @@ -710,8 +729,9 @@ int imaevm_hash_algo_from_sig(unsigned char *sig)
>   		return -1;
>   }
>   
> -int verify_hash(const char *file, const unsigned char *hash, int size,
> -		unsigned char *sig, int siglen)
> +int imaevm_verify_hash(void *public_keys, const char *file,

Replace void with struct public_key_entry.

With this nit fixed:

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


