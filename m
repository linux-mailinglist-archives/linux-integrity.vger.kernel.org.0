Return-Path: <linux-integrity+bounces-7202-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8210AB8B0A7
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 21:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1917F7E1F7A
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 19:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B2A27CCF3;
	Fri, 19 Sep 2025 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HvVjAxMr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369AB22A4F1;
	Fri, 19 Sep 2025 19:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758308753; cv=none; b=sUVLs0+ZKXEqEm4Mx9xLpP3d4anzaUsry7H3UiUvElQhx8DLP5cxM9SmfjBQfB0JLrjTufv1neh4x718rHpWygPZ3itv1EtIClbl0t3LN0CAWKt5ihzA8j4ZSDuHsv2+iJRBzR0X4AhfYJAdExPTKOR653setPVCpANM+CYy7us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758308753; c=relaxed/simple;
	bh=xw1Qb9odiOBXqSwKnLbtesJXYz8++AkEhNFsZRbGbqI=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=cDFRqDTJCVruhGb+1nB+gKfOimYz5BZJcOxQARcUY9D9zVxroPQnZ7epMTR2iYJTDG1+s2Kva1E/RaOR2Rw+j5K+4r7fH7NCA8Okeb+ZPzvXgzQmKVoh9nyhIAuLRQM9BIy+vmJPm6UVBNY3DC5Xd+uJEKP1wH9P38Dr27/RTXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HvVjAxMr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JCZNTB001894;
	Fri, 19 Sep 2025 19:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fC2MfO
	eJ7ihAkb3GelM+x51h2c2y+6EgLV3vTjIp8gQ=; b=HvVjAxMrEkSQjIHmhjOyNH
	H/wdxVznyhsdQjRRCRhSnLqiD40DLMgxwo33fClblPykw6QvwzMRJFePIhuFVlpX
	A28PG36JXSt+53AgEzfL3mqSP9c5Q7GlSA8jMV12lbaHLdPV6CFjkjp2A3xLyBuh
	LhggogFDAzeeQ6VD4tooH7EzHQqip/N3WvvNB5ftI7+pkygL1vwiQ3lrOn+FRl8F
	MY6qrkkU5mdpcgex8gkE6srNujPBEOW70UkNfbKmRlFnG0FevxBBbL9q6hcfOLDa
	4W0m8GJTRWlkYxhfKDnP7raXAHwBteHld42pXnqjYGY4jdhs3AtuVCGUeC7omWlg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 498dtwsn01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 19:04:49 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58JJ2TjC031806;
	Fri, 19 Sep 2025 19:04:48 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 498dtwsmyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 19:04:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58JIor9i018620;
	Fri, 19 Sep 2025 19:04:47 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 495n5mw7ms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 19:04:47 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58JJ4kfG32965352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 19:04:47 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0C3558043;
	Fri, 19 Sep 2025 19:04:46 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F74A58053;
	Fri, 19 Sep 2025 19:04:45 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.19.242])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Sep 2025 19:04:45 +0000 (GMT)
Message-ID: <89086cc85ec30c8aaf69149c1a6191dda607b54c.camel@linux.ibm.com>
Subject: Re: [PATCH v4 12/34] lsm: rework the LSM enable/disable
 setter/getter functions
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
In-Reply-To: <20250916220355.252592-48-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
	 <20250916220355.252592-48-paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Sep 2025 15:04:44 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EYvIQOmC c=1 sm=1 tr=0 ts=68cda951 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=vpqfxihKAAAA:8 a=DfNHnWVPAAAA:8
 a=xVhDTqbCAAAA:8 a=VnNF1IyMAAAA:8 a=Q3ZYS4L36-kBuqpsmi4A:9 a=QEXdDO2ut3YA:10
 a=AULIiLoY-XQsE5F6gcqX:22 a=rjTVMONInIDnV1a_A2c_:22 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-ORIG-GUID: TmzL4UpE0hIzGbCyiOQx_uN7S7Rixw3V
X-Proofpoint-GUID: IehiEAAsIeixacY1RUPkcAaKfqe3Wsom
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDA2NSBTYWx0ZWRfX3ypSA7MAVxXQ
 l/GARR9cPmlN32N2OX7Bsbc7Grb8XXR3cNEzoW7OReQQeZamNMhcB/iacjWnyVNXOss5brIQGie
 70NnXQxq8jZrwcf7aBpxNgo7nTPnqQStqvf0ZX3y/R9zKKLfDUEuDTJn2ZaqUBV9rhetMSKs86/
 71cK5GGPd8EJL2P6uO8XSpgn0KVbQqMQ3tFkPKBfDrwnftT5O1KmeGXrjwDPgwCFtGgonBtgKsB
 AnKdps3ZNQN5edQcfmkvl2Chl4jjzZUcdPPBII+fi937JIGPaHTBg6D23B0me2rYVbGLbBt3tc+
 aX20eo1w0Adh8Wq689VOD8ouQj+N+/Z7NB1qoV4hWvXYc0O+c9uyurj5s9tN6fFFuE+r1oMOQrV
 hVB55dq7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509180065

On Tue, 2025-09-16 at 18:03 -0400, Paul Moore wrote:
> In addition to style changes, rename set_enabled() to lsm_enabled_set()
> and is_enabled() to lsm_is_enabled() to better fit within the LSM
> initialization code.
>=20
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: John Johansen <john.johhansen@canonical.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  security/lsm_init.c | 62 ++++++++++++++++++++++-----------------------
>  1 file changed, 31 insertions(+), 31 deletions(-)
>=20
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 87e2147016b3..2cfd72ade6fb 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -10,6 +10,10 @@
> =20
>  #include "lsm.h"
> =20
> +/* LSM enabled constants. */
> +static __initdata int lsm_enabled_true =3D 1;
> +static __initdata int lsm_enabled_false =3D 0;
> +
>  /* Pointers to LSM sections defined in include/asm-generic/vmlinux.lds.h=
 */
>  extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
>  extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
> @@ -75,37 +79,33 @@ static int __init lsm_debug_enable(char *str)
>  }
>  __setup("lsm.debug", lsm_debug_enable);
> =20
> -/* Mark an LSM's enabled flag. */
> -static int lsm_enabled_true __initdata =3D 1;
> -static int lsm_enabled_false __initdata =3D 0;
> -static void __init set_enabled(struct lsm_info *lsm, bool enabled)
> +/**
> + * lsm_enabled_set - Mark a LSM as enabled
> + * @lsm: LSM definition
> + * @enabled: enabled flag
> + */
> +static void __init lsm_enabled_set(struct lsm_info *lsm, bool enabled)
>  {
>  	/*
>  	 * When an LSM hasn't configured an enable variable, we can use
>  	 * a hard-coded location for storing the default enabled state.
>  	 */
> -	if (!lsm->enabled) {
> -		if (enabled)
> -			lsm->enabled =3D &lsm_enabled_true;
> -		else
> -			lsm->enabled =3D &lsm_enabled_false;
> -	} else if (lsm->enabled =3D=3D &lsm_enabled_true) {
> -		if (!enabled)
> -			lsm->enabled =3D &lsm_enabled_false;
> -	} else if (lsm->enabled =3D=3D &lsm_enabled_false) {
> -		if (enabled)
> -			lsm->enabled =3D &lsm_enabled_true;
> +	if (!lsm->enabled ||
> +	    lsm->enabled =3D=3D &lsm_enabled_true ||
> +	    lsm->enabled =3D=3D &lsm_enabled_false) {
> +		lsm->enabled =3D enabled ? &lsm_enabled_true : &lsm_enabled_false;
>  	} else {
>  		*lsm->enabled =3D enabled;
>  	}
>  }
> =20
> -static inline bool is_enabled(struct lsm_info *lsm)
> +/**
> + * lsm_is_enabled - Determine if a LSM is enabled
> + * @lsm: LSM definition
> + */
> +static inline bool lsm_is_enabled(struct lsm_info *lsm)
>  {
> -	if (!lsm->enabled)
> -		return false;
> -
> -	return *lsm->enabled;
> +	return (lsm->enabled ? *lsm->enabled : false);
>  }
> =20
>  /* Is an LSM already listed in the ordered LSMs list? */
> @@ -139,7 +139,7 @@ static void __init append_ordered_lsm(struct lsm_info=
 *lsm, const char *from)
>  	lsm_idlist[last_lsm++] =3D lsm->id;
> =20
>  	init_debug("%s ordered: %s (%s)\n", from, lsm->id->name,
> -		   is_enabled(lsm) ? "enabled" : "disabled");
> +		   lsm_is_enabled(lsm) ? "enabled" : "disabled");
>  }
> =20
>  static void __init lsm_set_blob_size(int *need, int *lbs)
> @@ -162,17 +162,17 @@ static void __init lsm_prepare(struct lsm_info *lsm=
)
>  {
>  	struct lsm_blob_sizes *blobs;
> =20
> -	if (!is_enabled(lsm)) {
> -		set_enabled(lsm, false);
> +	if (!lsm_is_enabled(lsm)) {
> +		lsm_enabled_set(lsm, false);
>  		return;
>  	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && lsm_exclusive) {
>  		init_debug("exclusive disabled: %s\n", lsm->id->name);
> -		set_enabled(lsm, false);
> +		lsm_enabled_set(lsm, false);
>  		return;
>  	}
> =20
>  	/* Mark the LSM as enabled. */
> -	set_enabled(lsm, true);
> +	lsm_enabled_set(lsm, true);
>  	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !lsm_exclusive) {
>  		init_debug("exclusive chosen:   %s\n", lsm->id->name);
>  		lsm_exclusive =3D lsm;
> @@ -206,7 +206,7 @@ static void __init lsm_prepare(struct lsm_info *lsm)
>  /* Initialize a given LSM, if it is enabled. */
>  static void __init initialize_lsm(struct lsm_info *lsm)
>  {
> -	if (is_enabled(lsm)) {
> +	if (lsm_is_enabled(lsm)) {
>  		int ret;
> =20
>  		init_debug("initializing %s\n", lsm->id->name);
> @@ -240,7 +240,7 @@ static void __init ordered_lsm_parse(const char *orde=
r, const char *origin)
>  		lsm_for_each_raw(major) {
>  			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
>  			    strcmp(major->id->name, lsm_order_legacy) !=3D 0) {
> -				set_enabled(major, false);
> +				lsm_enabled_set(major, false);
>  				init_debug("security=3D%s disabled: %s (only one legacy major LSM)\n=
",
>  					   lsm_order_legacy, major->id->name);
>  			}
> @@ -286,7 +286,7 @@ static void __init ordered_lsm_parse(const char *orde=
r, const char *origin)
>  	lsm_for_each_raw(lsm) {
>  		if (exists_ordered_lsm(lsm))
>  			continue;
> -		set_enabled(lsm, false);
> +		lsm_enabled_set(lsm, false);
>  		init_debug("%s skipped: %s (not in requested order)\n",
>  			   origin, lsm->id->name);
>  	}
> @@ -319,12 +319,12 @@ static void __init lsm_init_ordered(void)
> =20
>  	pr_info("initializing lsm=3D");
>  	lsm_early_for_each_raw(early) {
> -		if (is_enabled(early))
> +		if (lsm_is_enabled(early))
>  			pr_cont("%s%s",
>  				first++ =3D=3D 0 ? "" : ",", early->id->name);
>  	}
>  	lsm_order_for_each(lsm) {
> -		if (is_enabled(*lsm))
> +		if (lsm_is_enabled(*lsm))
>  			pr_cont("%s%s",
>  				first++ =3D=3D 0 ? "" : ",", (*lsm)->id->name);
>  	}
> @@ -440,7 +440,7 @@ int __init security_init(void)
>  	 */
>  	lsm_early_for_each_raw(lsm) {
>  		init_debug("  early started: %s (%s)\n", lsm->id->name,
> -			   is_enabled(lsm) ? "enabled" : "disabled");
> +			   lsm_is_enabled(lsm) ? "enabled" : "disabled");
>  	}
> =20
>  	/* Load LSMs in specified order. */


