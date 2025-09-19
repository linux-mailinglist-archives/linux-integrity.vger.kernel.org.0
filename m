Return-Path: <linux-integrity+bounces-7189-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED24B8921C
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 12:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4F02178979
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 10:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A46F3081DD;
	Fri, 19 Sep 2025 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YAggCEjZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B288D2C031E;
	Fri, 19 Sep 2025 10:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758278800; cv=none; b=Ou7YzxkduORGn3POrB891bbv9WTdfYNRVvMnOEt7Ngcm6FZtz3ZqAknfyHJoZYUQDD+H1m8kkYiLVK6PnhgSGU5NvZzu/WUzk4e3SOnnXLGMwHOstdQ6ThL01WRD4N1ecM9iUM163+F4TxfKcG4jwBz/3sQOVB9Vk9Bz+wxJ21g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758278800; c=relaxed/simple;
	bh=v8aESY1HH4xS5iDdVBBWHEROSzQsyoOMmq2ysVEIePE=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=S5Bts4dD+yxSfV9l94ai1yreJe8KC8Nyno9/JuhJynis7chkzsjGZUv/qSgHjHtIbK8y2tcdTDa0z7AID10GyeS4KEYRPyyydUinQxE6FIy684/Afda9616xseiA9DJle0UWXrlRLgAJntTNvbCaKgzVw30r3WUXa6STR1JhEW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YAggCEjZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58J2C6dI024864;
	Fri, 19 Sep 2025 10:45:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BFn1LV
	d2sOwMNG7z0MOgWAWhed6jJ1Hip+Q13fe5LVw=; b=YAggCEjZkxqGXhT6oNEBLX
	2rHXwVpOK8UOGgvLdSYuAHl95IhIauCO/QRR6GyxTtEyu0fn0ryDJPV8nVoU2Atw
	N+1hgqbc+vCtLZLzhAiVpOTR4/p+HU8OeAAB9Ct3qvT1ileig1fNMrzPYoFudf6W
	vyGmqePgPzrqcAUT73jQA3SC/xcNyUQmNiLC8pzIpErThW1mENfZn0MtrmFMQ0do
	jqZtzbgTtT8ktFTKbNjjUHWL4tuQSsa/sBmFs0mZYBCYfpUW0a2lSUhReUOBoM/F
	8Q6nK2ywPbw4kzeYHQxBHekKlV6d5zpeWwEdTvEfxeb2r4/CcJ41rOzFDLCGeBAw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4qye40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 10:45:37 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58JAjbrW002043;
	Fri, 19 Sep 2025 10:45:37 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4qye3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 10:45:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58J6opS9022290;
	Fri, 19 Sep 2025 10:45:36 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kxq3g88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 10:45:36 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58JAjZt327722272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 10:45:35 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F19D58064;
	Fri, 19 Sep 2025 10:45:35 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C21695805C;
	Fri, 19 Sep 2025 10:45:33 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.169.163])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Sep 2025 10:45:33 +0000 (GMT)
Message-ID: <f2a83662bc18c250b32a7f1fa8743d402d2d4ec7.camel@linux.ibm.com>
Subject: Re: [PATCH v4 04/34] lsm: introduce looping macros for the
 initialization code
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
In-Reply-To: <20250916220355.252592-40-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
	 <20250916220355.252592-40-paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Sep 2025 06:45:33 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MfDcggdlMr2YWFaxHrpd8GeyOwsenJw8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX7gDllzGnS8ip
 2ow6l0JOtB73YHnNdJDZ81y6gP7P4Hmp6sYZI5ztXSDEvzYqk47N+gzTKH5jMMc6GYjlqZUvDft
 MytA+pzpuY/0rI/hYJ1kh7lHLvIrVql7Kye+kbyo/ArCXZjRwlOUiR2cbeM83aPlBs7mjTfuqZ4
 mHGmOyxTSuSte9J+TY6ideXln9r5EjYAdGmxKEulrexDt6d+WUZ2bsmV+xzRDUQoid/H3w3nMFk
 TpjnPApwKcn1kvKV/2/ZQ6tRVLhWKTJiKCTebfkR0Td1Jpd+Lca6LR5JlrssTMtDpy+Do5xyjI5
 uTnzvHdS4WEFKftaQkj+LWZVlp0PDKfii7CBGGM5zcd7hlCOfTbOyuY8hWtrusHdwRxUftQQL5V
 4YbfIlR+
X-Authority-Analysis: v=2.4 cv=R8oDGcRX c=1 sm=1 tr=0 ts=68cd3451 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=vpqfxihKAAAA:8 a=DfNHnWVPAAAA:8
 a=xVhDTqbCAAAA:8 a=VnNF1IyMAAAA:8 a=pjXSfA3FYt8kPrN9WJAA:9 a=QEXdDO2ut3YA:10
 a=AULIiLoY-XQsE5F6gcqX:22 a=rjTVMONInIDnV1a_A2c_:22 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-GUID: 1JBtcpkf2wJTRQMHBz1kYtXtD2QAkemT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

On Tue, 2025-09-16 at 18:03 -0400, Paul Moore wrote:
> There are three common for loop patterns in the LSM initialization code
> to loop through the ordered LSM list and the registered "early" LSMs.
> This patch implements these loop patterns as macros to help simplify the
> code and reduce the chance for errors.
>=20
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: John Johansen <john.johhansen@canonical.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  security/lsm_init.c | 42 +++++++++++++++++++++++++++---------------
>  1 file changed, 27 insertions(+), 15 deletions(-)
>=20
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 6f40ab1d2f54..18828a65c364 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -32,6 +32,15 @@ static __initdata bool debug;
>  			pr_info(__VA_ARGS__);				\
>  	} while (0)
> =20
> +#define lsm_order_for_each(iter)					\
> +	for ((iter) =3D ordered_lsms; *(iter); (iter)++)
> +#define lsm_for_each_raw(iter)						\
> +	for ((iter) =3D __start_lsm_info;					\
> +	     (iter) < __end_lsm_info; (iter)++)
> +#define lsm_early_for_each_raw(iter)					\
> +	for ((iter) =3D __start_early_lsm_info;				\
> +	     (iter) < __end_early_lsm_info; (iter)++)
> +
>  static int lsm_append(const char *new, char **result);
> =20
>  /* Save user chosen LSM */
> @@ -96,9 +105,10 @@ static bool __init exists_ordered_lsm(struct lsm_info=
 *lsm)
>  {
>  	struct lsm_info **check;
> =20
> -	for (check =3D ordered_lsms; *check; check++)
> +	lsm_order_for_each(check) {
>  		if (*check =3D=3D lsm)
>  			return true;
> +	}
> =20
>  	return false;
>  }
> @@ -209,7 +219,7 @@ static void __init ordered_lsm_parse(const char *orde=
r, const char *origin)
>  	char *sep, *name, *next;
> =20
>  	/* LSM_ORDER_FIRST is always first. */
> -	for (lsm =3D __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +	lsm_for_each_raw(lsm) {
>  		if (lsm->order =3D=3D LSM_ORDER_FIRST)
>  			append_ordered_lsm(lsm, "  first");
>  	}
> @@ -224,8 +234,7 @@ static void __init ordered_lsm_parse(const char *orde=
r, const char *origin)
>  		 * if the selected one was separately disabled: disable
>  		 * all non-matching Legacy Major LSMs.
>  		 */
> -		for (major =3D __start_lsm_info; major < __end_lsm_info;
> -		     major++) {
> +		lsm_for_each_raw(major) {
>  			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
>  			    strcmp(major->name, chosen_major_lsm) !=3D 0) {
>  				set_enabled(major, false);
> @@ -241,7 +250,7 @@ static void __init ordered_lsm_parse(const char *orde=
r, const char *origin)
>  	while ((name =3D strsep(&next, ",")) !=3D NULL) {
>  		bool found =3D false;
> =20
> -		for (lsm =3D __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +		lsm_for_each_raw(lsm) {
>  			if (strcmp(lsm->name, name) =3D=3D 0) {
>  				if (lsm->order =3D=3D LSM_ORDER_MUTABLE)
>  					append_ordered_lsm(lsm, origin);
> @@ -256,7 +265,7 @@ static void __init ordered_lsm_parse(const char *orde=
r, const char *origin)
> =20
>  	/* Process "security=3D", if given. */
>  	if (chosen_major_lsm) {
> -		for (lsm =3D __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +		lsm_for_each_raw(lsm) {
>  			if (exists_ordered_lsm(lsm))
>  				continue;
>  			if (strcmp(lsm->name, chosen_major_lsm) =3D=3D 0)
> @@ -265,13 +274,13 @@ static void __init ordered_lsm_parse(const char *or=
der, const char *origin)
>  	}
> =20
>  	/* LSM_ORDER_LAST is always last. */
> -	for (lsm =3D __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +	lsm_for_each_raw(lsm) {
>  		if (lsm->order =3D=3D LSM_ORDER_LAST)
>  			append_ordered_lsm(lsm, "   last");
>  	}
> =20
>  	/* Disable all LSMs not in the ordered list. */
> -	for (lsm =3D __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +	lsm_for_each_raw(lsm) {
>  		if (exists_ordered_lsm(lsm))
>  			continue;
>  		set_enabled(lsm, false);
> @@ -290,13 +299,14 @@ static void __init report_lsm_order(void)
>  	pr_info("initializing lsm=3D");
> =20
>  	/* Report each enabled LSM name, comma separated. */
> -	for (early =3D __start_early_lsm_info;
> -	     early < __end_early_lsm_info; early++)
> +	lsm_early_for_each_raw(early) {
>  		if (is_enabled(early))
>  			pr_cont("%s%s", first++ =3D=3D 0 ? "" : ",", early->name);
> -	for (lsm =3D ordered_lsms; *lsm; lsm++)
> +	}
> +	lsm_order_for_each(lsm) {
>  		if (is_enabled(*lsm))
>  			pr_cont("%s%s", first++ =3D=3D 0 ? "" : ",", (*lsm)->name);
> +	}
> =20
>  	pr_cont("\n");
>  }
> @@ -343,8 +353,9 @@ static void __init ordered_lsm_init(void)
>  	} else
>  		ordered_lsm_parse(builtin_lsm_order, "builtin");
> =20
> -	for (lsm =3D ordered_lsms; *lsm; lsm++)
> +	lsm_order_for_each(lsm) {
>  		lsm_prepare(*lsm);
> +	}
> =20
>  	report_lsm_order();
> =20
> @@ -382,8 +393,9 @@ static void __init ordered_lsm_init(void)
> =20
>  	lsm_early_cred((struct cred *) current->cred);
>  	lsm_early_task(current);
> -	for (lsm =3D ordered_lsms; *lsm; lsm++)
> +	lsm_order_for_each(lsm) {
>  		initialize_lsm(*lsm);
> +	}
>  }
> =20
>  static bool match_last_lsm(const char *list, const char *lsm)
> @@ -485,7 +497,7 @@ int __init early_security_init(void)
>  {
>  	struct lsm_info *lsm;
> =20
> -	for (lsm =3D __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++)=
 {
> +	lsm_early_for_each_raw(lsm) {
>  		if (!lsm->enabled)
>  			lsm->enabled =3D &lsm_enabled_true;
>  		lsm_prepare(lsm);
> @@ -512,7 +524,7 @@ int __init security_init(void)
>  	 * Append the names of the early LSM modules now that kmalloc() is
>  	 * available
>  	 */
> -	for (lsm =3D __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++)=
 {
> +	lsm_early_for_each_raw(lsm) {
>  		init_debug("  early started: %s (%s)\n", lsm->name,
>  			   is_enabled(lsm) ? "enabled" : "disabled");
>  		if (lsm->enabled)


