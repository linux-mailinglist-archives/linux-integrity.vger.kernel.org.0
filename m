Return-Path: <linux-integrity+bounces-3297-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C98C949D59
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Aug 2024 03:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E331F2296D
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Aug 2024 01:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11E81D6AA;
	Wed,  7 Aug 2024 01:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aUoBESlx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3C12209B;
	Wed,  7 Aug 2024 01:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722993932; cv=none; b=F30gMoUw+x1DqVxfPGu1UFVaz1kNzq0t96kURIqRB+MzU5oQBW1tXV/I3n1mCGWyei5lCASPHKv6hnoDfHBduAai8RU0m1H1rpJg7AG+EMO01uqiB9sDoc417E7IOL4b+bvTNT4C+ParnSOUONUv+CulifqPj7pu+n8EiY1exsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722993932; c=relaxed/simple;
	bh=RdmmaJIN/niCBudzuwUJhi0XTYmYEaNyimnVbmm6W3s=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=MfZjd2C+j61dGPbLI3OcWWWvwZISE+2QAZUqcVIk8ykvRn0rA0u/3XWG0HPFCb/65jBjE/y8/euSolIQvum7cDfYcP7hbNaM4fwQL6BeEdHkMnaQbweovsgdPvCNpE0jNTrEVLQWQ/xlEQxvwTd0xF805/1Msiuky675vTjxh1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aUoBESlx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4771MgHK019254;
	Wed, 7 Aug 2024 01:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:in-reply-to:references
	:content-type:date:content-transfer-encoding:mime-version; s=
	pp1; bh=fw4+UNUefHB/ppv2FvnlJCX7lVBHlTTo++OcFFVaQxY=; b=aUoBESlx
	iCVNMXTH44jMzaA+lHLZUZPvlTdSC2YMxAtc855YqD21moGPPnirkTKLl+FUsLTd
	vpNdmWVfTeoMbXbHJNY6tRyCeQWXf7Bb6Hz1pPPRxDLF+TE/BjHJzk+98ItrvI6N
	KPMNbsCnsHtH94s99+hn0Mc6x/63c7RvTTkrtX8hy2wccScO+BnhqVKvN6LqfERI
	EVMtqu40vURz0oPHT6gCA/I1gsX1CoY2jZCZc4npPB7JTlw6LKf7klUPD815dcHi
	E7ky6E36q4n3D5vVCNP1jtf5ap7nLBWmZ0Af6RZCtzjzLPNMlwA284ft91tjoAHw
	dPBjERzU9lyx1g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40uk02hkm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 01:24:59 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4771OwS7022695;
	Wed, 7 Aug 2024 01:24:58 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40uk02hkky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 01:24:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 476M31fc024322;
	Wed, 7 Aug 2024 01:24:57 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40sy90prfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 01:24:57 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4771OtOU11600506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Aug 2024 01:24:57 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DC2A58066;
	Wed,  7 Aug 2024 01:24:55 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8120A58054;
	Wed,  7 Aug 2024 01:24:54 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.166.93])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Aug 2024 01:24:54 +0000 (GMT)
Message-ID: <80af3c293db64365bdadbec122c37de7194fbf51.camel@linux.ibm.com>
Subject: Re: [RFC] integrity: wait for completion of i2c initialization
 using late_initcall_sync()
From: Mimi Zohar <zohar@linux.ibm.com>
To: Romain Naour <romain.naour@smile.fr>, Paul Menzel
 <pmenzel@molgen.mpg.de>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        serge@hallyn.com, jmorris@namei.org, paul@paul-moore.com,
        eric.snowberg@oracle.com, dmitry.kasatkin@gmail.com,
        roberto.sassu@huawei.com, Romain Naour <romain.naour@skf.com>
In-Reply-To: <785b9c89-a9a6-427d-8715-110cb638b645@smile.fr>
References: <20240701133814.641662-1-romain.naour@smile.fr>
	 <c090cd3c-f4c6-4923-a9fa-b54768ca2a26@molgen.mpg.de>
	 <d7429218-7b48-4201-8ad9-63728e188be5@smile.fr>
	 <e197920f27bc67df45327ef56ee509d113435b25.camel@linux.ibm.com>
	 <b551f01f52d5cefea3992f6c75baa0683ed57ac9.camel@linux.ibm.com>
	 <785b9c89-a9a6-427d-8715-110cb638b645@smile.fr>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 06 Aug 2024 20:41:22 -0400
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DhmVbBoBCYMdNP3J7E0tbmgGZlAV5H3j
X-Proofpoint-ORIG-GUID: DrPq6rqg9KKvAYz5LY2WR61b6OYgDctj
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_20,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1011 mlxscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408070007

On Thu, 2024-08-01 at 12:12 +0200, Romain Naour wrote:
> Hi Mimi,
>=20
> Le 11/07/2024 =C3=A0 16:06, Mimi Zohar a =C3=A9crit=C2=A0:
> > On Mon, 2024-07-01 at 22:37 -0400, Mimi Zohar wrote:
> > > Hi Romain,
> > >=20
> > > Please limit the subject line to 70 - 75 characters.
> > >=20
> > >=20
> > > On Mon, 2024-07-01 at 16:58 +0200, Romain Naour wrote:
> > > > > > [1]
> > > > > > https://lore.kernel.org/linux-integrity/9b98d912-ba78-402c-a5c8=
-154bef8794f7@smile.fr/
> > > > > > [2]
> > > > > > https://e2e.ti.com/support/processors-group/processors/f/proces=
sors-forum/1375425/tda4vm-ima-vs-tpm-builtin-driver-boot-order
> > > > > >=20
> > > > > > Signed-off-by: Romain Naour <romain.naour@skf.com>
> > > > >=20
> > > > > Should this get a Fixes: tag and be also applied to the stable se=
ries?
> > > >=20
> > > > The current behavior can be reproduced on any released kernel (at l=
east since
> > > > 6.1). But I'm not sure if it should be backported to stable kernels=
 since it
> > > > delays the ima/evm initialization at runtime.
> > >=20
> > > With the IMA builtin measurement policy specified on the boot command=
 line
> > > ("ima_policy=3Dtcb"), moving init_ima from the late_initcall() to
> > > late_initcall_sync() affects the measurement list order.  It's unlike=
ly, but
> > > possible, that someone is sealing the TPM to PCR-10.  It's probably n=
ot a good
> > > idea to backport the change.
> > >=20
> > > An alternative would be to continue using the late_initcall(), but re=
try on
> > > failure, instead of going directly into TPM-bypass mode.
>=20
> Indeed, it would be better if the IMA (and EVM) can use something like EP=
ROBE_DEFER.

Yes, "something like EPROBE_DEFER" sounds like the right direction.  Depend=
ing
on the environment, the TPM initialization delay might be acceptable and not
introduce an integrity gap.

For now let's start with just late_initcall() and late_initcall_sync().  If=
 the
TPM hasn't been initialized, not all of ima_init() needs to be deferred to
late_initcall_sync().

>=20
> > >=20
> > > As far as I can tell, everything is still being measured and verified=
, but more
> > > testing is required.
>=20
> Agree, I'm still evaluating the TPM stack when time allows.
>=20
> >=20
> > Romain, Paul, another report of IMA going into TPM-bypass mode is here:=
=20
> > https://github.com/raspberrypi/linux/issues/6217.  Deferring IMA initia=
lization
> > to late_initcall_sync() did not resolve the problem for them.  Please t=
ake a
> > look at the report.
>=20
> I don't think that the "mdelay(200)" is really needed when late_initcall_=
sync()
> is used. I guess the issue was the spi driver was not builtin, fixed by:
>=20
> CONFIG_SPI_DESIGNWARE=3Dy
> CONFIG_SPI_DW_MMIO=3Dy

Good to know.

thanks,

Mimi

