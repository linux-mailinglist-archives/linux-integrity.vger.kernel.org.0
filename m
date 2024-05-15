Return-Path: <linux-integrity+bounces-2418-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D0A8C65F7
	for <lists+linux-integrity@lfdr.de>; Wed, 15 May 2024 13:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5217B22F71
	for <lists+linux-integrity@lfdr.de>; Wed, 15 May 2024 11:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE6A7174F;
	Wed, 15 May 2024 11:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QZ67yjOW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EBD6F085;
	Wed, 15 May 2024 11:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715774170; cv=none; b=DFQEbKwh7e016RWWhASsip6AMdI5OLI7OuQpBIiFbPTwGfcLWRbnAzsk1R49D4el8BczYuBUAZcdEdMszyXj0OoQUmDF2QitjAdm597jBHavvCcDzapvErXIYH93WNOmeQCTNs22y5kC62LCMPFb9G8Gdv0pW8cMMpP9A7ss/as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715774170; c=relaxed/simple;
	bh=4pC6ilZ310P00v6s0/5Ld75NFzCzkUptLwWfKWKbUYY=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=Uu5EhZDd4YyTczRqc0U4poUXWYePECLE3JrbIUmbbb2emaVK6sZ29p3MXfLA8R3Nuar0tJak5x1fdxALniJfkhstNFMSH3yeQ7qTUVvqfo8/sXDeTnCc0tARhTAFy3vR9GCAUnhjp0X+rm52RgU2/qVvxueS2eko1ypkZoXWlNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QZ67yjOW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44FBQGSx009762;
	Wed, 15 May 2024 11:55:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=a57vU2orCPnYctsB8Gc3TVmzZjgD5+BC2tkG8ynyhrk=;
 b=QZ67yjOWGpqpQ8IhEdYdndRNJtmcGM2a49uQi0RxZvnX99DhxSoPV40E3QR4iv6LDUwy
 KNNtzGQmLdpCHiml4TWQdZ2JUH4MFLuTCUG87kJ/UC1Eoy2WpG1Rvi2T/rNJpLwVF5FQ
 D8IjS/5ePMi/VPcy2O7A83SgqR8v1Cq7uSc9xKLr/j6DZ2H6LRE1ujHTlfNrkvTwJG8I
 LEY4ViwQMy4irjQLtJoJe08pD//iKHD5jYXGSgJny41lLBS/sBgTyDUDRqLaPzldDS4p
 +z6Be3CLNX9tuIGmxfqrP0j3hl0/CGSQfosY+O5KMKoEUYcHrM+4btM1xiM6rzqqY8vA 2g== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4uyg833e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 11:55:51 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44FA3NYc006073;
	Wed, 15 May 2024 11:55:50 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y2nq2ty7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 11:55:50 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44FBtmOv19857804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 11:55:50 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3632658066;
	Wed, 15 May 2024 11:55:48 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1A1E5805E;
	Wed, 15 May 2024 11:55:47 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.158.76])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 May 2024 11:55:47 +0000 (GMT)
Message-ID: <1887e28b6bcbe1eca72028432c9e0fee7a72fbfe.camel@linux.ibm.com>
Subject: [GIT PULL] integrity: subsystem updates for v6.10
From: Mimi Zohar <zohar@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel
 <linux-kernel@vger.kernel.org>,
        Roberto Sassu
 <roberto.sassu@huaweicloud.com>
Date: Wed, 15 May 2024 07:55:47 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-25.el8_9) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tmcYkkciT_-Nlh97-3hwenfY-w5L_rwu
X-Proofpoint-GUID: tmcYkkciT_-Nlh97-3hwenfY-w5L_rwu
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_06,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxlogscore=829 priorityscore=1501 mlxscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405150082

Hi Linus,

Two IMA changes, one EVM change, a use after free bug fix, and a code cleanup to
address "-Wflex-array-member-not-at-end" warnings:

- The existing IMA {ascii, binary}_runtime_measurements lists include a hard
coded SHA1 hash.  To address this limitation, define per TPM enabled hash
algorithm {ascii, binary}_runtime_measurements lists.

- Close an IMA integrity init_module syscall measurement gap by defining a new
critical-data record.

- Enable (partial) EVM support on stacked filesystems (overlayfs).  Only EVM
portable & immutable file signatures are copied up, since they do not contain
filesystem specific metadata.

thanks,

Mimi


The following changes since commit fec50db7033ea478773b159e0e2efb135270e3b7:

  Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)

are available in the Git repository at:

  ssh://gitolite@ra.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.10

for you to fetch changes up to 9fa8e76250082a45d0d3dad525419ab98bd01658:

  ima: add crypto agility support for template-hash algorithm (2024-04-12 09:59:04 -0400)

----------------------------------------------------------------
integrity-v6.10

----------------------------------------------------------------
Enrico Bravi (1):
      ima: add crypto agility support for template-hash algorithm

Gustavo A. R. Silva (1):
      integrity: Avoid -Wflex-array-member-not-at-end warnings

Mimi Zohar (1):
      ima: define an init_module critical data record

Stefan Berger (11):
      ima: Fix use-after-free on a dentry's dname.name
      ima: Rename backing_inode to real_inode
      security: allow finer granularity in permitting copy-up of security xattrs
      evm: Implement per signature type decision in security_inode_copy_up_xattr
      evm: Use the metadata inode to calculate metadata hash
      ima: Move file-change detection variables into new structure
      evm: Store and detect metadata inode attributes changes
      ima: re-evaluate file integrity on file metadata change
      evm: Enforce signatures on unsupported filesystem for EVM_INIT_X509
      fs: Rename SB_I_EVM_UNSUPPORTED to SB_I_EVM_HMAC_UNSUPPORTED
      evm: Rename is_unsupported_fs to is_unsupported_hmac_fs

 fs/overlayfs/copy_up.c                    |   2 +-
 fs/overlayfs/super.c                      |   2 +-
 include/linux/evm.h                       |   8 ++
 include/linux/fs.h                        |   2 +-
 include/linux/integrity.h                 |  34 ++++++++
 include/linux/lsm_hook_defs.h             |   3 +-
 include/linux/security.h                  |   4 +-
 security/integrity/evm/evm.h              |   8 +-
 security/integrity/evm/evm_crypto.c       |  25 ++++--
 security/integrity/evm/evm_main.c         |  92 +++++++++++++++-----
 security/integrity/ima/ima.h              |  12 ++-
 security/integrity/ima/ima_api.c          |  32 ++++---
 security/integrity/ima/ima_appraise.c     |   4 +-
 security/integrity/ima/ima_crypto.c       |   7 +-
 security/integrity/ima/ima_fs.c           | 134 +++++++++++++++++++++++++++---
 security/integrity/ima/ima_iint.c         |   2 +-
 security/integrity/ima/ima_init.c         |   6 +-
 security/integrity/ima/ima_kexec.c        |   1 +
 security/integrity/ima/ima_main.c         |  44 +++++++---
 security/integrity/ima/ima_template_lib.c |  27 ++++--
 security/integrity/integrity.h            |  12 ++-
 security/security.c                       |   5 +-
 security/selinux/hooks.c                  |   2 +-
 security/smack/smack_lsm.c                |   2 +-
 24 files changed, 374 insertions(+), 96 deletions(-)


