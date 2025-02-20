Return-Path: <linux-integrity+bounces-4948-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E47A3E5BE
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 21:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE8EE17F4FC
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 20:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A764D1E2845;
	Thu, 20 Feb 2025 20:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pMXNHZYC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EC41DDC14
	for <linux-integrity@vger.kernel.org>; Thu, 20 Feb 2025 20:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740082931; cv=none; b=IFyiaWEUYNCNCgzHFWFAYl7Q4uD/5iOXJvDH76GtVh4KilQUfTKg7gdOuZ0LQqaxZFE09CXEArN164C48Gmfc/citXX815SHAlM40uZOf+lfv/OUge+NXhbu740C8a5N94iEy0J97Yjs1lexl2mV5QvzQTngweKbqRRCwq5fteM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740082931; c=relaxed/simple;
	bh=U+CFZzJVYcJo+I4M8o1pGNKai0w6mn/g52tz0Qi+qVc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IuNDEarsZ12Kr/BaCb1Se4F0NM3AYJb66Gxn3V1V1O/WfmOBhSWXWKDkC14IE1qbmxMs88LBxKOz6XZfCCYjg3S05RIgy9cWCkOtAAKoldy+xLB7uz47p6A+FnuMhIgAc7T4C4tKAAiTgpibORmgAt74ORuNw2cRWnp8RG7ziwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pMXNHZYC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KH1ghU007960;
	Thu, 20 Feb 2025 20:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=J8BXBu
	rZqtTVDqZCtDHWeGjY5WKGnG5lbCekbsOE3R4=; b=pMXNHZYCRzPINPJQ9DzH3G
	Y17b2N+qdm69gUxWqBRnL01C3GLtBAg54C/C+HEMyuIeLOBCUktXSLSzT2Y3DMqJ
	0Wr1PJ1rb4Aj1mSVTfja/m0qTabX+3AaxTexQ1n3WzRmXFDzzkaZ3dGJMx2OAO4c
	T/4gfPBwMbea4w6Hc1MLcIWh6gnwldAezBnAqEz5sSI4A8RAw3jH+9T4RlSYZWCV
	LAs5zQTJd5uyqe51sIu6FqUPunfS1z+9fG5pqylnpIF31aGaHcuzGpeJWxnmLSlG
	xC23JiXGLQ8g7Vhd+/KnOtYceJGno+3KzjdHUpYF1zzcPsJyzok1PJUiNFDxFyBA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44x1qybavn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 20:22:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51KI8aJU002343;
	Thu, 20 Feb 2025 20:22:02 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03xc287-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 20:22:02 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51KKM2Uu29557356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 20:22:02 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F76358054;
	Thu, 20 Feb 2025 20:22:02 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 784B05805A;
	Thu, 20 Feb 2025 20:22:01 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.103.152])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2025 20:22:01 +0000 (GMT)
Message-ID: <c625586b0dbc4302dfb7adf4acb0c891b74cf8bc.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 3/3] ima: additional ToMToU violation tests
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        Stefan Berger
	 <stefanb@linux.ibm.com>
Date: Thu, 20 Feb 2025 15:22:01 -0500
In-Reply-To: <20250220191342.GA2716312@pevik>
References: <20250220160054.12149-1-zohar@linux.ibm.com>
	 <20250220160054.12149-3-zohar@linux.ibm.com>
	 <20250220181604.GA2709977@pevik>
	 <fd10e47b4c8b6af0e8d37975cdf1e82133add8c3.camel@linux.ibm.com>
	 <20250220191342.GA2716312@pevik>
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
X-Proofpoint-GUID: ZnGBjgV6bORbniMK06PyUAcTeo9hcquB
X-Proofpoint-ORIG-GUID: ZnGBjgV6bORbniMK06PyUAcTeo9hcquB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_08,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200131

On Thu, 2025-02-20 at 20:13 +0100, Petr Vorel wrote:
> > On Thu, 2025-02-20 at 19:16 +0100, Petr Vorel wrote:
> > > Hi Mimi,
>=20
> > > > Kernel patch "ima: limit the number of ToMToU integrity violations"
> > > > prevents superfluous ToMToU violations.=C2=A0 Add corresponding LTP=
 tests.
>=20
> > > > Link:
> > > > https://lore.kernel.org/linux-integrity/20250219162131.416719-3-zoh=
ar@linux.ibm.com/
> > > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
>=20
> > > Unfortunately tests fail on both mainline kernel and kernel with your=
 patches.
>=20
> > The new LTP IMA violations patches should fail without the associated k=
ernel patches.
>=20
> > > Any hint what could be wrong?
>=20
> > Of course it's dependent on the IMA policy.=C2=A0 The tests assume bein=
g booted with the
> > IMA
> > TCB measurement policy or similar policy being loaded.=C2=A0 Can you sh=
are the IMA policy?
> > e.g. cat /sys/kernel/security/ima/policy
>=20
> > thanks,
>=20
> > Mimi
>=20
> Now testing on kernel *with* your patches. First run always fails, regard=
less
> whether using ima_policy=3Dtcb or
> /opt/ltp/testcases/data/ima_violations/violations.policy).
>=20
> Kind regards,
> Petr

I'm not seeing that on my test machine.  Could there be other things runnin=
g on your
system causing violations.  In anycase, your original test was less exactin=
g.   Similarly,
instead of "-eq", try using "-qe" in the following test and removing the su=
bsequent new
"gt" test.

if [ $(($num_violations_new - $num_violations)) -eq $expected_violations ];=
 then

>=20
> First run fails:
>=20
> # LTP_IMA_LOAD_POLICY=3D1 LTPROOT=3D"/opt/ltp" PATH=3D"/opt/ltp/testcases=
/bin:$PATH"
> ima_violations.sh
> (policy is /opt/ltp/testcases/data/ima_violations/violations.policy)
> ima_violations 1 TINFO: Running: ima_violations.sh=20
> ima_violations 1 TINFO: Tested kernel: Linux ts 6.14.0-rc3-1.gb6b4102-def=
ault #1 SMP
> PREEMPT_DYNAMIC Thu Feb 20 12:26:55 UTC 2025 (b6b4102) x86_64 x86_64 x86_=
64 GNU/Linux
> ima_violations 1 TINFO: Using /tmp/LTP_ima_violations.XR34KhtnDM as tmpdi=
r (tmpfs
> filesystem)
> tst_device.c:99: TINFO: Found free device 0 '/dev/loop0'
> ima_violations 1 TINFO: Formatting ext3 with opts=3D'/dev/loop0'
> ima_violations 1 TINFO: Mounting device: mount -t ext3 /dev/loop0
> /tmp/LTP_ima_violations.XR34KhtnDM/mntpoint=20
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
> ima_violations 1 TINFO: /proc/cmdline: BOOT_IMAGE=3D/boot/vmlinuz-6.14.0-=
rc3-1.gb6b4102-
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
> ima_violations 1 TINFO: WARNING: missing required policy content: 'measur=
e
> func=3DFILE_CHECK mask=3D^MAY_READ euid=3D0'
> ima_violations 1 TINFO: trying to load
> '/opt/ltp/testcases/data/ima_violations/violations.policy' policy:
> measure func=3DFILE_CHECK mask=3D^MAY_READ euid=3D0
> measure func=3DFILE_CHECK mask=3D^MAY_READ uid=3D0
> ima_violations 1 TINFO: example policy successfully loaded
> ima_violations 1 TINFO: using log /var/log/audit/audit.log
> ima_violations 1 TINFO: verify open writers violation
> ima_violations 1 TFAIL: open_writers too many violations added: 2 - 0
> ima_violations 2 TINFO: verify ToMToU violation
> ima_violations 2 TPASS: 1 ToMToU violation(s) added
> ima_violations 3 TINFO: verify open_writers using mmapped files
> tst_test.c:1900: TINFO: LTP version: 20250130-22-gcd2215702f
> tst_test.c:1904: TINFO: Tested kernel: 6.14.0-rc3-1.gb6b4102-default #1 S=
MP
> PREEMPT_DYNAMIC Thu Feb 20 12:26:55 UTC 2025 (b6b4102) x86_64
> tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> tst_kconfig.c:676: TINFO: CONFIG_FAULT_INJECTION kernel option detected w=
hich might slow
> the execution
> tst_test.c:1722: TINFO: Overall timeout per run is 0h 02m 00s
> ima_mmap.c:38: TINFO: sleep 3s
> ima_violations 3 TPASS: 1 open_writers violation(s) added
> ima_mmap.c:41: TPASS: test completed
>=20
> Summary:
> passed=C2=A0=C2=A0 1
> failed=C2=A0=C2=A0 0
> broken=C2=A0=C2=A0 0
> skipped=C2=A0 0
> warnings 0
> ima_violations 4 TINFO: verify limiting single open writer violation
> ima_violations 4 TPASS: 1 open_writers violation(s) added
> ima_violations 5 TINFO: verify limiting multiple open writers violations
> ima_violations 5 TPASS: 1 open_writers violation(s) added
> ima_violations 6 TINFO: verify new open writer causes additional violatio=
n
> ima_violations 6 TPASS: 2 open_writers violation(s) added
> ima_violations 7 TINFO: verify limiting single open reader ToMToU violati=
ons
> ima_violations 7 TPASS: 1 ToMToU violation(s) added
> ima_violations 8 TINFO: verify new open reader causes additional ToMToU v=
iolation
> ima_violations 8 TPASS: 2 ToMToU violation(s) added
> ima_violations 9 TINFO: WARNING: policy loaded via LTP_IMA_LOAD_POLICY=3D=
1, reboot
> recommended
>=20
> Summary:
> passed=C2=A0=C2=A0 7
> failed=C2=A0=C2=A0 1
> broken=C2=A0=C2=A0 0
> skipped=C2=A0 0
> warnings 0
>=20
> Second run is ok:
> # LTPROOT=3D"/opt/ltp" PATH=3D"/opt/ltp/testcases/bin:$PATH" ima_violatio=
ns.sh
> ima_violations 1 TINFO: Running: ima_violations.sh=20
> ima_violations 1 TINFO: Tested kernel: Linux ts 6.14.0-rc3-1.gb6b4102-def=
ault #1 SMP
> PREEMPT_DYNAMIC Thu Feb 20 12:26:55 UTC 2025 (b6b4102) x86_64 x86_64 x86_=
64 GNU/Linux
> ima_violations 1 TINFO: Using /var/tmp/LTP_ima_violations.SWERFjvPTp as t=
mpdir (btrfs
> filesystem)
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
> ima_violations 1 TINFO: /proc/cmdline: BOOT_IMAGE=3D/boot/vmlinuz-6.14.0-=
rc3-1.gb6b4102-
> default root=3DUUID=3De36b2366-1af2-4408-903c-1fca82c60f4c splash=3Dsilen=
t video=3D1024x768
> plymouth.ignore-serial-consoles console=3DttyS0 console=3Dtty kernel.soft=
lockup_panic=3D1
> resume=3D/dev/disk/by-uuid/c3b865f9-5d5b-410e-a6d1-9ebcf721584c mitigatio=
ns=3Dauto
> security=3Dapparmor ignore_loglevel
> ima_violations 1 TINFO: test requires IMA policy:
> measure func=3DFILE_CHECK mask=3D^MAY_READ euid=3D0
> measure func=3DFILE_CHECK mask=3D^MAY_READ uid=3D0
> ima_violations 1 TINFO: SUT has required policy content
> ima_violations 1 TINFO: using log /var/log/audit/audit.log
> ima_violations 1 TINFO: verify open writers violation
> ima_violations 1 TPASS: 1 open_writers violation(s) added
> ima_violations 2 TINFO: verify ToMToU violation
> ima_violations 2 TPASS: 1 ToMToU violation(s) added
> ima_violations 3 TINFO: verify open_writers using mmapped files
> tst_test.c:1900: TINFO: LTP version: 20250130-22-gcd2215702f
> tst_test.c:1904: TINFO: Tested kernel: 6.14.0-rc3-1.gb6b4102-default #1 S=
MP
> PREEMPT_DYNAMIC Thu Feb 20 12:26:55 UTC 2025 (b6b4102) x86_64
> tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> tst_kconfig.c:676: TINFO: CONFIG_FAULT_INJECTION kernel option detected w=
hich might slow
> the execution
> tst_test.c:1722: TINFO: Overall timeout per run is 0h 02m 00s
> ima_mmap.c:38: TINFO: sleep 3s
> ima_violations 3 TPASS: 1 open_writers violation(s) added
> ima_mmap.c:41: TPASS: test completed
>=20
> Summary:
> passed=C2=A0=C2=A0 1
> failed=C2=A0=C2=A0 0
> broken=C2=A0=C2=A0 0
> skipped=C2=A0 0
> warnings 0
> ima_violations 4 TINFO: verify limiting single open writer violation
> ima_violations 4 TPASS: 1 open_writers violation(s) added
> ima_violations 5 TINFO: verify limiting multiple open writers violations
> ima_violations 5 TPASS: 1 open_writers violation(s) added
> ima_violations 6 TINFO: verify new open writer causes additional violatio=
n
> ima_violations 6 TPASS: 2 open_writers violation(s) added
> ima_violations 7 TINFO: verify limiting single open reader ToMToU violati=
ons
> ima_violations 7 TPASS: 1 ToMToU violation(s) added
> ima_violations 8 TINFO: verify new open reader causes additional ToMToU v=
iolation
> ima_violations 8 TPASS: 2 ToMToU violation(s) added
>=20
> Summary:
> passed=C2=A0=C2=A0 8
> failed=C2=A0=C2=A0 0
> broken=C2=A0=C2=A0 0
> skipped=C2=A0 0
> warnings 0
>=20
> Reboot and running with ima_policy=3Dtcb also fails on the first time:
>=20
> # LTPROOT=3D"/opt/ltp" PATH=3D"/opt/ltp/testcases/bin:$PATH" ima_violatio=
ns.sh=20
> tmpfs is skipped
> ima_violations 1 TINFO: Running: ima_violations.sh=20
> ima_violations 1 TINFO: Tested kernel: Linux ts 6.14.0-rc3-1.gb6b4102-def=
ault #1 SMP
> PREEMPT_DYNAMIC Thu Feb 20 12:26:55 UTC 2025 (b6b4102) x86_64 x86_64 x86_=
64 GNU/Linux
> ima_violations 1 TINFO: Using /tmp/LTP_ima_violations.FKQSfezAwR as tmpdi=
r (tmpfs
> filesystem)
> tst_device.c:99: TINFO: Found free device 0 '/dev/loop0'
> ima_violations 1 TINFO: Formatting ext3 with opts=3D'/dev/loop0'
> ima_violations 1 TINFO: Mounting device: mount -t ext3 /dev/loop0
> /tmp/LTP_ima_violations.FKQSfezAwR/mntpoint=20
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
> ima_violations 1 TINFO: /proc/cmdline: BOOT_IMAGE=3D/boot/vmlinuz-6.14.0-=
rc3-1.gb6b4102-
> default root=3DUUID=3De36b2366-1af2-4408-903c-1fca82c60f4c splash=3Dsilen=
t video=3D1024x768
> plymouth.ignore-serial-consoles console=3DttyS0 console=3Dtty kernel.soft=
lockup_panic=3D1
> resume=3D/dev/disk/by-uuid/c3b865f9-5d5b-410e-a6d1-9ebcf721584c mitigatio=
ns=3Dauto
> security=3Dapparmor ignore_loglevel ima_policy=3Dtcb
> ima_violations 1 TINFO: $TMPDIR is on tmpfs =3D> run on loop device
> ima_violations 1 TINFO: booted with IMA policy: tcb
> ima_violations 1 TINFO: using log /var/log/audit/audit.log
> ima_violations 1 TINFO: verify open writers violation
> ima_violations 1 TFAIL: open_writers too many violations added: 3 - 1
> ima_violations 2 TINFO: verify ToMToU violation
> ima_violations 2 TPASS: 1 ToMToU violation(s) added
> ima_violations 3 TINFO: verify open_writers using mmapped files
> tst_test.c:1900: TINFO: LTP version: 20250130-22-gcd2215702f
> tst_test.c:1904: TINFO: Tested kernel: 6.14.0-rc3-1.gb6b4102-default #1 S=
MP
> PREEMPT_DYNAMIC Thu Feb 20 12:26:55 UTC 2025 (b6b4102) x86_64
> tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> tst_kconfig.c:676: TINFO: CONFIG_FAULT_INJECTION kernel option detected w=
hich might slow
> the execution
> tst_test.c:1722: TINFO: Overall timeout per run is 0h 02m 00s
> ima_mmap.c:38: TINFO: sleep 3s
> ima_violations 3 TPASS: 1 open_writers violation(s) added
> ima_mmap.c:41: TPASS: test completed
>=20
> Summary:
> passed=C2=A0=C2=A0 1
> failed=C2=A0=C2=A0 0
> broken=C2=A0=C2=A0 0
> skipped=C2=A0 0
> warnings 0
> ima_violations 4 TINFO: verify limiting single open writer violation
> ima_violations 4 TPASS: 1 open_writers violation(s) added
> ima_violations 5 TINFO: verify limiting multiple open writers violations
> ima_violations 5 TPASS: 1 open_writers violation(s) added
> ima_violations 6 TINFO: verify new open writer causes additional violatio=
n
> ima_violations 6 TPASS: 2 open_writers violation(s) added
> ima_violations 7 TINFO: verify limiting single open reader ToMToU violati=
ons
> ima_violations 7 TPASS: 1 ToMToU violation(s) added
> ima_violations 8 TINFO: verify new open reader causes additional ToMToU v=
iolation
> ima_violations 8 TPASS: 2 ToMToU violation(s) added
>=20
> Summary:
> passed=C2=A0=C2=A0 7
> failed=C2=A0=C2=A0 1
> broken=C2=A0=C2=A0 0
> skipped=C2=A0 0
> warnings 0
>=20
> Second and later run is again OK
> # LTPROOT=3D"/opt/ltp" PATH=3D"/opt/ltp/testcases/bin:$PATH" ima_violatio=
ns.sh=20
> tmpfs is skipped
> ima_violations 1 TINFO: Running: ima_violations.sh=20
> ima_violations 1 TINFO: Tested kernel: Linux ts 6.14.0-rc3-1.gb6b4102-def=
ault #1 SMP
> PREEMPT_DYNAMIC Thu Feb 20 12:26:55 UTC 2025 (b6b4102) x86_64 x86_64 x86_=
64 GNU/Linux
> ima_violations 1 TINFO: Using /tmp/LTP_ima_violations.1Qf6qJuSoo as tmpdi=
r (tmpfs
> filesystem)
> tst_device.c:99: TINFO: Found free device 0 '/dev/loop0'
> ima_violations 1 TINFO: Formatting ext3 with opts=3D'/dev/loop0'
> ima_violations 1 TINFO: Mounting device: mount -t ext3 /dev/loop0
> /tmp/LTP_ima_violations.1Qf6qJuSoo/mntpoint=20
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
> ima_violations 1 TINFO: /proc/cmdline: BOOT_IMAGE=3D/boot/vmlinuz-6.14.0-=
rc3-1.gb6b4102-
> default root=3DUUID=3De36b2366-1af2-4408-903c-1fca82c60f4c splash=3Dsilen=
t video=3D1024x768
> plymouth.ignore-serial-consoles console=3DttyS0 console=3Dtty kernel.soft=
lockup_panic=3D1
> resume=3D/dev/disk/by-uuid/c3b865f9-5d5b-410e-a6d1-9ebcf721584c mitigatio=
ns=3Dauto
> security=3Dapparmor ignore_loglevel ima_policy=3Dtcb
> ima_violations 1 TINFO: $TMPDIR is on tmpfs =3D> run on loop device
> ima_violations 1 TINFO: booted with IMA policy: tcb
> ima_violations 1 TINFO: using log /var/log/audit/audit.log
> ima_violations 1 TINFO: verify open writers violation
> ima_violations 1 TPASS: 1 open_writers violation(s) added
> ima_violations 2 TINFO: verify ToMToU violation
> ima_violations 2 TPASS: 1 ToMToU violation(s) added
> ima_violations 3 TINFO: verify open_writers using mmapped files
> tst_test.c:1900: TINFO: LTP version: 20250130-22-gcd2215702f
> tst_test.c:1904: TINFO: Tested kernel: 6.14.0-rc3-1.gb6b4102-default #1 S=
MP
> PREEMPT_DYNAMIC Thu Feb 20 12:26:55 UTC 2025 (b6b4102) x86_64
> tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> tst_kconfig.c:676: TINFO: CONFIG_FAULT_INJECTION kernel option detected w=
hich might slow
> the execution
> tst_test.c:1722: TINFO: Overall timeout per run is 0h 02m 00s
> ima_mmap.c:38: TINFO: sleep 3s
> ima_violations 3 TPASS: 1 open_writers violation(s) added
> ima_mmap.c:41: TPASS: test completed
>=20
> Summary:
> passed=C2=A0=C2=A0 1
> failed=C2=A0=C2=A0 0
> broken=C2=A0=C2=A0 0
> skipped=C2=A0 0
> warnings 0
> ima_violations 4 TINFO: verify limiting single open writer violation
> ima_violations 4 TPASS: 1 open_writers violation(s) added
> ima_violations 5 TINFO: verify limiting multiple open writers violations
> ima_violations 5 TPASS: 1 open_writers violation(s) added
> ima_violations 6 TINFO: verify new open writer causes additional violatio=
n
> ima_violations 6 TPASS: 2 open_writers violation(s) added
> ima_violations 7 TINFO: verify limiting single open reader ToMToU violati=
ons
> ima_violations 7 TPASS: 1 ToMToU violation(s) added
> ima_violations 8 TINFO: verify new open reader causes additional ToMToU v=
iolation
> ima_violations 8 TPASS: 2 ToMToU violation(s) added
>=20
> Summary:
> passed=C2=A0=C2=A0 8
> failed=C2=A0=C2=A0 0
> broken=C2=A0=C2=A0 0
> skipped=C2=A0 0
> warnings 0
>=20


