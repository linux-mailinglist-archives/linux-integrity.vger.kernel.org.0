Return-Path: <linux-integrity+bounces-7152-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F477B844FF
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 13:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E1701C0368A
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 11:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFC522FE0E;
	Thu, 18 Sep 2025 11:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ajf2HDbE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CF534BA40;
	Thu, 18 Sep 2025 11:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758194218; cv=none; b=bzCW30TSlZA+qh382CF7mo15Ep5i4tdYVGcmYz5IACY+vHjdx7pk3vp3Su9eN20rRPrjHyuMleAeGNPj3kMnko+nvWebm5HUr7B1OzBG0JzozFUGmEpn8Dxr+blIUvTYeQ2yVBOwtPPQ2IodEKqAtwLnmQWqKY3Y+WK4YdYWyfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758194218; c=relaxed/simple;
	bh=SlHYl1aJBCunzhJx3Xpwgt2zbgk8ZceSk3WFwewez24=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=YFN9WXJD8LrSOp8LZomzsSSl7JYQMzmDvEHlEfVBra4gqkF3FKVYWRUIUAFtk1XynNwuTRAA3s9Hw3XRWz1KjMrFcMrUh/ynVCM1hqNStYfV8A7fuA8SZY63shv523RB8DvUfxBtX48LY/MN5wlihe29F9Tko0P1RIBFwNVp4rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ajf2HDbE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I6G78M027383;
	Thu, 18 Sep 2025 11:15:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SAGZdk
	YG162AfmpfAQFbZ45upQ8XL1m7N1C+1AGgQo0=; b=Ajf2HDbElttw3dA4lRCTlE
	fdDBnlM/d7jfUDWQnKae+9Vbq2YeSFWeyDZn4vwukL9ZMnot1sGdZM0y4jGM9zBn
	CNm3sv8NgUR7My9AkPY3/5iKVM7qcJkZtvax8eROzWoyvz1ELD/aulcpg1hJhZuO
	6R3C7Cx4Xl9dyBbB/EBJ76KYI4SAjQgdgvOD5HKt5EOzAP84XUG3Q26x4QiiKeD8
	Ezg283sU1wxUWNX696bT7/q5vBV4VtHE9DLeU1g2roYwbyKlG3RoDwRQE5WiU6zH
	Doer9LB5gFYauUfuEfQK4kjuQMPBXbI16moNmj9VVLf5iV9BUn2vA9BmvMVJUhpw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4p9tys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:15:53 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58IAoHc5016457;
	Thu, 18 Sep 2025 11:15:52 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4p9tyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:15:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58I9FqnB005940;
	Thu, 18 Sep 2025 11:15:51 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 495jxueh2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:15:51 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58IBFpU827525868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 11:15:51 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5671458056;
	Thu, 18 Sep 2025 11:15:51 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BBE558052;
	Thu, 18 Sep 2025 11:15:50 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.76.15])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Sep 2025 11:15:50 +0000 (GMT)
Message-ID: <598e9ed199ba23e7e11c5ea29132bd2e3202305f.camel@linux.ibm.com>
Subject: Re: [PATCH v4 24/34] loadpin: move initcalls to the LSM framework
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
In-Reply-To: <20250916220355.252592-60-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
	 <20250916220355.252592-60-paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Sep 2025 07:15:50 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX4EUritDFjj8p
 4CGBZ+b3mE8Rluw9NAkrcFkRc8ZnoX7vMRKxFd+0joCD2zB6mFEfKv/QsiwofsSXmnrsWYbQVRw
 nE37wj2eRzkB57ZufhVygaYDfQ0V9USV6l1q+eY6wylQnO2JltISb0BrFTbYTpe1uR58n1mxXOk
 x6c9bd4n/WTdpiMdBNUnstKbHNRKcXRvBzSsfadi8XxEtqAdUskXMUUcxB9QWNo+Z+lnGFplmjG
 LlIfmrlZwsRcBDOdboUXRUbWxS90Ur+kgpvs9BioXX96hphVdDiivt/FGv3x6KOY4LZ4g+dJIrB
 IalR9Y5+9ysOfWQ5qNmZHoS8D7P7QbztJk+93dfdr5Tt3JHvR0TevgkOXVq+CD3Q1Ig9FLBSx5m
 vqh7ePs2
X-Proofpoint-ORIG-GUID: q9PmLhF8EFdsZHfYC2748n1JnozO894S
X-Proofpoint-GUID: 0WTREv8Cxp_eYj1xCc1WmIaPZRjYtNXy
X-Authority-Analysis: v=2.4 cv=cNzgskeN c=1 sm=1 tr=0 ts=68cbe9e9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=DfNHnWVPAAAA:8
 a=xVhDTqbCAAAA:8 a=8JviWiFCvzpu8RqBGacA:9 a=QEXdDO2ut3YA:10
 a=rjTVMONInIDnV1a_A2c_:22 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

On Tue, 2025-09-16 at 18:03 -0400, Paul Moore wrote:
> Acked-by: Kees Cook <kees@kernel.org>
> Reviewed-by: John Johansen <john.johhansen@canonical.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

For the first couple of iterations, the patch descriptions needed to be add=
ed or
improved upon.  Some of the patch descriptions are still missing (e.g. 25, =
27,
etc).  Is this intentional because you feel it is redundant or simply an
oversight because checkpatch.pl is not flagging it?  Checkpatch normally fl=
ags
missing patch descriptions, but isn't flagging it now because of the additi=
onal
tags.

FYI, teaching newbies how to break up a patch set is not easy.  This patch =
set
is nicely broken up and would be a good example.  However, leaving out the =
patch
description would be teaching the wrong thing.

Mimi


> ---
>  security/loadpin/loadpin.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index b9ddf05c5c16..273ffbd6defe 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -270,11 +270,6 @@ static int __init loadpin_init(void)
>  	return 0;
>  }
> =20
> -DEFINE_LSM(loadpin) =3D {
> -	.id =3D &loadpin_lsmid,
> -	.init =3D loadpin_init,
> -};
> -
>  #ifdef CONFIG_SECURITY_LOADPIN_VERITY
> =20
>  enum loadpin_securityfs_interface_index {
> @@ -434,10 +429,16 @@ static int __init init_loadpin_securityfs(void)
>  	return 0;
>  }
> =20
> -fs_initcall(init_loadpin_securityfs);
> -
>  #endif /* CONFIG_SECURITY_LOADPIN_VERITY */
> =20
> +DEFINE_LSM(loadpin) =3D {
> +	.id =3D &loadpin_lsmid,
> +	.init =3D loadpin_init,
> +#ifdef CONFIG_SECURITY_LOADPIN_VERITY
> +	.initcall_fs =3D init_loadpin_securityfs,
> +#endif /* CONFIG_SECURITY_LOADPIN_VERITY */
> +};
> +
>  /* Should not be mutable after boot, so not listed in sysfs (perm =3D=3D=
 0). */
>  module_param(enforce, int, 0);
>  MODULE_PARM_DESC(enforce, "Enforce module/firmware pinning");


