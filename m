Return-Path: <linux-integrity+bounces-4504-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154DA9FF007
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Dec 2024 15:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C982D161C95
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Dec 2024 14:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B362D052;
	Tue, 31 Dec 2024 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Whr+mQPn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84D92F4A
	for <linux-integrity@vger.kernel.org>; Tue, 31 Dec 2024 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735656862; cv=none; b=bQv2ZxZDpg22oSf1SMHU4aPKBwRzdl3kbOJ0qJJo+ZqfnmFXUx3WdXJ1ildRNI/8t4/4mFvk4z+Dvmq9UFwejGywPYyhlCXE6OAZd/Ebs98UDfXixupQzZDorfA04RCRIkOb5N2jpN+sA2+QiHNPfXL4cqe9wV/dERAxqDpr7D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735656862; c=relaxed/simple;
	bh=bkCXbINNMxd5OvdfXxMyh4XU4T7gZmk7DM7sLJZctgs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dx+bHjsTvrYGl8uow6eegU7RKqDFjKwRoqVkQJI8fT4frQ1pIAY3b8/59SxUyWIfE3/6/6pnb9giatTXPI5pSajjFF7eHzJ6drEPNYapM+7JNg4/vGAF8hw/8rBUEYamjrTuaVdixC9UVn+CxEdkopcgrGhVFi6AXdO30IjEYVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Whr+mQPn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BV2sYjZ009748;
	Tue, 31 Dec 2024 14:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=T3QoaK
	cfhU0ZHHmSOmCZ0Cg1YeG5s4qCECce2l3XUF4=; b=Whr+mQPnZZyRT7LDukE+l7
	AeX1SSa0MWbgWStnzUSSfR3+8eFs5SQ2qTowwALCLYmwHOXBSYeMwWpeivBCwymA
	jSfDZ30paBPiTSExdU8spefXMciokb5EemU+2nx55YJfDdaNeA/RgwFzUQniGwQS
	A3P+VpTaVPqdA4AFXT39leoyXHCrAd58IkpANew/rZlh7C9jYpHnOgi488Za4cLE
	KZVLNm2MfsqTUN+ltmfCviWOaz8imREiIV0o73IEMcIr2Nn8pmG/4oeIbMDK57p1
	ODlbmagQydajhvbasP9ej/M6cjncKKJaz5FWhUznlDnbDMDO+JCMqU55a6xoCHIg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43v5baacut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Dec 2024 14:54:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BVEmb63014023;
	Tue, 31 Dec 2024 14:54:14 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43tv1y2km4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Dec 2024 14:54:14 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BVEsDvF29033130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Dec 2024 14:54:13 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA9CB5805D;
	Tue, 31 Dec 2024 14:54:13 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 461C558053;
	Tue, 31 Dec 2024 14:54:13 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.178.58])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 31 Dec 2024 14:54:13 +0000 (GMT)
Message-ID: <b577405f0c6d2af8de6650eb1cd8c69305f616bf.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/8] ima_setup.sh: Allow to load predefined policy
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Date: Tue, 31 Dec 2024 09:54:12 -0500
In-Reply-To: <20241231100057.GB36475@pevik>
References: <20241213222014.1580991-1-pvorel@suse.cz>
	 <20241213222014.1580991-3-pvorel@suse.cz>
	 <a617f000c69875b5c02743c8f0a8fee72cb1ea55.camel@linux.ibm.com>
	 <20241231100057.GB36475@pevik>
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
X-Proofpoint-GUID: OR6WJwgFfQxiQikF3FXmuhdF4H4FEbqG
X-Proofpoint-ORIG-GUID: OR6WJwgFfQxiQikF3FXmuhdF4H4FEbqG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412310123

On Tue, 2024-12-31 at 11:00 +0100, Petr Vorel wrote:
> > Hi Petr,
>=20
> > On Fri, 2024-12-13 at 23:20 +0100, Petr Vorel wrote:
> > [snip]
>=20
> > > --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > > +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > > @@ -1,7 +1,7 @@
> > > =C2=A0#!/bin/sh
> > > =C2=A0# SPDX-License-Identifier: GPL-2.0-or-later
> > > =C2=A0# Copyright (c) 2009 IBM Corporation
> > > -# Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
> > > +# Copyright (c) 2018-2024 Petr Vorel <pvorel@suse.cz>
> > > =C2=A0# Author: Mimi Zohar <zohar@linux.ibm.com>
>=20
> > > =C2=A0TST_TESTFUNC=3D"test"
> > > @@ -72,14 +72,20 @@ require_policy_readable()
> > > =C2=A0	fi
> > > =C2=A0}
>=20
> > > -require_policy_writable()
> > > +check_policy_writable()
> > > =C2=A0{
> > > -	local err=3D"IMA policy already loaded and kernel not configured to=
 enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=3Dy)"
> > > -
> > > -	[ -f $IMA_POLICY ] || tst_brk TCONF "$err"
> > > -	# CONFIG_IMA_READ_POLICY
> > > +	[ -f $IMA_POLICY ] || return 1
> > > +	# workaround for kernels < v4.18 without fix
> > > +	# ffb122de9a60b ("ima: Reflect correct permissions for policy")
> > > =C2=A0	echo "" 2> log > $IMA_POLICY
> > > -	grep -q "Device or resource busy" log && tst_brk TCONF "$err"
> > > +	grep -q "Device or resource busy" log && return 1
> > > +	return 0
> > > +}
> > > +
> > > +require_policy_writable()
> > > +{
> > > +	check_policy_writable || tst_brk TCONF \
> > > +		"IMA policy already loaded and kernel not configured to enable mul=
tiple writes to it (need CONFIG_IMA_WRITE_POLICY=3Dy)"
> > > =C2=A0}
>=20
> > > =C2=A0check_ima_policy_content()
> > > @@ -158,6 +164,34 @@ print_ima_config()
> > > =C2=A0	tst_res TINFO "/proc/cmdline: $(cat /proc/cmdline)"
> > > =C2=A0}
>=20
> > > +load_ima_policy()
> > > +{
> > > +	local policy=3D"$(ls $TST_DATAROOT/*.policy 2>/dev/null)"
> > > +
> > > +	if [ "$LTP_IMA_LOAD_POLICY" !=3D 1 -a "$policy" -a -f "$policy" ]; =
then
> > > +		tst_res TINFO "NOTE: set LTP_IMA_LOAD_POLICY=3D1 to load policy fo=
r this test"
> > > +		return
> > > +	fi
> > > +
> > > +	if [ -z "$policy" -o ! -f "$policy" ]; then
> > > +		tst_res TINFO "no policy for this test"
> > > +		LTP_IMA_LOAD_POLICY=3D
> > > +		return
> > > +	fi
> > > +
> > > +	tst_res TINFO "trying to load '$policy' policy:"
> > > +	cat $policy
> > > +	if ! check_policy_writable; then
> > > +		tst_res TINFO "WARNING: IMA policy already loaded and kernel not c=
onfigured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=3Dy=
), reboot required"
> > > +		LTP_IMA_LOAD_POLICY=3D
> > > +		return
> > > +	fi
> > > +
> > > +	cat "$policy" 2> log > $IMA_POLICY
> > > +	if grep -q "Device or resource busy" log; then
> > > +		tst_brk TBROK "Loading policy failed"
> > > +	fi
>=20
> > To write to the IMA securityfs policy file, check_policy_writable() use=
d "echo",
> > while here it's using "cat".  "cat" fails when signed policies are requ=
ired.
> > Perhaps add something like:
> > +
> > +       if grep -q "write error: Permission denied" log; then
> > +               tst_brk TBROK "Loading unsigned policy failed"
> > +       fi
>=20
> +1, I'll add this extra check to v3.
>=20
> I suppose echo "" > /sys/kernel/security/ima/policy does not need this ch=
eck.

The original method for loading an IMA policy was by cat'ing the policy rul=
es.=20
Commit 7429b092811f ("ima: load policy using path") introduced the ability =
of
verifying the integrity of the policy itself.

echo <policy filepath>  > /sys/kernel/security/ima/policy

>=20
> Do I understand correctly you talk about policy containing func=3DPOLICY_=
CHECK [1]?

Yes.  On a secure boot enabled system, the architecture specific policy mig=
ht
require the IMA policy itself to be signed.

Snippet from ima_fs.c:

#if IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING) &&
IS_ENABLED(CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY)
        "appraise func=3DPOLICY_CHECK appraise_type=3Dimasig",
#endif

> Maybe there could be a test based on example [2].
>=20
> echo /home/user/tmpfile > /sys/kernel/security/ima/policy
> cp tmpfile /sys/kernel/security/ima/policy
> cat tmpfile > /sys/kernel/security/ima/policy

All of the above will load a policy, assuming the policy itself doesn't nee=
d to
be signed.  Only "echo /home/user/tmpfile > /sys/kernel/security/ima/policy=
" can
load a signed policy.

Loading a CA key (mokutil), signing (evmctl)[1] and loading (keyctl) an IMA
policy is probably beyond LTP.  The purpose of this test would be to detect
whether policies need to be signed.

Going forward what's probably needed is a new package containing a set of p=
re-
defined sample custom policies, which are signed by the distro.

[1] Directions for signing and loading a custom policy,
https://ima-doc.readthedocs.io/en/latest/ima-utilities.html#sign-and-instal=
l-a-custom-policy

Thanks,

Mimi

>=20
> Kind regards,
> Petr
>=20
> [1] https://ima-doc.readthedocs.io/en/latest/policy-syntax.html#func-poli=
cy-check
> [2] https://ima-doc.readthedocs.io/en/latest/ima-policy.html#runtime-cust=
om-policy
>=20
> > > +}
>=20
> > Mimi
>=20
>=20


