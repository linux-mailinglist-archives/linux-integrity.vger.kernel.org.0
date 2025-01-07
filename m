Return-Path: <linux-integrity+bounces-4528-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E76B9A04937
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jan 2025 19:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DCD43A4AE4
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jan 2025 18:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1283197A7A;
	Tue,  7 Jan 2025 18:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ArO/GxfS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E72186330
	for <linux-integrity@vger.kernel.org>; Tue,  7 Jan 2025 18:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736274586; cv=none; b=AS3UT3WlTUVhUVusraTfRfapWLSpS5C16rkudIvTIngnJWN9frid4MISXD0TbtII5iGEudxjPcudZsjXhxvy7VcauYm4kR+B7CgnzYbjznwQ8wBe34IogugwP8wXS1a7XUkZEWjnrC/Ox2RDNd02YD91J2aJPvae62P3rendTKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736274586; c=relaxed/simple;
	bh=3wpa7NOLMH9uH2o/nipvepQ4jegOFJ4KrWFAqbdCHM8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NRAClnzqphl41bMiBFK1WnOTxp+2PezuCR8B3alX7yRCSFCPfWURHNzyvFhgHE6MViko6TKABW9U/eSEnwpDsxvlwIbrGbQZ6Z9aa5MfaCxuF1HaQb7z9xbK6zO4WFAniIMEYcwzlUoqvLJBmSS34PUWFwde3g4deXA6jBeC4dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ArO/GxfS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507I4CXX005396;
	Tue, 7 Jan 2025 18:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JbEa5N
	rKIkHLRPHhFYuxRdkxm6VZs+vNTKG7MSmh0uo=; b=ArO/GxfSzebwgN+T/enl8+
	xELSIR99no1ozkDFTdeEJHiHjZU/hbi0bff6Ho91raNvtyhS+l+0izMp4j7CS6L4
	sysuIzqxPTC1DyMyPVqw0AYhGrlCME5ky0XVLiU91b4YElKvVEnEnJyegf37Zljk
	e+tKyCRDFb+ZNGxHRfiWuhIUvS336o0pI7VyBvJnRJa37DJcOHQvsi3RXwyjSCOc
	VsUCWHLeDEdGW1zNu4/OXKkzFLrQ/e/3LXgzCvo7vh3wl9wxlqIrXY/PyLBYSaQC
	hd6zpLwolISfJDp7tQkt8oM3zVT0G+T9zreCsvH23QmiAZekK5IcDzsOKLCrwYyg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4410f3atfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 18:29:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 507G5L6s003614;
	Tue, 7 Jan 2025 18:29:37 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yfat42j4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 18:29:37 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 507ITaqR29950582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jan 2025 18:29:36 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FBF55804E;
	Tue,  7 Jan 2025 18:29:36 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B39F25803F;
	Tue,  7 Jan 2025 18:29:35 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.138.2])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jan 2025 18:29:35 +0000 (GMT)
Message-ID: <baefcfa48e2e66e88b79b9db915d6c664d71c428.camel@linux.ibm.com>
Subject: Re: [PATCH v2 6/8] IMA: Add example policy for ima_violations.sh
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Date: Tue, 07 Jan 2025 13:29:35 -0500
In-Reply-To: <20250103190259.GA223253@pevik>
References: <20241213222014.1580991-1-pvorel@suse.cz>
	 <20241213222014.1580991-7-pvorel@suse.cz>
	 <35af7de88f6961817a9df23c55104d20c32d2680.camel@linux.ibm.com>
	 <20241231122340.GE36475@pevik>
	 <f0746bfae90306d45079f6f3e2f7a1d55e0ad79f.camel@linux.ibm.com>
	 <20250103190259.GA223253@pevik>
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
X-Proofpoint-GUID: Pt7PLwZyzJzqUL0HWFxCBAxwLP7A5rKU
X-Proofpoint-ORIG-GUID: Pt7PLwZyzJzqUL0HWFxCBAxwLP7A5rKU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501070153

On Fri, 2025-01-03 at 20:02 +0100, Petr Vorel wrote:
> > On Tue, 2024-12-31 at 13:23 +0100, Petr Vorel wrote:
> > > Hi Mimi,
>=20
> > > > Hi Petr,
>=20
> > > > On Fri, 2024-12-13 at 23:20 +0100, Petr Vorel wrote:
> > > > > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > > > ---
> > > > > =C2=A0.../integrity/ima/datafiles/ima_violations/violations.polic=
y=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> > > > > =C2=A01 file changed, 1 insertion(+)
> > > > > =C2=A0create mode 100644
> > > > > testcases/kernel/security/integrity/ima/datafiles/ima_violations/=
violations
> > > > > .policy
>=20
> > > > > diff --git
> > > > > a/testcases/kernel/security/integrity/ima/datafiles/ima_violation=
s/violatio
> > > > > ns.policy
> > > > > b/testcases/kernel/security/integrity/ima/datafiles/ima_violation=
s/violatio
> > > > > ns.policy
> > > > > new file mode 100644
> > > > > index 0000000000..5734c7617f
> > > > > --- /dev/null
> > > > > +++
> > > > > b/testcases/kernel/security/integrity/ima/datafiles/ima_violation=
s/violatio
> > > > > ns.policy
> > > > > @@ -0,0 +1 @@
> > > > > +func=3DFILE_CHECK
>=20
> > > > "[PATCH v2 1/8] IMA: Add TCB policy as an example for ima_measureme=
nts.sh"
> > > > contains two rules to measure files opened by root on file open.
>=20
> > > > measure func=3DFILE_CHECK mask=3D^MAY_READ euid=3D0
> > > > measure func=3DFILE_CHECK mask=3D^MAY_READ uid=3D0
>=20
> > > > If the 'tcb' or equivalent policy is loaded, there is no need to lo=
ad another
> > > > policy rule.=20
>=20
> > > I guess I'll move check for builtin policy loaded via kernel command =
line
> > > parameter also to ima_setup.sh to avoid loading example policy when t=
here is a
> > > required builtin policy loaded.
>=20
>=20
> > Between the builtin and arch specific policies, most of the rules are a=
lready
> > defined.=C2=A0 The exception is measuring the boot command line.=C2=A0 =
Perhaps we should
> > update the arch specific policy to include it with the other kexec rule=
s.
>=20
> > The arch specific policy may include the rule that requires the IMA pol=
icy to be
> > signed.
>=20
> > > I also wonder what is a common approach - don't
> > > try to load custom example policy when there is builtin policy loaded=
?
>=20
> > How about first checking if the rule exists when there is a builtin or
> > equivalent custom policy loaded, before loading the example test policy=
?
>=20
>=20
> > > My goal was to allow more broad IMA testing based on different setup:
>=20
> > Very good.
>=20
> > > * running tests with ima_policy=3Dtcb builtin policy (current approac=
h). Many
> > > tests will be skipped due missing required policy content.
>=20
> > Ok.=C2=A0 Remember even with "ima_policy=3Dtcb" specified on the boot c=
ommand line, the
> > results will differ depending on whether the arch specific policy is lo=
aded.
>=20
> > > * running tests without any builtin policy + load a custom policy + r=
eboot via
> > > LTP_IMA_LOAD_POLICY=3D1 (this patchset), but this should be probably =
be done only
> > > if required (or even none) builtin policy is loaded.
>=20
> > Good.=C2=A0 The first patch introduces the equivalent custom policy to
> > "ima_policy=3Dtcb".=C2=A0 By "load a custom policy" are you referring t=
o this policy or
> > a specific policy test rule?
>=20
> I refer to this policy. Maybe better would be "policy content required by=
 the test"
> or "test example policy".
>=20
> My point is to allow testing without forcing ima_policy=3Dtcb setup (some=
 tooling
> might not allow easily to add kernel cmdline parameters). Also, mixing te=
st
> example policy with ima_policy=3Dtcb may result a different measurements,=
 right?

Only if the file matches multiple, different measurement rules.  The orderi=
ng of the
policy rules impacts the measurement and might even prevent the measurement=
.

>=20
> If the above assumption is correct I would like to have testing *with*
> ima_policy=3Dtcb without loading any test example policy

I assume the purpose is to simplify testing.

However,
- Not all of the policy rules needed by the tests are included in the built=
in "tcb"
measurement policy.  Without loading test specific example policy rules, th=
e testing
would be incomplete.

- There's no guarantee that the builtin "tcb" measurement policy has not be=
en
replaced with a custom policy.

> and *without*
> ima_policy=3Dtcb but loading test example policy via LTP_IMA_LOAD_POLICY=
=3D1.

Ok, but this assumes the ability of loading an unsigned policy.

>=20
> > > * Ideally not require CONFIG_IMA_READ_POLICY=3Dy as some distros does=
 not have it
> > > (but then it is hard to detect whether failures are real bugs or just=
 false
> > > positives due not having a proper policy). Maybe convert TBROK/TFAIL =
to TCONF
> > > if
>=20
> I'm sorry, I was wrong here, I meant to ask: convert TFAIL to either TBRO=
K or
> TCONF,
> e.g. my patch [1].
>=20
> > > policy content is required but cannot be read due CONFIG_IMA_READ_POL=
ICY (and
> > > custom policy with proper content was not loaded).
>=20
> > Probably the latter option of converting from TBROK/TFAIL to TCONF is
> > preferable.=C2=A0 Why fail a test without knowing it will fail.
>=20
> Because on distros without CONFIG_IMA_READ_POLICY=3Dy we never get notifi=
ed about
> the failure (maybe kernel is broken when it fails but nobody notices TCON=
F).
> But although there is a slight difference between TFAIL and TBROK [2], I =
agree
> that TCONF is probably the best (nobody wants to deal with false positive=
s),
> which is handled in my patch [1].
>=20
> But instead of this I'll try for all tests which require to have certain =
policy
> content (currently all but ima_conditionals.sh): if LTP_IMA_LOAD_POLICY=
=3D1 set
> try to load example policy even policy content cannot be checked (TCONF w=
hen
> policy fails to be loaded or if LTP_IMA_LOAD_POLICY not set).

Sounds good.

Mimi

