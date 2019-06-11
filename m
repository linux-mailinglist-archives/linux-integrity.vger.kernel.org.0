Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39A5A3D6CD
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jun 2019 21:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405421AbfFKTam (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jun 2019 15:30:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:48738 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404836AbfFKTam (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jun 2019 15:30:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3613FAE1D;
        Tue, 11 Jun 2019 19:30:41 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Ignaz Forster <iforster@suse.de>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v3 0/4] LTP reproducer on broken IMA on overlayfs
Date:   Tue, 11 Jun 2019 21:30:17 +0200
Message-Id: <20190611193021.17651-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi, Ignaz,

sorry for bothering you with one more version of this patchset.

Changes v2->v3:
* added one commit "ima/ima_measurements.sh: Require builtin IMA tcb policy"
to avoid false positives 
* added README.md in last commit (might be in separate commit)

Petr Vorel (4):
  ima: Call test's cleanup inside ima_setup.sh cleanup
  shell: Add $TST_DEVICE as default parameter to tst_umount
  ima/ima_measurements.sh: Require builtin IMA tcb policy
  ima: Add overlay test + doc

 doc/test-writing-guidelines.txt               |  4 +-
 runtest/ima                                   |  1 +
 testcases/commands/df/df01.sh                 |  7 +-
 testcases/commands/mkfs/mkfs01.sh             |  2 +-
 .../security/integrity/ima/tests/README.md    | 82 ++++++++++++++++
 .../integrity/ima/tests/evm_overlay.sh        | 94 +++++++++++++++++++
 .../integrity/ima/tests/ima_measurements.sh   |  3 +-
 .../security/integrity/ima/tests/ima_setup.sh | 12 ++-
 .../integrity/ima/tests/ima_violations.sh     |  2 -
 testcases/lib/tst_test.sh                     |  2 +-
 10 files changed, 192 insertions(+), 17 deletions(-)
 create mode 100644 testcases/kernel/security/integrity/ima/tests/README.md
 create mode 100755 testcases/kernel/security/integrity/ima/tests/evm_overlay.sh

-- 
2.21.0

