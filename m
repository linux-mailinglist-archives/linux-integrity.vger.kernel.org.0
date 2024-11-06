Return-Path: <linux-integrity+bounces-4041-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A4D9BFA7A
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 00:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4B951C20C72
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2024 23:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FE520E003;
	Wed,  6 Nov 2024 23:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qzHCzTJB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361A420D4FE;
	Wed,  6 Nov 2024 23:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730937188; cv=none; b=JBfpruE0tw4cIvJ2ruG/sapk62CoDB5uyNDnKWjhPce7UFbk8adLku3dXz6o1hETD5UjjLE1HMBbP8ac4AzUqklmS/XZsqCZA3bpCDt+7YlLNbqTjcnay7VqPYH0Gu6kDuANBIopBOni3K3DS9Zfo5OJkOtmYflS1VC4CL7Vu5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730937188; c=relaxed/simple;
	bh=JND/4bPkGje8KY3p1TNkBlusp1UL8Yv8fKJsDctQP6U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fVvCobbCJyGfEsPQZHfMVg1/98FeWL31ng7D1lIy9VNHvPwUOBD5LLOw9LqSJ4VrPne0xNA2alIfH6IgOmOZH3g0uxKR8Fyud/jW4sZiyeEDJwUWMjnmAKoFLA5DSom8PV5QEfMit2pfa9dh7hMJFQQRPSSNqQ40bJjkJtLsCjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qzHCzTJB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6MeOnJ016836;
	Wed, 6 Nov 2024 23:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vFgfjO
	a+uZRBLj86R7LfiIxkjpN/jIWuMVxEu/006NA=; b=qzHCzTJBePeAhtc90wLv+7
	COPvHVRSB3YImy8gv5y6Funz9C4IeFm3jCOG+4sL5daalhM8bguLbK0xFmC0aMnT
	vXMgiNNAuZ/YCWYTQUXyZxb2MTxT3NtL9odsl2VMgDGSsdC51ViWvIhSgSvTDRxI
	/qG4jjdy/v7weMDa+Z6y/i7QZcxs97fcu8/0qqjGOxhGakBfNCuqHc8Ea81b5IPx
	vY55OTWuuYjoCCHn5gjf+l0ECvfLB/dHqIsCCKDIN2yHdHx9PDW2Sj0LPU5sMk8g
	67LnzPgzZaVz2PM2wjal7eX0Cu7c0dqBNIsFr+VyGJkhcQyP//vYkaCSBqqwAiaw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rhevraq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 23:52:54 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A6Nqr6J027510;
	Wed, 6 Nov 2024 23:52:53 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rhevrapw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 23:52:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6MvFN3023916;
	Wed, 6 Nov 2024 23:52:52 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nxsys1bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 23:52:52 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A6NqpM358655200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Nov 2024 23:52:51 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C488C58062;
	Wed,  6 Nov 2024 23:52:51 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FF8D58056;
	Wed,  6 Nov 2024 23:52:51 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.138.65])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Nov 2024 23:52:51 +0000 (GMT)
Message-ID: <84fcb3e29f3aa1ea7a5b638307e500608bc8b11a.camel@linux.ibm.com>
Subject: Re: [RFC PATCH] tpm: Allow the TPM2 pcr_extend HMAC capability to
 be disabled on boot
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley
	 <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc: roberto.sassu@huawei.com, mapengyu@gmail.com,
        Paul Moore
 <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        christian@heusel.eu
Date: Wed, 06 Nov 2024 18:52:50 -0500
In-Reply-To: <D5FHDIMJBWQM.2GWFOR0198360@kernel.org>
References: <20241015193916.59964-1-zohar@linux.ibm.com>
	 <D5FG6TOVUY5W.3SUG1J3CDB3J5@kernel.org>
	 <321b247dcfaba5d9691919eec8476b3c6fc7875d.camel@HansenPartnership.com>
	 <D5FHDIMJBWQM.2GWFOR0198360@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZyKI6CiWdxsbpLpqk6UpmfrbVuuDvfSM
X-Proofpoint-ORIG-GUID: of5xsuYIfBiswZgb59w5Q1JZAbbqT11f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 mlxlogscore=535 priorityscore=1501 lowpriorityscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060182

On Thu, 2024-11-07 at 01:22 +0200, Jarkko Sakkinen wrote:
> On Thu Nov 7, 2024 at 12:52 AM EET, James Bottomley wrote:
> >=20
> > I'm a bit confused here.  It's TPM2_PCR_Extend we have the trouble with
> > (as Mimi says in her email that you quoted) not TPM2_GetRandom.
> >=20
> > The random number generator reseed occurs in a kernel thread that fires
> > about once a minute, so it doesn't show up in really any of the boot
> > timings.  Plus even with sessions added, what there now isn't a
> > significant overhead even to the running kernel given it's asynchronous
> > and called infrequently.
>=20
> Ah, right then we need the boot flag, and my earlier comments to the
> parameter apply. I've never used IMA so I don't actually even know in
> detail how it is using TPM.

Huh?  A simple explanation is that IMA-measurement maintains a measurement =
list,
similar to the pre-boot event log.  Each IMA-measurement record extends the=
 TPM
PCR (default PCR 10).

Assuming IMA is enabled in the kernel, then just add "ima_policy=3Dtcb" or
"ima_policy=3Dcritical_data" on the boot command line.  To view the measure=
ment
records, cat <securityfs>/integrity/ima/ascii_runtime_measurements.  Normal=
ly
the IMA policy specified on the boot command line is replaced with a finer
grained custom policy.

Mimi


