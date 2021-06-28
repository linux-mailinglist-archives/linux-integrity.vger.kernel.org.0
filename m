Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8549B3B6818
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Jun 2021 20:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhF1SN2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Jun 2021 14:13:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20304 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231950AbhF1SN1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Jun 2021 14:13:27 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15SI4FOn027964;
        Mon, 28 Jun 2021 14:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=oOmE9JuSCNuN6JdtSlav75wscAap/nbuPNBBwMY5CS0=;
 b=sse4daR0hKDKT76gCI41m/cHt5zjWVW9t/8347eGtrslFak8FUzl9NfqSpFtLh/Kb6hc
 YIdfJ+uJi4BwXwUmm8igfJykAilAGgFlj9bSEV8LtLxj7vJaoFtwgUY5yv8PP8s1MDNO
 9w5aeWKWyISndvc7eMz/KUrDhEVPKCi0LthYOO6IQiby05JG6GfcByOUpbEL+jFT+W3F
 lsMGNjJEWFY3O0g7zMEQXwZXO5bU/OpgaoLrZAOK6tX8Ajn+r1oWaZYfhJbHjgyaSy2u
 nLLFwD8Gn4F4rCxmIzKyReG2ym+5PP97IiiRcY/aVN9OoSuBRf9QkQwGW+v7KaE7eX6A ZA== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39fjqb1an8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 14:11:00 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15SIAvPp004675;
        Mon, 28 Jun 2021 18:10:57 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 39duv88fsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 18:10:56 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15SIAsJl34537778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 18:10:54 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A9B552077;
        Mon, 28 Jun 2021 18:10:54 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.112.169])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3FC2E5207C;
        Mon, 28 Jun 2021 18:10:53 +0000 (GMT)
Message-ID: <12f950a86631e83e9af52faa843cd335ac867af8.camel@linux.ibm.com>
Subject: [GIT PULL] integrity subsystem updates for v5.14
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 28 Jun 2021 14:10:52 -0400
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4yigeBkAkShjWLvFzVQH3tOVoWdZDmrA
X-Proofpoint-GUID: 4yigeBkAkShjWLvFzVQH3tOVoWdZDmrA
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-28_14:2021-06-25,2021-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106280118
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Linus,

The large majority of the changes are EVM portable & immutable
signature related: removing a dependency on loading an HMAC key, safely
allowing file metadata included in the EVM portable & immutable
signatures to be modified, allowing EVM signatures to fulfill IMA file
signature policy requirements, including the EVM file metadata
signature in lieu of an IMA file data signature in the measurement
list, and adding dynamic debugging of EVM file metadata.

In addition, in order to detect critical data or file change
reversions, duplicate measurement records are permitted in the IMA
measurement list.  The remaining patches address compiler, sparse, and
doc warnings.

thanks,

Mimi

The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc:

  Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.14

for you to fetch changes up to 907a399de7b0566236c480d0c01ff52220532fb1:

  evm: Check xattr size discrepancy between kernel and user (2021-06-21 08:34:21 -0400)

----------------------------------------------------------------
integrity-v5.14

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      ima: Fix fall-through warning for Clang

Lakshmi Ramasubramanian (1):
      ima: Fix warning: no previous prototype for function 'ima_add_kexec_buffer'

Mimi Zohar (5):
      evm: fix writing <securityfs>/evm overflow
      Merge branch 'misc-evm-v7' into next-integrity
      Merge branch 'verify-evm-portable-sig-v2' into next-integrity
      ima: differentiate between EVM failures in the audit log
      evm: output EVM digest calculation info

Roberto Sassu (25):
      evm: Execute evm_inode_init_security() only when an HMAC key is loaded
      evm: Load EVM key in ima_load_x509() to avoid appraisal
      evm: Refuse EVM_ALLOW_METADATA_WRITES only if an HMAC key is loaded
      evm: Introduce evm_revalidate_status()
      evm: Introduce evm_hmac_disabled() to safely ignore verification errors
      evm: Allow xattr/attr operations for portable signatures
      evm: Pass user namespace to set/remove xattr hooks
      evm: Allow setxattr() and setattr() for unmodified metadata
      evm: Deprecate EVM_ALLOW_METADATA_WRITES
      ima: Allow imasig requirement to be satisfied by EVM portable signatures
      ima: Introduce template field evmsig and write to field sig as fallback
      ima: Don't remove security.ima if file must not be appraised
      ima: Add ima_show_template_uint() template library function
      ima: Define new template fields iuid and igid
      ima: Define new template field imode
      evm: Verify portable signatures against all protected xattrs
      ima: Define new template fields xattrnames, xattrlengths and xattrvalues
      ima: Define new template evm-sig
      evm: Don't return an error in evm_write_xattrs() if audit is not enabled
      doc: Fix warning in Documentation/security/IMA-templates.rst
      ima: Set correct casting types
      ima/evm: Fix type mismatch
      ima: Include header defining ima_post_key_create_or_update()
      ima: Pass NULL instead of 0 to ima_get_action() in ima_file_mprotect()
      evm: Check xattr size discrepancy between kernel and user

Tushar Sugandhi (1):
      IMA: support for duplicate measurement records

 Documentation/ABI/testing/evm                |  36 ++-
 Documentation/security/IMA-templates.rst     |  12 +-
 include/linux/evm.h                          |  34 ++-
 include/linux/integrity.h                    |   1 +
 security/integrity/evm/evm.h                 |   1 +
 security/integrity/evm/evm_crypto.c          |  58 ++++-
 security/integrity/evm/evm_main.c            | 376 ++++++++++++++++++++++++---
 security/integrity/evm/evm_secfs.c           |  31 ++-
 security/integrity/iint.c                    |   4 +-
 security/integrity/ima/Kconfig               |   7 +
 security/integrity/ima/ima_appraise.c        |  44 +++-
 security/integrity/ima/ima_asymmetric_keys.c |   1 +
 security/integrity/ima/ima_crypto.c          |   4 +-
 security/integrity/ima/ima_fs.c              |   6 +-
 security/integrity/ima/ima_init.c            |   4 +
 security/integrity/ima/ima_kexec.c           |   1 +
 security/integrity/ima/ima_main.c            |   2 +-
 security/integrity/ima/ima_queue.c           |   5 +-
 security/integrity/ima/ima_template.c        |  30 ++-
 security/integrity/ima/ima_template_lib.c    | 211 ++++++++++++++-
 security/integrity/ima/ima_template_lib.h    |  16 ++
 security/security.c                          |   4 +-
 22 files changed, 804 insertions(+), 84 deletions(-)

