Return-Path: <linux-integrity+bounces-5444-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31653A7196D
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 15:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65E231885DC0
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 14:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548211DEFD7;
	Wed, 26 Mar 2025 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rzvUdXHd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959681F17E8;
	Wed, 26 Mar 2025 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000503; cv=none; b=GfHUDBqjDfY1XAY/HeCaBOoa4WeRpaqiE12x4eNhjmaRLf2ImBVeIKzPrwDu5IWoJdnqCqqLDTHT6f9sr6SEqNYYOJpoO5B5KSsjUut16Srev1bNBKKsOSkfVtDv+zZ719BuQ1i/OQc3ZVKLjIQfZ2LD516dquGU5yTZYMTATm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000503; c=relaxed/simple;
	bh=UAEk/9kPjvmga7GcKmw9nqNKziWIzKa6VIdrotiYH1Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WIA87rseTzqH4uG7tX14Imkyc4SkFhAM//RheGSkF/6RHqqGWkVvMH6hDJZ2HjEndLN9Hck+PXiuTnNKxaId9dHnRVfeVKkH2NsPJ0UqzcauRZFm4dYRgIm28akh0gaf1BJhPL1rLuT35azLDIAEhiWdrLEz1TmVHQTVxyyRrxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rzvUdXHd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QC54MX027698;
	Wed, 26 Mar 2025 14:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ra3A8m
	93pQeCibvdnnrnUW2lYYCiD9gyKANCUrrYnd4=; b=rzvUdXHdZYW3ij3j5uSmJJ
	JHB6vAdmcXjefkYQyhAiR1gNhH25z+9O0Rr2UuChClLwUMHbmaCruylVa+NVkt+y
	SLiYd5Eyu6Nyxp8awe76V6qWmkrwKSveHCSPgn2KvfmPxYbXxqNTNfbmJ6RjNPaT
	CY0MYHkYmvtIbwa/MDYBVC8HkySZOTbo9DAr0FCRLTzX9p2Vt9s18yFimJhIypkg
	VeNsvT210FOXmHieH3+KOzXqklff9DF/gE7+tQC4Vv2R4hvytRzvCQuBH5hSRbFr
	3OPWW3hVzLYWZjThQV3LZHAszgb3NncE5bBRzeDFUeGif+d8Iurp/nXZRcCeJL/Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kbjx3h12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 14:48:04 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52QElRYA028748;
	Wed, 26 Mar 2025 14:48:03 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kbjx3h0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 14:48:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52QEjtUf020639;
	Wed, 26 Mar 2025 14:48:02 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j8hp0s9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 14:48:02 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52QEm2Q929557450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 14:48:02 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B46758065;
	Wed, 26 Mar 2025 14:48:02 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DAB358056;
	Wed, 26 Mar 2025 14:48:01 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.116.195])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Mar 2025 14:48:01 +0000 (GMT)
Message-ID: <4efc3cd7521eb1aef435af2b02a9a112f049c0f2.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v2 02/13] ima: always create runtime_measurements
 sysfs file for ima_hash
From: Mimi Zohar <zohar@linux.ibm.com>
To: Nicolai Stange <nstange@suse.de>
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley
 <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Wed, 26 Mar 2025 10:48:01 -0400
In-Reply-To: <87wmcboqg4.fsf@>
References: <20250323140911.226137-1-nstange@suse.de>
	 <20250323140911.226137-3-nstange@suse.de>
	 <35d199c2a09e9215aad715c97a6702dd04be4a98.camel@linux.ibm.com>
	 <fbd87f01b5463e399900df8dcb094a9039bd589f.camel@linux.ibm.com>
	 <87wmcboqg4.fsf@>
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
X-Proofpoint-GUID: 5zsxOVmxvPCqrxxr9yrGke_BeyLFpOQa
X-Proofpoint-ORIG-GUID: JcTprj394txHKd6TmrZrvg7pEjc3SURu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_07,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503260088

On Wed, 2025-03-26 at 14:46 +0100, Nicolai Stange wrote:
> Mimi Zohar <zohar@linux.ibm.com> writes:
>=20
> > On Wed, 2025-03-26 at 09:21 +0100, Nicolai Stange wrote:
> > > Mimi Zohar <zohar@linux.ibm.com> writes:
> > >=20
> > > > On Sun, 2025-03-23 at 15:09 +0100, Nicolai Stange wrote:
>=20
> > > > "ima_hash" is the default file hash algorithm.  Re-using it as the =
default
> > > > complete measurement list assumes that the subsequent kexec'ed kern=
els configure
> > > > and define it as the default file hash algorithm as well, which mig=
ht not be the
> > > > case.
> > >=20
> > > I don't really see why the ima_hashes would have to match between kex=
ecs
> > > for this to work -- all events' template hashes are getting recreated
> > > from scratch anyway after kexec (ima_restore_measurement_list() ->
> > > ima_calc_field_array_hash()).
> > >=20
> > > That is, if ima_hash=3Dsha256 first, and ima_hash=3Dsha384 after kexe=
c, one
> > > would have *runtime_measurements_sha256 first and
> > > *runtime_measurements_sha384 after kexec. And both had exclusively
> > > template hashes of their respective algo in them each.
> > >=20
> > > What am I missing?
> >=20
> > Your solution would work nicely, if the "ima_hash" algorithm could be g=
uaranteed
> > to be built into the kernel.  It's highly unlikely someone would choose=
 a hash
> > algorithm not built into kernel, but it is possible.  hash_setup() only=
 verifies
> > that the hash algorithm is a valid name.
>=20
> But ima_init_ima_crypto(), hence the whole IMA __init, would fail if
> ima_hash was unavailable at __init time?

Thanks for pointing that out!  Now I understand why just selecting SHA256 i=
s
sufficient.

Mimi

>=20
> > Either fix hash_setup() to guarantee that the chosen hash algorithm is =
built
> > into the kernel or use the CONFIG_IMA_DEFAULT_HASH and add a Kconfig to=
 select
> > the hash algorithm.  This would be in lieu of v2 05/13.
> >=20
> > > > Drop this patch.
> > >=20
> > > Fine by me, but just to confirm, in case there's no TPM attached and
> > > SHA1 was disabled, there would be no /sys/*/*runtime_measurement* at =
all
> > > then. Is that Ok?
> >=20
> > Of course not.  :)
> >=20
> > > ima_hash was chosen here only, because after this series, it will be =
the
> > > only single algorithm guaranteed to be available.
> >=20
> > With the proposed changes to "[RFC PATCH v2 05/13] ima: select CRYPTO_S=
HA256
> > from Kconfig', SHA256 would be added to the "extra" measurements if the=
 TPM
> > SHA256 bank is disabled.
>=20
>=20


