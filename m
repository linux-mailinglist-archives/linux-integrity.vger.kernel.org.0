Return-Path: <linux-integrity+bounces-5305-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B042AA665C7
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Mar 2025 02:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43D60166F38
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Mar 2025 01:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3478617C220;
	Tue, 18 Mar 2025 01:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hpNCSpJL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D6D17A30C;
	Tue, 18 Mar 2025 01:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742263041; cv=none; b=EDTgjaULobqUa1xAVWEkLGCe+14KCOTBzbPadVeBbCRXpmnw4AhFiKr2J4LBxuudOk20vmJUTBVYHMzM/GSXRYkW9zU35eY2j531WuUS/16aLE7NGovNHluSATHnrZ4oYe7Su2+wnV73PAuxoXSL40Sl7BFyRTTovFYbBRUORp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742263041; c=relaxed/simple;
	bh=/iBmV1cXQoWTW1R5ATObPFcGTqqYcJQHsoPrlpEpZ5A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z5XTK7QKlDxNTHBQu8CmWV05uEbdeY9Vz5qR+JoVA0vdfMeB+0oHVOKNZhS9DX4vuM2+psYYN9H6TTKbWfVsdUISau7kL71+1mYvQqvUg63a4IF/yOeBBTNjE1S2TE20E8oxUmTjOLiTcZs8yOMKDW/YKqTBY9Hy5PeeyNm8HPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hpNCSpJL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HKWmtU013021;
	Tue, 18 Mar 2025 01:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=v8WC45
	Oi6UTAujif7QXeW5fwBszpSKjT+aq0rVJo5hA=; b=hpNCSpJLklwprbY8IyD+lh
	YNUVU/FgAhCJ5q53s0EDnB9/e/yFSr9VSTq3whnlveXSBEcSWG6Q7qCCj6M4mtxi
	eERds/zWrepVsI3FXkAfyVcWc7JicltEWNLrXEI327410kh4F8tEj2LQXCc0npBG
	w+NG9+z/99WHMef7b9NP92pAlgkUGXZnFbuqfbR+EBUWLyquMh06YvbmC3zCacek
	TSIkuCrERtjCHXxgkir5Ha+5NwcKjh7VU0ZQWMntuF0sMvIqCdwJ7TtCabXiv/8k
	JQ7c0L54Ig/cx9md5VwKCafBvw//UZD4rKD0AabCakFAzmhqANtWlfVx2SDKGPGQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ec49dmqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 01:57:05 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52I1ustW018855;
	Tue, 18 Mar 2025 01:57:05 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ec49dmqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 01:57:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52HMCcQg009577;
	Tue, 18 Mar 2025 01:57:03 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dm8ysgun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 01:57:03 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52I1v3Ze33686128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 01:57:03 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0326158056;
	Tue, 18 Mar 2025 01:57:03 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F1BD5805A;
	Tue, 18 Mar 2025 01:57:02 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.183.137])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Mar 2025 01:57:02 +0000 (GMT)
Message-ID: <7e7d730961ee65dd063755f6a1ff9aefdcdff430.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v1 3/7] ima: move INVALID_PCR() to ima.h
From: Mimi Zohar <zohar@linux.ibm.com>
To: Nicolai Stange <nstange@suse.de>,
        Roberto Sassu
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 17 Mar 2025 21:57:02 -0400
In-Reply-To: <20250313173339.3815589-4-nstange@suse.de>
References: <20250313173339.3815589-1-nstange@suse.de>
	 <20250313173339.3815589-4-nstange@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zqgMWr-Ui97ZSANoVVtI_CR8IQTTLhiE
X-Proofpoint-ORIG-GUID: w5N93VrmQGHyaqgUAhq6136PR6usp9lG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_01,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=955 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2503180012

On Thu, 2025-03-13 at 18:33 +0100, Nicolai Stange wrote:
> Make the INVALID_PCR() #define available to other compilation units
> by moving it from ima_policy.c to ima.h and renaming it to
> IMA_INVALID_PCR() in the course.
>=20
> Signed-off-by: Nicolai Stange <nstange@suse.de>

Restoring the IMA measurement list doesn't involve extending the TPM.  The =
hash
specific measurements have already been extended into the respective TPM ba=
nks.
Is this and the subsequent patch necessary?

Mimi


> ---
>  security/integrity/ima/ima.h        | 4 ++++
>  security/integrity/ima/ima_policy.c | 5 +----
>  2 files changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index a4f284bd846c..1158a7b8bf6b 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -198,6 +198,10 @@ struct ima_iint_cache {
>  	struct ima_digest_data *ima_hash;
>  };
> =20
> +#define IMA_INVALID_PCR(a) (((a) < 0) || \
> +	(a) >=3D (sizeof_field(struct ima_iint_cache, measured_pcrs) * 8))
> +
> +
>  extern struct lsm_blob_sizes ima_blob_sizes;
> =20
>  static inline struct ima_iint_cache *
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima=
/ima_policy.c
> index 128fab897930..d9e4210ea814 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -48,9 +48,6 @@
>  #define HASH		0x0100
>  #define DONT_HASH	0x0200
> =20
> -#define INVALID_PCR(a) (((a) < 0) || \
> -	(a) >=3D (sizeof_field(struct ima_iint_cache, measured_pcrs) * 8))
> -
>  int ima_policy_flag;
>  static int temp_ima_appraise;
>  static int build_ima_appraise __ro_after_init;
> @@ -1855,7 +1852,7 @@ static int ima_parse_rule(char *rule, struct ima_ru=
le_entry *entry)
>  			ima_log_string(ab, "pcr", args[0].from);
> =20
>  			result =3D kstrtoint(args[0].from, 10, &entry->pcr);
> -			if (result || INVALID_PCR(entry->pcr))
> +			if (result || IMA_INVALID_PCR(entry->pcr))
>  				result =3D -EINVAL;
>  			else
>  				entry->flags |=3D IMA_PCR;


