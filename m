Return-Path: <linux-integrity+bounces-6610-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E05AF849B
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Jul 2025 01:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832AE1C8199C
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jul 2025 23:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DB72D4B53;
	Thu,  3 Jul 2025 23:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RWDC6zRN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322032DCBF8;
	Thu,  3 Jul 2025 23:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751587000; cv=none; b=kYZDXnsegVix8hZRuh5eP9WZ1MTv/5AzpuxXc5iaNwim8sv2g80/rMsq6pw9lkAIIc0dhOJaCc8RGHdSAn9gH3QJBDxarfibjLCj7n8Yh/xkAjHcqZgefTS3Nc3KehV/NL/ah13Tu6ff9q3jtpOr4C/yW4pRlvAUtvEqfOHAaZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751587000; c=relaxed/simple;
	bh=ExZBHsDj04AwmsSdr9VXgToQgmgAQT02DqFV2+lqnLQ=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=rOJPqBVwCniAA+w1NNEuZkn6oBbL7iNsThOoGlAHDhCYCVDwJAdBgW1h0GuT5EhJfUAv6YUGYXAI3KkjCvLliSmdd8hWGA/HmAKschrWz0MweNLjLT5sK/x6d/sZ35tcblgbiv7YT+vadGzd2jEOH7c3Xytc/2h+ojzCY0LfdyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RWDC6zRN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 563LIG8r019404;
	Thu, 3 Jul 2025 23:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rQyGx7
	n5L4RTYW8g4N5PU7Ra1hUF34LDY778PdcxfJI=; b=RWDC6zRNBqZcZ+s0oTTnxo
	34uYRvjVlRFEvlggk/IoVH/zPospErlW8vZy3P2dctW/9zkPGRF3BrWZ6S7yHHNC
	sbuTIb7DIWp6ApPTp/NFTVjw4yaSOFLH7j30X8nMePAOtkdb660d7MTZ2InCF1RZ
	rDo8IvRtNKvUZFWH2lHjL2npOnXTJvOeUuWraeJL8YIDTwGzFTGV7GBQI4lub0nm
	+Oq/u6NgpwuvrC3bQcuCn7LlaIIMcojHpAEEqIPvIbfokVVZ2GpDdj4fNkELI26/
	t624GDuLsX3PWh5OEmKh5pHD9RLlZcabnXzy6+Ir5H1p8VXggBr1wHznTkMUQh/w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j5ttpmkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 23:56:19 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 563NuJNi016770;
	Thu, 3 Jul 2025 23:56:19 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j5ttpmkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 23:56:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 563LUt5k011873;
	Thu, 3 Jul 2025 23:56:18 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47jv7n79qn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 23:56:18 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 563NuHg031392466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Jul 2025 23:56:17 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EE505805A;
	Thu,  3 Jul 2025 23:56:17 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA4F958051;
	Thu,  3 Jul 2025 23:56:16 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.109.107])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Jul 2025 23:56:16 +0000 (GMT)
Message-ID: <45b30f515efc3e364e1d248ab0ed7f12f8312f5d.camel@linux.ibm.com>
Subject: Re: [PATCH] Revert "integrity: Do not load MOK and MOKx when
 secure boot be disabled"
From: Mimi Zohar <zohar@linux.ibm.com>
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
        Roberto Sassu	
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"	 <serge@hallyn.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Lee,
 Chun-Yi" <joeyli.kernel@gmail.com>
In-Reply-To: <aGZ_x8Ar6iwzt2zV@gardel-login>
References: <Z9wDxeRQPhTi1EIS@gardel-login>
	 <1a6cf2097487816e4b93890ad760f18fe750bd70.camel@linux.ibm.com>
	 <aGYurikYK1ManAp3@gardel-login>
	 <8401c23009db3b8447b0b06710b37b1585a081ab.camel@linux.ibm.com>
	 <aGZ_x8Ar6iwzt2zV@gardel-login>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Jul 2025 19:56:16 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ngv24GXPO1hQcMU7BUj9Fb_EXtXmvAc7
X-Authority-Analysis: v=2.4 cv=UtNjN/wB c=1 sm=1 tr=0 ts=686718a3 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=OVBXMk3rAAAA:8 a=lb4k8tyOFZTsDB4Z8wgA:9 a=QEXdDO2ut3YA:10
 a=FyXiZ670jEa15epue5As:22
X-Proofpoint-ORIG-GUID: rsShTHBCxf8qs8jvCzd37yD3HlhGQRk8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDE5NSBTYWx0ZWRfXxoWODegZ4yWK mXb3e3oBisS+cy5Dy68F9qpsWRtJIMcw9H4efaW2DUY8JEx/Fctx+qNIG6xkrvHWSqumckTprKG nADeIycRH4NGLH6DdbBjPFgya2Ey5nC+aE+Ks7OJMzqGm5aLw8GAofQvyVAaYn5aJmGk+rsHkMk
 L9z+GXuB56NqLkK7AG++bWdU8naMWKWmVpe5znuU7VIx34wJtfdb51GMESWQ6WBByKJEh61CNCc PSuMeL7VdFe2I/KcBlO6atji49j4trusozBPOviEPiiulD5zOGYgsUErvoT/p6fBxSQpUx5/0PS TUnhSVejFaBBHh4/7UMJK7RjmUUnYMC6GHrxNe+lm2IvSXS6n1Hw2Qo8Rk2qFzecsoGaDE5PSTd
 E8mVY5INJyrgttNAlnjHKcR/gTbLFszExbQfsDUgW2ChEKnotdT7RnY/fyByZhpj1R2A5apq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_06,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030195

On Thu, 2025-07-03 at 15:04 +0200, Lennart Poettering wrote:
[ ... ]
> The thing is that if SB is off, then all bets are off, it's really
> pointless in assuming the kernel image had any trust left you'd need
> to protect. That's just *not* the case. Where do you think that trust
> should come from?
>=20
> If SB is off, then anything that got loaded early enough could just
> patch arbitrary keys into the ELF image of the kernel before starting
> it, and everything will look perfect later on, because the image is
> not authenticated after all via SB. So there *already* is a way into
> the kernel keyring with this =E2=80=93 it's just really messy to parse an=
d
> patch ELF at runtime like this from the bootloader. My hope with just
> relaxing the rules on MOK keys when SB is off is to just make this
> stuff cleaner and more elegant (and also to leave the ELF image intact
> so that we get clean measurements, both of the kernel and of the keys
> we add).
>=20
> > > i.e. there is a concious decision in place that there is no trust
> > > chain, and that the firmware *happily* *already* accepts unsigned boo=
t
> > > loaders/kernels and just runs with them. If SecureBoot is already off=
,
> > > then an attacker can patch around in the kernel invoked at boot
> > > completely freely anyway, there is *no* authentication done. Hence
> > > it's really weird to then insist that the path into the kernel keyrin=
g
> > > via mok keys is off in *only* this case, because an attacker can get
> > > into that anyway in this case, it's just a lot more cumbersome.
> > >=20
> > > It's really strange that currently when people ask for tight security
> > > (i.e. SB on) the linux kernel is super relaxed and allows any keys to
> > > be inserted, but if people ask for security checks to be off (i.e. SB
> > > off) the kernel starts being super strict and doesn't allow any keys
> > > to propagate into mok. That's really confusing and contradictory, no?
> >=20
> > That all may be true, but you're ignoring what I said about only "trust=
ing" MOK
> > in certain situations.  If you have another safer, better mechanism for
> > establishing a new root of trust for keys (e.g. TPM), then by all means=
 share it
> > and we can make additional exceptions.
>=20
> Yes, we have that in systemd: there's local attestation in place
> already in systemd via the "systemd-pcrlock" feature. i.e. the idea is
> that the disk encryption keys are only released to the OS if the
> measurements of the boot phase match some golden measurements. This is
> in a way a reasonable alternative (or addition) to SecureBoot: instead of
> prohibiting code to run if it doesn't carry a signature of some
> trusted key, you let it all run, but then later on you refuse to give
> it the disk encryptions keys =E2=80=93 the keys to the kingdom =E2=80=93 =
unless the
> measurements all along the way match what you expect them to be. This
> protects the OS quite nicely, and makes SB to some level optional, as
> we basically enforce security "a-posteriori" rather than "a-priori" =E2=
=80=93 by
> means of the TPM's key policies.
>=20
> Now you might wonder: if we have such local attestation policies, why
> do we *also* want to get keys into the kernel keyring? That's because
> the attestation policies are checked (primarily) when FDE is unlocked,
> so that's our security boundary, our milestone where eveything
> *before* is protected via attestation, but which cannot protect
> anything *after*. In my model we then want to protect
> any further resources via the kernel keyring then. hence it matters to
> us to have a clean, elegant way, to insert keys *before* that
> milestone that then can protect resources comeing *after* it.
>=20
> Why do I want to avoid SB at all for these setups? Mostly, because
> it's a bureacractic effort to get your keys intot he Microsoft
> keyring, and if you do get them there, then their security value is
> kinda weak anyway, because the allowlist that the keyring is is such
> an extremely wide net, it's at best a denylist of bad stuff rather
> than an allowlist of good stuff at this point. It's kinda undemocratic
> too. But anyway, the pros and cons of SB are another discussion. I am
> primarily interested in making it optional, so that you can get
> security with SB and without SB, because you always have someting to
> protect the boot, and always something that protects the rest.

You're basically relying on trusted/verified boot and, in TPM 1.2 terminolo=
gy,
sealing a key to a TPM PCR value.  Only if the PCR matches an expected valu=
e is
the key released.  Instead of relying on MOK, the keys could be stored in t=
he
TPM NVRAM and loaded onto the existing .machine keyring or define a new key=
ring
linked to the .secondary_trusted_keys keyring[1].  Then you could really cl=
aim
the TPM as a new root of trust for both trusted and secure boot without any
dependency on MOK.
                                                                           =
    =20
That would be preferable to changing the existing expectations to loading t=
he
MOK keys when secure boot is not enabled.       =20
                                                                           =
    =20
[1] A prior attempt to load keys from TPM NVRAM.                           =
   =20
https://lore.kernel.org/linux-integrity/20210225203229.363302-1-patrick@pui=
terwijk.org/

Mimi


