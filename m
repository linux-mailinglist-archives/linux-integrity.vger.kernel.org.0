Return-Path: <linux-integrity+bounces-4046-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF55D9BFB25
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 02:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7708D283536
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 01:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E99228F4;
	Thu,  7 Nov 2024 01:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lWkVUr3c"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61E04431;
	Thu,  7 Nov 2024 01:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730941673; cv=none; b=aJmeVDyB7B/RJ+wMbuObxS+F1cJ08QX5edR1uHgkZhGhKxufwsa/QNtBXtYw+BHmqc4vSMAzNqhsmaU3yXvfhnaEhVH6pvg02V8Clri1qFYz/nPQsVa3lA0Y2Lwz3h7YW6F997EOO5znyS1nvcN4kscw/7CLm2qFTahrmSVBlL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730941673; c=relaxed/simple;
	bh=cEm6dhdi2r1OOLMEUXpi5UYBnR/MqEHjLO4oj+hVfNU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J8giKddy7ZJ96izdWYPrhyGHCEG80MKhkPLhN+RvLiieCVusFUmPtjY49Z49UToaMdXA+FOgVGKPuBunRIy3aq7ZKVNEdgi+9wyB4JYpCgUiiH2GmnjvYKSWv2+/Nunh2P6qpyGGqkvcaTVtJc6U0mMFUXx3a0f2wuuI9azTmng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lWkVUr3c; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A70echc001288;
	Thu, 7 Nov 2024 01:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=grtinK
	EFdtZSbNRI9C9F7GDhrgR9M/KBXZ9TV5Ssw2U=; b=lWkVUr3cvmRPGUVjf8+IlE
	9m1PCdLTk/8tpxQu24S/GzgQ4Y2wis1oThOw9LHn6Ue1gH7DqI9JL3w9+fEaiy8S
	gF5Rnw6EZZUFrchIb5QFuLnNon3fFalFRj0ZnT90kZrc2YN26i2ilWFuuqU4lVZA
	1oq7fZosN0nbWQYihvRqHproyBhSFiL0n29Dy+OKqs9hTZKB2M3cGrjV3RAzZZlb
	ms1Jikua/sApBz8bT6OzR94czcCKvi5FX0BxHmNv2fOaHuvRb9bNX9B+myCAy/WP
	emPJ7oX8GgwUZFTyrRzSNI8P6foTL4q6gYPOaL0yIBzSyKtV9LzSHX8LzQdilgqQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rk7903fv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 01:07:28 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A717SYs020928;
	Thu, 7 Nov 2024 01:07:28 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rk7903fs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 01:07:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6N6qkP023919;
	Thu, 7 Nov 2024 01:07:27 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nxsysjkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 01:07:27 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A717QoF21692686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2024 01:07:27 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B25FC58059;
	Thu,  7 Nov 2024 01:07:26 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22FFB58058;
	Thu,  7 Nov 2024 01:07:26 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.138.65])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Nov 2024 01:07:26 +0000 (GMT)
Message-ID: <0bca8c26693d28093a1cf4dd2df1dcc985cbf252.camel@linux.ibm.com>
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
        christian@heusel.eu, Ken Goldman <kgold@linux.ibm.com>
Date: Wed, 06 Nov 2024 20:07:25 -0500
In-Reply-To: <D5FI94F98BS0.2JMJGMV9W5GBC@kernel.org>
References: <20241015193916.59964-1-zohar@linux.ibm.com>
	 <D5FG6TOVUY5W.3SUG1J3CDB3J5@kernel.org>
	 <321b247dcfaba5d9691919eec8476b3c6fc7875d.camel@HansenPartnership.com>
	 <D5FHDIMJBWQM.2GWFOR0198360@kernel.org>
	 <84fcb3e29f3aa1ea7a5b638307e500608bc8b11a.camel@linux.ibm.com>
	 <D5FI94F98BS0.2JMJGMV9W5GBC@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AHdQnPnao0VhTdBQzq6TbNFBfQDbMCda
X-Proofpoint-ORIG-GUID: Qe6DJKljlHkgUJGAzQ-ykl64aueFIQwG
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070006

On Thu, 2024-11-07 at 02:03 +0200, Jarkko Sakkinen wrote:
> On Thu Nov 7, 2024 at 1:52 AM EET, Mimi Zohar wrote:
> > On Thu, 2024-11-07 at 01:22 +0200, Jarkko Sakkinen wrote:
> > > On Thu Nov 7, 2024 at 12:52 AM EET, James Bottomley wrote:
> > > >=20
> > > > I'm a bit confused here.  It's TPM2_PCR_Extend we have the trouble =
with
> > > > (as Mimi says in her email that you quoted) not TPM2_GetRandom.
> > > >=20
> > > > The random number generator reseed occurs in a kernel thread that f=
ires
> > > > about once a minute, so it doesn't show up in really any of the boot
> > > > timings.  Plus even with sessions added, what there now isn't a
> > > > significant overhead even to the running kernel given it's asynchro=
nous
> > > > and called infrequently.
> > >=20
> > > Ah, right then we need the boot flag, and my earlier comments to the
> > > parameter apply. I've never used IMA so I don't actually even know in
> > > detail how it is using TPM.
> >=20
> > Huh?  A simple explanation is that IMA-measurement maintains a measurem=
ent list,
> > similar to the pre-boot event log.  Each IMA-measurement record extends=
 the TPM
> > PCR (default PCR 10).
> >=20
> > Assuming IMA is enabled in the kernel, then just add "ima_policy=3Dtcb"=
 or
> > "ima_policy=3Dcritical_data" on the boot command line.  To view the mea=
surement
> > records, cat <securityfs>/integrity/ima/ascii_runtime_measurements.  No=
rmally
> > the IMA policy specified on the boot command line is replaced with a fi=
ner
> > grained custom policy.
>=20
> I'll try to figure out how to test it regularly. And yeah we need the
> flag obviously.
>=20
> I have my (CI compatible) framework that I run regularly with upstream
> that I've mentioned a few times earlier.
>=20
> https://codeberg.org/jarkko/linux-tpmdd-test
>=20
> How would I would make all files in /etc get to get the checksums, and
> how can I generate legit and illegit change to some file in that tree?
>=20
> No need to address how to implement that to my framework, I can figure
> that out. I just would love throw something so that any performance
> regressions will be catched right at the get go, i.e. before they
> end up to the mainline.

Yes, I still need to look at it.  FYI, the IMA policy cannot be defined in =
terms
of pathnames.  For testing, we've been loopback mounting a filesystem and
defining policy rules based on the UUID of the filesystem.  If you're using
SELinux, then rules can be defined in terms of SELinux labels. There are ot=
her
methods of identifying files.  Ken's been working on new IMA documentation[=
1],
which can be viewed here
https://ima-doc.readthedocs.io/en/latest/ima-concepts.html .

Here are some examples as to how to locally verify the IMA measurement list=
 and
the boot aggregate.

1. To locally verify the IMA measurement list matches TPM PCR-10, use evmctl
(ima-evm-utils).  For example,

a. An IMA measurement list without integrity violations
(/sys/kernel/security/ima/violations)

evmctl ima_measurement /sys/kernel/security/ima/binary_runtime_measurements

b. An IMA measurement list with integrity violations

evmctl ima_measurement --ignore-violations
/sys/kernel/security/ima/binary_runtime_measurements

2. To locally verify the 'boot_aggregate' record, the first record in the I=
MA
measurement list, use "evmctl ima_boot_aggregate -v" and compare the result=
ing
hash with the one in the boot_aggregate record.
 =20
[1] https://github.com/linux-integrity/ima-doc
[2] https://github.com/linux-integrity/ima-evm-utils/tree/next-testing/

Mimi

