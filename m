Return-Path: <linux-integrity+bounces-6444-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A560AD6E79
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Jun 2025 13:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF33188DAEE
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Jun 2025 11:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8661B23C384;
	Thu, 12 Jun 2025 11:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="THqkDFYU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9862A23A9AD;
	Thu, 12 Jun 2025 11:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749726004; cv=none; b=ZDoNEKfpiANQZSavBnEbQIeIlH4cCWmeM23YGkIvOfx0pIIS7T5qt2PrhML/xtHUKLKyTeWcKXJF/9hj/2bsOngJVeoRc1nyrVxfNuALuXlH89cXXFmO7+ck2a4EFvEBdUSJYlM2aymgHGseZIdDAEX4P4nK/oxW4/sK/mFqSDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749726004; c=relaxed/simple;
	bh=k/q2tI+7tEP2C7OO0lBGT+8cI/YxCdHD6IQB3wGd958=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Lznkj3zq2t4FzvU4SKFEKtOuF9bx7v1lqhFiJtaHHgxU8XA8p7lC5aagC2JoJ/Qd9nDNJYE7uIhfOQGvI4cit8hpyFx23K9DPgvH+1td4Kw3/lA+41GKNoliTRh3THQkbbZO1ol7bBtZdPwP3ghOsZYWPy+19hpDGnANksr25Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=THqkDFYU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C10IWf032084;
	Thu, 12 Jun 2025 10:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=upoG1H
	Xm/JgEgq2xUA+z8prMKZNeNeTVb2PMDEyK4/c=; b=THqkDFYUxUixVyqMFytTsc
	Kw2NlUJVFAZxK39IyYulgJeQy4oHlqexfWQGKM1tlz79ovJxtPcyUNEb+fp8j/Rt
	sYWfBEo4RX2zBXN0eQ3QGjrkpD+UJdkJh6yOH/X2reBrVPUUZGGk68LS+0w5+fCU
	j03D8iE9+hZAVV3wIhMJoZRCnegcRoneXMzi7REl+/2mBzlArnmr40jt9yRXNRJ7
	od73LjI5V9vzD+BC4hVcsuip2AwnuArOd9bEn7y+z1C15mStFwVC9jAa5U2o7IbY
	KiXylep25zrjcwiQOI66OBQDwxDfOh3dgE+2Ef1wR22ubgeuYV1yyJGhjyNy2fqg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474dv7t4w6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 10:59:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55CAjXTJ014948;
	Thu, 12 Jun 2025 10:59:46 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4750rpccsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 10:59:46 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55CAxjcv30933674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 10:59:45 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C133858056;
	Thu, 12 Jun 2025 10:59:45 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A9035803F;
	Thu, 12 Jun 2025 10:59:45 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.181.231])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Jun 2025 10:59:45 +0000 (GMT)
Message-ID: <c1ad06ef84170633bdcc7f49b06d646ddbbdc763.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ima: add a knob ima= to make IMA be able to be
 disabled
From: Mimi Zohar <zohar@linux.ibm.com>
To: Baoquan He <bhe@redhat.com>, linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, coxu@redhat.com, piliu@redhat.com,
        pmenzel@molgen.mpg.de, chenste@linux.microsoft.com
In-Reply-To: <20250611082535.127759-1-bhe@redhat.com>
References: <20250611082535.127759-1-bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Jun 2025 06:59:44 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LbV20D_8XnbYyJkmnamk7MuArxadswEI
X-Proofpoint-GUID: LbV20D_8XnbYyJkmnamk7MuArxadswEI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA4MiBTYWx0ZWRfX06WKXTLE7AeP HWo1oKuXzPvrRbnVFBo90alyOVO22qjqoGv2G3tg0iKFto1S0UQAwJCSuNCLmYSl4H5PKlSHbC3 fIR9wwHH6uu3DA/cB7h744tyzFLiDADS9QTpn3POPs86+bIdI/nF9UtjtcPQmqI7YgJASSuALdR
 lgRiTlOai7aI4iRHa/PKCE2M3VDQw3AypL16iIMuKcSl7yja2lkN27pJsX0L1tVwQV28rfZFoVJ n8JlPeFuuNUxGc1urJc7D/ztZG/zXySuiz/PBVS11AKT+NseIaVve0JFlLASxeNwOwj4PT8Hr0R XqSWc3BFsyAi+2gvfQQ7t0RRrSe7xfOev1jhllhg52KMgSYvXhOEWe9Z3ZO65w1058gBrBvKhS0
 sHuCpWynaQzI+FmiQ0/r937hNLTdOm5eVwsGgDeKT6uEo5m6WLQj1J7E8lF/FBaSGFOjV/xu
X-Authority-Analysis: v=2.4 cv=CfMI5Krl c=1 sm=1 tr=0 ts=684ab323 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=UeMwZWw34uBX8khp:21 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=BtPcbq9k6-QGU93c7UYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120082

Hi Baoquan,

As discussed
https://lore.kernel.org/linux-integrity/aC6ezNcUZ%2FulKgpv@MiWiFi-R3L-srv/ =
the
Subject line should indicate disabling IMA is limited to kdump.

On Wed, 2025-06-11 at 16:25 +0800, Baoquan He wrote:
> Kdump kernel doesn't need IMA functionality, and enabling IMA will cost
> extra memory. It would be very helpful to allow IMA to be disabled for
> kdump kernel.
>=20
> Hence add a knob ima=3Don|off here to allow turning IMA off in kdump
> kernel if needed.
>=20
> Note that this IMA disabling is only limited to kdump kernel, please don'=
t
> abuse it in other kernel and thus serious consequences are caused.

Remove the word 'only', here, and in other places.

>=20
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
> v1->v2:
> - Improve patch log and doc description;
> - Make slight adjustment in code;=20
> These are all made according to Mimi's great suggestions.=20
>=20
>  .../admin-guide/kernel-parameters.txt         |  5 ++++
>  security/integrity/ima/ima_main.c             | 26 +++++++++++++++++++
>  2 files changed, 31 insertions(+)
>=20
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index b3d62f4c370a..1de67b9c20b4 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2214,6 +2214,11 @@
>  			different crypto accelerators. This option can be used
>  			to achieve best performance for particular HW.
> =20
> +	ima=3D		[IMA] Enable or disable IMA
> +			Format: { "off" | "on" }
> +			Default: "on"
> +			Note that this is only limited to kdump kernel.

Remove the word 'only' ->  Note that disabling IMA is limited to kdump kern=
el.

> +
>  	indirect_target_selection=3D [X86,Intel] Mitigation control for Indirec=
t
>  			Target Selection(ITS) bug in Intel CPUs. Updated
>  			microcode is also required for a fix in IBPB.
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index f99ab1a3b0f0..c38f3881d72f 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -27,6 +27,7 @@
>  #include <linux/fs.h>
>  #include <linux/iversion.h>
>  #include <linux/evm.h>
> +#include <linux/crash_dump.h>
> =20
>  #include "ima.h"
> =20
> @@ -38,11 +39,30 @@ int ima_appraise;
> =20
>  int __ro_after_init ima_hash_algo =3D HASH_ALGO_SHA1;
>  static int hash_setup_done;
> +static int ima_disabled __ro_after_init;
> =20
>  static struct notifier_block ima_lsm_policy_notifier =3D {
>  	.notifier_call =3D ima_lsm_policy_change,
>  };
> =20
> +static int __init ima_setup(char *str)
> +{
> +	if (!is_kdump_kernel()) {
> +		pr_info("Warning: ima setup option only permitted in kdump");
> +		return 1;
> +	}
> +
> +	if (strncmp(str, "off", 3) =3D=3D 0)
> +		ima_disabled =3D 1;
> +	else if (strncmp(str, "on", 2) =3D=3D 0)
> +		ima_disabled =3D 0;
> +	else
> +		pr_err("Invalid ima setup option: \"%s\" , please specify ima=3Don|off=
.", str);
> +
> +	return 1;
> +}
> +__setup("ima=3D", ima_setup);
> +
>  static int __init hash_setup(char *str)
>  {
>  	struct ima_template_desc *template_desc =3D ima_template_desc_current()=
;
> @@ -1186,6 +1206,12 @@ static int __init init_ima(void)
>  {
>  	int error;
> =20
> +	/*Note that turning IMA off is only limited to kdump kernel.*/

Remove the word "only"  -> Note that turning IMA off is intentionally limit=
ed to
kdump kernel."

> +	if (ima_disabled && is_kdump_kernel()) {
> +		pr_info("IMA functionality is disabled");
> +		return 0;
> +	}
> +
>  	ima_appraise_parse_cmdline();
>  	ima_init_template_list();
>  	hash_setup(CONFIG_IMA_DEFAULT_HASH);

Mimi


