Return-Path: <linux-integrity+bounces-2916-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C13DE91308D
	for <lists+linux-integrity@lfdr.de>; Sat, 22 Jun 2024 00:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2622CB27E15
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 22:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2192716D4D8;
	Fri, 21 Jun 2024 22:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CCeqbrPE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F2C80C03
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 22:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719009896; cv=none; b=JfgDtG9ZGQEgfSzFgCcjzIosoRvPLbvB23MBACLTuABUHwn3hzLYU4/sxMBMzsTyEpNYiIGFeXnPO+CP1DA2UB7CxOr0NrmFxNMTxLiIcXNKnGHYUuhSDfl4PSeqOSyjPZGGee13d5KX+YEij17NX6E6REU4slcmrpUkT5TdL5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719009896; c=relaxed/simple;
	bh=pGiL43cTBKzo0bz+55EJw9oEOlMLSN4JlTsszX8UI+c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eCg7AJxZbO7QwP0ccbhGTBPtw3LxhYHWzuTVPgtwsoLCFz8RGQDPNS8XKj+zqAFRgSI11CfZKGmikynNkPRw0XnyKoVgBUUxDelyAOaXwE619zzht+8l2rFBj9jzbGkQAARoG6GZA7sjHtNgLCjGqgmsJXvHBG8iPJyZuReM+LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CCeqbrPE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LLoEx2029492;
	Fri, 21 Jun 2024 22:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	64jq8zWKtERKgwHGgwKLGx8MNdpVh5/z4hb8g6OZNx0=; b=CCeqbrPEwY6Q3+aS
	2xXr1BtLVZVXubWHFKwPYirGbkJa4JfGRRcwuAe049KJ1sPAmsv7LrLGFz194NlU
	3Pl/ku4npcRjKwFPVGKIdZHCBsQuq6w5SaJR03bmMdyUa/ZClc64ProdxW259Aaj
	ekpMzBsQvr+sXmRRSa6HLHmBpNHk7pn7Bj6/36NllVLSVZEspeJRBY0osPefi8T1
	VLUsTWj/XlD8b9XoUgAjsRHmJOFYW5iGXJGhbAUmscz8tl6mzrE7qMEKHpXbkgMq
	67gjCcQqeO8GrmA0+trziz4hz5wvE6pq621GGd9v/H/aQNVDBVxysjAUUCOtkt2T
	slFiVw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ywh15r5st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 22:44:45 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45LMijk7031056;
	Fri, 21 Jun 2024 22:44:45 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ywh15r5sp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 22:44:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45LJVOqZ007687;
	Fri, 21 Jun 2024 22:44:44 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yvrsphk9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 22:44:44 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45LMifsr18285124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 22:44:43 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0F8258055;
	Fri, 21 Jun 2024 22:44:41 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D8405804B;
	Fri, 21 Jun 2024 22:44:41 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.41.136])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Jun 2024 22:44:40 +0000 (GMT)
Message-ID: <e667feaa37e186a2a240ca70c994c27e88724876.camel@linux.ibm.com>
Subject: Re: [PATCH ] ima: fix buffer overrun in ima_eventdigest_init_common
From: Mimi Zohar <zohar@linux.ibm.com>
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
        roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com
Cc: eric.snowberg@oracle.com, linux-integrity@vger.kernel.org
Date: Fri, 21 Jun 2024 18:44:40 -0400
In-Reply-To: <20240620194632.3996068-1-samasth.norway.ananda@oracle.com>
References: <20240620194632.3996068-1-samasth.norway.ananda@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-25.el8_9) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6HcPnd4yp_HB4x89-FUI-6kBwQQX9i-C
X-Proofpoint-ORIG-GUID: wn1o7b9txoFZdi62UBSU2MI9pzXCvM_Z
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_12,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 adultscore=0 spamscore=0 clxscore=1011 impostorscore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210163

Hi Samasth,

On Thu, 2024-06-20 at 12:46 -0700, Samasth Norway Ananda wrote:
> Function ima_eventdigest_init() can call ima_eventdigest_init_common()
> with HASH_ALGO__LAST which is then used to access the array
> hash_digest_size[] leading to buffer overrun. Have a conditional
> statement to handle this.

The original 'ima' template ("d|n") digest is not prefixed with the digest
algorithm, since it is hard coded to sha1.  ima_eventdigest_init() intentionally
calls ima_eventdigest_init_common() with HASH_ALGO__LAST.  To avoid ...

> 
> Fixes: 9fab303a2cb3 ("ima: fix violation measurement list record")
> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
> ---
>  security/integrity/ima/ima_template_lib.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
> index 4183956c53af..14c000fe8312 100644
> --- a/security/integrity/ima/ima_template_lib.c
> +++ b/security/integrity/ima/ima_template_lib.c
> @@ -320,13 +320,17 @@ static int ima_eventdigest_init_common(const u8 *digest, u32 digestsize,
>  
>  	if (digest)

Please add a brace after "digest" and before "else".

Refer to the section titled "3) Placing Braces and Spaces" in "
https://www.kernel.org/doc/html/v4.10/process/coding-style.html.


>  		memcpy(buffer + offset, digest, digestsize);
> -	else
> +	else {
>  		/*
>  		 * If digest is NULL, the event being recorded is a violation.
>  		 * Make room for the digest by increasing the offset by the
>  		 * hash algorithm digest size.
>  		 */

Please update the comment to reflect the case when the hash algorithm isn't
specified.

> -		offset += hash_digest_size[hash_algo];
> +		if (hash_algo < HASH_ALGO__LAST)
> +                        offset += hash_digest_size[hash_algo];
> +               else
> +                        offset += IMA_DIGEST_SIZE;
> +	}
>  
>  	return ima_write_template_field_data(buffer, offset + digestsize,
>  					     fmt, field_data);

Please fix the other scripts/checkpatch.pl complaints.

thanks,

Mimi


