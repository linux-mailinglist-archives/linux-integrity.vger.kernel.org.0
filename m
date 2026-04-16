Return-Path: <linux-integrity+bounces-9208-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEuhNYLi4GlhnAAAu9opvQ
	(envelope-from <linux-integrity+bounces-9208-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2026 15:22:10 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D89AC40EBA2
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2026 15:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7B94305B6BE
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2026 13:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF023BED55;
	Thu, 16 Apr 2026 13:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ssrnp1vz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BBB3B9DA9;
	Thu, 16 Apr 2026 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776345539; cv=none; b=S0LBPHHYiTyJgBLMi8ZVvH/8/AU5il4K42PTe7wZsV6zxuDAV+W6qqy7GFWuFDvaGsKwHMj7iCcHNKn1T38tTpBkYOUfibkVsX8hCJ1ueTrjE1jtCbExCiPtT8h7KwC+wHuhQ0PSbQlv2WchEWkwMvOjLETjUR9Q6iLZEDiWMBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776345539; c=relaxed/simple;
	bh=m1iekBXqjq91pB15kUrkZ4jwreH+egi4HWeRP9WeBfI=;
	h=Message-ID:Subject:From:To:Cc:Content-Type:Date:MIME-Version; b=MyFvMyn5CU9gXeW+697WN9HIEJxtfRIV8zAJz/A2JmR1LCPgMRMmObcd5UkivG7U6LUDD+IUdZdw5aJR558pLNDnfPqln3Czu1iAPquJcaBKRqlJXOsjrj2RXOKS0Cc90XWQH1E/l5vhQe9SJaQ6Mv1M4tS+/lXYle+Ovrk8Fi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ssrnp1vz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G0wxXv1862693;
	Thu, 16 Apr 2026 13:18:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=iB+uDH0J24tnNmMVbl1meAInHK0v
	68JLJsZF/enx/Qc=; b=ssrnp1vz0/MMfSL41VU/UQRgHB848BV88cFypFtZ3gzy
	s2cb/hA34wsS7iTc2wKRcu7BSQ63J1ZgbOcOZFaQp10J7r5QMo4Tc6h3QG8SLyIj
	iecuQF7xgwKLQ763KXtwAayI6ur1z8C2qZMlKUWRYrOXuVhIk0fj74237ss7IhSp
	Lew3f9a0F49sH6dDOwzWgZN7mLgDZ3XqGfVxtmOrKGw77l0QTq6JQvOuqQwMsiaC
	w6qsWtpr30repW13liKdHee0JBBkjqmGpXZvQY54up9A8RF9ONUmNDq0WfHTP1ci
	8NS66QeU1hxjYpdhfyXBJfvjUU6wUmgroyFOvOMDGQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89pmp63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 13:18:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63GCSPsG003305;
	Thu, 16 Apr 2026 13:18:50 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4djbh94kg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 13:18:50 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63GDIoJu22413888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 13:18:50 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3200F58053;
	Thu, 16 Apr 2026 13:18:50 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95B8C58043;
	Thu, 16 Apr 2026 13:18:49 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.84.116])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Apr 2026 13:18:49 +0000 (GMT)
Message-ID: <67d7f2aba75660bf44478e5718820061390b080e.camel@linux.ibm.com>
Subject: [GIT PULL] integrity: subsystem fixes for v7.1
From: Mimi Zohar <zohar@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel	
 <linux-kernel@vger.kernel.org>,
        Roberto Sassu
 <roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 09:18:49 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wDWiu1CAVXJL4ii8FaBFCvn3Y2qTGZLm
X-Proofpoint-ORIG-GUID: wDWiu1CAVXJL4ii8FaBFCvn3Y2qTGZLm
X-Authority-Analysis: v=2.4 cv=WbE8rUhX c=1 sm=1 tr=0 ts=69e0e1bb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=tBJjWXG4mUQVYkpuR2UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDEyNyBTYWx0ZWRfX9KBYhyCjO8Hd
 hkgO8kilFdqtCmWXTIV9/ytwTdtx1oDCbzkoDmsAbqYD29AsQTCrbSvcb4BXgbBqV0GRqlanLqP
 JW6Cb1czDggcFHmRiu3qR9eVvVAnbvm/NnwnR91azJYzffotQOedHSGoajZ4LINp+Pv1gKVc46X
 I0kdem3jlTauIjrYWEgyGdL7Y4sDDbw1u2CdYWw9hO+WC0dOst/sRsW/4rsvG1mqLojt6RNSG7Z
 mLGeluV+7PjIIqGaizjVyIZW52vJel+MiJ1Jt7WiLUMPfg1snkwAHyTSfkxF3+60dqqbI2tv1PL
 d334VeEuXRaVlRcUt1D6PXf2q8KEk0t5TELG2ZOdHZbChuTHZyhGKfiL8itB5bnIYnZqJqebPw6
 3lPnGqnDjRwB6jgrkCn5ILj0X4pGhCuxCOPTjU2hfVv2dVCdw1CF4yVTH6cFgE97ElpklYDWE6O
 ieMij9Y1u2PmYnuGy1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 phishscore=0 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160127
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-9208-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.ibm.com:mid];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: D89AC40EBA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Linus,

There are 2 main changes, 1 feature removal, some code cleanup, and        =
   =20
a number of bug fixes.

Main changes:
- Detecting secure boot mode was limited to IMA.  Make detecting secure boo=
t
mode accessible to EVM and other LSMs.
- IMA sigv3 support was limited to fsverity.  Add IMA sigv3 support for IMA
regular file hashes and EVM portable signatures.

Remove:
- Remove IMA support for asychronous hash calculation originally added for
hardware acceleration.

Cleanup:
- Remove unnecessary Kconfig CONFIG_MODULE_SIG and CONFIG_KEXEC_SIG tests.
- Add descriptions of the IMA atomic flags.

Bug fixes:
- Like IMA, properly limit EVM "fix" mode.
- Define and call evm_fix_hmac() to update security.evm.
- Fallback to using i_version to detect file change for filesystems that do=
 not
support STATX_CHANGE_COOKIE.
- Address missing kernel support for configured (new) TPM hash algorithms.
- Add missing crypto_shash_final() return value.

Thanks,

Mimi

The following changes since commit 11439c4635edd669ae435eec308f4ab8a0804808=
:

  Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git=
/ tags/integrity-v7.1

for you to fetch changes up to 82bbd447199ff1441031d2eaf9afe041550cf525:

  evm: Enforce signatures version 3 with new EVM policy 'bit 3' (2026-04-01=
 10:16:53 -0400)

----------------------------------------------------------------
integrity-v7.1

----------------------------------------------------------------
Coiby Xu (5):
      integrity: Make arch_ima_get_secureboot integrity-wide
      evm: Don't enable fix mode when secure boot is enabled
      s390: Drop unnecessary CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
      evm: fix security.evm for a file with IMA signature
      ima: Add code comments to explain IMA iint cache atomic_flags

Daniel Hodges (1):
      ima: check return value of crypto_shash_final() in boot aggregate

Dmitry Safonov (1):
      ima_fs: Correctly create securityfs files for unsupported hash algos

Eric Biggers (1):
      ima: remove buggy support for asynchronous hashes

Mimi Zohar (4):
      ima: fallback to using i_version to detect file change
      ima: Define asymmetric_verify_v3() to verify IMA sigv3 signatures
      ima: add regular file data hash signature version 3 support
      ima: add support to require IMA sigv3 signatures

Nathan Chancellor (1):
      integrity: Eliminate weak definition of arch_get_secureboot()

Roberto Sassu (1):
      ima: Define and use a digest_size field in the ima_algo_desc structur=
e

Stefan Berger (2):
      integrity: Allow sigv3 verification on EVM_XATTR_PORTABLE_DIGSIG
      evm: Enforce signatures version 3 with new EVM policy 'bit 3'

Thomas Wei=C3=9Fschuh (2):
      ima: efi: Drop unnecessary check for CONFIG_MODULE_SIG/CONFIG_KEXEC_S=
IG
      powerpc/ima: Drop unnecessary check for CONFIG_MODULE_SIG

 Documentation/ABI/testing/evm                   |   1 +
 Documentation/ABI/testing/ima_policy            |  10 +-
 Documentation/admin-guide/kernel-parameters.txt |  17 --
 MAINTAINERS                                     |   1 +
 arch/Kconfig                                    |   3 +
 arch/powerpc/Kconfig                            |   1 +
 arch/powerpc/kernel/ima_arch.c                  |   8 +-
 arch/powerpc/kernel/secure_boot.c               |   6 +
 arch/s390/Kconfig                               |   2 +-
 arch/s390/kernel/Makefile                       |   1 -
 arch/s390/kernel/ima_arch.c                     |  14 -
 arch/s390/kernel/ipl.c                          |   6 +
 arch/x86/include/asm/efi.h                      |   4 +-
 arch/x86/platform/efi/efi.c                     |   2 +-
 include/linux/evm.h                             |   8 +
 include/linux/ima.h                             |   7 +-
 include/linux/secure_boot.h                     |  23 ++
 security/integrity/Makefile                     |   1 +
 security/integrity/digsig.c                     |   8 +-
 security/integrity/digsig_asymmetric.c          |  59 ++++
 security/integrity/efi_secureboot.c             |  56 ++++
 security/integrity/evm/evm.h                    |   3 +-
 security/integrity/evm/evm_main.c               |  69 ++++-
 security/integrity/ima/ima.h                    |  29 +-
 security/integrity/ima/ima_api.c                |  13 +-
 security/integrity/ima/ima_appraise.c           |  79 ++---
 security/integrity/ima/ima_crypto.c             | 390 +-------------------=
----
 security/integrity/ima/ima_efi.c                |  53 +---
 security/integrity/ima/ima_fs.c                 |  34 ++-
 security/integrity/ima/ima_main.c               |  37 ++-
 security/integrity/ima/ima_policy.c             |  22 +-
 security/integrity/integrity.h                  |  15 +-
 security/integrity/platform_certs/load_uefi.c   |   2 +-
 33 files changed, 398 insertions(+), 586 deletions(-)
 delete mode 100644 arch/s390/kernel/ima_arch.c
 create mode 100644 include/linux/secure_boot.h
 create mode 100644 security/integrity/efi_secureboot.c

