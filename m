Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEE624B1B1
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Aug 2020 11:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgHTJIo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Aug 2020 05:08:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:39558 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgHTJIk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Aug 2020 05:08:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1C308B75F;
        Thu, 20 Aug 2020 09:09:05 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        Lachlan Sneff <t-josne@linux.microsoft.com>
Subject: [LTP v4 3/5] IMA: Refactor datafiles directory
Date:   Thu, 20 Aug 2020 11:08:22 +0200
Message-Id: <20200820090824.3033-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820090824.3033-1-pvorel@suse.cz>
References: <20200820090824.3033-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The IMA datafiles directory is structured so that it cannot be directly
expanded to include datafiles for tests other than `ima_policy.sh`
as it's installed into /opt/ltp/testcases/data/ima_policy.

Also not all policies are meant to be for ima_policy.sh, thus
move policies into their own directories based on the test which they
belong to. Rename policy directory to ima_policy to follow the
pattern that directory in sources match the installed directory.

Reported-by: Lachlan Sneff <t-josne@linux.microsoft.com>
Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
[ pvorel: based on Lachlan's patch, rewritten ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
The same as in v3.

 .../kernel/security/integrity/ima/datafiles/Makefile  | 10 +++++-----
 .../integrity/ima/datafiles/ima_kexec/Makefile        | 11 +++++++++++
 .../ima/datafiles/{ => ima_kexec}/kexec.policy        |  0
 .../integrity/ima/datafiles/ima_keys/Makefile         | 11 +++++++++++
 .../ima/datafiles/{ => ima_keys}/keycheck.policy      |  0
 .../integrity/ima/datafiles/ima_policy/Makefile       | 11 +++++++++++
 .../ima/datafiles/{ => ima_policy}/measure.policy     |  0
 .../datafiles/{ => ima_policy}/measure.policy-invalid |  0
 8 files changed, 38 insertions(+), 5 deletions(-)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_kexec/Makefile
 rename testcases/kernel/security/integrity/ima/datafiles/{ => ima_kexec}/kexec.policy (100%)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_keys/Makefile
 rename testcases/kernel/security/integrity/ima/datafiles/{ => ima_keys}/keycheck.policy (100%)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_policy/Makefile
 rename testcases/kernel/security/integrity/ima/datafiles/{ => ima_policy}/measure.policy (100%)
 rename testcases/kernel/security/integrity/ima/datafiles/{ => ima_policy}/measure.policy-invalid (100%)

diff --git a/testcases/kernel/security/integrity/ima/datafiles/Makefile b/testcases/kernel/security/integrity/ima/datafiles/Makefile
index 369407112..6857ccfee 100644
--- a/testcases/kernel/security/integrity/ima/datafiles/Makefile
+++ b/testcases/kernel/security/integrity/ima/datafiles/Makefile
@@ -1,6 +1,8 @@
 #
 #    testcases/kernel/security/integrity/ima/policy testcases Makefile.
 #
+#    Copyright (c) Linux Test Project, 2019-2020
+#    Copyright (c) 2020 Microsoft Corporation
 #    Copyright (C) 2009, Cisco Systems Inc.
 #
 #    This program is free software; you can redistribute it and/or modify
@@ -20,12 +22,10 @@
 # Ngie Cooper, July 2009
 #
 
-top_srcdir		?= ../../../../../..
+top_srcdir	?= ../../../../../..
 
 include	$(top_srcdir)/include/mk/env_pre.mk
 
-INSTALL_DIR		:= testcases/data/ima_policy
+SUBDIRS	:= ima_*
 
-INSTALL_TARGETS		:= measure.policy-invalid *.policy
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_kexec/Makefile b/testcases/kernel/security/integrity/ima/datafiles/ima_kexec/Makefile
new file mode 100644
index 000000000..5e0d632a7
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/datafiles/ima_kexec/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2020
+
+top_srcdir	?= ../../../../../../..
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_DIR		:= testcases/data/ima_kexec
+INSTALL_TARGETS	:= *.policy
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/security/integrity/ima/datafiles/kexec.policy b/testcases/kernel/security/integrity/ima/datafiles/ima_kexec/kexec.policy
similarity index 100%
rename from testcases/kernel/security/integrity/ima/datafiles/kexec.policy
rename to testcases/kernel/security/integrity/ima/datafiles/ima_kexec/kexec.policy
diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_keys/Makefile b/testcases/kernel/security/integrity/ima/datafiles/ima_keys/Makefile
new file mode 100644
index 000000000..452321843
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/datafiles/ima_keys/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2020
+
+top_srcdir	?= ../../../../../../..
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_DIR		:= testcases/data/ima_keys
+INSTALL_TARGETS	:= *.policy
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/security/integrity/ima/datafiles/keycheck.policy b/testcases/kernel/security/integrity/ima/datafiles/ima_keys/keycheck.policy
similarity index 100%
rename from testcases/kernel/security/integrity/ima/datafiles/keycheck.policy
rename to testcases/kernel/security/integrity/ima/datafiles/ima_keys/keycheck.policy
diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_policy/Makefile b/testcases/kernel/security/integrity/ima/datafiles/ima_policy/Makefile
new file mode 100644
index 000000000..953e21556
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/datafiles/ima_policy/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2020
+
+top_srcdir	?= ../../../../../../..
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_DIR		:= testcases/data/ima_policy
+INSTALL_TARGETS	:= *.policy-invalid *.policy
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/security/integrity/ima/datafiles/measure.policy b/testcases/kernel/security/integrity/ima/datafiles/ima_policy/measure.policy
similarity index 100%
rename from testcases/kernel/security/integrity/ima/datafiles/measure.policy
rename to testcases/kernel/security/integrity/ima/datafiles/ima_policy/measure.policy
diff --git a/testcases/kernel/security/integrity/ima/datafiles/measure.policy-invalid b/testcases/kernel/security/integrity/ima/datafiles/ima_policy/measure.policy-invalid
similarity index 100%
rename from testcases/kernel/security/integrity/ima/datafiles/measure.policy-invalid
rename to testcases/kernel/security/integrity/ima/datafiles/ima_policy/measure.policy-invalid
-- 
2.28.0

