Return-Path: <linux-integrity+bounces-7162-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4727AB85D0E
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 17:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F5C3B69ED
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 15:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E566313D45;
	Thu, 18 Sep 2025 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DqJ4xidW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F21B31158F;
	Thu, 18 Sep 2025 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210677; cv=none; b=DCfTuUJ17wxy2AeIRrvb9Iada/tbpSagx/I7svCe9eYzJlUFQcv7KCAdZ/QkmoNiYru16pCf3SudGY1D02gx8sL6Ayk//WzCDmp8ixi3QQI9sSY+GzwajcgWfE2kJtzAlCt3AKJyaVdNfk26YNuZyzzmCGw6VwrSbt3lHdDgCGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210677; c=relaxed/simple;
	bh=XLoC4IDn6XB4T4stDaEg7atqyx17HXOSv6kMWVrjEEc=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=FkcHvkJlCEs5dAKF6huIId2QIWe/yWyXBgX914bDAFmDgKqIAtmD5CKfKwfXqcVqbWDbaHTDYM1Q50iLrk2NSezk2uEFM8jqrlJW4G4v0xXeNXjjAaJknbUAy4fmTvt8V4LkDXwjf5+a9JWZU9N8ufzss8vh31X5sF/7qAR1jNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DqJ4xidW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I8L6Uw011358;
	Thu, 18 Sep 2025 15:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PChGhv
	dlII29F1X4own0ZbEZ9B3RdFiEEvM/kvev0L4=; b=DqJ4xidW8BdujQXw8XwKAg
	TeJGZbdc8cattWF/hDssZKjSVxvH9fPY/DCCQ4PXmwCcIjk3FHXhBlnSdDzwXvJw
	LR4bMTMwiQnfz45nFUFNv5oYrOPGuqMtOfmWzAezkzW88Lhr4yfYRnGiZzo3pC3c
	RTmrCdYd/v2DIYBa1aSemOTm7yoJV+jFjBWDszdQKXaeVEh6BknnLyoiuGG7KE5j
	vZhtFHbn/rY+VVARsRmR75q+eCmn6oCNmYR3qIDQU2e9WM4KrIoeDKvraP5gDh0z
	sBruDyUstEP7VRX+muXm8YsJGA4DeuLSt96fBm6v+9b9ABfM+TycV9eIX05MylRA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4njttu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 15:50:08 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58IFo8XC002773;
	Thu, 18 Sep 2025 15:50:08 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4njttp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 15:50:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58IF8Af0009486;
	Thu, 18 Sep 2025 15:50:07 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 495nn3q3ww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 15:50:07 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58IFo6Hs32113282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 15:50:06 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC13F5805E;
	Thu, 18 Sep 2025 15:50:06 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B7DE5805D;
	Thu, 18 Sep 2025 15:50:05 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.89.238])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Sep 2025 15:50:05 +0000 (GMT)
Message-ID: <4db3bb94c42f11240a880a439c7a678599d7053f.camel@linux.ibm.com>
Subject: Re: [PATCH v4 20/34] lsm: cleanup the debug and console output in
 lsm_init.c
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
In-Reply-To: <20250916220355.252592-56-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
	 <20250916220355.252592-56-paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Sep 2025 11:50:05 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MN5gmNZl c=1 sm=1 tr=0 ts=68cc2a30 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=vpqfxihKAAAA:8 a=DfNHnWVPAAAA:8
 a=xVhDTqbCAAAA:8 a=rzX1WqAAvrR1uQPcxNMA:9 a=QEXdDO2ut3YA:10
 a=AULIiLoY-XQsE5F6gcqX:22 a=rjTVMONInIDnV1a_A2c_:22 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-GUID: 6yzVrc6RCklkC6LcnuLiLsEyMYnVnO8T
X-Proofpoint-ORIG-GUID: NwrpxkIowtORex3aANCNMuoijrBXtuMo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX+tSVHHOaa1kj
 OZjZYVduOu81zF6PCpm1PVq/TApZWrsvZHYk7VfyWtFXVEfe1GB25xi+QzQu3GhBVjdyD2HaE74
 c3ztiP0Qh6t3rA9hsXoC7BawBV/2hIUTjMibB9/L9OZ9DPHp8QulgzrVCCqbgTX/tH7kslOKFHZ
 OtJd/DKwuCcMpr1c8hjazBiVS5nBkXczhqSNFg7lBLrBcj+oM7RmBycoU5yCljC47A48e6jKs9D
 6R7Ma4IgLwzYholvi1AQHJ1cDpkqseTc5xeJBK+DmLjtBjRMAYvntKxCOAt38MlOYnceTQOKvVO
 Kk/g3KdVFf+ivDlLHSJ1eQMoXnAWugdDsyvUCrrALVdokLAE5HAofdN1hMtLqeMTK9L0qU3PTuM
 kW8+bvyC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

On Tue, 2025-09-16 at 18:03 -0400, Paul Moore wrote:
> Move away from an init specific init_debug() macro to a more general
> lsm_pr()/lsm_pr_cont()/lsm_pr_dbg() set of macros that are available
> both before and after init.  In the process we do a number of minor
> changes to improve the LSM initialization output and cleanup the code
> somewhat.
>=20
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: John Johansen <john.johhansen@canonical.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/lsm.h      |  11 ++++
>  security/lsm_init.c | 123 +++++++++++++++++++-------------------------
>  security/security.c |   2 +
>  3 files changed, 66 insertions(+), 70 deletions(-)
>=20
> diff --git a/security/lsm.h b/security/lsm.h
> index dbe755c45e57..8dc267977ae0 100644
> --- a/security/lsm.h
> +++ b/security/lsm.h
> @@ -6,9 +6,20 @@
>  #ifndef _LSM_H_
>  #define _LSM_H_
> =20
> +#include <linux/printk.h>
>  #include <linux/lsm_hooks.h>
>  #include <linux/lsm_count.h>
> =20
> +/* LSM debugging */
> +extern bool lsm_debug;
> +#define lsm_pr(...)		pr_info(__VA_ARGS__)
> +#define lsm_pr_cont(...)	pr_cont(__VA_ARGS__)
> +#define lsm_pr_dbg(...)
>=20
> 				\
> +	do {								\
> +		if (lsm_debug)						\
> +			pr_info(__VA_ARGS__);				\
> +	} while (0)


The existing pr_info and pr_cont themselves are #defines.  Is there a reaso=
n for
these new "#define"?  If there is a valid reason for having these new defin=
es,
why aren't they simply prefixed with "lsm"?

Mimi

