Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FF022FC24
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jul 2020 00:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgG0Wax (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jul 2020 18:30:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:39962 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgG0Waw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jul 2020 18:30:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0CEBAAD76;
        Mon, 27 Jul 2020 22:31:02 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>,
        Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        balajib@linux.microsoft.com, linux-integrity@vger.kernel.org
Subject: [PATCH v5 0/4] IMA: kexec cmdline measurement
Date:   Tue, 28 Jul 2020 00:30:37 +0200
Message-Id: <20200727223041.13110-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi all,

sending hopefully the last version. In the end I did quite few changes,
thus sending patchset instead of merging without review.

Tested on various setup:
ima_kexec 1 TCONF: IMA policy does not specify '^measure.*func=KEXEC_CMDLINE'
---
ima_kexec 1 TPASS: kexec -s -l /boot/vmlinuz-5.3.13-1-default --append=foo passed as expected
ima_kexec 1 TPASS: kexec cmdline for --append=foo was measured correctly
ima_kexec 2 TPASS: kexec -s -l /boot/vmlinuz-5.3.13-1-default --command-line=bar passed as expected
ima_kexec 2 TPASS: kexec cmdline for --command-line=bar was measured correctly
---
ima_kexec 1 TBROK: kexec failed: kexec_file_load failed: Required key not available
---
ima_kexec 1 TWARN: policy not readable, it might not contain required measure func=KEXEC_CMDLINE
ima_kexec 1 TBROK: unable to find a correct entry for --reuse-cmdline

Kind regards,
Petr

Lachlan Sneff (1):
  IMA: Add test for kexec cmdline measurement

Petr Vorel (3):
  IMA: Rename helper to require_ima_policy_cmdline
  IMA: Add policy related helpers
  IMA/ima_keys.sh: Fix policy readability check

 runtest/ima                                   |   1 +
 .../kernel/security/integrity/ima/README.md   |   8 ++
 .../integrity/ima/datafiles/kexec.policy      |   1 +
 .../integrity/ima/tests/evm_overlay.sh        |   2 +-
 .../security/integrity/ima/tests/ima_kexec.sh | 111 ++++++++++++++++++
 .../security/integrity/ima/tests/ima_keys.sh  |  10 +-
 .../integrity/ima/tests/ima_measurements.sh   |   2 +-
 .../security/integrity/ima/tests/ima_setup.sh |  41 ++++++-
 8 files changed, 164 insertions(+), 12 deletions(-)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/kexec.policy
 create mode 100755 testcases/kernel/security/integrity/ima/tests/ima_kexec.sh

-- 
2.27.0

