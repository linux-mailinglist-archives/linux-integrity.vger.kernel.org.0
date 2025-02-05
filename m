Return-Path: <linux-integrity+bounces-4735-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2ECA29CEE
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Feb 2025 23:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9EF47A2600
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Feb 2025 22:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C178218E99;
	Wed,  5 Feb 2025 22:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KtJkK5j0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DF521773E
	for <linux-integrity@vger.kernel.org>; Wed,  5 Feb 2025 22:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738795862; cv=none; b=KdJ2CiGBVRseXDolskT1Hwnxolf0bQ0iujrQilU6JDb12f3+b0m87X07xK/sQfPz/wJ6aQ38ZNkCL2z7vJKFGET7GK9UUokHLLf7Jndn8UxfJLk2ZtxxwglJXcG7+CYlEt+Sg2n+dpdZas2eqUhDJ32fUv2YK5K2HRjsSMZWJi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738795862; c=relaxed/simple;
	bh=Wh0VDaZ/D5Qn8bmib1Frahaq30kiPDcvUUteN+4v36A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ljlzENw1W3A1x5n7n4N2GLs9YHrRf8+udQY61q4Qf3Gk3AeWfWdhKcBflnNKGvmInWjcI62YuAIhDHckSoVn/zLYszzp7RbmNeSuybwEKyMF5gGU++7dd10fQ/dXAnL+FnqP9sVAfMBOQlGaVWXAIBVeVFS2ruL9Su2Ax6wF2jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KtJkK5j0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515F1jUF001752;
	Wed, 5 Feb 2025 22:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rsFj4o
	y2olOzpeNfKrP4+6n9a7U/lVXgqlzwm4UuA+I=; b=KtJkK5j04+vEOJerRmYqAh
	+FBghiVHFNzaeWMbiVXhq/84RYGV7iVoyXaCkmZHRq9Ih1DJb7VaxPgCDgvvGElC
	tBogTzKsCR0Rvc4tZ4vk4n1GNaV3vUUmpfSiIW6cKx/vz6oh1YJL3P0mqke0o101
	4mCj1NosITYmZ1NQ2+Zs/Z9Rzh1DcDan3Hg+guxggmHQACch0/ANNsbLJYvewGgk
	a22tne7tiv+IFZOZ446pb/dqqqozhXYqvln8za2B6o9TbEZoyw0XS+bBzB05VtKf
	/wK+dWiEwQ95BDCqDdddANvtkvPXRLRB9rdAaJjxFKHRxQATpCzQB7T2s4S6Tmaw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ma8ytct9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 22:50:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 515K5h5r006525;
	Wed, 5 Feb 2025 22:50:50 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hyekk5qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 22:50:50 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 515MonHD56295746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Feb 2025 22:50:49 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2853958055;
	Wed,  5 Feb 2025 22:50:49 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E521E58059;
	Wed,  5 Feb 2025 22:50:48 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Feb 2025 22:50:48 +0000 (GMT)
Message-ID: <317f8bb3-34eb-498b-9823-883d10a325a9@linux.ibm.com>
Date: Wed, 5 Feb 2025 17:50:48 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/2] ima: limit the number of open-writers
 integrity violations
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: roberto.sassu@huawei.com
References: <20250205033210.849509-1-zohar@linux.ibm.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20250205033210.849509-1-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: e2qS4tu_qRbKLhLQtvSgj9c_U9QrjQle
X-Proofpoint-GUID: e2qS4tu_qRbKLhLQtvSgj9c_U9QrjQle
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 phishscore=0 mlxlogscore=967 spamscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050172



On 2/4/25 10:32 PM, Mimi Zohar wrote:
> Limit the number of open-writers integrity violation audit messages
> and records in the IMA measurement list emitted when re-opening a
> file for read.

.. to only show one violation. (?)

> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   security/integrity/ima/ima.h      |  1 +
>   security/integrity/ima/ima_main.c | 14 ++++++++++++--
>   2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index a4f284bd846c..7f21568544dd 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -182,6 +182,7 @@ struct ima_kexec_hdr {
>   #define IMA_CHANGE_ATTR		2
>   #define IMA_DIGSIG		3
>   #define IMA_MUST_MEASURE	4
> +#define IMA_LIMIT_VIOLATIONS	5
>   
>   /* IMA integrity metadata associated with an inode */
>   struct ima_iint_cache {
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 28b8b0db6f9b..5091ad931677 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -137,8 +137,16 @@ static void ima_rdwr_violation_check(struct file *file,
>   	} else {
>   		if (must_measure)
>   			set_bit(IMA_MUST_MEASURE, &iint->atomic_flags);

iint is assumed to be here under, which is correct when must_measure is 
set since how the single caller of this function calls it.

> -		if (inode_is_open_for_write(inode) && must_measure)
> -			send_writers = true;
> +
> +		if (inode_is_open_for_write(inode) && must_measure) {
> +			if (!iint)
> +				iint = ima_iint_find(inode);

When must_measure is set, the case of iint == NULL should never occur here.

> +
> +			/* Limit number of open_writers violations */
> +			if (iint && !test_and_set_bit(IMA_LIMIT_VIOLATIONS,
> +						      &iint->atomic_flags))
if (!test_and_set_bit(...))


> +				send_writers = true;
> +		}
>   	}
>   
>   	if (!send_tomtou && !send_writers)
> @@ -167,6 +175,8 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
>   	if (atomic_read(&inode->i_writecount) == 1) {
>   		struct kstat stat;
>   
> +		clear_bit(IMA_LIMIT_VIOLATIONS, &iint->atomic_flags);
> +
>   		update = test_and_clear_bit(IMA_UPDATE_XATTR,
>   					    &iint->atomic_flags);
>   		if ((iint->flags & IMA_NEW_FILE) ||

I tested the two patches. For the file /usr/bin/foobar that's being 
measured on FILE_CHECK I get two violations for this sequence here:

# exec 3>/usr/bin/foobar
# exec 4</usr/bin/foobar
# exec 3>/usr/bin/foobar

This here now only emits one violation now.

# exec 3>/usr/bin/foobar
# exec 4</usr/bin/foobar
# exec 4</usr/bin/foobar
# exec 5</usr/bin/foobar
# exec 6</usr/bin/foobar



