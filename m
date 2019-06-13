Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6393A4417D
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jun 2019 18:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731222AbfFMQOv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 12:14:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:34166 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731311AbfFMQOu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 12:14:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 61ED4AD43;
        Thu, 13 Jun 2019 16:14:48 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Ignaz Forster <iforster@suse.de>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v4 3/4] ima/ima_measurements.sh: Require builtin IMA tcb policy
Date:   Thu, 13 Jun 2019 18:14:13 +0200
Message-Id: <20190613161414.29161-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190613161414.29161-1-pvorel@suse.cz>
References: <20190613161414.29161-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Although custom policy which may contain the equivalent measurement
tcb rules can be loaded via dracut, systemd or later manually from
user space, detecting it would require IMA_READ_POLICY=y. In order
to simplify the check and avoid false positives lets ignore this
option and require builtin IMA tcb policy.

Create check_ima_policy() helper in ima_setup.sh, so it can be reused in
other tests.

+ Use SPDX license identifier

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../integrity/ima/tests/ima_measurements.sh   | 23 ++++----------
 .../security/integrity/ima/tests/ima_setup.sh | 30 ++++++++++---------
 2 files changed, 21 insertions(+), 32 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index 328affc43..1b9ed85b8 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -1,19 +1,7 @@
 #!/bin/sh
 # Copyright (c) 2009 IBM Corporation
-# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program. If not, see <http://www.gnu.org/licenses/>.
+# Copyright (c) 2018-2019 Petr Vorel <pvorel@suse.cz>
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
 # Author: Mimi Zohar, zohar@ibm.vnet.ibm.com
 #
@@ -28,16 +16,17 @@ TST_NEEDS_DEVICE=1
 
 setup()
 {
-	TEST_FILE="$PWD/test.txt"
+	check_ima_policy "tcb"
 
+	TEST_FILE="$PWD/test.txt"
 	POLICY="$IMA_DIR/policy"
 	[ -f "$POLICY" ] || tst_res TINFO "not using default policy"
-
 	DIGEST_INDEX=
 
 	local template="$(tail -1 $ASCII_MEASUREMENTS | cut -d' ' -f 3)"
 	local i
 
+	# parse digest index
 	# https://www.kernel.org/doc/html/latest/security/IMA-templates.html#use
 	case "$template" in
 	ima|ima-ng|ima-sig) DIGEST_INDEX=4 ;;
@@ -56,8 +45,6 @@ setup()
 
 	[ -z "$DIGEST_INDEX" ] && tst_brk TCONF \
 		"Cannot find digest index (template: '$template')"
-
-	tst_res TINFO "IMA measurement tests assume tcb policy to be loaded (ima_policy=tcb)"
 }
 
 # TODO: find support for rmd128 rmd256 rmd320 wp256 wp384 tgr128 tgr160
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index da49eb1b2..606034fec 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -1,19 +1,7 @@
 #!/bin/sh
 # Copyright (c) 2009 IBM Corporation
-# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program. If not, see <http://www.gnu.org/licenses/>.
+# Copyright (c) 2018-2019 Petr Vorel <pvorel@suse.cz>
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
 # Author: Mimi Zohar, zohar@ibm.vnet.ibm.com
 
@@ -31,6 +19,20 @@ SYSFS="/sys"
 UMOUNT=
 TST_FS_TYPE="ext3"
 
+check_ima_policy()
+{
+	local policy="$1"
+	local i
+
+	grep -q "ima_$policy" /proc/cmdline && return
+	for i in $(cat /proc/cmdline); do
+		if grep -q '^ima_policy=' $i; then
+			grep -e "|[ ]*$policy" -e "$policy[ ]*|" -e "=$policy" $i && return
+		fi
+	done
+	tst_brk TCONF "IMA measurement tests require builtin IMA $policy policy (e.g. ima_policy=$policy kernel parameter)"
+}
+
 mount_helper()
 {
 	local type="$1"
-- 
2.21.0

