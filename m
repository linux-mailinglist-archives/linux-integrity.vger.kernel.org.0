Return-Path: <linux-integrity+bounces-4956-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B33A3EA8B
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 03:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D3E701673
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 02:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A746157A72;
	Fri, 21 Feb 2025 02:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="srFNz6pK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF4F1CD1E1
	for <linux-integrity@vger.kernel.org>; Fri, 21 Feb 2025 02:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740103654; cv=none; b=oVA4VvjFG+f6sUwuWb0z55PzqwP7EQwswGR3rqbKopWdU+7+jNDaLUeNhqn3EdOFGXSFWh5ZFADphwJ6N13ralc1ixHLIIUAiVVq5c4VdsiJZC/Tdlw0e9aH0bnFjOF69jGWBLH/aQmhxQ74iq6NFay5dKaU1UZSOl1AvQMLEIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740103654; c=relaxed/simple;
	bh=ZG0fyS27pCDfL9PFoKlOaT4qSkeTExJncX8NGcvqcjM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n0ojU3k0+9FjsacKtYVZaDUtaz+WxRjIjzEG4dEr89SkbIc+u952X1W9R9biQZVzgeU/SmpIrBuAgqYKTWlqp15ELtWVLbBHAht5dK3hhWcVXOcrPb+mKLxKofqCH1VMJJ74YbQQ9SMQDODhhVnxeDkT+GO4Y6Ewpl/NMBt+CfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=srFNz6pK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KH1d34007117;
	Fri, 21 Feb 2025 02:07:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=C1HPyd
	21sazgz3pXWPTlykpxc0KCB3IIyp6NaWvihYk=; b=srFNz6pKoW1rdC6cUxH6ys
	nkgWS1MoTVsmdWItDyzG6v6uu3LHeg0AJpEmbQ5sXCNu5nJY1QYYbWyNCYWEt+m5
	JXcFxrQV/y9oCz2WF0OWRNDBGEQby3lh6K4tjiHIcdGOJlc4j01Zke2vwx9w+ISj
	CJ+4cok7NFiCJIibN2NLoe04azmJhnwrdQ+Xd7cOdEeFMNpFqEXUSESUoNLuvNes
	1biADep7AhoVGiHF5P1YlKkLUYwWw4KnxnPztICjuqRc2DCQpoNpStxX8hv+cAJS
	RssknSksFJ2xWCWDJeipQQWTeUvdVCw53/ZB+BWF6hvNhvVOZaXmH6e3zStybxwQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44x1qycfqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 02:07:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51L1IQKj030138;
	Fri, 21 Feb 2025 02:07:25 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w01xdet1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 02:07:25 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51L27OtI27656744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 02:07:24 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B15F5805A;
	Fri, 21 Feb 2025 02:07:25 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1C9058051;
	Fri, 21 Feb 2025 02:07:24 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.45.62])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Feb 2025 02:07:24 +0000 (GMT)
Message-ID: <cd07d8052fbfa0cde426b4b07fde0c70e6aa046f.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 3/3] ima: additional ToMToU violation tests
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        Stefan Berger
	 <stefanb@linux.ibm.com>
Date: Thu, 20 Feb 2025 21:07:24 -0500
In-Reply-To: <20250220214333.GA2726725@pevik>
References: <20250220160054.12149-1-zohar@linux.ibm.com>
	 <20250220160054.12149-3-zohar@linux.ibm.com>
	 <20250220181604.GA2709977@pevik>
	 <fd10e47b4c8b6af0e8d37975cdf1e82133add8c3.camel@linux.ibm.com>
	 <20250220191342.GA2716312@pevik>
	 <c625586b0dbc4302dfb7adf4acb0c891b74cf8bc.camel@linux.ibm.com>
	 <2637152a2715b8e84e966b12bc9c9cb1c27592c2.camel@linux.ibm.com>
	 <20250220214333.GA2726725@pevik>
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
X-Proofpoint-GUID: N0kut96FH6tF7T3-_kpE9pueIsDUixkq
X-Proofpoint-ORIG-GUID: N0kut96FH6tF7T3-_kpE9pueIsDUixkq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 impostorscore=0 bulkscore=0 mlxlogscore=813 adultscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210013

On Thu, 2025-02-20 at 22:43 +0100, Petr Vorel wrote:
> > On Thu, 2025-02-20 at 15:22 -0500, Mimi Zohar wrote:
> > > On Thu, 2025-02-20 at 20:13 +0100, Petr Vorel wrote:
> > > > > On Thu, 2025-02-20 at 19:16 +0100, Petr Vorel wrote:
> > > > > > Hi Mimi,
>=20
> > > > > > > Kernel patch "ima: limit the number of ToMToU integrity viola=
tions"
> > > > > > > prevents superfluous ToMToU violations.=C2=A0 Add correspondi=
ng LTP tests.
>=20
> > > > > > > Link:
> > > > > > > https://lore.kernel.org/linux-integrity/20250219162131.416719=
-3-zohar@linux.ibm.com/
> > > > > > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
>=20
> > > > > > Unfortunately tests fail on both mainline kernel and kernel wit=
h your patches.
>=20
> > > > > The new LTP IMA violations patches should fail without the associ=
ated kernel
> > > > > patches.
>=20
> > > > > > Any hint what could be wrong?
>=20
> > > > > Of course it's dependent on the IMA policy.=C2=A0 The tests assum=
e being booted with
> > > > > the
> > > > > IMA
> > > > > TCB measurement policy or similar policy being loaded.=C2=A0 Can =
you share the IMA
> > > > > policy?
> > > > > e.g. cat /sys/kernel/security/ima/policy
>=20
> > > > > thanks,
>=20
> > > > > Mimi
>=20
> > > > Now testing on kernel *with* your patches. First run always fails, =
regardless
> > > > whether using ima_policy=3Dtcb or
> > > > /opt/ltp/testcases/data/ima_violations/violations.policy).
>=20
> > > > Kind regards,
> > > > Petr
>=20
> > > I'm not seeing that on my test machine.=C2=A0 Could there be other th=
ings running on your
> > > system causing violations.=C2=A0 In anycase, your original test was l=
ess exacting.=C2=A0=C2=A0
> > > Similarly,
> > > instead of "-eq", try using "-qe" in the following test and removing =
the subsequent
> > > new
> > > "gt" test.
>=20
> > -> "-ge"
>=20
> Sure, changing to -ge fixes the problem:
> if [ $(($num_violations_new - $num_violations)) -ge $expected_violations =
]; then
>=20
> I guess we need "-ge" for older kernels (unless "fix" for stable).=C2=A0 =
Should we
> accept "$expected_violations || $expected_violations + 1" for new kernels=
 to
> avoid problems like the one on my system.

The problem is that we don't control what else is running on the system.  S=
o there could
be other violations independent of these tests.  I'll have to think about i=
t some more and
get back to you.  (There's no rush to do anything with these LTP IMA violat=
ion tests.)

>=20
> I wonder if the problem was somehow caused by the fact that I built kerne=
l. OTOH
> it's build by OBS (official openSUSE build service).

As long as you weren't building the kernel and running the tests at the sam=
e, I doubt it
would be the problem.

>=20
> I don't expect you'd have time to look into it, in case you're interested=
 and
> have time sending a links to rpm binary and src package.

Ok.
>=20
> https://download.opensuse.org/repositories/home:/pevik:/ima-limit-open-wr=
iters-ToMToU/standard/x86_64/kernel-default-6.14~rc3-1.1.gb6b4102.x86_64.rp=
m
> https://download.opensuse.org/repositories/home:/pevik:/ima-limit-open-wr=
iters-ToMToU/standard/src/kernel-source-6.14~rc3-1.1.gb6b4102.src.rpm
>=20

thanks,

Mimi

