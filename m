Return-Path: <linux-integrity+bounces-4930-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B563A3DE69
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 16:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0D71882E6B
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 15:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913B31D61A3;
	Thu, 20 Feb 2025 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CwLJbmc+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFE861FCE
	for <linux-integrity@vger.kernel.org>; Thu, 20 Feb 2025 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065064; cv=none; b=tNXcVs1tGgqfgi72eIFGxNEC/+0DWsZpnM+CkUapG2IRCSk6/xuwuLYEfwUhW2yoVJ/P5fXKpkQYHbDFmiLWyIWUeRa+4NmGy6C6AamNnw0dtqNCd5FE8AxM+d/VQyRsKZM1rzXUZGktmV3c663qK32DN+x3PnP29eJrs6ecY3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065064; c=relaxed/simple;
	bh=y0Xwrmc5FNxYS4QKOGyuDaz1j8kjW7ZzPgUbg4Y5Lzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iFNbQtJfCEsRoulGVnRpOrq6pduDRXIS9hgnQVDEDNPx+YG0+cKsPLescCzn6K3o4XQI15V50+GWkMBWwHIOpwiEfbAP3SUDDqHJS8iy838J/Q7L3IqYZJ6EaWTYZ9+Fs1jmnR5LIv1pqXuw1OzhuywG/8IY62dODH4C8K1AeuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CwLJbmc+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KE38xr028245;
	Thu, 20 Feb 2025 15:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HgvVO0
	nTzC0EfWxkjRpxVO5iIuk8GvtkLsuvDbBsYnw=; b=CwLJbmc+j1voFbXmLUOmC6
	HCh7YmkyAaG2Z8RunnZWAiVZ3tMPXXM2Ww28ITMLFbs/R0NtEe3sWoofpmC98F+F
	fZvREKqHJ7F5++ZhXJaLCa2H6gwSIj2to03Bomm8M0yP5FShhiQTGu2VD7nSdtVI
	DVfedfyISeTWzL0YEeccnQrpYNRxG2qLGn2tTXERhmRhaKY464c8TX99cXOB9xyE
	y/9YXmtty6D366Uqy4rgFZAtXL8CdETknN4UyEo5eiyXvc5BIRWn36JNJh8ds6kp
	5TcPXuAT6Nm9LXsRnwdmztwF0txm3amnyA8ZetKZ+vgX4dmaSMRD3FZuo3hhJKwg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wx78jtym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 15:24:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51KFHaeL005817;
	Thu, 20 Feb 2025 15:24:08 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w02xjnpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 15:24:08 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51KFO7NU26870316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 15:24:07 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 648655805D;
	Thu, 20 Feb 2025 15:24:07 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C55D58043;
	Thu, 20 Feb 2025 15:24:07 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2025 15:24:07 +0000 (GMT)
Message-ID: <8bebd73a-8950-40c6-92e1-493354b2480c@linux.ibm.com>
Date: Thu, 20 Feb 2025 10:24:06 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ima: limit the number of open-writers integrity
 violations
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: roberto.sassu@huawei.com, Petr Vorel <pvorel@suse.cz>
References: <20250219162131.416719-1-zohar@linux.ibm.com>
 <20250219162131.416719-2-zohar@linux.ibm.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20250219162131.416719-2-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jt0klp6AhsG5KqeENdTuVDQdpzxdzYxN
X-Proofpoint-ORIG-GUID: jt0klp6AhsG5KqeENdTuVDQdpzxdzYxN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_06,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 malwarescore=0 mlxscore=0 clxscore=1011
 spamscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200108



On 2/19/25 11:21 AM, Mimi Zohar wrote:
> Each time a file in policy, that is already opened for write, is opened
> for read an open-writers integrity violation audit message is emitted
> and a violation record is added to the IMA measurement list, even if an
> open-writers violation has already been recorded.
> 
> Limit the number of open-writers integrity violations for an existing
> file open for write to one.  After the existing file open for write
> closes (__fput), subsequent open-writers integrity violations may occur.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Tested-by: Stefan Berger <stefanb@linux.ibm.com>


> ---
> Change log v1:
> - Basesd on Stefan's RFC comments, updated the patch description and code.
> 
>   security/integrity/ima/ima.h      |  1 +
>   security/integrity/ima/ima_main.c | 11 +++++++++--
>   2 files changed, 10 insertions(+), 2 deletions(-)
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
> index 28b8b0db6f9b..cde3ae55d654 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -137,8 +137,13 @@ static void ima_rdwr_violation_check(struct file *file,
>   	} else {
>   		if (must_measure)
>   			set_bit(IMA_MUST_MEASURE, &iint->atomic_flags);
> -		if (inode_is_open_for_write(inode) && must_measure)
> -			send_writers = true;
> +
> +		/* Limit number of open_writers violations */
> +		if (inode_is_open_for_write(inode) && must_measure) {
> +			if (!test_and_set_bit(IMA_LIMIT_VIOLATIONS,
> +					      &iint->atomic_flags))
> +				send_writers = true;
> +		}
>   	}
> 
>   	if (!send_tomtou && !send_writers)
> @@ -167,6 +172,8 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
>   	if (atomic_read(&inode->i_writecount) == 1) {
>   		struct kstat stat;
> 
> +		clear_bit(IMA_LIMIT_VIOLATIONS, &iint->atomic_flags);
> +
>   		update = test_and_clear_bit(IMA_UPDATE_XATTR,
>   					    &iint->atomic_flags);
>   		if ((iint->flags & IMA_NEW_FILE) ||
> --
> 2.48.1
> 


