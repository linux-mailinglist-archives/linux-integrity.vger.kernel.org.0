Return-Path: <linux-integrity+bounces-5065-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03058A4E1DC
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 15:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9EFD173F52
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 14:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7EF20898D;
	Tue,  4 Mar 2025 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mnZSFsSf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6511B206F10
	for <linux-integrity@vger.kernel.org>; Tue,  4 Mar 2025 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099495; cv=none; b=GGMOhWS8Bkm2y/i8GUNyDx84IfD+mTsQ4iyc33rwECAsDVBf6NZ2/0FlsL0l/vr02BzDSet5P9b4L4zQ5yp5x6iaVtKUklJUVtPhfzUenEy1kwTyAFbFAwZBAZuLQOK1RmW7zZ9h8aTPlq+I2bXtQVcMkZMcZqOBiVyfHqKPXbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099495; c=relaxed/simple;
	bh=xlvM0+sdQ85oMpYQi2XCWgMkWwgS8jEcB6Q+13rN4mQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oWZQO8N9BUV86POjjvCBEm/g2JWCNnzzZy6Uy25cE9yaGeeTsUM6+lf2XEa4j8iAtP0rAtrMniiRIhhaMdPP5GWVfEHiw6XCVgz3g1iLOKdfUxxt9wt3O+0eWD5XcW73mmhs+ONbZsl3EgoiBeuZl5pkNoWBfolPa6ZtQY0yC30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mnZSFsSf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524E3HiY018960;
	Tue, 4 Mar 2025 14:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Rsqy3w
	mRlX27seePk++Tegua/DxyogCDF8CkwHLX0HU=; b=mnZSFsSfTUjLDv7/46oqdA
	EuZY7YNHkA/GbYMHRcEgCLV4ziYuiClKgs/x7UAbwhiwvymDOxb+Z55V/f70gknX
	AEp6kvrFgEE4rJbxx8UDrAlY1HtggOvblFeL4hqHhBB/ICuEM6A79y+tDGoi8ufT
	C2xEDBuIvvcwJ8DjoGU3BeS0UaVnB9DKDpaLYbgig/tTYKNErebCXdtGeu3lFRnD
	fBlOodsH/Z7kAzxKRp/LhM1QHt97NpOTO3jJAoCcQlPL3aR8iZjlBu1nkcM1jmR+
	QLqcqfGIpBzZc1F32nFduuR/X9o0m5KnqWPR1hBu3L2/VBEVLtUorHJIpnwgCLhg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4562xpg6n1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 14:44:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 524B2QLf008901;
	Tue, 4 Mar 2025 14:44:45 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454cxydyx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 14:44:45 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 524EiiaO32506422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 14:44:45 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0EFF5805C;
	Tue,  4 Mar 2025 14:44:44 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B8CE58054;
	Tue,  4 Mar 2025 14:44:44 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.136.132])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 14:44:44 +0000 (GMT)
Message-ID: <678478de87319625e591e8e956a57b31c700bbd2.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/4] ima_violations.sh: Update validate() to support
 multiple violations
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Date: Tue, 04 Mar 2025 09:44:43 -0500
In-Reply-To: <20250304133101.GC81126@pevik>
References: <20250304115331.524842-1-zohar@linux.ibm.com>
	 <20250304115331.524842-2-zohar@linux.ibm.com>
	 <20250304133101.GC81126@pevik>
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
X-Proofpoint-ORIG-GUID: BsKY9_2JsvEDwdH6wuc-bxTnlANNsAY2
X-Proofpoint-GUID: BsKY9_2JsvEDwdH6wuc-bxTnlANNsAY2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_06,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503040118

On Tue, 2025-03-04 at 14:31 +0100, Petr Vorel wrote:
> Hi Mimi,
>=20
> > Add support for the number of expected violations.  Include the
> > expected number of violations in the output.
>=20
> Unfortunately this works only on fixed kernel (e.g. the one with v1 of yo=
ur
> "ima: limit both open-writers and ToMToU violations" kernel patchset [1]
> (I haven't built v2 [2], but it's really just
> s/IMA_LIMIT_VIOLATIONS/IMA_EMITTED_OPENWRITERS/ =3D> it will work)
>=20
> Testing on any other kernel it fails on first testing after reboot:

Hi Petr,

I only tested by specifying the "ima_policy=3Dtcb" on the boot command line=
.  This
failure happens when loading the test specific policy rules.  If setup() is
called before loading the test specific policy rules, forcing the $LOG file
violation at setup() would be too early.

Mimi

>=20
> # LTP_IMA_LOAD_POLICY=3D1 LTPROOT=3D"/opt/ltp" PATH=3D"/opt/ltp/testcases=
/bin:$PATH" ima_violations.sh # openSUSE Tumbleweed 6.13, without your patc=
h
> tmpfs is skipped
> ima_violations 1 TINFO: Running: ima_violations.sh
> ima_violations 1 TINFO: Tested kernel: Linux tss 6.13.1-1-default #1 SMP =
PREEMPT_DYNAMIC Mon Feb  3 05:33:25 UTC 2025 (1918d13) x86_64 x86_64 x86_64=
 GNU/Linux
> ima_violations 1 TINFO: Using /tmp/LTP_ima_violations.bbGjQQLJIx as tmpdi=
r (tmpfs filesystem)
> tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
> ima_violations 1 TINFO: Formatting ext3 with opts=3D'/dev/loop0'
> ima_violations 1 TINFO: Mounting device: mount -t ext3 /dev/loop0 /tmp/LT=
P_ima_violations.bbGjQQLJIx/mntpoint
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
> ima_violations 1 TINFO: /proc/cmdline: BOOT_IMAGE=3D/boot/vmlinuz-6.13.1-=
1-default root=3DUUID=3D1e7acd04-4289-49c9-ba76-a406b385cdc9 splash=3Dsilen=
t video=3D1024x768 plymouth.ignore-serial-consoles console=3DttyS0 console=
=3Dtty kernel.softlockup_panic=3D1 mitigations=3Dauto ignore_loglevel secur=
ity=3Dselinux selinux=3D1 enforcing=3D1 ima_policy=3Dcritical_data
> ima_violations 1 TINFO: $TMPDIR is on tmpfs =3D> run on loop device
> ima_violations 1 TINFO: test requires IMA policy:
> measure func=3DFILE_CHECK mask=3D^MAY_READ euid=3D0
> measure func=3DFILE_CHECK mask=3D^MAY_READ uid=3D0
> ima_violations 1 TINFO: WARNING: missing required policy content: 'measur=
e func=3DFILE_CHECK mask=3D^MAY_READ euid=3D0'
> ima_violations 1 TINFO: trying to load '/opt/ltp/testcases/data/ima_viola=
tions/violations.policy' policy:
> measure func=3DFILE_CHECK mask=3D^MAY_READ euid=3D0
> measure func=3DFILE_CHECK mask=3D^MAY_READ uid=3D0
> ima_violations 1 TINFO: example policy successfully loaded
> ima_violations 1 TINFO: using log /var/log/audit/audit.log
> ima_violations 1 TINFO: verify open writers violation
> ima_violations 1 TFAIL: open_writers too many violations added: 3 - 1
> ima_violations 2 TINFO: verify ToMToU violation
> ima_violations 2 TFAIL: ToMToU too many violations added: 6 - 4
> ima_violations 3 TINFO: verify open_writers using mmapped files
> tst_test.c:1900: TINFO: LTP version: 20250130
> tst_test.c:1904: TINFO: Tested kernel: 6.13.1-1-default #1 SMP PREEMPT_DY=
NAMIC Mon Feb  3 05:33:25 UTC 2025 (1918d13) x86_64
> tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> tst_kconfig.c:676: TINFO: CONFIG_FAULT_INJECTION kernel option detected w=
hich might slow the execution
> tst_test.c:1722: TINFO: Overall timeout per run is 0h 02m 00s
> ima_mmap.c:38: TINFO: sleep 3s
> ima_violations 3 TFAIL: open_writers too many violations added: 9 - 7
> ima_violations 4 TINFO: WARNING: policy loaded via LTP_IMA_LOAD_POLICY=3D=
1, reboot recommended
> ima_mmap.c:41: TPASS: test completed
>=20
> It keeps failing repeatedly.
> I was able to reproduce the problem on SLE15-SP6 (6.4 based) and SLE15-SP=
4 (5.14 based).
>=20
> I tried to test also some Debian VM. It fails when run after reboot:
>=20
> # LTP_IMA_LOAD_POLICY=3D1 LTPROOT=3D"/opt/ltp" PATH=3D"/opt/ltp/testcases=
/bin:$PATH" ima_violations.sh # some Debian VM
> tmpfs is skipped
> ima_violations 1 TINFO: Running: ima_violations.sh
> ima_violations 1 TINFO: Tested kernel: Linux tt 6.9.9-amd64 #1 SMP PREEMP=
T_DYNAMIC Debian 6.9.9-1 (2024-07-13) x86_64 GNU/Linux
> ima_violations 1 TINFO: Using /tmp/LTP_ima_violations.RbX4HA7oZx as tmpdi=
r (tmpfs filesystem)
> tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
> ima_violations 1 TINFO: Formatting ext3 with opts=3D'/dev/loop0'
> ima_violations 1 TINFO: Mounting device: mount -t ext3 /dev/loop0 /tmp/LT=
P_ima_violations.RbX4HA7oZx/mntpoint
> ima_violations 1 TINFO: timeout per run is 0h 5m 0s
> ima_violations 1 TINFO: IMA kernel config:
> ima_violations 1 TINFO: CONFIG_IMA=3Dy
> ima_violations 1 TINFO: CONFIG_IMA_MEASURE_PCR_IDX=3D10
> ima_violations 1 TINFO: CONFIG_IMA_LSM_RULES=3Dy
> ima_violations 1 TINFO: CONFIG_IMA_SIG_TEMPLATE=3Dy
> ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_TEMPLATE=3D"ima-sig"
> ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH_SHA256=3Dy
> ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH=3D"sha256"
> ima_violations 1 TINFO: CONFIG_IMA_APPRAISE=3Dy
> ima_violations 1 TINFO: CONFIG_IMA_ARCH_POLICY=3Dy
> ima_violations 1 TINFO: CONFIG_IMA_APPRAISE_BOOTPARAM=3Dy
> ima_violations 1 TINFO: CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=3Dy
> ima_violations 1 TINFO: CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=3Dy
> ima_violations 1 TINFO: CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=3Dy
> ima_violations 1 TINFO: /proc/cmdline: BOOT_IMAGE=3D/boot/vmlinuz-6.9.9-a=
md64 root=3DUUID=3De55db984-06ad-45d3-9707-dcaec157aebd ro quiet
> ima_violations 1 TINFO: $TMPDIR is on tmpfs =3D> run on loop device
> ima_violations 1 TINFO: test requires IMA policy:
> measure func=3DFILE_CHECK mask=3D^MAY_READ euid=3D0
> measure func=3DFILE_CHECK mask=3D^MAY_READ uid=3D0
> ima_violations 1 TINFO: WARNING: policy is not readable, failure will be =
treated as TCONF
> ima_violations 1 TINFO: trying to load '/opt/ltp/testcases/data/ima_viola=
tions/violations.policy' policy:
> measure func=3DFILE_CHECK mask=3D^MAY_READ euid=3D0
> measure func=3DFILE_CHECK mask=3D^MAY_READ uid=3D0
> ima_violations 1 TINFO: example policy successfully loaded
> ima_violations 1 TINFO: using log /var/log/audit/audit.log
> ima_violations 1 TINFO: verify open writers violation
> ima_violations 1 TFAIL: open_writers too many violations added: 3 - 1
> ima_violations 2 TINFO: verify ToMToU violation
> ima_violations 2 TFAIL: ToMToU too many violations added: 6 - 4
> ima_violations 3 TINFO: verify open_writers using mmapped files
> tst_test.c:1890: TINFO: LTP version: 20240930-58-g15ce5997c
> tst_test.c:1894: TINFO: Tested kernel: 6.9.9-amd64 #1 SMP PREEMPT_DYNAMIC=
 Debian 6.9.9-1 (2024-07-13) x86_64
> tst_test.c:1725: TINFO: Timeout per run is 0h 00m 30s
> ima_mmap.c:38: TINFO: sleep 3s
> ima_violations 3 TFAIL: open_writers too many violations added: 9 - 7
> ima_mmap.c:41: TPASS: test completed
>=20
> Summary:
> passed   1
> failed   0
> broken   0
> skipped  0
> warnings 0
> ima_violations 4 TINFO: WARNING: policy loaded via LTP_IMA_LOAD_POLICY=3D=
1, reboot recommended
>=20
> Summary:
> passed   0
> failed   3
> broken   0
> skipped  0
> warnings 0
>=20
> But it TCONF when repeatedly run:
>=20
> ima_violations 1 TCONF: open_writers too many violations added: 13 - 11
> ima_violations 2 TINFO: verify ToMToU violation
> ima_violations 2 TCONF: ToMToU too many violations added: 16 - 14
> ima_violations 3 TINFO: verify open_writers using mmapped files
> tst_test.c:1890: TINFO: LTP version: 20240930-58-g15ce5997c
> tst_test.c:1894: TINFO: Tested kernel: 6.9.9-amd64 #1 SMP PREEMPT_DYNAMIC=
 Debian 6.9.9-1 (2024-07-13) x86_64
> tst_test.c:1725: TINFO: Timeout per run is 0h 00m 30s
> ima_mmap.c:38: TINFO: sleep 3s
> ima_violations 3 TCONF: open_writers too many violations added: 19 - 17
>=20
> I guess this is not what you expected. I wonder what is wrong.
>=20
> Kind regards,
> Petr
>=20
> [1] https://lore.kernel.org/linux-integrity/20250219162131.416719-1-zohar=
@linux.ibm.com/
> [2] https://lore.kernel.org/linux-integrity/20250228205505.476845-1-zohar=
@linux.ibm.com/
>=20


