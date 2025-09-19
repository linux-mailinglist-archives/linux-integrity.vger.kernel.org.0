Return-Path: <linux-integrity+bounces-7192-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AA4B89243
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 12:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E8D52102A
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 10:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB75D2FC009;
	Fri, 19 Sep 2025 10:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EOU4emfC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FC2239E61;
	Fri, 19 Sep 2025 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758278825; cv=none; b=dsLY+XlKy4952+hkqYjIDKitWLRL/mEgjVzXM8nQHhEPPSDTdyuonOAp/npoT6vXddKjcCVvv97WKmYiPNJJ4iqCdSXyAvQqzPxpU1asNAWVFCnHPDODyuvjRZVNJ+Am8VGQVRcst18vz19H4M8fJBoSo28xlEgOwRDQjkprTmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758278825; c=relaxed/simple;
	bh=vfLWEdp6hPELtATZXb+jIVKsrbbD0y0LPNqnfytFKMk=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Mxx+Gut6pAjNah75/d7waIyMrciQtxFDqnsI0Jpg3HuDVV4wRWPdzLlYipAzzgAi6sRH3BZHUQ2TFD8IXcAYbyS8rJgnLg5WDACNo27CfUa46ycFBkQZv0+WlbRM8MZVCiOgxVOUTOVWAhFkIqyygyAL8eWDuozlIA0r6pwuxyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EOU4emfC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58J9MdFc011259;
	Fri, 19 Sep 2025 10:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AeWO0w
	syEqad90+ewvUVs9jH/hJLSB8u3MG16Wi1Ktk=; b=EOU4emfCrpg5VNaDdloZKx
	5OVzmdvNwjF+oBn6tPViJw9MHNlo8ObowNtp8OPAfFtzbAaK+atiA22Zm5U7Gu/N
	4Sve323cIBabHsCknxbXNDyQ+7jKs6f1QPYzeqJE+z3f47NggKXajyL2YduxrOlt
	eDcE6g7Q4cyirGp9NgCYPV0Rgdb3tHWbI2+EYMlTmQXgBcAXWI5ILh83GqnWV2TF
	18TpaVuS1VHFaj5f5+CY0sxcEn7YLaOnh0U9N4fWFBtvdPS/rlYuXCwPKJNm8hdz
	Je1BwpyZD4kH9XSBZJXXMOPxPw+whsKU0Js21EQVLAWExz87ii1XHqi8jlbjTD6Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4nqf1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 10:45:59 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58JAQrat030562;
	Fri, 19 Sep 2025 10:45:58 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4nqf1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 10:45:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58J93Ehw005963;
	Fri, 19 Sep 2025 10:45:57 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 495jxuknpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 10:45:57 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58JAjv8D16646836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 10:45:57 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E3935805D;
	Fri, 19 Sep 2025 10:45:57 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B97B458056;
	Fri, 19 Sep 2025 10:45:55 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.169.163])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Sep 2025 10:45:55 +0000 (GMT)
Message-ID: <a158ffe2edd1588b6afc435d392f286e77851168.camel@linux.ibm.com>
Subject: Re: [PATCH v4 07/34] lsm: rename ordered_lsm_init() to
 lsm_init_ordered()
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
In-Reply-To: <20250916220355.252592-43-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
	 <20250916220355.252592-43-paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Sep 2025 06:45:55 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MN5gmNZl c=1 sm=1 tr=0 ts=68cd3467 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=vpqfxihKAAAA:8 a=DfNHnWVPAAAA:8
 a=xVhDTqbCAAAA:8 a=VnNF1IyMAAAA:8 a=Kzl9HfZgd8uXcRyxXDcA:9 a=QEXdDO2ut3YA:10
 a=AULIiLoY-XQsE5F6gcqX:22 a=rjTVMONInIDnV1a_A2c_:22 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-GUID: p0AUmOeBcJx7Lfs_RqRvm9V_RPRpogUZ
X-Proofpoint-ORIG-GUID: 66hp5Ll5lkJ9DJ5epRaAspA-a6Ak0jIP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfXzks57cyTUEE6
 8qC4fW29GVBeXRBFrspTbROcqhw3D6vVMm8LlXIt1lL8d9DxTosHsEZCmefHcJdQXBbVGVMr6Nc
 q3FZ8Frc9fa6VARQXzS4vTOxgnkXn4wymZ63NCIbvbgnT951XUKeLjymjp69M8xXXwc5OL+RFHD
 9VoNEyULSFiz8qbYNg/hI37VCoc0GHYmQAI9HnDdQXLb7h1pyNptr4zh8TgkijCuOA+JpBgi1VP
 3uaXbx4/nW8z0bPHCzYVtRdG1+7/umZuQMPHo2+Jqt557fGeWgtH02+uQ7yXIrwqgZDlOhwU3fd
 B1wkOOisHs5ySFWQLF7/ppmsivzBDqfLCMLWduvLni8b7hcWE71zNu2sMWr9URzh1n+eO0AqEmn
 TqUPTa6s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

On Tue, 2025-09-16 at 18:03 -0400, Paul Moore wrote:
> The new name more closely fits the rest of the naming scheme in
> security/lsm_init.c.  This patch also adds a trivial comment block to
> the top of the function.
>=20
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: John Johansen <john.johhansen@canonical.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  security/lsm_init.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index a8b82329c76a..4a108b03c23d 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -291,7 +291,10 @@ static void __init ordered_lsm_parse(const char *ord=
er, const char *origin)
>  	kfree(sep);
>  }
> =20
> -static void __init ordered_lsm_init(void)
> +/**
> + * lsm_init_ordered - Initialize the ordered LSMs
> + */
> +static void __init lsm_init_ordered(void)
>  {
>  	unsigned int first =3D 0;
>  	struct lsm_info **lsm;
> @@ -342,9 +345,6 @@ static void __init ordered_lsm_init(void)
>  	init_debug("bpf prog blob size   =3D %d\n", blob_sizes.lbs_bpf_prog);
>  	init_debug("bpf token blob size  =3D %d\n", blob_sizes.lbs_bpf_token);
> =20
> -	/*
> -	 * Create any kmem_caches needed for blobs
> -	 */
>  	if (blob_sizes.lbs_file)
>  		lsm_file_cache =3D kmem_cache_create("lsm_file_cache",
>  						   blob_sizes.lbs_file, 0,
> @@ -498,7 +498,7 @@ int __init security_init(void)
>  	}
> =20
>  	/* Load LSMs in specified order. */
> -	ordered_lsm_init();
> +	lsm_init_ordered();
> =20
>  	return 0;
>  }


