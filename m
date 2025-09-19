Return-Path: <linux-integrity+bounces-7191-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFA9B89222
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 12:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE73561E5D
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 10:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D282F239E61;
	Fri, 19 Sep 2025 10:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UXI8tfhP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BC527E041;
	Fri, 19 Sep 2025 10:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758278818; cv=none; b=Gk/HzjxCQABxT4rWwJhxFvHcMU6mS88Yhx3l2odyM8Z1T1qDhgx9ePa7SkHISWxuFn/UZ+/MfhuKYoxxL1vHhNqqEKstyNw8bcVqR+lfnWJSajAjUSS0hUhzvbP75C2P0N+9qBbliacSOqBC3JzQ/oI831RWri9S2EGcifJXxy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758278818; c=relaxed/simple;
	bh=ofAxZlicU1dPxFy5Rs9BvhQW7H155sXn2HejsZ4RKiQ=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=EWdzAity/4MBqkgKE3C6TG3WO4C99QcdrA3rf/18gq4I0yuhtmDSxXn5yQTLkVA+soA/OvtMmhCAbYs855/EtqI6Vmy07pNamLgI9dJA1zLe1ESP2P0u6JlWhcBNHYVnTwadabBW3/4Ed8zDvrkChOcCQuPpZR8f8V/jRMnghYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UXI8tfhP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58J51kFu024759;
	Fri, 19 Sep 2025 10:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rL7DAN
	SorS/p458yvRAnIQfyZwzfYXuzfXf3VrTL3fQ=; b=UXI8tfhPSkd3/n1uSRfMLJ
	lClOFb8PEPy2Vf2oq+5u3RP3uWMhFNxQbtCT6b6Mdf8rdZkQ+oWl6RCKaxocsdPH
	4zeost/qVY/9Mo2cTC0MwVSpJic8zRj9MCEOzgxg5Kghm0VfjszlnKOFbBKpUWO3
	xp5g0qWBMbMJUUrnM4C3MazmktIHkVODECbX4xF6Sr0VQxVuQxpbpt9RUef+Yhah
	peKaOgmJ+bxLnAPsI4UDpd1MdaDO5CrUxAWYr2sUFoXEkMvefUcdc0fNTSdPz7bt
	yjAx9tS5fwTU2AZ2wc3z6gM2NBoEqdrdaVoPOUPGhxNBiJMAJYjWkP3+OgXR0fIA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4qye5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 10:45:53 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58JAXj6W009571;
	Fri, 19 Sep 2025 10:45:52 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4qye59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 10:45:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58J9ZnVt022347;
	Fri, 19 Sep 2025 10:45:51 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kxq3g8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 10:45:51 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58JAjf1M5702230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 10:45:41 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CA195805C;
	Fri, 19 Sep 2025 10:45:51 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E921E58054;
	Fri, 19 Sep 2025 10:45:49 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.169.163])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Sep 2025 10:45:49 +0000 (GMT)
Message-ID: <6a44ab9633ebc5695e1772a1e39b246da3875da8.camel@linux.ibm.com>
Subject: Re: [PATCH v4 06/34] lsm: integrate lsm_early_cred() and
 lsm_early_task() into caller
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
In-Reply-To: <20250916220355.252592-42-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
	 <20250916220355.252592-42-paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Sep 2025 06:45:49 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _J9FjwPfseKw1kNwLIIF609kkHXdo-Be
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfXxvA03d1vFtsk
 BZIqjBI5/w/Tj/QnSFfkWQKQBPG1G13Qi3xzzG8BHmRkyEK4sP7Udk8/FhPwHp0MOsMYFbcuPpZ
 9zHEn4IMExk1EPHfbwciP44Jl9lNGlf9uQnjGkUUUGsC62hHq6Uf9zNHZ/mjWGsH/OWQdGTUvdb
 V69IcraotrCEThjKMLp+tPjUH5RYVjxYQ5JOUSlIx+014M/jggxM3G/yf80uRjJRVJ9vrrdRk48
 sEE5zZtisRjufFqFO35ySYAbQHUK1kaW27TfaNALFukDY+lQuHx7iy238H2ZdvAcjDoCYOxZFEz
 AJFaVWawryOK16tNPFrOqGCuwKLE83Rncno8Y8JeZG1F2nsCQRKn/vy+enaz46UhDVqbckHdw9x
 pBTAvTpZ
X-Authority-Analysis: v=2.4 cv=R8oDGcRX c=1 sm=1 tr=0 ts=68cd3461 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=vpqfxihKAAAA:8 a=DfNHnWVPAAAA:8
 a=xVhDTqbCAAAA:8 a=VnNF1IyMAAAA:8 a=-7y2BtPKUMOZGTT3hucA:9 a=QEXdDO2ut3YA:10
 a=AULIiLoY-XQsE5F6gcqX:22 a=rjTVMONInIDnV1a_A2c_:22 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-GUID: IMCeFxcMRKwUFPRlIPC3X1DAoe9-7XQv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

On Tue, 2025-09-16 at 18:03 -0400, Paul Moore wrote:
> With only one caller of lsm_early_cred() and lsm_early_task(), insert
> the functions' code directly into the caller and ger rid of the two
> functions.
>=20
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: John Johansen <john.johhansen@canonical.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  security/lsm_init.c | 35 +++++------------------------------
>  1 file changed, 5 insertions(+), 30 deletions(-)
>=20
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 09afa7ad719e..a8b82329c76a 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -291,34 +291,6 @@ static void __init ordered_lsm_parse(const char *ord=
er, const char *origin)
>  	kfree(sep);
>  }
> =20
> -/**
> - * lsm_early_cred - during initialization allocate a composite cred blob
> - * @cred: the cred that needs a blob
> - *
> - * Allocate the cred blob for all the modules
> - */
> -static void __init lsm_early_cred(struct cred *cred)
> -{
> -	int rc =3D lsm_cred_alloc(cred, GFP_KERNEL);
> -
> -	if (rc)
> -		panic("%s: Early cred alloc failed.\n", __func__);
> -}
> -
> -/**
> - * lsm_early_task - during initialization allocate a composite task blob
> - * @task: the task that needs a blob
> - *
> - * Allocate the task blob for all the modules
> - */
> -static void __init lsm_early_task(struct task_struct *task)
> -{
> -	int rc =3D lsm_task_alloc(task);
> -
> -	if (rc)
> -		panic("%s: Early task alloc failed.\n", __func__);
> -}
> -
>  static void __init ordered_lsm_init(void)
>  {
>  	unsigned int first =3D 0;
> @@ -382,8 +354,11 @@ static void __init ordered_lsm_init(void)
>  						    blob_sizes.lbs_inode, 0,
>  						    SLAB_PANIC, NULL);
> =20
> -	lsm_early_cred((struct cred *) current->cred);
> -	lsm_early_task(current);
> +	if (lsm_cred_alloc((struct cred *)current->cred, GFP_KERNEL))
> +		panic("%s: early cred alloc failed.\n", __func__);
> +	if (lsm_task_alloc(current))
> +		panic("%s: early task alloc failed.\n", __func__);
> +
>  	lsm_order_for_each(lsm) {
>  		initialize_lsm(*lsm);
>  	}


