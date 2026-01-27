Return-Path: <linux-integrity+bounces-8336-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAJfAn7TeGlHtgEAu9opvQ
	(envelope-from <linux-integrity+bounces-8336-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 16:02:22 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAEF963B3
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 16:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D71A5301079A
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 14:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C1935C1B7;
	Tue, 27 Jan 2026 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n165nIZx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DC2354AF2;
	Tue, 27 Jan 2026 14:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525583; cv=none; b=tuj6yzcJ+Kp7vaGA6YwLu4Xn+OaMXGqu4rCsTIRewt4vII5Lsq9mlRlkHJFtBytTuGgSRW/Lzt24r3829+DePFMh4NNxM9qjPdjEPoFRCe2pSYajDHdm7sYKODAm3ganb4Vhiax2R7a3ITi7Cz6e0kqB3QyRbOPU3VW/I07yIf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525583; c=relaxed/simple;
	bh=mAsYwmNrx5CqjQYtt41QiO08NxElcGY5+9VNdKx3Q8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I41OvkZFDoZ962fFLA0bD3FUdbb01XAMdDf6L3qlnRx8L1dXfHqilaElg+E2Af9s3WxcgZ1SeZqJ6uD3OQwt2FNxqi/nkkm0ykkbGlx+VWbCT0YZqhhBFYYAqE2D5PrDxDuWdyzbnE9jO19CjOXVGaJcDl8Nbg4QNwn4pV3Fak0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n165nIZx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R54cWf021821;
	Tue, 27 Jan 2026 14:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=jUMYkYZEFqCMLdQSRiG3tgCgSpNq4nyFuCHURg/CL
	SE=; b=n165nIZx7U2aZSMEurVSq511quAqUkJlFjnHIX5GXgE9B/J6r0AztpaH6
	MTYXZXLRDK5gFOT6yYKsbXOank34cnW0leoslh2Ae2tthGV9DFdNjcTKDVqOIZye
	IL1thFNf4l/A/adej7jHP0rY3TwABtAlVmpQJoo9XrR4xd6aMM5Bi1wPRFnP9CjY
	kn9wQrssl8pg5M2kXQ0lLVxkwTqrilEG+mF2qZjBI2/+4VEqr794ow3N5xy3B/GK
	L+GuX8p5i1IH9UBTCK6jiY+UXh+BuHfVfdZf/u/h9tGIQFdKpv7hFMJqKWPc47it
	nduVKM20HP7zvU1YRuCPHS3mJNfcQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrtdvw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 14:52:45 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60RElmAO005883;
	Tue, 27 Jan 2026 14:52:45 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrtdvw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 14:52:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RD4EFF031030;
	Tue, 27 Jan 2026 14:52:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bw8dsh4h3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 14:52:44 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60REqeuq27328898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 14:52:40 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A99BD2004B;
	Tue, 27 Jan 2026 14:52:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD3BC20040;
	Tue, 27 Jan 2026 14:52:36 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com.com (unknown [9.124.210.108])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Jan 2026 14:52:36 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, ssrish@linux.ibm.com
Subject: [PATCH v5 0/6] Extend "trusted" keys to support a new trust source named the PowerVM Key Wrapping Module (PKWM)
Date: Tue, 27 Jan 2026 20:22:22 +0530
Message-ID: <20260127145228.48320-1-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: b1GsP9IPq-_D65tdBFIAsCcoauEc7vYW
X-Authority-Analysis: v=2.4 cv=Uptu9uwB c=1 sm=1 tr=0 ts=6978d13d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=OZ_REq_LgKhKeL2JI8IA:9
X-Proofpoint-ORIG-GUID: 2-rH4ahASdrg-IiUEunGPdG7b-lAkrfR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyMSBTYWx0ZWRfX4tsn+m73WuC6
 gpT/3mTQf1/SGcjzWsgT3vOC50D3B7i8tFI5ixosz37kEgtlnBh9FQJTJEe3s5r7myYKCXD1Efa
 5Sy7gP8SVkkCFkofv5ZfYA8vIcUtueKful0htghmuDLMqwOmf+F5caBwUq3A4xsyqWxISQpGTmS
 0I/K4syOt2XSBTFkzumxBV6uyl+tWWiLyHyaXb5FSjIkDnLU2kKGOtBirf425Ul2ybyuj2lASMn
 gT2plaNbZcr6DD4kagvEzkCdKhj0TFHRSQlyXg+/nuvryAWWmKy0wTkctOv2noJNbAsxKHwLd89
 ECesQtHO+UctlHlYCVIVg+DYarqQThziytCz5GNsfw+UFAmPH59BcKjHEi89w+ruf+O193PIPUG
 vJXY1bRtCTCsuzg7lXCq9RvPRTXH0TPCGxGtQFOPLak0/5Rx2nH2uBZdz793rvKRBFYWLutCZ2k
 u4Gkwvs1Q+D/i4IlG1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270121
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8336-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,csgroup.eu,HansenPartnership.com,kernel.org,vger.kernel.org];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ssrish@linux.ibm.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.ibm.com:mid]
X-Rspamd-Queue-Id: EBAEF963B3
X-Rspamd-Action: no action

Power11 has introduced a feature called the PowerVM Key Wrapping Module
(PKWM), where PowerVM in combination with Power LPAR Platform KeyStore
(PLPKS) [1] supports a new feature called "Key Wrapping" [2] to protect
user secrets by wrapping them using a hypervisor generated wrapping key.
This wrapping key is an AES-GCM-256 symmetric key that is stored as an
object in the PLPKS. It has policy based protections that prevents it from
being read out or exposed to the user. This wrapping key can then be used
by the OS to wrap or unwrap secrets via hypervisor calls.

This patchset intends to add the PKWM, which is a combination of IBM
PowerVM and PLPKS, as a new trust source for trusted keys. The wrapping key
does not exist by default and its generation is requested by the kernel at
the time of PKWM initialization. This key is then persisted by the PKWM and
is used for wrapping any kernel provided key, and is never exposed to the
user. The kernel is aware of only the label to this wrapping key.

Along with the PKWM implementation, this patchset includes two preparatory
patches: one fixing the kernel-doc inconsistencies in the PLPKS code and
another reorganizing PLPKS config variables in the sysfs.

Changelog:

v5:

* Patch 1:
  - Add Nayna's Reviewed-by tag
* Patch 2:
  - Add Nayna's Reviewed-by tag
* Patch 3:
  - Add Nayna's Reviewed-by tag
* Patch 4:
  - Fix build error identified by chleroy@kernel.org
  - Add Nayna's Reviewed-by tag
* Patch 5:
  - Add Reviewed-by tags from Nayna and Jarkko

v4:

* Patch 5:
  - Add a per-backend private data pointer in trusted_key_options
    to store a pointer to the backend-specific options structure
  - Minor clean-up

v3:

* Patch 2:
  - Add Mimi's Reviewed-by tag
* Patch 4:
  - Minor tweaks to some print statements
  - Fix typos
* Patch 5:
  - Fix typos
  - Add Mimi's Reviewed-by tag
* Patch 6:
  - Add Mimi's Reviewed-by tag

v2:

* Patch 2:
  - Fix build warning detected by the kernel test bot
* Patch 5:
  - Use pr_debug inside dump_options
  - Replace policyhande with wrap_flags inside dump_options
  - Provide meaningful error messages with error codes

Nayna Jain (1):
  docs: trusted-encryped: add PKWM as a new trust source

Srish Srinivasan (5):
  pseries/plpks: fix kernel-doc comment inconsistencies
  powerpc/pseries: move the PLPKS config inside its own sysfs directory
  pseries/plpks: expose PowerVM wrapping features via the sysfs
  pseries/plpks: add HCALLs for PowerVM Key Wrapping Module
  keys/trusted_keys: establish PKWM as a trusted source

 .../ABI/testing/sysfs-firmware-plpks          |  58 ++
 Documentation/ABI/testing/sysfs-secvar        |  65 --
 .../admin-guide/kernel-parameters.txt         |   1 +
 Documentation/arch/powerpc/papr_hcalls.rst    |  43 ++
 .../security/keys/trusted-encrypted.rst       |  50 ++
 MAINTAINERS                                   |   9 +
 arch/powerpc/include/asm/hvcall.h             |   4 +-
 arch/powerpc/include/asm/plpks.h              |  95 +--
 arch/powerpc/include/asm/secvar.h             |   1 -
 arch/powerpc/kernel/secvar-sysfs.c            |  21 +-
 arch/powerpc/platforms/pseries/Makefile       |   2 +-
 arch/powerpc/platforms/pseries/plpks-secvar.c |  29 -
 arch/powerpc/platforms/pseries/plpks-sysfs.c  |  96 +++
 arch/powerpc/platforms/pseries/plpks.c        | 687 +++++++++++++++++-
 include/keys/trusted-type.h                   |   7 +-
 include/keys/trusted_pkwm.h                   |  33 +
 security/keys/trusted-keys/Kconfig            |   8 +
 security/keys/trusted-keys/Makefile           |   2 +
 security/keys/trusted-keys/trusted_core.c     |   6 +-
 security/keys/trusted-keys/trusted_pkwm.c     | 190 +++++
 20 files changed, 1206 insertions(+), 201 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-plpks
 create mode 100644 arch/powerpc/platforms/pseries/plpks-sysfs.c
 create mode 100644 include/keys/trusted_pkwm.h
 create mode 100644 security/keys/trusted-keys/trusted_pkwm.c

-- 
2.47.3


