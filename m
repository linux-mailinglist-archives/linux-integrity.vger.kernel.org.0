Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 234C561F28
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jul 2019 14:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731089AbfGHM7Q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Jul 2019 08:59:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59152 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730893AbfGHM7Q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Jul 2019 08:59:16 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x68CwBRg018656
        for <linux-integrity@vger.kernel.org>; Mon, 8 Jul 2019 08:59:15 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tm5yj0tdv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 08 Jul 2019 08:59:14 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 8 Jul 2019 13:59:12 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 8 Jul 2019 13:59:10 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x68CwvCD25166306
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Jul 2019 12:58:57 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C324742047;
        Mon,  8 Jul 2019 12:59:09 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EB3B4204B;
        Mon,  8 Jul 2019 12:59:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.110.58])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Jul 2019 12:59:08 +0000 (GMT)
Subject: [GIT PULL] integrity subsystem updates for v5.3
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 08 Jul 2019 08:58:58 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19070812-0016-0000-0000-0000029047EA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070812-0017-0000-0000-000032EDF56F
Message-Id: <1562590738.11461.9.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-08_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907080162
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Linus,

Included in this pull request are bug fixes, code clean up, and new
features.  Listed below are the main changes.

- IMA policy rules can be defined in terms of LSM labels, making the
IMA policy dependent on LSM policy label changes, in particular LSM
label deletions.  The new environment, in which IMA-appraisal is being
used, frequently updates the LSM policy and permits LSM label
deletions.

- Prevent an mmap'ed shared file opened for write from also being
mmap'ed execute.  In the long term, making this and other similar
changes at the VFS layer would be preferable.

- The IMA per policy rule template format support is needed for a
couple of new/proposed features (eg. kexec boot command line
measurement, appended signatures, and VFS provided file hashes).

- Other than the "boot-aggregate" record in the IMA measuremeent list,
all other measurements are of file data.  Measuring and storing the
kexec boot command line in the IMA measurement list is the first
buffer based measurement included in the measurement list.

(Stephen is carrying a patch to address a merge conflict with David's
"Keys: Set 4 - Key ACLs for 5.3").

thanks,

Mimi


The following changes since commit 8cdc23a3d9ec0944000ad43bad588e36afdc38cd:

  ima: show rules with IMA_INMASK correctly (2019-05-29 23:18:25 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity

for you to fetch changes up to 650b29dbdf2caf7db27cdc8bfa8fc009b28a6ce3:

  integrity: Introduce struct evm_xattr (2019-06-30 17:54:41 -0400)

----------------------------------------------------------------
Geert Uytterhoeven (1):
      integrity: Fix __integrity_init_keyring() section mismatch

Janne Karhunen (2):
      LSM: switch to blocking policy update notifiers
      ima: use the lsm policy update notifier

Matthew Garrett (1):
      IMA: support for per policy rule template formats

Mimi Zohar (2):
      x86/ima: check EFI SetupMode too
      ima: prevent a file already mmap'ed write to be mmap'ed execute

Nayna Jain (1):
      x86/ima: fix the Kconfig dependency for IMA_ARCH_POLICY

Prakhar Srivastava (3):
      IMA: Define a new hook to measure the kexec boot command line arguments
      IMA: Define a new template field buf
      KEXEC: Call ima_kexec_cmdline to measure the boot command line args

Thiago Jung Bauermann (3):
      ima: Use designated initializers for struct ima_event_data
      ima: Update MAX_TEMPLATE_NAME_LEN to fit largest reasonable definition
      integrity: Introduce struct evm_xattr

YueHaibing (1):
      ima: Make arch_policy_entry static

 Documentation/ABI/testing/ima_policy      |   6 +-
 Documentation/security/IMA-templates.rst  |   7 +-
 arch/x86/kernel/ima_arch.c                |  12 ++-
 drivers/infiniband/core/device.c          |   6 +-
 include/linux/ima.h                       |   2 +
 include/linux/security.h                  |  12 +--
 kernel/kexec_file.c                       |   9 +-
 security/integrity/digsig.c               |   5 +-
 security/integrity/evm/evm_main.c         |   8 +-
 security/integrity/ima/Kconfig            |   3 +-
 security/integrity/ima/ima.h              |  21 +++-
 security/integrity/ima/ima_api.c          |  38 +++++--
 security/integrity/ima/ima_appraise.c     |   9 +-
 security/integrity/ima/ima_init.c         |   6 +-
 security/integrity/ima/ima_main.c         | 123 ++++++++++++++++++++--
 security/integrity/ima/ima_policy.c       | 163 +++++++++++++++++++++++++-----
 security/integrity/ima/ima_template.c     |  23 +++--
 security/integrity/ima/ima_template_lib.c |  21 ++++
 security/integrity/ima/ima_template_lib.h |   4 +
 security/integrity/integrity.h            |   6 ++
 security/security.c                       |  23 +++--
 security/selinux/hooks.c                  |   2 +-
 security/selinux/selinuxfs.c              |   2 +-
 23 files changed, 413 insertions(+), 98 deletions(-)

