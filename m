Return-Path: <linux-integrity+bounces-5067-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DBEA4E28D
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 16:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B489519C37A4
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 15:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A922265628;
	Tue,  4 Mar 2025 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mWgLppn0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F534209671
	for <linux-integrity@vger.kernel.org>; Tue,  4 Mar 2025 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100383; cv=none; b=ZaLlIIJUXYD83/dAxomyujUNJ53BsX0H+qc/ymaw6QF3aRV2K8oPClLO3y1vCydstSo5ndMTEb1Hq86n79+KZ7FZ4cQuOR1Fr8hw+jm8BmmIehDdqTA0/TkwaatB2suNKfzNiBfPiLJgSjprw2ZvY/OZg/TNnfkspoOthQ2gG0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100383; c=relaxed/simple;
	bh=CArDgHovjcIOScsfqlfUHgKRIpt24Di9N3fv6hPd8kA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qKwATrK3G2MWUNfuQlvzUouWQuu5peJZTli7eQYLa+AEdNJuwYNmuwUa1nYVR5JJaQ5sqX3buG0TMMCzM16hW1PLc9NynkR1ctctqsHZfetFuWzuQIXkMpzM7FezrYz4+bFA64wNMni9UdXhBAkHPIQGRMN62KHQmr30WEuGK1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mWgLppn0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524DtSBX021527;
	Tue, 4 Mar 2025 14:59:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4k/M7G
	j9QI2M4zx/FPw2VYE/oWuzsr4bvd5zCP84vU0=; b=mWgLppn0ekCaw9OGuEl6Ww
	OHgvqL+FfiCf7Oi31r1t+VC6qCnDVNQaBqqNlqSdxbY12R3flqoTIeW5w17LYcrC
	jAs9Z7IBeYuDD5+x3qoXc4wjsRXnxi7iDekfa/F5S959iLuxxwvGjXTYwcJAV0K6
	lqof4V8ggFX0RkGwTQE56aKtNAYJ74bEyf6lTmouAKao+fqwxzkqTeLLihGqkQ7X
	mioNNHVAksRqk3og/RmaJ+meHI6Jkhchv7yvZUL/7GGxmy41+n1fgta09Zh7AeBo
	hVedXE9W38Bt+hp80Ycda7EfyKbupapEv5dinNmtjSE1T2/XiqA0ziElIlepjFdQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455sw7k3g7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 14:59:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 524C9PQ3013776;
	Tue, 4 Mar 2025 14:59:33 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2kntj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 14:59:33 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 524ExX6k46793074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 14:59:33 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C89B58059;
	Tue,  4 Mar 2025 14:59:33 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2AD058043;
	Tue,  4 Mar 2025 14:59:32 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.136.132])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 14:59:32 +0000 (GMT)
Message-ID: <54cf5311ec5e0debd6dfd63669e8d01883c0ba23.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/4] ima_violations.sh: Update validate() to support
 multiple violations
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Date: Tue, 04 Mar 2025 09:59:32 -0500
In-Reply-To: <678478de87319625e591e8e956a57b31c700bbd2.camel@linux.ibm.com>
References: <20250304115331.524842-1-zohar@linux.ibm.com>
	 <20250304115331.524842-2-zohar@linux.ibm.com>
	 <20250304133101.GC81126@pevik>
	 <678478de87319625e591e8e956a57b31c700bbd2.camel@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: Yph2OAIpuoBKAC17WPHw0NHE3ABO7p6I
X-Proofpoint-GUID: Yph2OAIpuoBKAC17WPHw0NHE3ABO7p6I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_06,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040122

On Tue, 2025-03-04 at 09:44 -0500, Mimi Zohar wrote:
> On Tue, 2025-03-04 at 14:31 +0100, Petr Vorel wrote:
> > Hi Mimi,
> >=20
> > > Add support for the number of expected violations.  Include the
> > > expected number of violations in the output.
> >=20
> > Unfortunately this works only on fixed kernel (e.g. the one with v1 of =
your
> > "ima: limit both open-writers and ToMToU violations" kernel patchset [1=
]
> > (I haven't built v2 [2], but it's really just
> > s/IMA_LIMIT_VIOLATIONS/IMA_EMITTED_OPENWRITERS/ =3D> it will work)
> >=20
> > Testing on any other kernel it fails on first testing after reboot:
>=20
> Hi Petr,
>=20
> I only tested by specifying the "ima_policy=3Dtcb" on the boot command li=
ne.  This
> failure happens when loading the test specific policy rules.  If setup() =
is
> called before loading the test specific policy rules, forcing the $LOG fi=
le
> violation at setup() would be too early.

Sorry, that doesn't seem to be the case.

With the changes to validate(), even the original tests will only work on a=
 new
kernel.  I'll rework the patch set, so at least the original tests will con=
tinue
to work.

Mimi

>=20
> >=20
> > # LTP_IMA_LOAD_POLICY=3D1 LTPROOT=3D"/opt/ltp" PATH=3D"/opt/ltp/testcas=
es/bin:$PATH" ima_violations.sh # openSUSE Tumbleweed 6.13, without your pa=
tch
> > tmpfs is skipped
> > ima_violations 1 TINFO: Running: ima_violations.sh
> > ima_violations 1 TINFO: Tested kernel: Linux tss 6.13.1-1-default #1 SM=
P PREEMPT_DYNAMIC Mon Feb  3 05:33:25 UTC 2025 (1918d13) x86_64 x86_64 x86_=
64 GNU/Linux
> > ima_violations 1 TINFO: Using /tmp/LTP_ima_violations.bbGjQQLJIx as tmp=
dir (tmpfs filesystem)
> > tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
> > ima_violations 1 TINFO: Formatting ext3 with opts=3D'/dev/loop0'
> > ima_violations 1 TINFO: Mounting device: mount -t ext3 /dev/loop0 /tmp/=
LTP_ima_violations.bbGjQQLJIx/mntpoint
> > ima_violations 1 TINFO: timeout per run is 0h 5m 0s
> > ima_violations 1 TINFO: IMA kernel config:
> > ima_violations 1 TINFO: CONFIG_IMA=3Dy
> > ima_violations 1 TINFO: CONFIG_IMA_MEASURE_PCR_IDX=3D10
> > ima_violations 1 TINFO: CONFIG_IMA_LSM_RULES=3Dy
> > ima_violations 1 TINFO: CONFIG_IMA_NG_TEMPLATE=3Dy
> > ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_TEMPLATE=3D"ima-ng"
> > ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH_SHA256=3Dy
> > ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH=3D"sha256"
> > ima_violations 1 TINFO: CONFIG_IMA_READ_POLICY=3Dy
> > ima_violations 1 TINFO: CONFIG_IMA_APPRAISE=3Dy
> > ima_violations 1 TINFO: CONFIG_IMA_ARCH_POLICY=3Dy
> > ima_violations 1 TINFO: CONFIG_IMA_APPRAISE_BOOTPARAM=3Dy
> > ima_violations 1 TINFO: CONFIG_IMA_APPRAISE_MODSIG=3Dy
> > ima_violations 1 TINFO: CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=3Dy
> > ima_violations 1 TINFO: CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=3Dy
> > ima_violations 1 TINFO: CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=3Dy
> > ima_violations 1 TINFO: CONFIG_IMA_DISABLE_HTABLE=3Dy
> > ima_violations 1 TINFO: /proc/cmdline: BOOT_IMAGE=3D/boot/vmlinuz-6.13.=
1-1-default root=3DUUID=3D1e7acd04-4289-49c9-ba76-a406b385cdc9 splash=3Dsil=
ent video=3D1024x768 plymouth.ignore-serial-consoles console=3DttyS0 consol=
e=3Dtty kernel.softlockup_panic=3D1 mitigations=3Dauto ignore_loglevel secu=
rity=3Dselinux selinux=3D1 enforcing=3D1 ima_policy=3Dcritical_data
> > ima_violations 1 TINFO: $TMPDIR is on tmpfs =3D> run on loop device
> > ima_violations 1 TINFO: test requires IMA policy:
> > measure func=3DFILE_CHECK mask=3D^MAY_READ euid=3D0
> > measure func=3DFILE_CHECK mask=3D^MAY_READ uid=3D0
> > ima_violations 1 TINFO: WARNING: missing required policy content: 'meas=
ure func=3DFILE_CHECK mask=3D^MAY_READ euid=3D0'
> > ima_violations 1 TINFO: trying to load '/opt/ltp/testcases/data/ima_vio=
lations/violations.policy' policy:
> > measure func=3DFILE_CHECK mask=3D^MAY_READ euid=3D0
> > measure func=3DFILE_CHECK mask=3D^MAY_READ uid=3D0
> > ima_violations 1 TINFO: example policy successfully loaded
> > ima_violations 1 TINFO: using log /var/log/audit/audit.log
> > ima_violations 1 TINFO: verify open writers violation
> > ima_violations 1 TFAIL: open_writers too many violations added: 3 - 1
> > ima_violations 2 TINFO: verify ToMToU violation
> > ima_violations 2 TFAIL: ToMToU too many violations added: 6 - 4
> > ima_violations 3 TINFO: verify open_writers using mmapped files
> > tst_test.c:1900: TINFO: LTP version: 20250130
> > tst_test.c:1904: TINFO: Tested kernel: 6.13.1-1-default #1 SMP PREEMPT_=
DYNAMIC Mon Feb  3 05:33:25 UTC 2025 (1918d13) x86_64
> > tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> > tst_kconfig.c:676: TINFO: CONFIG_FAULT_INJECTION kernel option detected=
 which might slow the execution
> > tst_test.c:1722: TINFO: Overall timeout per run is 0h 02m 00s
> > ima_mmap.c:38: TINFO: sleep 3s
> > ima_violations 3 TFAIL: open_writers too many violations added: 9 - 7
> > ima_violations 4 TINFO: WARNING: policy loaded via LTP_IMA_LOAD_POLICY=
=3D1, reboot recommended
> > ima_mmap.c:41: TPASS: test completed
> >=20
> > It keeps failing repeatedly.
> > I was able to reproduce the problem on SLE15-SP6 (6.4 based) and SLE15-=
SP4 (5.14 based).
> >=20
> > I tried to test also some Debian VM. It fails when run after reboot:
> >=20
> > # LTP_IMA_LOAD_POLICY=3D1 LTPROOT=3D"/opt/ltp" PATH=3D"/opt/ltp/testcas=
es/bin:$PATH" ima_violations.sh # some Debian VM
> > tmpfs is skipped
> > ima_violations 1 TINFO: Running: ima_violations.sh
> > ima_violations 1 TINFO: Tested kernel: Linux tt 6.9.9-amd64 #1 SMP PREE=
MPT_DYNAMIC Debian 6.9.9-1 (2024-07-13) x86_64 GNU/Linux
> > ima_violations 1 TINFO: Using /tmp/LTP_ima_violations.RbX4HA7oZx as tmp=
dir (tmpfs filesystem)
> > tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
> > ima_violations 1 TINFO: Formatting ext3 with opts=3D'/dev/loop0'
> > ima_violations 1 TINFO: Mounting device: mount -t ext3 /dev/loop0 /tmp/=
LTP_ima_violations.RbX4HA7oZx/mntpoint
> > ima_violations 1 TINFO: timeout per run is 0h 5m 0s
> > ima_violations 1 TINFO: IMA kernel config:
> > ima_violations 1 TINFO: CONFIG_IMA=3Dy
> > ima_violations 1 TINFO: CONFIG_IMA_MEASURE_PCR_IDX=3D10
> > ima_violations 1 TINFO: CONFIG_IMA_LSM_RULES=3Dy
> > ima_violations 1 TINFO: CONFIG_IMA_SIG_TEMPLATE=3Dy
> > ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_TEMPLATE=3D"ima-sig"
> > ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH_SHA256=3Dy
> > ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH=3D"sha256"
> > ima_violations 1 TINFO: CONFIG_IMA_APPRAISE=3Dy
> > ima_violations 1 TINFO: CONFIG_IMA_ARCH_POLICY=3Dy
> > ima_violations 1 TINFO: CONFIG_IMA_APPRAISE_BOOTPARAM=3Dy
> > ima_violations 1 TINFO: CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=3Dy
> > ima_violations 1 TINFO: CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=3Dy
> > ima_violations 1 TINFO: CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=3Dy
> > ima_violations 1 TINFO: /proc/cmdline: BOOT_IMAGE=3D/boot/vmlinuz-6.9.9=
-amd64 root=3DUUID=3De55db984-06ad-45d3-9707-dcaec157aebd ro quiet
> > ima_violations 1 TINFO: $TMPDIR is on tmpfs =3D> run on loop device
> > ima_violations 1 TINFO: test requires IMA policy:
> > measure func=3DFILE_CHECK mask=3D^MAY_READ euid=3D0
> > measure func=3DFILE_CHECK mask=3D^MAY_READ uid=3D0
> > ima_violations 1 TINFO: WARNING: policy is not readable, failure will b=
e treated as TCONF
> > ima_violations 1 TINFO: trying to load '/opt/ltp/testcases/data/ima_vio=
lations/violations.policy' policy:
> > measure func=3DFILE_CHECK mask=3D^MAY_READ euid=3D0
> > measure func=3DFILE_CHECK mask=3D^MAY_READ uid=3D0
> > ima_violations 1 TINFO: example policy successfully loaded
> > ima_violations 1 TINFO: using log /var/log/audit/audit.log
> > ima_violations 1 TINFO: verify open writers violation
> > ima_violations 1 TFAIL: open_writers too many violations added: 3 - 1
> > ima_violations 2 TINFO: verify ToMToU violation
> > ima_violations 2 TFAIL: ToMToU too many violations added: 6 - 4
> > ima_violations 3 TINFO: verify open_writers using mmapped files
> > tst_test.c:1890: TINFO: LTP version: 20240930-58-g15ce5997c
> > tst_test.c:1894: TINFO: Tested kernel: 6.9.9-amd64 #1 SMP PREEMPT_DYNAM=
IC Debian 6.9.9-1 (2024-07-13) x86_64
> > tst_test.c:1725: TINFO: Timeout per run is 0h 00m 30s
> > ima_mmap.c:38: TINFO: sleep 3s
> > ima_violations 3 TFAIL: open_writers too many violations added: 9 - 7
> > ima_mmap.c:41: TPASS: test completed
> >=20
> > Summary:
> > passed   1
> > failed   0
> > broken   0
> > skipped  0
> > warnings 0
> > ima_violations 4 TINFO: WARNING: policy loaded via LTP_IMA_LOAD_POLICY=
=3D1, reboot recommended
> >=20
> > Summary:
> > passed   0
> > failed   3
> > broken   0
> > skipped  0
> > warnings 0
> >=20
> > But it TCONF when repeatedly run:
> >=20
> > ima_violations 1 TCONF: open_writers too many violations added: 13 - 11
> > ima_violations 2 TINFO: verify ToMToU violation
> > ima_violations 2 TCONF: ToMToU too many violations added: 16 - 14
> > ima_violations 3 TINFO: verify open_writers using mmapped files
> > tst_test.c:1890: TINFO: LTP version: 20240930-58-g15ce5997c
> > tst_test.c:1894: TINFO: Tested kernel: 6.9.9-amd64 #1 SMP PREEMPT_DYNAM=
IC Debian 6.9.9-1 (2024-07-13) x86_64
> > tst_test.c:1725: TINFO: Timeout per run is 0h 00m 30s
> > ima_mmap.c:38: TINFO: sleep 3s
> > ima_violations 3 TCONF: open_writers too many violations added: 19 - 17
> >=20
> > I guess this is not what you expected. I wonder what is wrong.
> >=20
> > Kind regards,
> > Petr
> >=20
> > [1] https://lore.kernel.org/linux-integrity/20250219162131.416719-1-zoh=
ar@linux.ibm.com/
> > [2] https://lore.kernel.org/linux-integrity/20250228205505.476845-1-zoh=
ar@linux.ibm.com/
> >=20
>=20
>=20


