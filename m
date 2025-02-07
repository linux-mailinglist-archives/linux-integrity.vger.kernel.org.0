Return-Path: <linux-integrity+bounces-4757-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF88A2CD61
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2025 21:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D5493AABBA
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2025 20:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CA3195980;
	Fri,  7 Feb 2025 20:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n7hUQp3C"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD22187342;
	Fri,  7 Feb 2025 20:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738958563; cv=none; b=VvxHA+fkaVcFXdzdtt4pn8VeTVH4hn0NWCOakNUgdvo0ficCaqrsJMtUaOopbnwROPF4UHM0nlQPyfNGycmAfNM0XQmTROUAxdLtXlgj8UjZSMz02rhdVH/Jwmq0j+2qgB2UZ2P6We19WhMdD1fbCNpXFOHpkbiD6bEIqlAWjSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738958563; c=relaxed/simple;
	bh=9dk3rHUzSmTeWIRuA6b+JrU+vJEoo28SEvdU2FGvds0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jP16IB0ZgKGTppHpeXlNZaEoqJEJx7cCg9B7Vj+GaJYZi4dwUbn0QgQK3ymQrXNj7yj0u7TvwlJytzK+XdKyjTvKx7m7IDy7DgMujQau+nIf3dqY7bWZL38h5zhBKnbzdnr/QDHX7aP4NsEueHdgiKh8AmWQQsdpxgsOiC5Nl1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n7hUQp3C; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517BVFZ0027661;
	Fri, 7 Feb 2025 20:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HwHTFE
	VZI2gdyAGVCwWOpvvsHUwDlhYbFcodIx4JiyE=; b=n7hUQp3CPguOh8u/TiE4AS
	boNk9/TAZ8HmNOC/+ywlbl20+nnjyZbcKm8VW5l368+S5XRBfNOxY8LeMSNRrmuc
	4q5z696VhapOdfAWNpak8BxTmMusj+52CVqTxODgcDtVzdMIOX0XNUYe7LUSm+zZ
	ZkjlXzHYFWYDsUkMzdFeamdpvlFpqegoI5Z2vL30UH5wCZPudjaHRWJLicLeFCwf
	JM3Xcx+/AtzJBaLyEU3P1R4mPhZfpxsiosTU6B5ATiX6E8B3sQu186oDbV8+v3a7
	IW4BYB8ZfwQY4C4nNTt4KBficPgDb4LlqMpOdxSvWMKr/8d2x8J15RzkGQWi/PDA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44n910ct8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 20:02:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 517JlEpi024493;
	Fri, 7 Feb 2025 20:02:11 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxxnn7h5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 20:02:11 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 517K2Bdb22479392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Feb 2025 20:02:11 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 408205805C;
	Fri,  7 Feb 2025 20:02:11 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97DFA5805A;
	Fri,  7 Feb 2025 20:02:09 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.80.253])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Feb 2025 20:02:09 +0000 (GMT)
Message-ID: <861f5c51f4af46a4d731c632461b72c0045e577d.camel@linux.ibm.com>
Subject: Re: [PATCH v7 0/7] ima: kexec: measure events between kexec load
 and excute
From: Mimi Zohar <zohar@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com
Date: Fri, 07 Feb 2025 15:02:09 -0500
In-Reply-To: <b07a4b44-b76f-4691-ac01-6e91b6b83672@linux.microsoft.com>
References: <20250203184558.61367-1-chenste@linux.microsoft.com>
	 <eb2d3b5f-7aca-42c8-9b34-8ca07b8bc060@linux.microsoft.com>
	 <8091ed0d942806e16f995e8444da29df7843df62.camel@linux.ibm.com>
	 <b07a4b44-b76f-4691-ac01-6e91b6b83672@linux.microsoft.com>
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
X-Proofpoint-ORIG-GUID: R1EQDqADoagOynRo2WPA8TunqzRaMPbK
X-Proofpoint-GUID: R1EQDqADoagOynRo2WPA8TunqzRaMPbK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_09,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070150

On Mon, 2025-02-03 at 16:56 -0800, steven chen wrote:
> On 2/3/2025 4:50 PM, Mimi Zohar wrote:
> > On Mon, 2025-02-03 at 15:25 -0800, steven chen wrote:
> > > Hi all,
> > >=20
> > > The below is the correct version for review.
> > >=20
> > > [PATCH v7 0/7] ima: kexec: measure events between kexec load and excu=
te
> > > <
> > > https://lore.kernel.org/linux-integrity/20250203232033.64123-1-chenst=
e@linux.microso
> > > ft.com/T/#t>
> > >=20
> > > Please ignore the this version because patch 5 is missing.
> > >=20
> > > I am really sorry to have troubled you.
> > Thanks, Steven.=C2=A0 I was able to apply the patch set to v6.13.=C2=A0=
 For some reason, b4
> > downloads a duplicate 4/7 patch.
> >=20
> > Mimi
>=20
> Hi Mimi,
>=20
> Please use the one below
>=20
> [PATCH v7 0/7] ima: kexec: measure events between kexec load and excute=
=20
> <
> https://lore.kernel.org/linux-integrity/20250203232033.64123-1-chenste@li=
nux.microso
> ft.com/T/#t>
>=20
> Please ignore the this version because patch 5 is missing.
>=20
> I am really sorry.

No problem.  My point I was trying to make the other day was that I was abl=
e to apply
the NEW version of the patch set (even though b4 got confused), in order to=
 give a
heads up for anyone else trying to apply it.

new: b4 am -o /tmp 20250203232033.64123-1-chenste@linux.microsoft.com
old: b4 am -o /tmp 20250203184558.61367-1-chenste@linux.microsoft.com

Mimi

