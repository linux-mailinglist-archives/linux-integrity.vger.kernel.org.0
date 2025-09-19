Return-Path: <linux-integrity+bounces-7203-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22087B8B0B3
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 21:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F207E8A3C
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 19:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C4A26159E;
	Fri, 19 Sep 2025 19:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DG6Ot0Bg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B4D25CC5E;
	Fri, 19 Sep 2025 19:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758308827; cv=none; b=qSnRQmJa9+eoe4JdmbHX2HoiNpXQlDELw30EVS/qdwk6hN+LtVK65jqB3071FSvv6LvgLtb1MTr+IugWRKmGvG7GOnmE9ZfjUn/khFj7LlVSNOxlJzmXG6auaNaECtC9F7X3lxDqBdqw1f3jPgUmjRAdV3N48t8RBqnPn+mADGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758308827; c=relaxed/simple;
	bh=kbN7YkdnKN5GJHIfZ4apdhVpmD4G5XghEQR/e0UnTO0=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=L5ddij+Sm/UfAZx65+nn8sWS16e7JWmtN692HLF+b7L84pBrz3gfXC3Sn9EB0MoxwIXJqiIGri0tsJ4n1iO816F02bwnGrpqddD+cwE4Pg2oogtnFmEF9ARiZywmGOXSF3PQCycQKXUvTT3cwlcvnX0YF6LZtV5H9ETlk3X4/Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DG6Ot0Bg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDhITp000333;
	Fri, 19 Sep 2025 19:06:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KTI4Xp
	ybCkIs5Cn0/DFFbb6M80EajiA874tdVCDlWqM=; b=DG6Ot0Bgd92hzd15avyarq
	SmEK39D1ydWn452L5n77jcPd5myl72dAKFFKz9xXhht6RZwO0VfVWPphtwsgMXx2
	AjDGNBx/BCBwuR0il8yOPI4+tia44P67G0qScSAzyszLvbQviYEdVXChBGdPjK7p
	aBcFvBIunOsomHl+d6xPm0zMuOyFidDTtvIkvxkDyyrn+KZkhlrDo/K5PAc2Oi8j
	HcXIc+FdqBczvvttqxXsu2qpHfUR6Xy+PeQqO5iAdTQd3s9sVEcBJT+EnnO570CY
	kBFlV8X27Ol4oU3KoUzbtK0kXT5ORJWSxnS+VxsC9Cq4t8sy/RYufgh2LQlStDEQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4j2nup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 19:05:59 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58JJ5xip003407;
	Fri, 19 Sep 2025 19:05:59 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4j2nuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 19:05:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58JIWroZ018637;
	Fri, 19 Sep 2025 19:05:58 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 495n5mw7rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 19:05:58 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58JJ5vPA29688148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 19:05:57 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1844058059;
	Fri, 19 Sep 2025 19:05:57 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 155BB58055;
	Fri, 19 Sep 2025 19:05:56 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.19.242])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Sep 2025 19:05:55 +0000 (GMT)
Message-ID: <16c84542071d5b64d98c70cd0d10d1e81160ef32.camel@linux.ibm.com>
Subject: Re: [PATCH v4 13/34] lsm: rename exists_ordered_lsm() to
 lsm_order_exists()
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
In-Reply-To: <20250916220355.252592-49-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
	 <20250916220355.252592-49-paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Sep 2025 15:05:54 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LV1u1WFxrrG95iktcQK5YUeHofsBo1nA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX5jTaAI0Pyxhb
 Nzmzwdi96EYhftigX2Iht3jkCzLVvoN3tnU+Nz6zptaujNX89ZKWadLrmBZiAkfoUdzkPhVKWR/
 a36aTKz37cPg12UPeTBMV9zsrj1D0sl5zgh/Wo83/m4B98+k0uzu3g2KSHPnZGtNR+FDFKMlqla
 FL16eRJAPrp1qLrn1vkrK804vOm6H4C9Us+j4YmsrVVP1jpKmQSMA81g6ndDqVoQqc64QbThg5b
 j/DqIvVXJZQ8H/FIh5V6GPhz4XitRbLZwbsTeZe5Q6AJzhhgs7EDYhTc2ejOdoLznWjX6F+w9BQ
 Hpo8oScY8xU/tgO82JLfTzQM+HL25K+Kymz0FDclfD+FbN+af6gCWT6bBtrv7wXmSCc1u5cNzxz
 xHWKjV69
X-Proofpoint-GUID: _LCoM54pUkFvA9M1XgqBVBlwka7Wr8T8
X-Authority-Analysis: v=2.4 cv=co2bk04i c=1 sm=1 tr=0 ts=68cda997 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=vpqfxihKAAAA:8 a=DfNHnWVPAAAA:8
 a=xVhDTqbCAAAA:8 a=VnNF1IyMAAAA:8 a=uxJjvxosubxIdL1KwykA:9 a=QEXdDO2ut3YA:10
 a=AULIiLoY-XQsE5F6gcqX:22 a=rjTVMONInIDnV1a_A2c_:22 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160204

On Tue, 2025-09-16 at 18:03 -0400, Paul Moore wrote:
> Also add a header comment block to the function.
>=20
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: John Johansen <john.johhansen@canonical.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  security/lsm_init.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 2cfd72ade6fb..ec46ddb18e1e 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -108,8 +108,11 @@ static inline bool lsm_is_enabled(struct lsm_info *l=
sm)
>  	return (lsm->enabled ? *lsm->enabled : false);
>  }
> =20
> -/* Is an LSM already listed in the ordered LSMs list? */
> -static bool __init exists_ordered_lsm(struct lsm_info *lsm)
> +/**
> + * lsm_order_exists - Determine if a LSM exists in the ordered list
> + * @lsm: LSM definition
> + */
> +static bool __init lsm_order_exists(struct lsm_info *lsm)
>  {
>  	struct lsm_info **check;
> =20
> @@ -126,7 +129,7 @@ static int last_lsm __initdata;
>  static void __init append_ordered_lsm(struct lsm_info *lsm, const char *=
from)
>  {
>  	/* Ignore duplicate selections. */
> -	if (exists_ordered_lsm(lsm))
> +	if (lsm_order_exists(lsm))
>  		return;
> =20
>  	if (WARN(last_lsm =3D=3D MAX_LSM_COUNT, "%s: out of LSM static calls!?\=
n", from))
> @@ -269,7 +272,7 @@ static void __init ordered_lsm_parse(const char *orde=
r, const char *origin)
>  	/* Process "security=3D", if given. */
>  	if (lsm_order_legacy) {
>  		lsm_for_each_raw(lsm) {
> -			if (exists_ordered_lsm(lsm))
> +			if (lsm_order_exists(lsm))
>  				continue;
>  			if (strcmp(lsm->id->name, lsm_order_legacy) =3D=3D 0)
>  				append_ordered_lsm(lsm, "security=3D");
> @@ -284,7 +287,7 @@ static void __init ordered_lsm_parse(const char *orde=
r, const char *origin)
> =20
>  	/* Disable all LSMs not in the ordered list. */
>  	lsm_for_each_raw(lsm) {
> -		if (exists_ordered_lsm(lsm))
> +		if (lsm_order_exists(lsm))
>  			continue;
>  		lsm_enabled_set(lsm, false);
>  		init_debug("%s skipped: %s (not in requested order)\n",


