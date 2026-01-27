Return-Path: <linux-integrity+bounces-8348-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFeyBv0CeWkdugEAu9opvQ
	(envelope-from <linux-integrity+bounces-8348-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 19:25:01 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BB298FA6
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 19:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AD2B3037D6A
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 18:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E15326949;
	Tue, 27 Jan 2026 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CQ9Skn2i"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811FC2C0282
	for <linux-integrity@vger.kernel.org>; Tue, 27 Jan 2026 18:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769538297; cv=none; b=EjvXcWwzYwdt/1x/b+KDcuzbWI0YvWNtLuelMp0xaVC3hD99HJaNwcpkhipwK7YltWjbQR3XMyQ4vjkHtXFIi9/VyfXo5zz7SJkWzFoqTDlEKT4Ycgp34uAvDt8WDwFv6rFybGJJ60WHv8EYRQUtTBJLIrZF/ejm8MFWFfleVzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769538297; c=relaxed/simple;
	bh=v3oZMmSxRTlkKzzlye/DrElySpA5tA4sWFYy+ZTh4Fc=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=JPrF5vjJOlg0viEXOQ4lCmwBlIlXd+R9saZHAmg1uNJunp6OXNsFt/F1Zy73pbqLHZuCBbtj7NGCfePIC7fSJZzAtWrdcEsYG54S214+qzHsVeCPjXD+dW6PdgMWdN9wNn4oD9ymFV8vVo4s6YYFrgpCKR2pq6cYJbFQItJbZ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CQ9Skn2i; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60RH0Prw021821;
	Tue, 27 Jan 2026 18:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DcRKyJ
	EM5s/6sS92kS1sOSlSlxzX2/oa/N7VkfXvO5E=; b=CQ9Skn2idhFbhtxYMmU73a
	1Uup+YksbNH4IUajf89smePsrydDMu3Tv35QJovlqg07dZxvVunjN586uwNfv9oE
	pUbmj/0feDB8rDxomBipoDGNhtJi4LKzuWjYGadwN2Wllh8KhHtpeJhBkPvEZAZC
	aCFI/HVGXD6ZrU8N59z4/f1mOwB+UKghhAEKm2h3mqIDTsrYr4avuh/0xMfHRZWs
	W/8/oK3zlvp8agfemICgERZGHyQu98dU5GQeDCDHJ47JJATbd6SdG3K9Cq+FZyo9
	UvKV3Bxy5pjkhIAcqp3shwqtyCv9QTHXOO7KMXtGEO5+duz3Mh5WStd7jUAHC7Gw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrtf0qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 18:24:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RF0BtW018303;
	Tue, 27 Jan 2026 18:24:49 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwb41sjcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 18:24:49 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60RIOnFA29032968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 18:24:49 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1585C58056;
	Tue, 27 Jan 2026 18:24:49 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F2235804E;
	Tue, 27 Jan 2026 18:24:48 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.189.79])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Jan 2026 18:24:48 +0000 (GMT)
Message-ID: <447d5d46a8ac3ed8a8283d87bd555459a2679495.camel@linux.ibm.com>
Subject: Re: [PATCH] ima_setup.sh: Fix check of signed policy requirement
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org
In-Reply-To: <20260127131755.GA146899@pevik>
References: <20260121083343.127613-1-pvorel@suse.cz>
	 <20260127131755.GA146899@pevik>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Jan 2026 13:24:48 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cksGe1t79QRuDBYy2o-fhV-qaI3MlbEP
X-Authority-Analysis: v=2.4 cv=Uptu9uwB c=1 sm=1 tr=0 ts=697902f2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=_4C9gLwq-jLjF3gInBgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: cksGe1t79QRuDBYy2o-fhV-qaI3MlbEP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE0OSBTYWx0ZWRfX6mnWdqxDHPWl
 LB5YuWYr9sh5KKX0jxBywZK15f/upTW8xcDjn/yHZrLeNNLBAE0eODrTwrhR3UYIdbvnIw5gncX
 FzgzZl9rf52dPwFicqoFpL7GxTzKMF+GmjCA+dtkQUH0FH2ULYP1J0mpf8C3MojdBGxu34KC9an
 Fet1LR4cGG023gbCQMtCRAM9z08neWqa8igzxelJzmu7iSEh9V4w9XCtXzW3SmUATyvdcVdBUwS
 CL4G2k5Sgp5lP/YBpnCwYYIfI5T15Fl03qSCyoXQEipxbL5jA79JIL7hXUzKk5gzSdR1CZUtExa
 M8bbazj8DwPM4dbBZcTuht44IYUj/BSaZpl3msH54mgqZjvBuKVVFilHUKboHAfQ0YqY69Pfx54
 EfR3BM38BolsOyz1FG/QYqRcw/5jX32772EOY1k6YxsRK/2bYCV26aUnC2gLQKGnF/+WBKxY3pf
 DUqBZCM+L18vqhGL/HA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270149
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8348-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 71BB298FA6
X-Rspamd-Action: no action

Hi Petr,

On Tue, 2026-01-27 at 14:17 +0100, Petr Vorel wrote:
> Hi Mimi, all,
>=20
> > Kernel code in arch_get_ima_policy() depends also on
> > CONFIG_IMA_ARCH_POLICY added in v5.0:
> > d958083a8f640 ("x86/ima: define arch_get_ima_policy() for x86")
>=20
> > Fixes: c38b528783 ("ima_{conditionals, policy}: Handle policy required =
to be signed")
> > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Hi Mimi, all,
>=20
> > FYI I'd like to merge it this week to get it into LTP release.
>=20
> > Kind regards,
> > Petr
>=20
> I dared to merge this to get it into upcoming LTP release (this/next week=
).

I'm so sorry for the delay.

Only if CONFIG_IMA_ARCH_POLICY IS configured, should check_need_signed_poli=
cy be
set to true and the test skipped.  However, I'm seeing:

tst_kconfig.c:531: TINFO: Constraint 'CONFIG_IMA_ARCH_POLICY' not satisfied=
!
tst_kconfig.c:477: TINFO: Variables:
tst_kconfig.c:495: TINFO:  CONFIG_IMA_ARCH_POLICY=3Dn
ima_conditionals 1 TCONF: Aborting due to unsuitable kernel config, see abo=
ve!

Instead it's requiring CONFIG_IMA_ARCH_POLICY to be enabled.

Mimi

>=20
> >  testcases/kernel/security/integrity/ima/tests/ima_setup.sh | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh=
 b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > index 1bce78d425..df0b8d1532 100644
> > --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > @@ -466,10 +466,11 @@ require_evmctl()
> >  }
>=20
> >  # 56dc986a6b20b ("ima: require signed IMA policy when UEFI secure boot=
 is enabled") # v6.5-rc4
> > +# d958083a8f640 ("x86/ima: define arch_get_ima_policy() for x86") # v5=
.0
> >  check_need_signed_policy()
> >  {
> >  	tst_secureboot_enabled && tst_kvcmp -ge '6.5' && tst_require_kconfigs=
 \
> > -		'CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY'
> > +		'CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY,CONFIG_IM=
A_ARCH_POLICY'
> >  }
>=20
> >  # loop device is needed to use only for tmpfs

