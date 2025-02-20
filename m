Return-Path: <linux-integrity+bounces-4942-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D79A3E48D
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 20:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D382519C3DED
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 19:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640EB26388B;
	Thu, 20 Feb 2025 18:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UYiOD7h5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA13211A1D
	for <linux-integrity@vger.kernel.org>; Thu, 20 Feb 2025 18:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077993; cv=none; b=fQFn1UwIDlaSxvHfvsiApYNQndKoA8OYxj8ZBQy9fID1NULYitgdbTS6j2vBBEWOvbPhRLu1HF7VyP8MtNP6mErYRvQK8uah1jDtqVSjIq3F+hZPIyS/iyLt0bpGyHj2JbX1qQ6I7ZpbX+QQKmoa22C1RXmPK2WxcHx7Pu6jHhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077993; c=relaxed/simple;
	bh=CnpVOfCAOZ9tPteuWM9z9z8I8PRqNpka4SF/zG1NT5U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ECwa3lon4BgvhohK6CAoIxr0ytqYmehXhGVIiYQst0O37KtfjviwTf9lDeo5lUN1xDwJv0of9xhZ+ojc9bmN4sbb9tKt6pezd4RL4FuoUel0jIVqWIxGDNBjrrUvCQPWCGg43OI6aIO0zU9lFkZ26yA5voUpsOPoNMSGesK5U34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UYiOD7h5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KH1dch009312;
	Thu, 20 Feb 2025 18:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OQkyoP
	DDFoOqdoxDmIN7TKNLFJjbaD8hujTu/sC9V+w=; b=UYiOD7h5lnzsm2FAOcFPu8
	oxXN4ZkZvUAtAUa9yWZVn/Tt1Fe6HdGNY3+LFYzGpE9lkVb9qLLTp1TrGkRaH+tr
	woBAqu2jyY0sRxPjW7vN2yl/+Yju+MCRGjx3fmIbUMI6Q/jtHWPlcUW6sOKdXFTi
	ur3d2jbGRaoPkb9hbbtLR3A0lWgNGXl+GcEaD66GvKdRaoWeiWGMbrMyuLcOw1GG
	nLHxGWkL3jV7o/B2h8k/CUHup/85yIhFH8FZO3/1bdQBJCcV6+HJj1ypxnAKTQVR
	lzF/mzohRFuBCVZFZh1rt30eyoCiTtA9jNYtI5T93mGrPl5A2AujUKxjkU/K05Ig
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wu80csx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 18:59:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51KI9rLR029299;
	Thu, 20 Feb 2025 18:59:45 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w024kpp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 18:59:45 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51KIxj3U65470928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 18:59:45 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F92358059;
	Thu, 20 Feb 2025 18:59:45 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C46E658058;
	Thu, 20 Feb 2025 18:59:44 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.103.152])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2025 18:59:44 +0000 (GMT)
Message-ID: <fd10e47b4c8b6af0e8d37975cdf1e82133add8c3.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 3/3] ima: additional ToMToU violation tests
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        Stefan Berger
	 <stefanb@linux.ibm.com>
Date: Thu, 20 Feb 2025 13:59:44 -0500
In-Reply-To: <20250220181604.GA2709977@pevik>
References: <20250220160054.12149-1-zohar@linux.ibm.com>
	 <20250220160054.12149-3-zohar@linux.ibm.com>
	 <20250220181604.GA2709977@pevik>
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
X-Proofpoint-GUID: xY-Nj3lZjWuHGwMvP2VebYEjdVSNyG5j
X-Proofpoint-ORIG-GUID: xY-Nj3lZjWuHGwMvP2VebYEjdVSNyG5j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_08,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200130

On Thu, 2025-02-20 at 19:16 +0100, Petr Vorel wrote:
> Hi Mimi,
>=20
> > Kernel patch "ima: limit the number of ToMToU integrity violations"
> > prevents superfluous ToMToU violations.=C2=A0 Add corresponding LTP tes=
ts.
>=20
> > Link:
> > https://lore.kernel.org/linux-integrity/20250219162131.416719-3-zohar@l=
inux.ibm.com/
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
>=20
> Unfortunately tests fail on both mainline kernel and kernel with your pat=
ches.

The new LTP IMA violations patches should fail without the associated kerne=
l patches.
>=20
> Any hint what could be wrong?

Of course it's dependent on the IMA policy.  The tests assume being booted =
with the IMA
TCB measurement policy or similar policy being loaded.  Can you share the I=
MA policy?
e.g. cat /sys/kernel/security/ima/policy

thanks,

Mimi

>=20
> Mainline kernel (on kernel with your patches it looks the same):
> ima_violations 1 TINFO: Running: ima_violations.sh
> ima_violations 1 TINFO: Tested kernel: Linux ts 6.13.0-2.g0127a37-default=
 #1 SMP
> PREEMPT_DYNAMIC Thu Jan 23 11:21:55 UTC 2025 (0127a37) x86_64 x86_64 x86_=
64 GNU/Linux
> ima_violations 1 TINFO: Using /tmp/LTP_ima_violations.cKm34XVZk2 as tmpdi=
r (tmpfs
> filesystem)
> tst_device.c:99: TINFO: Found free device 0 '/dev/loop0'
> ima_violations 1 TINFO: Formatting ext3 with opts=3D'/dev/loop0'
> ima_violations 1 TINFO: Mounting device: mount -t ext3 /dev/loop0
> /tmp/LTP_ima_violations.cKm34XVZk2/mntpoint
> ima_violations 1 TINFO: timeout per run is 0h 5m 0s
> ima_violations 1 TINFO: IMA kernel config:
> ima_violations 1 TINFO: CONFIG_IMA=3Dy
> ima_violations 1 TINFO: CONFIG_IMA_MEASURE_PCR_IDX=3D10
> ima_violations 1 TINFO: CONFIG_IMA_LSM_RULES=3Dy
> ima_violations 1 TINFO: CONFIG_IMA_NG_TEMPLATE=3Dy
> ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_TEMPLATE=3D"ima-ng"
> ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH_SHA256=3Dy
> ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH=3D"sha256"
> ima_violations 1 TINFO: CONFIG_IMA_READ_POLICY=3Dy
> ima_violations 1 TINFO: CONFIG_IMA_APPRAISE=3Dy
> ima_violations 1 TINFO: CONFIG_IMA_ARCH_POLICY=3Dy
> ima_violations 1 TINFO: CONFIG_IMA_APPRAISE_BOOTPARAM=3Dy
> ima_violations 1 TINFO: CONFIG_IMA_APPRAISE_MODSIG=3Dy
> ima_violations 1 TINFO: CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=3Dy
> ima_violations 1 TINFO: CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=3Dy
> ima_violations 1 TINFO: CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=3Dy
> ima_violations 1 TINFO: CONFIG_IMA_DISABLE_HTABLE=3Dy
> ima_violations 1 TINFO: /proc/cmdline: BOOT_IMAGE=3D/boot/vmlinuz-6.13.0-=
2.g0127a37-
> default root=3DUUID=3De36b2366-1af2-4408-903c-1fca82c60f4c splash=3Dsilen=
t video=3D1024x768
> plymouth.ignore-serial-consoles console=3DttyS0 console=3Dtty kernel.soft=
lockup_panic=3D1
> resume=3D/dev/disk/by-uuid/c3b865f9-5d5b-410e-a6d1-9ebcf721584c mitigatio=
ns=3Dauto
> security=3Dapparmor ignore_loglevel
> ima_violations 1 TINFO: $TMPDIR is on tmpfs =3D> run on loop device
> ima_violations 1 TINFO: test requires IMA policy:
> measure func=3DFILE_CHECK mask=3D^MAY_READ euid=3D0
> measure func=3DFILE_CHECK mask=3D^MAY_READ uid=3D0
> ima_violations 1 TINFO: SUT has required policy content
> ima_violations 1 TINFO: using log /var/log/audit/audit.log
> ima_violations 1 TINFO: verify open writers violation
> ima_violations 1 TFAIL: open_writers too many violations added
> ima_violations 2 TINFO: verify ToMToU violation
> ima_violations 2 TFAIL: ToMToU too many violations added
> ima_violations 3 TINFO: verify open_writers using mmapped files
> tst_test.c:1900: TINFO: LTP version: 20250130-22-gcd2215702f
> tst_test.c:1904: TINFO: Tested kernel: 6.13.0-2.g0127a37-default #1 SMP P=
REEMPT_DYNAMIC
> Thu Jan 23 11:21:55 UTC 2025 (0127a37) x86_64
> tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> tst_kconfig.c:676: TINFO: CONFIG_FAULT_INJECTION kernel option detected w=
hich might slow
> the execution
> tst_test.c:1722: TINFO: Overall timeout per run is 0h 02m 00s
> ima_mmap.c:38: TINFO: sleep 3s
> ima_violations 3 TFAIL: open_writers too many violations added
> ima_mmap.c:41: TPASS: test completed
>=20
> Summary:
> passed=C2=A0=C2=A0 1
> failed=C2=A0=C2=A0 0
> broken=C2=A0=C2=A0 0
> skipped=C2=A0 0
> warnings 0
> ima_violations 4 TINFO: verify limiting single open writer violation
> ima_violations 4 TFAIL: open_writers too many violations added
> ima_violations 5 TINFO: verify limiting multiple open writers violations
> ima_violations 5 TFAIL: open_writers too many violations added
> ima_violations 6 TINFO: verify new open writer causes additional violatio=
n
> ima_violations 6 TFAIL: open_writers too many violations added
> ima_violations 7 TINFO: verify limiting single open reader ToMToU violati=
ons
> ima_violations 7 TFAIL: ToMToU too many violations added
> ima_violations 8 TINFO: verify new open reader causes additional ToMToU v=
iolation
> ima_violations 8 TFAIL: ToMToU too many violations added
>=20
> Kind regards,
> Petr
>=20


