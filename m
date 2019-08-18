Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E393E91A59
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2019 01:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfHRX6Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 18 Aug 2019 19:58:25 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33124 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbfHRX6Z (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 18 Aug 2019 19:58:25 -0400
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 54995DC0C941E6D47D1B;
        Mon, 19 Aug 2019 00:58:21 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.36) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 19 Aug 2019 00:58:14 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <linux-integrity@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>, <zohar@linux.ibm.com>,
        <dmitry.kasatkin@huawei.com>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [WIP][RFC][PATCH 0/3] Introduce Infoflow LSM
Date:   Mon, 19 Aug 2019 01:57:42 +0200
Message-ID: <20190818235745.1417-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.154]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch set introduces a new security module called Infoflow LSM. Its
main purpose is to enforce the Clark-Wilson integrity policy, in order
to protect mutable files against modifications from processes outside the
Trusted Computing Base (TCB). With this protection, mutable files inside
the TCB can be safely excluded from measurement by Integrity Measurement
Architecture (IMA), and their unknown digest won't cause a failure during
the remote attestation process.

Infoflow LSM takes advantage of the LSM stacking capability and enforces
security decisions on top of other label-based LSMs such as SELinux and
SMACK. The main benefit of this design choice is that it is not necessary
to modify the policy of the existing LSMs.

Infoflow LSM has three main modes of operation:
- discover: discovers process operations based on which the information
            flow analysis can be performed and the TCB can be determined;
- enforce: enforce the Clark-Wilson policy, depending on the TCB previously
           determined
- permissive: allow operations that would be denied, but show them in a
              file in securityfs

Discovered operations can be obtained from
/sys/kernel/security/infoflow/rules and are in the format:

allow subj obj:class { permissions };

The TCB can be determined from discovered operations with the RA Verifier
tool available at:

https://github.com/euleros/ra-verifier

The tool takes as input the application that must be protected or the
initial TCB. It will then tells which subjects violate the Clark-Wilson
policy. Possible resolution strategies are to add a subject to the TCB or
to add a filtering interface to the TCB subject that reads a low integrity
object.

RA Verifier produces a policy for Infoflow LSM, with the list of TCB
subjects, objects and filtering interfaces.

This patch set can be retrieved at:

https://github.com/euleros/linux

Roberto


Roberto Sassu (3):
  security: introduce call_int_hook_and() macro
  lsm notifier: distinguish between state change and policy change
  security: add infoflow LSM

 .../admin-guide/kernel-parameters.txt         |  23 +
 drivers/infiniband/core/device.c              |   2 +-
 include/linux/lsm_audit.h                     |   3 +
 include/linux/security.h                      |   1 +
 include/uapi/linux/xattr.h                    |   2 +
 security/Kconfig                              |   1 +
 security/Makefile                             |   2 +
 security/infoflow/Kconfig                     |   6 +
 security/infoflow/Makefile                    |   7 +
 security/infoflow/infoflow.h                  | 173 ++++
 security/infoflow/infoflow_access.c           | 182 ++++
 security/infoflow/infoflow_ctx.c              | 342 ++++++++
 security/infoflow/infoflow_fs.c               | 479 +++++++++++
 security/infoflow/infoflow_lsm.c              | 778 ++++++++++++++++++
 security/integrity/evm/evm_main.c             |   1 +
 security/security.c                           |  19 +-
 security/selinux/avc.c                        |   2 +-
 security/selinux/selinuxfs.c                  |   2 +-
 18 files changed, 2020 insertions(+), 5 deletions(-)
 create mode 100644 security/infoflow/Kconfig
 create mode 100644 security/infoflow/Makefile
 create mode 100644 security/infoflow/infoflow.h
 create mode 100644 security/infoflow/infoflow_access.c
 create mode 100644 security/infoflow/infoflow_ctx.c
 create mode 100644 security/infoflow/infoflow_fs.c
 create mode 100644 security/infoflow/infoflow_lsm.c

-- 
2.17.1

