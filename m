Return-Path: <linux-integrity+bounces-4981-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725AEA42BF0
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Feb 2025 19:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1F177A1E92
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Feb 2025 18:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3814B263F59;
	Mon, 24 Feb 2025 18:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c3OHhQxJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889F326139E
	for <linux-integrity@vger.kernel.org>; Mon, 24 Feb 2025 18:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422939; cv=none; b=Pv8UWiXl+3mA++mdSmYfG8+bFr891Sh3dXOOurlzFDDOn/v5qpadMV2AIApmZv/affp+Tgl8fXxdyTcxmPvv21Iy8ZdJzHUAL3NTMYSx9s6zRa6vnGNoWS/M0jVXOEV1GAbSPrdjd6h5nDmdZUXAOjYvYD6pI+2wInu213gWQYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422939; c=relaxed/simple;
	bh=3gyNTZCE8kQGlFL59fXDwDoE7mneCRgdKmWfTlzpXHs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M17JYs53NjShQU2FTRTMzKCrsBxUxVWeUplvTFev7Z4TMm1gOOu+W3/ADZTEJkyb5ML2SDGVi4MN+gH11bOhplLXdmc9TyJV8lHLWYRKq4pdzSrnZMpAtg+CVjaC1Sp4f1byWXfKy2OU78ivhbNYsveQCasQ+kIld9Z4SvpYA7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c3OHhQxJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OCQDHT020365;
	Mon, 24 Feb 2025 18:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Yojfkl
	zttvkO+bI+UNhP7iJoOSgbvukoX/a57WEYxkk=; b=c3OHhQxJNeIBypNcL09r9Z
	Ap59tVimliwp+tifC8esZO98OIoWW72zRyfe9wTfS+9/BEUvOKWGqoETPsf1JQyW
	SMqkitP8KqNCjYAZNSno8/xOp6IpAdvBFfF38A8HJLBhI5O+NCMBIaUb/HPjwfbq
	RHwddA+JloQH4aDaF95LsxV8TO261KVJ5X2nSFLj3EZ0m18l5qbWYZKtuud3Cy0C
	qBlSjEknzCITY8w+dp0UopnsPItYbzfBYw+fqgMANeF3ci9VhsIWeFbvSni1Fil8
	18+We3EZcl7WnosiXyL5XAb11VLoOKAB41CqVh1i4NCO8v2pB+ibec3UHiodiAqA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 450cta4u4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 18:48:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51OGdGcX026990;
	Mon, 24 Feb 2025 18:48:49 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ytdk8ke0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 18:48:49 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51OImmNi22479158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 18:48:49 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3F7858059;
	Mon, 24 Feb 2025 18:48:48 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 813A458061;
	Mon, 24 Feb 2025 18:48:48 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.5.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Feb 2025 18:48:48 +0000 (GMT)
Message-ID: <26a46dd0c56d95108c575937c15fa35d48f67577.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 3/3] ima: additional ToMToU violation tests
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        Stefan Berger
	 <stefanb@linux.ibm.com>
Date: Mon, 24 Feb 2025 13:48:48 -0500
In-Reply-To: <20250221081623.GA2739743@pevik>
References: <20250220160054.12149-1-zohar@linux.ibm.com>
	 <20250220160054.12149-3-zohar@linux.ibm.com>
	 <20250220181604.GA2709977@pevik>
	 <fd10e47b4c8b6af0e8d37975cdf1e82133add8c3.camel@linux.ibm.com>
	 <20250220191342.GA2716312@pevik>
	 <c625586b0dbc4302dfb7adf4acb0c891b74cf8bc.camel@linux.ibm.com>
	 <2637152a2715b8e84e966b12bc9c9cb1c27592c2.camel@linux.ibm.com>
	 <20250220214333.GA2726725@pevik>
	 <cd07d8052fbfa0cde426b4b07fde0c70e6aa046f.camel@linux.ibm.com>
	 <20250221081623.GA2739743@pevik>
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
X-Proofpoint-GUID: y4BuzdeDU8x7SE1siHUCGmJAp_FrpMT0
X-Proofpoint-ORIG-GUID: y4BuzdeDU8x7SE1siHUCGmJAp_FrpMT0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_09,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=887
 lowpriorityscore=0 mlxscore=0 impostorscore=0 suspectscore=0 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502240121

On Fri, 2025-02-21 at 09:16 +0100, Petr Vorel wrote:
> > On Thu, 2025-02-20 at 22:43 +0100, Petr Vorel wrote:
> > > > On Thu, 2025-02-20 at 15:22 -0500, Mimi Zohar wrote:
> > > > > On Thu, 2025-02-20 at 20:13 +0100, Petr Vorel wrote:
> > > > > > > On Thu, 2025-02-20 at 19:16 +0100, Petr Vorel wrote:
> > > > > > > > Hi Mimi,
>=20
> > > > > > > > > Kernel patch "ima: limit the number of ToMToU integrity
> > > > > > > > > violations"
> > > > > > > > > prevents superfluous ToMToU violations.=C2=A0 Add corresp=
onding LTP
> > > > > > > > > tests.
>=20
> > > > > > > > > Link:
> > > > > > > > > https://lore.kernel.org/linux-integrity/20250219162131.41=
6719-3-zohar@linux.ibm.com/
> > > > > > > > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
>=20
> > > > > > > > Unfortunately tests fail on both mainline kernel and kernel=
 with
> > > > > > > > your patches.
>=20
> > > > > > > The new LTP IMA violations patches should fail without the
> > > > > > > associated kernel
> > > > > > > patches.
>=20
> > > > > > > > Any hint what could be wrong?
>=20
> > > > > > > Of course it's dependent on the IMA policy.=C2=A0 The tests a=
ssume
> > > > > > > being booted with
> > > > > > > the
> > > > > > > IMA
> > > > > > > TCB measurement policy or similar policy being loaded.=C2=A0 =
Can you
> > > > > > > share the IMA
> > > > > > > policy?
> > > > > > > e.g. cat /sys/kernel/security/ima/policy
>=20
> > > > > > > thanks,
>=20
> > > > > > > Mimi
>=20
> > > > > > Now testing on kernel *with* your patches. First run always fai=
ls,
> > > > > > regardless
> > > > > > whether using ima_policy=3Dtcb or
> > > > > > /opt/ltp/testcases/data/ima_violations/violations.policy).
>=20
> > > > > > Kind regards,
> > > > > > Petr
>=20
> > > > > I'm not seeing that on my test machine.=C2=A0 Could there be othe=
r things
> > > > > running on your
> > > > > system causing violations.=C2=A0 In anycase, your original test w=
as less
> > > > > exacting.=C2=A0=C2=A0
> > > > > Similarly,
> > > > > instead of "-eq", try using "-qe" in the following test and remov=
ing
> > > > > the subsequent
> > > > > new
> > > > > "gt" test.
>=20
> > > > -> "-ge"
>=20
> > > Sure, changing to -ge fixes the problem:
> > > if [ $(($num_violations_new - $num_violations)) -ge $expected_violati=
ons
> > > ]; then
>=20
> > > I guess we need "-ge" for older kernels (unless "fix" for stable).=C2=
=A0 Should
> > > we
> > > accept "$expected_violations || $expected_violations + 1" for new ker=
nels
> > > to
> > > avoid problems like the one on my system.
>=20
> > The problem is that we don't control what else is running on the system=
.=C2=A0 So
> > there could
> > be other violations independent of these tests.=C2=A0 I'll have to thin=
k about it
> > some more and
> > get back to you.=C2=A0 (There's no rush to do anything with these LTP I=
MA
> > violation tests.)
>=20
> OK, thank you. The worse scenario would be to use less precise variant "-=
ge".
>=20
> > > I wonder if the problem was somehow caused by the fact that I built
> > > kernel. OTOH
> > > it's build by OBS (official openSUSE build service).
>=20
> > As long as you weren't building the kernel and running the tests at the
> > same, I doubt it
> > would be the problem.
>=20
> Understand, just something on openSUSE Tumbleweed system.

Peter, thank you for the tumbleweed image.

The default IMA tcb policy results is measuring $LOG (/var/log/audit/audit.=
log)
on the first call to validate().  To prevent that from interfering with tes=
t1, I
would add the following line or something similar in setup() to force measu=
ring
$LOG to happen earlier.

exec 3< $LOG || exit 1

Assuming that works, I'll update the kernel and LTP tests.

thanks,

Mimi















