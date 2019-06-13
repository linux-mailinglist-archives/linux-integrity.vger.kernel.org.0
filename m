Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8748444179
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jun 2019 18:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731743AbfFMQOr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 12:14:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:34120 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731187AbfFMQOr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 12:14:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2D87AAC94;
        Thu, 13 Jun 2019 16:14:46 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Ignaz Forster <iforster@suse.de>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v4 0/4] LTP reproducer on broken IMA on overlayfs
Date:   Thu, 13 Jun 2019 18:14:10 +0200
Message-Id: <20190613161414.29161-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi, Ignaz,

changes v3->v4:
* Add helper check_ima_policy() and use it in ima_measurements.sh and
  evm_overlay.sh
* Rephrase commit message for ima_measurements.sh changes and docs
* Use SPDX-License-Identifier: GPL-2.0-or-later

Anything wrong in docs / commit message?

Kind regards,
Petr

Petr Vorel (4):
  ima: Call test's cleanup inside ima_setup.sh cleanup
  shell: Add $TST_DEVICE as default parameter to tst_umount
  ima/ima_measurements.sh: Require builtin IMA tcb policy
  ima: Add overlay test + doc

 doc/test-writing-guidelines.txt               |  4 +-
 runtest/ima                                   |  1 +
 testcases/commands/df/df01.sh                 |  7 +-
 testcases/commands/mkfs/mkfs01.sh             |  2 +-
 .../security/integrity/ima/tests/README.md    | 83 +++++++++++++++++
 .../integrity/ima/tests/evm_overlay.sh        | 93 +++++++++++++++++++
 .../integrity/ima/tests/ima_measurements.sh   | 23 +----
 .../security/integrity/ima/tests/ima_setup.sh | 42 +++++----
 .../integrity/ima/tests/ima_violations.sh     |  2 -
 testcases/lib/tst_test.sh                     |  2 +-
 10 files changed, 211 insertions(+), 48 deletions(-)
 create mode 100644 testcases/kernel/security/integrity/ima/tests/README.md
 create mode 100755 testcases/kernel/security/integrity/ima/tests/evm_overlay.sh

-- 
2.21.0

