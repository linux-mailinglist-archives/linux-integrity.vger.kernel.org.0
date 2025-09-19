Return-Path: <linux-integrity+bounces-7199-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8028DB8B07A
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 21:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8181CC4EAD
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 19:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8639C26159E;
	Fri, 19 Sep 2025 19:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QnL39S8k"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD82217F3D;
	Fri, 19 Sep 2025 19:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758308617; cv=none; b=f0TE2bA+MvoHF9CtxIGe1N7e4/EwLYIX6tnEm4uf4AEPi8wTVyDDU6a+iQS1hlyFcHGWaL3dUuxImTX6HMR4zABC13T7pTDr0JxqyMqkh1GbJnQkPIrJo4GWDe0s8NxunPpBZtsR+An4dKw1VFVyuyvbfGJ4U+pO3V5Lox9PFUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758308617; c=relaxed/simple;
	bh=wQ25qQiNKf1eeQdWxdQGjmPWXYAwoGPhgrPbG4DsH1Q=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=PQKuXKREZdl8zNNahpPzWvPx7eL57k+Y8FjjZniS2LItB8hq6qxZRsT+Zl7zyYwCyfiSuQhAf8Ik4sfkyCo6RhHZie9aRK7TNq3cCekVE14zDj4tUQIbudykyCZustqaURgkAVTWyDtQJnPM7wnQqPbUcxTFHFM91dqy/XVu3Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QnL39S8k; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JE9ZLO027388;
	Fri, 19 Sep 2025 19:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OuYHkH
	SlHkzySYvdH6VPYSH8EVm0xzCe94FkGf7/rfQ=; b=QnL39S8k5YUMlHL2xGAx9x
	hb9K7f5/uXtn73dhvrgbuzg0YyA/CfEDDqiS/9MV3ryj5Tyu9dO2iwVA6Qcmimke
	7mRJGKFJMTGIMhOixfy5biERp5SsVIhTs1lQ2UPLK8th9B5rSVUzFXkvX8yVy/+S
	+0f6AZ1Ubh74IRAyBC+vDRvRKb3K/fPgUGW9qgh9JK3FgCkwKWwF8gj8jHYyNFep
	G68XxQ1XIYF0UNUNy8WOiqOY/g0nG8neP42eCq7p/z8YgglsZfI1ev3PKL7Y9noj
	7M3xPW2VRtXLgKL1nZPT7oxWAGSkYILtFsYUgHal8yy8xTRR6XRZN5eFP/e4T9Bw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4pjs34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 19:02:29 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58JJ1xfO000958;
	Fri, 19 Sep 2025 19:02:28 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4pjs31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 19:02:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58JGIamn018668;
	Fri, 19 Sep 2025 19:02:27 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4997a29jth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 19:02:27 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58JJ2RhB17760960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 19:02:27 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F41905805F;
	Fri, 19 Sep 2025 19:02:26 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CBE558054;
	Fri, 19 Sep 2025 19:02:25 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.19.242])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Sep 2025 19:02:25 +0000 (GMT)
Message-ID: <3f5809b2250efd65e02dea44437175e2a95f5f2d.camel@linux.ibm.com>
Subject: Re: [PATCH v4 08/34] lsm: replace the name field with a pointer to
 the lsm_id struct
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
In-Reply-To: <20250916220355.252592-44-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
	 <20250916220355.252592-44-paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Sep 2025 15:02:25 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX0V0zNN6Hk/1x
 RcmCWra4klMShT4/By7JA/iqbV00h3H8bTSUiX+Zuih3/E6T2cJlq13W+492kZYacjA05eh8OG/
 UDnALZS1k+F6XQJ1bmSpKAyENUxce/AWyNkzS3p/5dvtKrUjsRPN4FRGtFVasJMRdduZD//aF81
 ShhxCgrjV07zpM2TSbLLPMzAtkVQhJ9qlYG11fg3enlHzvwHEgrfMD72cxptpBC0Tev34x0EmOd
 C34XctMV/2PFcuRdNlxc+ibP5Ts7me4XeTt35boTg8clyVpUGweCDoQi7LW5ZWPH7mbIPR0PrmC
 eE0iY+W4IHPSl4RqWQ3sYB//qZZBjjptPbYUlyV5B06WU4SLBoToGbqdkr26ZFISQcxbQUufOEv
 5Xtx9nrr
X-Proofpoint-ORIG-GUID: OnOAtGHZvkHYMch8aT1au9Q06r3cWa4g
X-Proofpoint-GUID: IiP6NCaRdvzNAdrdKEQakVZGg2sQaS8I
X-Authority-Analysis: v=2.4 cv=cNzgskeN c=1 sm=1 tr=0 ts=68cda8c5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=3MP0g_lkJP05MlL4:21 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8
 a=DfNHnWVPAAAA:8 a=vpqfxihKAAAA:8 a=xVhDTqbCAAAA:8 a=VnNF1IyMAAAA:8
 a=kkBOLNhXHHjkpg_EOLUA:9 a=QEXdDO2ut3YA:10 a=rjTVMONInIDnV1a_A2c_:22
 a=AULIiLoY-XQsE5F6gcqX:22 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

On Tue, 2025-09-16 at 18:03 -0400, Paul Moore wrote:
> Reduce the duplication between the lsm_id struct and the DEFINE_LSM()
> definition by linking the lsm_id struct directly into the individual
> LSM's DEFINE_LSM() instance.
>=20
> Linking the lsm_id into the LSM definition also allows us to simplify
> the security_add_hooks() function by removing the code which populates
> the lsm_idlist[] array and moving it into the normal LSM startup code
> where the LSM list is parsed and the individual LSMs are enabled,
> making for a cleaner implementation with less overhead at boot.
>=20
> Reviewed-by: Kees Cook <kees@kernel.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  include/linux/lsm_hooks.h         |  2 +-
>  security/apparmor/lsm.c           |  2 +-
>  security/bpf/hooks.c              |  2 +-
>  security/commoncap.c              |  2 +-
>  security/integrity/evm/evm_main.c |  2 +-
>  security/integrity/ima/ima_main.c |  2 +-
>  security/ipe/ipe.c                |  2 +-
>  security/landlock/setup.c         |  2 +-
>  security/loadpin/loadpin.c        |  2 +-
>  security/lockdown/lockdown.c      |  2 +-
>  security/lsm_init.c               | 45 +++++++++++++------------------
>  security/safesetid/lsm.c          |  2 +-
>  security/selinux/hooks.c          |  2 +-
>  security/smack/smack_lsm.c        |  2 +-
>  security/tomoyo/tomoyo.c          |  2 +-
>  security/yama/yama_lsm.c          |  2 +-
>  16 files changed, 33 insertions(+), 42 deletions(-)
>=20
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 0112926ed923..7343dd60b1d5 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -152,7 +152,7 @@ enum lsm_order {
>  };
> =20
>  struct lsm_info {
> -	const char *name;	/* Required. */
> +	const struct lsm_id *id;
>  	enum lsm_order order;	/* Optional: default is LSM_ORDER_MUTABLE */
>  	unsigned long flags;	/* Optional: flags describing LSM */
>  	int *enabled;		/* Optional: controlled by CONFIG_LSM */
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 8e1cc229b41b..45b3a304d525 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -2552,7 +2552,7 @@ static int __init apparmor_init(void)
>  }
> =20
>  DEFINE_LSM(apparmor) =3D {
> -	.name =3D "apparmor",
> +	.id =3D &apparmor_lsmid,
>  	.flags =3D LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
>  	.enabled =3D &apparmor_enabled,
>  	.blobs =3D &apparmor_blob_sizes,
> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> index db759025abe1..40efde233f3a 100644
> --- a/security/bpf/hooks.c
> +++ b/security/bpf/hooks.c
> @@ -33,7 +33,7 @@ struct lsm_blob_sizes bpf_lsm_blob_sizes __ro_after_ini=
t =3D {
>  };
> =20
>  DEFINE_LSM(bpf) =3D {
> -	.name =3D "bpf",
> +	.id =3D &bpf_lsmid,
>  	.init =3D bpf_lsm_init,
>  	.blobs =3D &bpf_lsm_blob_sizes
>  };
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 6bd4adeb4795..b50479bd0286 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -1505,7 +1505,7 @@ static int __init capability_init(void)
>  }
> =20
>  DEFINE_LSM(capability) =3D {
> -	.name =3D "capability",
> +	.id =3D &capability_lsmid,
>  	.order =3D LSM_ORDER_FIRST,
>  	.init =3D capability_init,
>  };
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/e=
vm_main.c
> index 0add782e73ba..db8e324ed4e6 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -1175,7 +1175,7 @@ struct lsm_blob_sizes evm_blob_sizes __ro_after_ini=
t =3D {
>  };
> =20
>  DEFINE_LSM(evm) =3D {
> -	.name =3D "evm",
> +	.id =3D &evm_lsmid,
>  	.init =3D init_evm_lsm,
>  	.order =3D LSM_ORDER_LAST,
>  	.blobs =3D &evm_blob_sizes,
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index cdd225f65a62..eade8e1e3cb1 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -1279,7 +1279,7 @@ struct lsm_blob_sizes ima_blob_sizes __ro_after_ini=
t =3D {
>  };
> =20
>  DEFINE_LSM(ima) =3D {
> -	.name =3D "ima",
> +	.id =3D &ima_lsmid,
>  	.init =3D init_ima_lsm,
>  	.order =3D LSM_ORDER_LAST,
>  	.blobs =3D &ima_blob_sizes,
> diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
> index 4317134cb0da..2426441181dc 100644
> --- a/security/ipe/ipe.c
> +++ b/security/ipe/ipe.c
> @@ -92,7 +92,7 @@ static int __init ipe_init(void)
>  }
> =20
>  DEFINE_LSM(ipe) =3D {
> -	.name =3D "ipe",
> +	.id =3D &ipe_lsmid,
>  	.init =3D ipe_init,
>  	.blobs =3D &ipe_blobs,
>  };
> diff --git a/security/landlock/setup.c b/security/landlock/setup.c
> index bd53c7a56ab9..47dac1736f10 100644
> --- a/security/landlock/setup.c
> +++ b/security/landlock/setup.c
> @@ -75,7 +75,7 @@ static int __init landlock_init(void)
>  }
> =20
>  DEFINE_LSM(LANDLOCK_NAME) =3D {
> -	.name =3D LANDLOCK_NAME,
> +	.id =3D &landlock_lsmid,
>  	.init =3D landlock_init,
>  	.blobs =3D &landlock_blob_sizes,
>  };
> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index 68252452b66c..b9ddf05c5c16 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -271,7 +271,7 @@ static int __init loadpin_init(void)
>  }
> =20
>  DEFINE_LSM(loadpin) =3D {
> -	.name =3D "loadpin",
> +	.id =3D &loadpin_lsmid,
>  	.init =3D loadpin_init,
>  };
> =20
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index cf83afa1d879..4813f168ff93 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -168,6 +168,6 @@ DEFINE_EARLY_LSM(lockdown) =3D {
>  #else
>  DEFINE_LSM(lockdown) =3D {
>  #endif
> -	.name =3D "lockdown",
> +	.id =3D &lockdown_lsmid,
>  	.init =3D lockdown_lsm_init,
>  };
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 4a108b03c23d..628f54790360 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -127,9 +127,10 @@ static void __init append_ordered_lsm(struct lsm_inf=
o *lsm, const char *from)
>  	/* Enable this LSM, if it is not already set. */
>  	if (!lsm->enabled)
>  		lsm->enabled =3D &lsm_enabled_true;
> -	ordered_lsms[last_lsm++] =3D lsm;
> +	ordered_lsms[last_lsm] =3D lsm;
> +	lsm_idlist[last_lsm++] =3D lsm->id;
> =20
> -	init_debug("%s ordered: %s (%s)\n", from, lsm->name,
> +	init_debug("%s ordered: %s (%s)\n", from, lsm->id->name,
>  		   is_enabled(lsm) ? "enabled" : "disabled");
>  }
> =20
> @@ -157,7 +158,7 @@ static void __init lsm_prepare(struct lsm_info *lsm)
>  		set_enabled(lsm, false);
>  		return;
>  	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
> -		init_debug("exclusive disabled: %s\n", lsm->name);
> +		init_debug("exclusive disabled: %s\n", lsm->id->name);
>  		set_enabled(lsm, false);
>  		return;
>  	}
> @@ -165,7 +166,7 @@ static void __init lsm_prepare(struct lsm_info *lsm)
>  	/* Mark the LSM as enabled. */
>  	set_enabled(lsm, true);
>  	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
> -		init_debug("exclusive chosen:   %s\n", lsm->name);
> +		init_debug("exclusive chosen:   %s\n", lsm->id->name);
>  		exclusive =3D lsm;
>  	}
> =20
> @@ -200,9 +201,9 @@ static void __init initialize_lsm(struct lsm_info *ls=
m)
>  	if (is_enabled(lsm)) {
>  		int ret;
> =20
> -		init_debug("initializing %s\n", lsm->name);
> +		init_debug("initializing %s\n", lsm->id->name);
>  		ret =3D lsm->init();
> -		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
> +		WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
>  	}
>  }
> =20
> @@ -236,10 +237,10 @@ static void __init ordered_lsm_parse(const char *or=
der, const char *origin)
>  		 */
>  		lsm_for_each_raw(major) {
>  			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
> -			    strcmp(major->name, chosen_major_lsm) !=3D 0) {
> +			    strcmp(major->id->name, chosen_major_lsm) !=3D 0) {
>  				set_enabled(major, false);
>  				init_debug("security=3D%s disabled: %s (only one legacy major LSM)\n=
",
> -					   chosen_major_lsm, major->name);
> +					   chosen_major_lsm, major->id->name);
>  			}
>  		}
>  	}
> @@ -251,7 +252,7 @@ static void __init ordered_lsm_parse(const char *orde=
r, const char *origin)
>  		bool found =3D false;
> =20
>  		lsm_for_each_raw(lsm) {
> -			if (strcmp(lsm->name, name) =3D=3D 0) {
> +			if (strcmp(lsm->id->name, name) =3D=3D 0) {
>  				if (lsm->order =3D=3D LSM_ORDER_MUTABLE)
>  					append_ordered_lsm(lsm, origin);
>  				found =3D true;
> @@ -268,7 +269,7 @@ static void __init ordered_lsm_parse(const char *orde=
r, const char *origin)
>  		lsm_for_each_raw(lsm) {
>  			if (exists_ordered_lsm(lsm))
>  				continue;
> -			if (strcmp(lsm->name, chosen_major_lsm) =3D=3D 0)
> +			if (strcmp(lsm->id->name, chosen_major_lsm) =3D=3D 0)
>  				append_ordered_lsm(lsm, "security=3D");
>  		}
>  	}
> @@ -285,7 +286,7 @@ static void __init ordered_lsm_parse(const char *orde=
r, const char *origin)
>  			continue;
>  		set_enabled(lsm, false);
>  		init_debug("%s skipped: %s (not in requested order)\n",
> -			   origin, lsm->name);
> +			   origin, lsm->id->name);
>  	}
> =20
>  	kfree(sep);
> @@ -317,11 +318,13 @@ static void __init lsm_init_ordered(void)
>  	pr_info("initializing lsm=3D");
>  	lsm_early_for_each_raw(early) {
>  		if (is_enabled(early))
> -			pr_cont("%s%s", first++ =3D=3D 0 ? "" : ",", early->name);
> +			pr_cont("%s%s",
> +				first++ =3D=3D 0 ? "" : ",", early->id->name);
>  	}
>  	lsm_order_for_each(lsm) {
>  		if (is_enabled(*lsm))
> -			pr_cont("%s%s", first++ =3D=3D 0 ? "" : ",", (*lsm)->name);
> +			pr_cont("%s%s",
> +				first++ =3D=3D 0 ? "" : ",", (*lsm)->id->name);
>  	}
>  	pr_cont("\n");
> =20
> @@ -432,18 +435,6 @@ void __init security_add_hooks(struct security_hook_=
list *hooks, int count,
>  {
>  	int i;
> =20
> -	/*
> -	 * A security module may call security_add_hooks() more
> -	 * than once during initialization, and LSM initialization
> -	 * is serialized. Landlock is one such case.
> -	 * Look at the previous entry, if there is one, for duplication.
> -	 */
> -	if (lsm_active_cnt =3D=3D 0 || lsm_idlist[lsm_active_cnt - 1] !=3D lsmi=
d) {
> -		if (lsm_active_cnt >=3D MAX_LSM_COUNT)
> -			panic("%s Too many LSMs registered.\n", __func__);
> -		lsm_idlist[lsm_active_cnt++] =3D lsmid;
> -	}
> -
>  	for (i =3D 0; i < count; i++) {
>  		hooks[i].lsmid =3D lsmid;
>  		lsm_static_call_init(&hooks[i]);
> @@ -491,10 +482,10 @@ int __init security_init(void)
>  	 * available
>  	 */
>  	lsm_early_for_each_raw(lsm) {
> -		init_debug("  early started: %s (%s)\n", lsm->name,
> +		init_debug("  early started: %s (%s)\n", lsm->id->name,
>  			   is_enabled(lsm) ? "enabled" : "disabled");
>  		if (lsm->enabled)
> -			lsm_append(lsm->name, &lsm_names);
> +			lsm_append(lsm->id->name, &lsm_names);
>  	}
> =20
>  	/* Load LSMs in specified order. */
> diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> index 1ba564f097f5..9a7c68d4e642 100644
> --- a/security/safesetid/lsm.c
> +++ b/security/safesetid/lsm.c
> @@ -287,6 +287,6 @@ static int __init safesetid_security_init(void)
>  }
> =20
>  DEFINE_LSM(safesetid_security_init) =3D {
> +	.id =3D &safesetid_lsmid,
>  	.init =3D safesetid_security_init,
> -	.name =3D "safesetid",
>  };
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 4da5e792b42e..d94b1ff316ba 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -7630,7 +7630,7 @@ void selinux_complete_init(void)
>  /* SELinux requires early initialization in order to label
>     all processes and objects when they are created. */
>  DEFINE_LSM(selinux) =3D {
> -	.name =3D "selinux",
> +	.id =3D &selinux_lsmid,
>  	.flags =3D LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
>  	.enabled =3D &selinux_enabled_boot,
>  	.blobs =3D &selinux_blob_sizes,
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index fc340a6f0dde..e09490c75f59 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -5275,7 +5275,7 @@ static __init int smack_init(void)
>   * all processes and objects when they are created.
>   */
>  DEFINE_LSM(smack) =3D {
> -	.name =3D "smack",
> +	.id =3D &smack_lsmid,
>  	.flags =3D LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
>  	.blobs =3D &smack_blob_sizes,
>  	.init =3D smack_init,
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index d6ebcd9db80a..ed0f7b052a85 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -612,7 +612,7 @@ static int __init tomoyo_init(void)
>  }
> =20
>  DEFINE_LSM(tomoyo) =3D {
> -	.name =3D "tomoyo",
> +	.id =3D &tomoyo_lsmid,
>  	.enabled =3D &tomoyo_enabled,
>  	.flags =3D LSM_FLAG_LEGACY_MAJOR,
>  	.blobs =3D &tomoyo_blob_sizes,
> diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
> index 3d064dd4e03f..38b21ee0c560 100644
> --- a/security/yama/yama_lsm.c
> +++ b/security/yama/yama_lsm.c
> @@ -476,6 +476,6 @@ static int __init yama_init(void)
>  }
> =20
>  DEFINE_LSM(yama) =3D {
> -	.name =3D "yama",
> +	.id =3D &yama_lsmid,
>  	.init =3D yama_init,
>  };


