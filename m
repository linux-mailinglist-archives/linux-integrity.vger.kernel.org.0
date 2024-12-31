Return-Path: <linux-integrity+bounces-4505-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C739FF044
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Dec 2024 16:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13D9162019
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Dec 2024 15:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B15A13CFA6;
	Tue, 31 Dec 2024 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tI7XEuvi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62C116426
	for <linux-integrity@vger.kernel.org>; Tue, 31 Dec 2024 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735659303; cv=none; b=gvCgyJYPl8noNHYX8DI2cPfDgPfkuUiJbeH/iehTe2KoAT1au4PHiSi4DMEvR9DCrP21uIvFelgqWwpGaLzlvKJjHb3BWPUlUpEhskcqsVRnRK5LWuXM1lQS9paot4R/nGxoxytjlFcmy60XoeDrAz6aN1GeNJYnv7rJJVrvGOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735659303; c=relaxed/simple;
	bh=SouRUdFZmik0fOWO+12bXf/9+NwyZsCBf01ItVbVd1Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GwINcwUFgGNn+apCdUi3ojZbTYhika5FPBSy3Z5Hrd6XtPF4G8xu3L3r7FzswhMzJC7zdVf4o3oXFATQ1guwcpWNuSZhGr9d5WA45JT5fj5yn9J4q3oq5JBNFgUN2TsmqLzY21mQ3D9u2y+rQGXGxCn6xpFvJDkkNFmravNlcqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tI7XEuvi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BVDsa6S023925;
	Tue, 31 Dec 2024 15:34:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=i1cBYH
	5xlzEU5fJYZjpYPeKUOmLzPrw9bC4DSmBNu5Y=; b=tI7XEuviwOnpXZvyig3Wjd
	nSop4kLWCkpaL2/FGUuAOsvNSxUMMmPeZYvV6x4+bvr1QBJlBJpjsdk+KY+I0j4c
	cLN/B+3VLSZ3GIrKhydQWcHqrZtjbRF0p+yYy/IldwxCuT8v2f+GevHV6vQFhmBO
	Vm5IPPPIPpjSS5qICijXN0/uj5A99koVpihexsjlgIwCZmONhdSxIkv6w2BNjJaF
	8GlMQAAU2iHKSAYwXH3nbvGVlmg06jMb3lzsDP3aj/Ppo6IA/gAyrgQF6W52JPnN
	iCzEAzq+FDSdSjIohLVqNjaN/x0nyFLcE0n+OcsRjuOdVqM1x0EDIklHpkVuJvGw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43v5nhakpv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Dec 2024 15:34:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BVE54Yu014564;
	Tue, 31 Dec 2024 15:34:49 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43tunsjt5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Dec 2024 15:34:49 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BVFYmhx11207314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Dec 2024 15:34:48 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF7BC5803F;
	Tue, 31 Dec 2024 15:34:48 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A3EB5804E;
	Tue, 31 Dec 2024 15:34:48 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.178.58])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 31 Dec 2024 15:34:48 +0000 (GMT)
Message-ID: <f0746bfae90306d45079f6f3e2f7a1d55e0ad79f.camel@linux.ibm.com>
Subject: Re: [PATCH v2 6/8] IMA: Add example policy for ima_violations.sh
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Date: Tue, 31 Dec 2024 10:34:47 -0500
In-Reply-To: <20241231122340.GE36475@pevik>
References: <20241213222014.1580991-1-pvorel@suse.cz>
	 <20241213222014.1580991-7-pvorel@suse.cz>
	 <35af7de88f6961817a9df23c55104d20c32d2680.camel@linux.ibm.com>
	 <20241231122340.GE36475@pevik>
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
X-Proofpoint-ORIG-GUID: p5OyB5HshQHggiaviKsaYSibU-35jlHe
X-Proofpoint-GUID: p5OyB5HshQHggiaviKsaYSibU-35jlHe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412310131

On Tue, 2024-12-31 at 13:23 +0100, Petr Vorel wrote:
> Hi Mimi,
>=20
> > Hi Petr,
>=20
> > On Fri, 2024-12-13 at 23:20 +0100, Petr Vorel wrote:
> > > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > ---
> > >  .../integrity/ima/datafiles/ima_violations/violations.policy     | 1=
 +
> > >  1 file changed, 1 insertion(+)
> > >  create mode 100644 testcases/kernel/security/integrity/ima/datafiles=
/ima_violations/violations.policy
>=20
> > > diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_vi=
olations/violations.policy b/testcases/kernel/security/integrity/ima/datafi=
les/ima_violations/violations.policy
> > > new file mode 100644
> > > index 0000000000..5734c7617f
> > > --- /dev/null
> > > +++ b/testcases/kernel/security/integrity/ima/datafiles/ima_violation=
s/violations.policy
> > > @@ -0,0 +1 @@
> > > +func=3DFILE_CHECK
>=20
> > "[PATCH v2 1/8] IMA: Add TCB policy as an example for ima_measurements.=
sh"
> > contains two rules to measure files opened by root on file open.
>=20
> > measure func=3DFILE_CHECK mask=3D^MAY_READ euid=3D0
> > measure func=3DFILE_CHECK mask=3D^MAY_READ uid=3D0
>=20
> > If the 'tcb' or equivalent policy is loaded, there is no need to load a=
nother
> > policy rule.=20
>=20
> I guess I'll move check for builtin policy loaded via kernel command line
> parameter also to ima_setup.sh to avoid loading example policy when there=
 is a
> required builtin policy loaded.
>=20

Between the builtin and arch specific policies, most of the rules are alrea=
dy
defined.  The exception is measuring the boot command line.  Perhaps we sho=
uld
update the arch specific policy to include it with the other kexec rules.

The arch specific policy may include the rule that requires the IMA policy =
to be
signed.

> I also wonder what is a common approach - don't
> try to load custom example policy when there is builtin policy loaded?

How about first checking if the rule exists when there is a builtin or
equivalent custom policy loaded, before loading the example test policy?

>=20
> My goal was to allow more broad IMA testing based on different setup:

Very good.
>=20
> * running tests with ima_policy=3Dtcb builtin policy (current approach). =
Many
> tests will be skipped due missing required policy content.

Ok.  Remember even with "ima_policy=3Dtcb" specified on the boot command li=
ne, the
results will differ depending on whether the arch specific policy is loaded=
.

> * running tests without any builtin policy + load a custom policy + reboo=
t via
> LTP_IMA_LOAD_POLICY=3D1 (this patchset), but this should be probably be d=
one only
> if required (or even none) builtin policy is loaded.

Good.  The first patch introduces the equivalent custom policy to
"ima_policy=3Dtcb".  By "load a custom policy" are you referring to this po=
licy or
a specific policy test rule?

> * Ideally not require CONFIG_IMA_READ_POLICY=3Dy as some distros does not=
 have it
> (but then it is hard to detect whether failures are real bugs or just fal=
se
> positives due not having a proper policy). Maybe convert TBROK/TFAIL to T=
CONF if
> policy content is required but cannot be read due CONFIG_IMA_READ_POLICY =
(and
> custom policy with proper content was not loaded).

Probably the latter option of converting from TBROK/TFAIL to TCONF is
preferable.  Why fail a test without knowing it will fail.

> But you may have an idea what is more useful (brings more test coverage).

There are two main problems:
- Not being able to read the policy.
- Only being able to load a signed policy.

I think between your above ordering and a new test to see if the policy nee=
ds to
be signed, it's the best we can do for now.

As mentioned in my 2/8 response, a new package containing pre-defined custo=
m
policies that are signed by the distro would resolve the latter problem.


Thanks,

Mimi

