Return-Path: <linux-integrity+bounces-4998-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8468BA46ACA
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Feb 2025 20:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D07B188AF83
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Feb 2025 19:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FF816F288;
	Wed, 26 Feb 2025 19:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iisPBJo4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD74A41C71
	for <linux-integrity@vger.kernel.org>; Wed, 26 Feb 2025 19:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740597588; cv=none; b=P2Km7eNp0Wqqzptc6VZjceQaFeFm6SRLGkN4vWYaaLWUMb1gECZHDazpdslS0RAlv9gbsvRueGTFhdmxZmixe6gbLoafC88GIJdbW6AsE3n1G/DbNfAPN1+OuPEkV7bcKJ/NNnsqNQ2ItvdCQFzGnjRxo5gjh/D8EwZusxzpf5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740597588; c=relaxed/simple;
	bh=v/YVnT7ytg3mW7r0o/pb/RhB/BOKB1vuwLO/R6frOBY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iqWM5YMUW2Iix4StOoYoMHyfINqwI5qPUzYD/9+XqX1Vx3SlcYjAcoS1aTilr/A31pIk0/4zI6bcZpUMxaT1pOI4Z42DRWhLnT4IAFPf4kLn5MscWsVXwdHWN7jvW9zbYJL6KN+KJLP2ocoeshe098fmmX6w+PCJqYf1UjawYy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iisPBJo4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QDaHYU008203;
	Wed, 26 Feb 2025 19:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3mInEc
	9kWN3sVjOOn4L86haTius2BQNZtco14BYf7U0=; b=iisPBJo4JasKE5IGEXRDQD
	bQ6KvFLpfz1Wp/ioKPWLK6mBiCFRErEbcKDIl1mXZsJtyAugqxYArVlZojuMiljb
	yTwm00vxHbLCKvjwGaCgBd3cPtpBJEGso788bSJNvF4qQ5ZP7aUkvknMvhVFZUmU
	BM3WGz8SpG0QqlRh3MPeO0Sb3uVpgh6L03+jmcuKq4CdC/AAVN+XY66nnZIl8NJb
	HQcYMYN4x2ybt1mnvSVR24eUyIsAoxzt20P4ysZaIIOAByytlOB0vFmgmFvM3uwx
	qfl8Df4vEP4gSIVvH1IVVJbrUHd5EoONFKPPC+6Yy3RxBr4pQRyuOChh+alMfsvg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451ssymmcw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 19:19:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51QGpT8O002595;
	Wed, 26 Feb 2025 19:19:30 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yu4jv6ue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 19:19:30 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51QJJT1g14680698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 19:19:29 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AEAB85805D;
	Wed, 26 Feb 2025 19:19:29 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CFCF58058;
	Wed, 26 Feb 2025 19:19:29 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.103.152])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Feb 2025 19:19:29 +0000 (GMT)
Message-ID: <27cbda733ae6285866b0b38d771981431b9162e5.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] ima: limit the number of ToMToU integrity violations
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
        linux-integrity@vger.kernel.org
Cc: roberto.sassu@huawei.com, Stefan Berger <stefanb@linux.ibm.com>,
        Petr
 Vorel <pvorel@suse.cz>
Date: Wed, 26 Feb 2025 14:19:28 -0500
In-Reply-To: <62e715f5ea0e901f7fd4185e996871eb9f2e14e2.camel@huaweicloud.com>
References: <20250219162131.416719-1-zohar@linux.ibm.com>
	 <20250219162131.416719-3-zohar@linux.ibm.com>
	 <62e715f5ea0e901f7fd4185e996871eb9f2e14e2.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KdiB2otHp51H0no-fYsmKuX47syhW9IZ
X-Proofpoint-GUID: KdiB2otHp51H0no-fYsmKuX47syhW9IZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260149

Hi Roberto,

On Fri, 2025-02-21 at 18:36 +0100, Roberto Sassu wrote:
> On Wed, 2025-02-19 at 11:21 -0500, Mimi Zohar wrote:
> > Each time a file in policy, that is already opened for read, is opened
> > for write a Time-of-Measure-Time-of-Use (ToMToU) integrity violation
> > audit message is emitted and a violation record is added to the IMA
> > measurement list, even if a ToMToU violation has already been recorded.
> >=20
> > Limit the number of ToMToU integrity violations for an existing file
> > open for read.
> >=20
> > Note: The IMA_MUST_MEASURE atomic flag must be set from the reader side
> > based on policy.  This may result in a per open reader additional ToMTo=
U
> > violation.
>=20
> Probably the goal can be summarized as to limit emitting consecutive
> ToMToU violations.

Other audit messages and measurements could have been emitted, so they may =
not
be consecutive.

>=20
> In the previous patch, we are not emitting a new open_writers violation
> until all writers close the file. Here, it is a bit different, we are
> not emitting an additional ToMToU violation until there is another
> reader matching the policy. Maybe we should highlight this difference.
>=20
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> >  security/integrity/ima/ima_main.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima=
/ima_main.c
> > index cde3ae55d654..f1671799a11b 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -129,9 +129,10 @@ static void ima_rdwr_violation_check(struct file *=
file,
> >  		if (atomic_read(&inode->i_readcount) && IS_IMA(inode)) {
> >  			if (!iint)
> >  				iint =3D ima_iint_find(inode);
> > +
> >  			/* IMA_MEASURE is set from reader side */
> > -			if (iint && test_bit(IMA_MUST_MEASURE,
> > -						&iint->atomic_flags))
> > +			if (iint && test_and_clear_bit(IMA_MUST_MEASURE,
>=20
> Since IMA_MUST_MEASURE is only used for violations, what if we rename
> it to:
>=20
> IMA_TOMTOU_MAY_EMIT

How about naming the atomic flags as IMA_MAY_EMIT_TOMTOU and
IMA_EMIT_OPENWRITERS?

Mimi

