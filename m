Return-Path: <linux-integrity+bounces-8385-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDrUAn5cf2m0owIAu9opvQ
	(envelope-from <linux-integrity+bounces-8385-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 01 Feb 2026 15:00:30 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1792C60A2
	for <lists+linux-integrity@lfdr.de>; Sun, 01 Feb 2026 15:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BED26300D169
	for <lists+linux-integrity@lfdr.de>; Sun,  1 Feb 2026 14:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2A9350281;
	Sun,  1 Feb 2026 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X7XFKVge"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A076433B96B;
	Sun,  1 Feb 2026 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769954405; cv=none; b=jnYU1/h5N2SZY75ikStfwrwYmM3IDDDY4+TsUA6QZc2mLSeYDnsPJKDn03IsMbSoprUNf6HXLGe7Mu++lz4nuui8G5rJjgP9m+wgmTw72YWz7CcnEOyyNJJKQX0r+Hewhq9SWLijVlgdlbWvamB+WM1gNpSmpsuvZpmVbAQ3phw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769954405; c=relaxed/simple;
	bh=9CUyWFqvZUZE77tGvED5NwKrPM+1OYeAo+JY1bW9jlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GouuS30UOLvCH2eeTxAL+I6X3G3F9G1g5lKjgHZjRp/2BY8YACauRTyFziw8ZKJGfHj9tbWQXHDixU1GeiI4uWYIU5UyLV2oKR7/JyeMuuAqamxCWuPjtUVK/UR8IzkeJ4fDwpE/hpDAuMtpyTBQKfBkFh6IG6G55JJyQQbIbtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X7XFKVge; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 611AOUH5023281;
	Sun, 1 Feb 2026 13:59:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=YvJIjmim0OikdErSegBjMhVuxU2jaiv07AsIxZxgl
	a0=; b=X7XFKVgeDrxEOSCp7xsPSE3zz3J9PNHiSZAY4bvGqdH6BR0BNlD7dK5oS
	qc02131/KdB8r08Rl7wVk11gttptp66usg0tlqeWXqqp2wGtiVCOarVcvU2lIpG2
	P2QRJ5Q99JuQlj417Fly7Jnzr//h0eTjRfSYha0Y5womAv+ZcAw+SuRLXo3qRdLz
	spIaXGwKQ9XMfNqKTXitGwghYUiUdkhHt2Twgolywd1AqELLziBfgQly7JZPBw4o
	kd+YplyyogeSLcXoYqutjrlw/4QNHg1o+um8IISc45Rad4FG62AXZWMfFGuEp5Vl
	7wSGEfEcE2KSzUwQau4hrbyEsStuA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c185gkt4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Feb 2026 13:59:40 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 611DxdOo032705;
	Sun, 1 Feb 2026 13:59:39 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c185gkt4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Feb 2026 13:59:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 611AVQuf027348;
	Sun, 1 Feb 2026 13:59:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1xs11ajv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Feb 2026 13:59:38 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 611DxYrQ58917196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 1 Feb 2026 13:59:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF51D2004D;
	Sun,  1 Feb 2026 13:59:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0ECE20040;
	Sun,  1 Feb 2026 13:59:31 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com.com (unknown [9.39.20.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  1 Feb 2026 13:59:31 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, ssrish@linux.ibm.com
Subject: [PATCH v6 0/6] Extend "trusted" keys to support a new trust source named the PowerVM Key Wrapping Module (PKWM)
Date: Sun,  1 Feb 2026 19:29:24 +0530
Message-ID: <20260201135930.898721-1-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=UdxciaSN c=1 sm=1 tr=0 ts=697f5c4c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
 a=ppIsY0g9Vwzl1MCcPLUA:9
X-Proofpoint-GUID: aJ_UsP8Af8NIVjDlrBxAJylb5H1sc0GD
X-Proofpoint-ORIG-GUID: FpMvTFeFkjJEkxWfDYsJlCrSQ1UB72lw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAxMDEyMCBTYWx0ZWRfX7IG/S9+2pWPF
 4gwkD4uxRVHNZ6DgjQWkoqTkNzAn+/MmRONUMDpNCzmwTw28eiLwE6rCbq1CQnWAsut/913SEV+
 ePJLMUYkYDH+u5FA1Y8DzZz86FW9l9NJvaw7woqyIYItKi+d7mo84Wjg4JPT+FqwuEG8GUWJbwc
 lJXyhaT6m0I8a+sJMdQfehG9Ve098AMvY+78eDJG6YLkoi4XoQjW19HW07tgt85TCRgAOIPWbCI
 iNcpLfGKYLP6kCvgdCOtVFsaKfeYM7hT3FMCSwdcLrhXt8XPHeWigrKl+OZaUD0ggi2GRBloOcu
 e3kNB3E6Mj+TpCAet6Xll8li96phGMbhBQwVPLdvGv1f/F3NbPdliN4AzwljUUF83ddf5N8s2Yq
 tvL2xjhrcGhrab/kmV9kBn/uLpeeslXJvQBO3OqPvSpwF2HsUcTV4Ssmy+/mj5dCyqnOmUhvpWK
 s+fBiopBzFCKgKHN3kw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-01_05,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602010120
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8385-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,csgroup.eu,HansenPartnership.com,kernel.org,vger.kernel.org];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ssrish@linux.ibm.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: A1792C60A2
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

v6:

* Patch 1 to Patch 3:
  - Add Nayna's Tested-by tag
* Patch 4
  - Fix build error reported by kernel test robot <lkp@intel.com>
  - Add Nayna's Tested-by tag
* Patch 5
  - Add Nayna's Tested-by tag

v5:

* Patch 1 to Patch 3:
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
 arch/powerpc/platforms/pseries/plpks.c        | 688 +++++++++++++++++-
 include/keys/trusted-type.h                   |   7 +-
 include/keys/trusted_pkwm.h                   |  33 +
 security/keys/trusted-keys/Kconfig            |   8 +
 security/keys/trusted-keys/Makefile           |   2 +
 security/keys/trusted-keys/trusted_core.c     |   6 +-
 security/keys/trusted-keys/trusted_pkwm.c     | 190 +++++
 20 files changed, 1207 insertions(+), 201 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-plpks
 create mode 100644 arch/powerpc/platforms/pseries/plpks-sysfs.c
 create mode 100644 include/keys/trusted_pkwm.h
 create mode 100644 security/keys/trusted-keys/trusted_pkwm.c

-- 
2.47.3


