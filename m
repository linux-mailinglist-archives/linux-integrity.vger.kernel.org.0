Return-Path: <linux-integrity+bounces-7200-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE3CB8B086
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 21:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37CFE7E122B
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 19:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F23526D4DE;
	Fri, 19 Sep 2025 19:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HmW6PGdi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41CB217F3D;
	Fri, 19 Sep 2025 19:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758308622; cv=none; b=SLmme96Nm0Sg32ZqqMc2BGsTm/GDAK3osh1mC5pM0TIIyzLnqlGSQQd7dDUshBELI+4lpage0nt/UOPjZlqmoXz8Xq6rl8RPNIV02qQWVmBeAoL/wCQXFlPgjijxIYAf8RnmTl9O6HT6amaxd4XLAwYXHT29FgDMerQVDPhtn0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758308622; c=relaxed/simple;
	bh=afB7K0U3upPvwlaRwoDChMKvr6SkCOA8iDuvFwEfaK0=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=ilu8nBM7XfOFvixSpepxHJJPTRdPkRNGtFwd4Jnb9d8GVE9MGPt+uToyY9PGxRKO0NyszfH7UV9NXEXplb4cZq7oKNPa7IoIj/5sIk7kG5wIvI5kZFnCynT16t9d8bZ6jExwxsvgnZbgHUyYlFm+7mUkz9ukUItn+Wa+5T4msmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HmW6PGdi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JAOROE027677;
	Fri, 19 Sep 2025 19:02:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fAIm+v
	fZiI5jfD4FQ747dnnc3N0sp9x5BI1eqCf5+Pw=; b=HmW6PGdiANCgIvwbM0X00O
	FGJhaYDDcN7X+9DGY65PW1bMMIIR/EhAPZ6eKub2L22BldzspwnAxgCtutD9nBkt
	TT/loquh0M4L023CERyxOeILfKBD6vbLAYnTyWakZvoN2s4AsFChOh8YrNWF8oAa
	VAmP+4oRwTfJHUqK5ttFlOELky4xW6BKPit/A1TJ7sJei99JY0dwgi7PXZhMYIXq
	JfJuT2wyYLOrGAE90E4vjJ/msFnU5bxJltiUTg11dsrN4goSIYHwaZTtJTDH/RI1
	nYPLkgADq4anS5GtM/i9vO70tv02Y3HCgIxBMCTQGpxeFLHk9ISxqlSmUmDIXd6w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4pjs40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 19:02:36 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58JIvetX024845;
	Fri, 19 Sep 2025 19:02:35 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4pjs3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 19:02:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58JIDPMA027341;
	Fri, 19 Sep 2025 19:02:34 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495menn9w9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 19:02:34 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58JJ2X6n5767742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 19:02:33 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A45995803F;
	Fri, 19 Sep 2025 19:02:33 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C23215805A;
	Fri, 19 Sep 2025 19:02:32 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.19.242])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Sep 2025 19:02:32 +0000 (GMT)
Message-ID: <698561ebfccfd593f628c39ad1b6e25c963d0d36.camel@linux.ibm.com>
Subject: Re: [PATCH v4 09/34] lsm: rename the lsm order variables for
 consistency
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
In-Reply-To: <20250916220355.252592-45-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
	 <20250916220355.252592-45-paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Sep 2025 15:02:32 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX30lXZPEg7PLH
 FjWLhqRCz+DUE7sTfsHWpBpTb2ZDhdVDy2vw8GAh6bmSdMRpUhgeqXpGcsRhp5OAXsmLEM1SwqJ
 ZJJNAwsLTK3AnzTZIz13SYSY4gmE4+XLoTDkql14j7ZZawqfxsG3wrb7g+yMQRgpeUdMaZCOA0s
 ambor8B7i+IJsMmrQ+/UHQs0sFjyPMB8TsQ4RLBrUf1COb3G3ZCAzQnBrab10kaV0slNyketUxc
 DTJLzTqOv/cLXdtYxZhtPRBlsEJE5BEZI9lLuME8n6lp58o0GNfQibiJwWPXFB3CmY7NiHwkIYF
 NpCszelptMcBLKucG3IVtkGCjSMTYl3udNBg/Dck+SkMFegbsYNJJMGKMJ4yrOIT6NM5hMwi7en
 RjAAqRJa
X-Proofpoint-ORIG-GUID: FnYiYamEoWY-XXrtytMYpxUA8kJVmvml
X-Proofpoint-GUID: DyVxUYErkRbGquPnHULYbIUXPdadIn4t
X-Authority-Analysis: v=2.4 cv=cNzgskeN c=1 sm=1 tr=0 ts=68cda8cc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=DfNHnWVPAAAA:8
 a=vpqfxihKAAAA:8 a=xVhDTqbCAAAA:8 a=VnNF1IyMAAAA:8 a=-0596TH21-E17VyoYvkA:9
 a=QEXdDO2ut3YA:10 a=rjTVMONInIDnV1a_A2c_:22 a=AULIiLoY-XQsE5F6gcqX:22
 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

On Tue, 2025-09-16 at 18:03 -0400, Paul Moore wrote:
> Rename the builtin_lsm_order variable to lsm_order_builtin,
> chosen_lsm_order to lsm_order_cmdline, chosen_major_lsm to
> lsm_order_legacy, ordered_lsms[] to lsm_order[], and exclusive
> to lsm_exclusive.
>=20
> This patch also renames the associated kernel command line parsing
> functions and adds some basic function comment blocks.  The parsing
> function choose_major_lsm() was renamed to lsm_choose_security(),
> choose_lsm_order() to lsm_choose_lsm(), and enable_debug() to
> lsm_debug_enable().
>=20
> Reviewed-by: Kees Cook <kees@kernel.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  security/lsm_init.c | 86 +++++++++++++++++++++++++--------------------
>  1 file changed, 48 insertions(+), 38 deletions(-)
>=20
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 628f54790360..2e76cefb1585 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -16,14 +16,14 @@ char *lsm_names;
>  extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
>  extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
> =20
> -/* Boot-time LSM user choice */
> -static __initconst const char *const builtin_lsm_order =3D CONFIG_LSM;
> -static __initdata const char *chosen_lsm_order;
> -static __initdata const char *chosen_major_lsm;
> +/* Build and boot-time LSM ordering. */
> +static __initconst const char *const lsm_order_builtin =3D CONFIG_LSM;
> +static __initdata const char *lsm_order_cmdline;
> +static __initdata const char *lsm_order_legacy;
> =20
>  /* Ordered list of LSMs to initialize. */
> -static __initdata struct lsm_info *ordered_lsms[MAX_LSM_COUNT + 1];
> -static __initdata struct lsm_info *exclusive;
> +static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
> +static __initdata struct lsm_info *lsm_exclusive;
> =20
>  static __initdata bool debug;
>  #define init_debug(...)							\
> @@ -33,7 +33,7 @@ static __initdata bool debug;
>  	} while (0)
> =20
>  #define lsm_order_for_each(iter)					\
> -	for ((iter) =3D ordered_lsms; *(iter); (iter)++)
> +	for ((iter) =3D lsm_order; *(iter); (iter)++)
>  #define lsm_for_each_raw(iter)						\
>  	for ((iter) =3D __start_lsm_info;					\
>  	     (iter) < __end_lsm_info; (iter)++)
> @@ -41,31 +41,41 @@ static __initdata bool debug;
>  	for ((iter) =3D __start_early_lsm_info;				\
>  	     (iter) < __end_early_lsm_info; (iter)++)
> =20
> -static int lsm_append(const char *new, char **result);
> -
> -/* Save user chosen LSM */
> -static int __init choose_major_lsm(char *str)
> +/**
> + * lsm_choose_security - Legacy "major" LSM selection
> + * @str: kernel command line parameter
> + */
> +static int __init lsm_choose_security(char *str)
>  {
> -	chosen_major_lsm =3D str;
> +	lsm_order_legacy =3D str;
>  	return 1;
>  }
> -__setup("security=3D", choose_major_lsm);
> +__setup("security=3D", lsm_choose_security);
> =20
> -/* Explicitly choose LSM initialization order. */
> -static int __init choose_lsm_order(char *str)
> +/**
> + * lsm_choose_lsm - Modern LSM selection
> + * @str: kernel command line parameter
> + */
> +static int __init lsm_choose_lsm(char *str)
>  {
> -	chosen_lsm_order =3D str;
> +	lsm_order_cmdline =3D str;
>  	return 1;
>  }
> -__setup("lsm=3D", choose_lsm_order);
> +__setup("lsm=3D", lsm_choose_lsm);
> =20
> -/* Enable LSM order debugging. */
> -static int __init enable_debug(char *str)
> +/**
> + * lsm_debug_enable - Enable LSM framework debugging
> + * @str: kernel command line parameter
> + *
> + * Currently we only provide debug info during LSM initialization, but w=
e may
> + * want to expand this in the future.
> + */
> +static int __init lsm_debug_enable(char *str)
>  {
>  	debug =3D true;
>  	return 1;
>  }
> -__setup("lsm.debug", enable_debug);
> +__setup("lsm.debug", lsm_debug_enable);
> =20
>  /* Mark an LSM's enabled flag. */
>  static int lsm_enabled_true __initdata =3D 1;
> @@ -127,7 +137,7 @@ static void __init append_ordered_lsm(struct lsm_info=
 *lsm, const char *from)
>  	/* Enable this LSM, if it is not already set. */
>  	if (!lsm->enabled)
>  		lsm->enabled =3D &lsm_enabled_true;
> -	ordered_lsms[last_lsm] =3D lsm;
> +	lsm_order[last_lsm] =3D lsm;
>  	lsm_idlist[last_lsm++] =3D lsm->id;
> =20
>  	init_debug("%s ordered: %s (%s)\n", from, lsm->id->name,
> @@ -157,7 +167,7 @@ static void __init lsm_prepare(struct lsm_info *lsm)
>  	if (!is_enabled(lsm)) {
>  		set_enabled(lsm, false);
>  		return;
> -	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
> +	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && lsm_exclusive) {
>  		init_debug("exclusive disabled: %s\n", lsm->id->name);
>  		set_enabled(lsm, false);
>  		return;
> @@ -165,9 +175,9 @@ static void __init lsm_prepare(struct lsm_info *lsm)
> =20
>  	/* Mark the LSM as enabled. */
>  	set_enabled(lsm, true);
> -	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
> +	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !lsm_exclusive) {
>  		init_debug("exclusive chosen:   %s\n", lsm->id->name);
> -		exclusive =3D lsm;
> +		lsm_exclusive =3D lsm;
>  	}
> =20
>  	/* Register the LSM blob sizes. */
> @@ -226,7 +236,7 @@ static void __init ordered_lsm_parse(const char *orde=
r, const char *origin)
>  	}
> =20
>  	/* Process "security=3D", if given. */
> -	if (chosen_major_lsm) {
> +	if (lsm_order_legacy) {
>  		struct lsm_info *major;
> =20
>  		/*
> @@ -237,10 +247,10 @@ static void __init ordered_lsm_parse(const char *or=
der, const char *origin)
>  		 */
>  		lsm_for_each_raw(major) {
>  			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
> -			    strcmp(major->id->name, chosen_major_lsm) !=3D 0) {
> +			    strcmp(major->id->name, lsm_order_legacy) !=3D 0) {
>  				set_enabled(major, false);
>  				init_debug("security=3D%s disabled: %s (only one legacy major LSM)\n=
",
> -					   chosen_major_lsm, major->id->name);
> +					   lsm_order_legacy, major->id->name);
>  			}
>  		}
>  	}
> @@ -265,11 +275,11 @@ static void __init ordered_lsm_parse(const char *or=
der, const char *origin)
>  	}
> =20
>  	/* Process "security=3D", if given. */
> -	if (chosen_major_lsm) {
> +	if (lsm_order_legacy) {
>  		lsm_for_each_raw(lsm) {
>  			if (exists_ordered_lsm(lsm))
>  				continue;
> -			if (strcmp(lsm->id->name, chosen_major_lsm) =3D=3D 0)
> +			if (strcmp(lsm->id->name, lsm_order_legacy) =3D=3D 0)
>  				append_ordered_lsm(lsm, "security=3D");
>  		}
>  	}
> @@ -301,15 +311,15 @@ static void __init lsm_init_ordered(void)
>  	struct lsm_info **lsm;
>  	struct lsm_info *early;
> =20
> -	if (chosen_lsm_order) {
> -		if (chosen_major_lsm) {
> +	if (lsm_order_cmdline) {
> +		if (lsm_order_legacy) {
>  			pr_warn("security=3D%s is ignored because it is superseded by lsm=3D%=
s\n",
> -				chosen_major_lsm, chosen_lsm_order);
> -			chosen_major_lsm =3D NULL;
> +				lsm_order_legacy, lsm_order_cmdline);
> +			lsm_order_legacy =3D NULL;
>  		}
> -		ordered_lsm_parse(chosen_lsm_order, "cmdline");
> +		ordered_lsm_parse(lsm_order_cmdline, "cmdline");
>  	} else
> -		ordered_lsm_parse(builtin_lsm_order, "builtin");
> +		ordered_lsm_parse(lsm_order_builtin, "builtin");
> =20
>  	lsm_order_for_each(lsm) {
>  		lsm_prepare(*lsm);
> @@ -473,9 +483,9 @@ int __init security_init(void)
>  {
>  	struct lsm_info *lsm;
> =20
> -	init_debug("legacy security=3D%s\n", chosen_major_lsm ? : " *unspecifie=
d*");
> -	init_debug("  CONFIG_LSM=3D%s\n", builtin_lsm_order);
> -	init_debug("boot arg lsm=3D%s\n", chosen_lsm_order ? : " *unspecified*"=
);
> +	init_debug("legacy security=3D%s\n", lsm_order_legacy ? : " *unspecifie=
d*");
> +	init_debug("  CONFIG_LSM=3D%s\n", lsm_order_builtin);
> +	init_debug("boot arg lsm=3D%s\n", lsm_order_cmdline ? : " *unspecified*=
");
> =20
>  	/*
>  	 * Append the names of the early LSM modules now that kmalloc() is


