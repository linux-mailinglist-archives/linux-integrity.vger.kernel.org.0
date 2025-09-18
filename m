Return-Path: <linux-integrity+bounces-7153-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 014B9B845C3
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 13:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2941BC0A72
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 11:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA023279DB4;
	Thu, 18 Sep 2025 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kAlq2MP6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF122FFF86;
	Thu, 18 Sep 2025 11:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758195024; cv=none; b=gINI70dOKbFnGn6ZV4qLJAgMSJS/CySh6UwPM/c46o9cDeaEl5vWzscg24yKAUVpCzn/OX83260vWyIMGU0EIpE+Lr9fnfNRa7efr3K4gNtrJkNJl4KEKX2nH4/C89kmViUNCbpRbxqJQ0PuhdvEVYF/w3s/ORXwrZsIMlghtBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758195024; c=relaxed/simple;
	bh=7lVLoeYwTuFHxY6LU9qZ9Nj3iox/+jRqtu9rv4jEfeA=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=jkGhbyGEs826khhWopQjQ/9+qQEZGfg+DOEFwOw1rnpHdJaduksRw8+O4CmqCRW2963YSD0PeYcqxrVGgDcNGnfDFD3v0GiHPh9RESjF1oDZHyT/P6Kqc46+Cl8b9bFG7Mvd9NXjTsiKLgxx5F+rCUZ9M+LoVDny5qsdLloICtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kAlq2MP6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I7ZXix000328;
	Thu, 18 Sep 2025 11:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Cfe5ye
	d+st1LaoGAlaeebw4NC28/PmM4I2h0DXqh0Ts=; b=kAlq2MP6ZWJIgqSsxlKVt2
	RiVz2oDUPwX1cYTMj0Z4IyWnPztVX0rVxqdmi+XlRuhDvESvYC0+JrCc1t6l7jdR
	Z1KKSRfrQaCn0Lro6Xoz24A/H6MYduZaHoRqObvHVipnPimwC/58QnnhyZxjPtxi
	p4aOK1P+tOUl+rWRMJ+Net+lFT7mAO4CakDg0K8qvcdM/IWaLIzNFbWNnNDyTfqx
	aYixhbNdzFIUWKEOLUV29lYVl+g7WchpJhyxhIGoo1ukVHvyp9S700snabTp8p4U
	Tl9bcTFNLt25+cFxwEhFgDFFB8/3oiUoTj6D9ku4ps/KmQq8cq2iVTiUR9uV/ncQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 498dtwh3sp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:29:18 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58IBTHIV007687;
	Thu, 18 Sep 2025 11:29:17 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 498dtwh3sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:29:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58I92k8D029468;
	Thu, 18 Sep 2025 11:29:17 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kb16hjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:29:17 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58IBTGcu20906506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 11:29:16 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E2C45805D;
	Thu, 18 Sep 2025 11:29:16 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E62658056;
	Thu, 18 Sep 2025 11:29:15 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.76.15])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Sep 2025 11:29:15 +0000 (GMT)
Message-ID: <8b560b9522c1c42e26a108e2f9b2977901d73649.camel@linux.ibm.com>
Subject: Re: [PATCH v4 15/34] lsm: rename/rework ordered_lsm_parse() to
 lsm_order_parse()
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
        Roberto Sassu	
 <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?=	 <mic@digikod.net>,
        =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
        Kees Cook
 <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
        Casey Schaufler	
 <casey@schaufler-ca.com>,
        Tetsuo Handa
 <penguin-kernel@I-love.SAKURA.ne.jp>,
        Nicolas Bouchinet
 <nicolas.bouchinet@oss.cyber.gouv.fr>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
In-Reply-To: <20250916220355.252592-51-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
	 <20250916220355.252592-51-paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Sep 2025 07:29:15 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EYvIQOmC c=1 sm=1 tr=0 ts=68cbed0e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=vpqfxihKAAAA:8 a=DfNHnWVPAAAA:8
 a=xVhDTqbCAAAA:8 a=VnNF1IyMAAAA:8 a=3HYbWfqQRXicnkShgLIA:9 a=QEXdDO2ut3YA:10
 a=AULIiLoY-XQsE5F6gcqX:22 a=rjTVMONInIDnV1a_A2c_:22 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-ORIG-GUID: 70N_k6VfSbfNWxX2DK1fSKM8pF7J3jAB
X-Proofpoint-GUID: jXf6Wk73o5TXQ2EwwSzLAfmyXWBaPdhb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDA2NSBTYWx0ZWRfX3en/Clk1d/ee
 HHhZSj1+ApT9EbrUc6W/VgUy20eL2eXc/P9q85YgCLk/wEIWuPCiykcN4rdaJafVfe/1sXaa+nI
 6EZI/wKqc6QwUjk5DFoa2aokwKl5i9BR1xwEXUslWYRp3QMEqPEEmtO6wkwA0B7gdClwH/GsWfo
 4/Sqv/Pbc9Qj/tRF8VuocR4Q0wBNWBoqIl7lM+EThaECKBk1bjAkAv1sQ9zSHhj9QJPEP/+ttK3
 O4JfnXfcyD3fKQMzuM8EqZNj/ZRhDLF8ISXPvxG3mVQTO4myCbnAldMIOfov6JLx1s/KrqFsyt9
 1X9oMuyhibF+170jpqgcaLbEU0hmHiwc0dgfZ3cBWaMRBGu9jIHGpuUt3OHBFLQ4CT+QlC0e8XN
 QPDyzB2Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509180065

On Tue, 2025-09-16 at 18:03 -0400, Paul Moore wrote:
> Rename ordered_lsm_parse() to lsm_order_parse() for the sake of
> consistency with the other LSM initialization routines, and also
> do some minor rework of the function.  Aside from some minor style
> decisions, the majority of the rework involved shuffling the order
> of the LSM_FLAG_LEGACY and LSM_ORDER_FIRST code so that the
> LSM_FLAG_LEGACY checks are handled first; it is important to note
> that this doesn't affect the order in which the LSMs are registered.
>=20
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: John Johansen <john.johhansen@canonical.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/lsm_init.c | 82 ++++++++++++++++++++-------------------------
>  1 file changed, 37 insertions(+), 45 deletions(-)
>=20
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index a314484d7c2f..7b2491120fc8 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -228,83 +228,75 @@ static void __init initialize_lsm(struct lsm_info *=
lsm)
>  	}
>  }
> =20
> -/* Populate ordered LSMs list from comma-separated LSM name list. */
> -static void __init ordered_lsm_parse(const char *order, const char *orig=
in)
> +/**
> + * lsm_order_parse - Parse the comma delimited LSM list
> + * @list: LSM list
> + * @src: source of the list
> + */
> +static void __init lsm_order_parse(const char *list, const char *src)
>  {
>  	struct lsm_info *lsm;
>  	char *sep, *name, *next;
> =20
> -	/* LSM_ORDER_FIRST is always first. */
> -	lsm_for_each_raw(lsm) {
> -		if (lsm->order =3D=3D LSM_ORDER_FIRST)
> -			lsm_order_append(lsm, "  first");
> -	}
> -
> -	/* Process "security=3D", if given. */
> +	/* Handle any Legacy LSM exclusions if one was specified. */
>  	if (lsm_order_legacy) {
> -		struct lsm_info *major;
> -
>  		/*
> -		 * To match the original "security=3D" behavior, this
> -		 * explicitly does NOT fallback to another Legacy Major
> -		 * if the selected one was separately disabled: disable
> -		 * all non-matching Legacy Major LSMs.
> +		 * To match the original "security=3D" behavior, this explicitly
> +		 * does NOT fallback to another Legacy Major if the selected
> +		 * one was separately disabled: disable all non-matching
> +		 * Legacy Major LSMs.
>  		 */
> -		lsm_for_each_raw(major) {
> -			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
> -			    strcmp(major->id->name, lsm_order_legacy) !=3D 0) {
> -				lsm_enabled_set(major, false);
> +		lsm_for_each_raw(lsm) {
> +			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) &&
> +			     strcmp(lsm->id->name, lsm_order_legacy)) {
> +				lsm_enabled_set(lsm, false);
>  				init_debug("security=3D%s disabled: %s (only one legacy major LSM)\n=
",
> -					   lsm_order_legacy, major->id->name);
> +					   lsm_order_legacy, lsm->id->name);
>  			}
>  		}
>  	}
> =20
> -	sep =3D kstrdup(order, GFP_KERNEL);
> +	/* LSM_ORDER_FIRST */
> +	lsm_for_each_raw(lsm) {
> +		if (lsm->order =3D=3D LSM_ORDER_FIRST)
> +			lsm_order_append(lsm, "first");
> +	}
> +
> +	/* Normal or "mutable" LSMs */

Paul, there's a reason for another set of eyes reviewing patches and yes, e=
ven,
comments.  What are "mutable" LSMs?!

The above comment LSM_ORDER_FIRST is self describing.  Here the word "order=
" is
missing from this comment.
-> Normal or "mutable" LSM ordering

Otherwise, Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>


> +	sep =3D kstrdup(list, GFP_KERNEL);
>  	next =3D sep;
>  	/* Walk the list, looking for matching LSMs. */
>  	while ((name =3D strsep(&next, ",")) !=3D NULL) {
> -		bool found =3D false;
> -
>  		lsm_for_each_raw(lsm) {
> -			if (strcmp(lsm->id->name, name) =3D=3D 0) {
> -				if (lsm->order =3D=3D LSM_ORDER_MUTABLE)
> -					lsm_order_append(lsm, origin);
> -				found =3D true;
> -			}
> +			if (!strcmp(lsm->id->name, name) &&
> +			    lsm->order =3D=3D LSM_ORDER_MUTABLE)
> +				lsm_order_append(lsm, src);
>  		}
> -
> -		if (!found)
> -			init_debug("%s ignored: %s (not built into kernel)\n",
> -				   origin, name);
>  	}
> +	kfree(sep);
> =20
> -	/* Process "security=3D", if given. */
> +	/* Legacy LSM if specified. */
>  	if (lsm_order_legacy) {
>  		lsm_for_each_raw(lsm) {
> -			if (lsm_order_exists(lsm))
> -				continue;
> -			if (strcmp(lsm->id->name, lsm_order_legacy) =3D=3D 0)
> -				lsm_order_append(lsm, "security=3D");
> +			if (!strcmp(lsm->id->name, lsm_order_legacy))
> +				lsm_order_append(lsm, src);
>  		}
>  	}
> =20
> -	/* LSM_ORDER_LAST is always last. */
> +	/* LSM_ORDER_LAST */
>  	lsm_for_each_raw(lsm) {
>  		if (lsm->order =3D=3D LSM_ORDER_LAST)
> -			lsm_order_append(lsm, "   last");
> +			lsm_order_append(lsm, "last");
>  	}
> =20
> -	/* Disable all LSMs not in the ordered list. */
> +	/* Disable all LSMs not previously enabled. */
>  	lsm_for_each_raw(lsm) {
>  		if (lsm_order_exists(lsm))
>  			continue;
>  		lsm_enabled_set(lsm, false);
>  		init_debug("%s skipped: %s (not in requested order)\n",
> -			   origin, lsm->id->name);
> +			   src, lsm->id->name);
>  	}
> -
> -	kfree(sep);
>  }
> =20
>  /**
> @@ -322,9 +314,9 @@ static void __init lsm_init_ordered(void)
>  				lsm_order_legacy, lsm_order_cmdline);
>  			lsm_order_legacy =3D NULL;
>  		}
> -		ordered_lsm_parse(lsm_order_cmdline, "cmdline");
> +		lsm_order_parse(lsm_order_cmdline, "cmdline");
>  	} else
> -		ordered_lsm_parse(lsm_order_builtin, "builtin");
> +		lsm_order_parse(lsm_order_builtin, "builtin");
> =20
>  	lsm_order_for_each(lsm) {
>  		lsm_prepare(*lsm);


