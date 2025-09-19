Return-Path: <linux-integrity+bounces-7186-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBEDB89231
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 12:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22FB3B78AA
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 10:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ECD309DDD;
	Fri, 19 Sep 2025 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Uv4oxWgz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D8C27E041;
	Fri, 19 Sep 2025 10:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758278762; cv=none; b=FreolqEI/DCsx1o/yKASMHbr6dYZI4sGnVB1LXsyKyyiaeO7Zoe5IeL2vGrfLAL0zR7Vad8aZGptJECtdCopLoOSTj2vJjA47qzIC0NOAoArW+w1afhQXRF4TQYQYccQNXl45C1VRK4/2NX2sbTt2n5So7Y33zqdTxtpj7YKui0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758278762; c=relaxed/simple;
	bh=UOHoa5wzbdQfWjDC1cKYvPxHzhvCZvB70jFmwHu/70Y=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=nWvxNUU49BXeqnQLbQW4H9oCfKbBGNIeRmcAXLxZeDYzjhds+7HlmIN2GW5Wd/fSaYEfQicpKnj2nsP52/AXQ4UqByVDO/QJVi9/FCP5gb3WmabkbUBHzthWwhTBpMxDoO3AmWSIvNm5hTqMr6DDXeGFYEuadSEZQ3R85c0WnyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Uv4oxWgz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58J9fL8V013515;
	Fri, 19 Sep 2025 10:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9gndJp
	D8xpzADd7NL0XB40uPrj6mRr+0gyZUWOdUMYs=; b=Uv4oxWgznrN2w9mJj6HzZ5
	W+RfbMMozP2hbSvjHKIV8hmp3+uIVcYkotGU95Wv3qIgc/A3cEA60YtnwuPUA/pR
	P5X7aifUrDKY66mRmW0/5YSzTjMsYyfvhMHO20y0Yn7GTm+QvYb8ofj25ecTmil1
	gyNkKG2JMvg9AuehoBtl0lJ4je42PXOQ1z8rTqDyI/9i670go9N0nJYm/CPW/g1H
	AKz4HU6D3lu3Jt8C9Yw7ribEsOQ7KToOEqqwkWvIRJxURhOTqtK2RfHzvjklyodj
	sKyv3V52UUKFeso4RqT/lYBgZOWTpAf6QASl+xtP1aa0x1T67qlbqJMx7jubshnA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4jg3b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 10:44:50 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58JAYKTd004892;
	Fri, 19 Sep 2025 10:44:50 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4jg3aw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 10:44:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58JAVtxR027268;
	Fri, 19 Sep 2025 10:44:48 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495menkbdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 10:44:48 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58JAimhE23069414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 10:44:48 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BDB45804E;
	Fri, 19 Sep 2025 10:44:48 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EC575803F;
	Fri, 19 Sep 2025 10:44:46 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.169.163])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Sep 2025 10:44:46 +0000 (GMT)
Message-ID: <1f70b9ada5d894c41e39d1e4ca076d7bf4f0dfb8.camel@linux.ibm.com>
Subject: Re: [PATCH v4 01/34] lsm: split the notifier code out into
 lsm_notifier.c
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
In-Reply-To: <20250916220355.252592-37-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
	 <20250916220355.252592-37-paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Sep 2025 06:44:45 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Qf5mvtbv c=1 sm=1 tr=0 ts=68cd3422 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=DfNHnWVPAAAA:8
 a=vpqfxihKAAAA:8 a=xVhDTqbCAAAA:8 a=VnNF1IyMAAAA:8 a=1Zjqg7Ikt4ZBDJGY-noA:9
 a=QEXdDO2ut3YA:10 a=rjTVMONInIDnV1a_A2c_:22 a=AULIiLoY-XQsE5F6gcqX:22
 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-ORIG-GUID: jyaECFWl-qpfK6WDI_PLT-40OuTmPjHK
X-Proofpoint-GUID: A6eAIa9Py_f1aw84BsSMv3dq2Vr3qiJy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfXwhAGeP5jqg/Q
 yI8kM0N/+vLdMwrxrAgUFjeoR2HM7/iX9+cPYjDG2eyHcZEEcFx4hSkfgrxGeCMbQIqcauWK9Pz
 X+Y54Fy4RutfByiZeVwHcvv9WsuBFrusE0bTkgZR4RXXMt5VaRjfepogEbr3FdjEQ/8q2/m2LSx
 I1mJLkQzHb1DI3tlLDliiFKHxZ+lqJ2Pjw5TqjrNz5URfQ81BT4WrBjcaONFxUhYAhxXUiuCGtR
 IbmjpMOUxoiKJBeys5I3dwdugSbFoyFDuUNGLAUX85CjzKq39mKB4KRCbhu36wv9XHQW++q+8zj
 q2zVxtqxTJztu/bTmIA6MvJ3I3An+x29fa2g+ujMjZYK4YH6rAmR4ExMZNarejqKGiFMSI7YLVN
 nCyCsPi8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

On Tue, 2025-09-16 at 18:03 -0400, Paul Moore wrote:
> In an effort to decompose security/security.c somewhat to make it less
> twisted and unwieldy, pull out the LSM notifier code into a new file
> as it is fairly well self-contained.
>=20
> No code changes.
>=20
> Reviewed-by: Kees Cook <kees@kernel.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  security/Makefile       |  2 +-
>  security/lsm_notifier.c | 31 +++++++++++++++++++++++++++++++
>  security/security.c     | 23 -----------------------
>  3 files changed, 32 insertions(+), 24 deletions(-)
>  create mode 100644 security/lsm_notifier.c
>=20
> diff --git a/security/Makefile b/security/Makefile
> index 22ff4c8bd8ce..14d87847bce8 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -11,7 +11,7 @@ obj-$(CONFIG_SECURITY) 			+=3D lsm_syscalls.o
>  obj-$(CONFIG_MMU)			+=3D min_addr.o
> =20
>  # Object file lists
> -obj-$(CONFIG_SECURITY)			+=3D security.o
> +obj-$(CONFIG_SECURITY)			+=3D security.o lsm_notifier.o
>  obj-$(CONFIG_SECURITYFS)		+=3D inode.o
>  obj-$(CONFIG_SECURITY_SELINUX)		+=3D selinux/
>  obj-$(CONFIG_SECURITY_SMACK)		+=3D smack/
> diff --git a/security/lsm_notifier.c b/security/lsm_notifier.c
> new file mode 100644
> index 000000000000..c92fad5d57d4
> --- /dev/null
> +++ b/security/lsm_notifier.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * LSM notifier functions
> + *
> + */
> +
> +#include <linux/notifier.h>
> +#include <linux/security.h>
> +
> +static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
> +
> +int call_blocking_lsm_notifier(enum lsm_event event, void *data)
> +{
> +	return blocking_notifier_call_chain(&blocking_lsm_notifier_chain,
> +					    event, data);
> +}
> +EXPORT_SYMBOL(call_blocking_lsm_notifier);
> +
> +int register_blocking_lsm_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&blocking_lsm_notifier_chain,
> +						nb);
> +}
> +EXPORT_SYMBOL(register_blocking_lsm_notifier);
> +
> +int unregister_blocking_lsm_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&blocking_lsm_notifier_chain,
> +						  nb);
> +}
> +EXPORT_SYMBOL(unregister_blocking_lsm_notifier);
> diff --git a/security/security.c b/security/security.c
> index ca126b02d2fe..8cb049bebc57 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -90,8 +90,6 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIA=
LITY_MAX + 1] =3D {
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] =3D "confidentiality",
>  };
> =20
> -static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
> -
>  static struct kmem_cache *lsm_file_cache;
>  static struct kmem_cache *lsm_inode_cache;
> =20
> @@ -649,27 +647,6 @@ void __init security_add_hooks(struct security_hook_=
list *hooks, int count,
>  	}
>  }
> =20
> -int call_blocking_lsm_notifier(enum lsm_event event, void *data)
> -{
> -	return blocking_notifier_call_chain(&blocking_lsm_notifier_chain,
> -					    event, data);
> -}
> -EXPORT_SYMBOL(call_blocking_lsm_notifier);
> -
> -int register_blocking_lsm_notifier(struct notifier_block *nb)
> -{
> -	return blocking_notifier_chain_register(&blocking_lsm_notifier_chain,
> -						nb);
> -}
> -EXPORT_SYMBOL(register_blocking_lsm_notifier);
> -
> -int unregister_blocking_lsm_notifier(struct notifier_block *nb)
> -{
> -	return blocking_notifier_chain_unregister(&blocking_lsm_notifier_chain,
> -						  nb);
> -}
> -EXPORT_SYMBOL(unregister_blocking_lsm_notifier);
> -
>  /**
>   * lsm_blob_alloc - allocate a composite blob
>   * @dest: the destination for the blob


