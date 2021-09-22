Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D72F414836
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Sep 2021 13:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbhIVLyq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Sep 2021 07:54:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55140 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbhIVLyq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Sep 2021 07:54:46 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C9F65222CF;
        Wed, 22 Sep 2021 11:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632311595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2uYlr6b/NxsdBICfWqG6HJ4ljJcu+lACUQcJRyulBbo=;
        b=NeqNSFQlDj6gIBFH45/CbLcUZEvZtq7UNYf3vwyx2Tt+KsanNvKUEwvBIopEII65WMdl8Z
        E7hPZjFFVUQUdXTeBlwJ0aK5zIcKfmaolrOuz93PWPNYQpIsmaoUF1Zgc6tpkMxUewVYzH
        jN7TqwKtzrwGhGvrRF7YcRY9AmuXHLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632311595;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2uYlr6b/NxsdBICfWqG6HJ4ljJcu+lACUQcJRyulBbo=;
        b=GYwtGKEPhqkmTEPbqPLMontVl5P2Mivgpg+r9yw1PQHghfxiLiPGnLGkouZjhrIbrb3AoE
        FGeL8JqaMrwFVDAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97AF214289;
        Wed, 22 Sep 2021 11:53:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0CUjIysZS2F9CgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 22 Sep 2021 11:53:15 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Alex Henrie <alexh@vpitech.com>, alexhenrie24@gmail.com,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Petr Vorel <pvorel@suse.cz>
Subject: [PATCH v6 3/3] IMA: Add tests for uid, gid, fowner, and fgroup options
Date:   Wed, 22 Sep 2021 13:53:10 +0200
Message-Id: <20210922115310.5927-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922115310.5927-1-pvorel@suse.cz>
References: <20210922115310.5927-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Alex Henrie <alexh@vpitech.com>

Requires "ima: add gid support".

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Alex Henrie <alexh@vpitech.com>
[ pvorel: add test_file parameter to ima_check(), add
verify_measurement() (DRY) ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/ima                                   |  1 +
 .../integrity/ima/tests/ima_conditionals.sh   | 62 +++++++++++++++++++
 2 files changed, 63 insertions(+)
 create mode 100755 testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh

diff --git a/runtest/ima b/runtest/ima
index 29caa034a..01942eefa 100644
--- a/runtest/ima
+++ b/runtest/ima
@@ -6,4 +6,5 @@ ima_violations ima_violations.sh
 ima_keys ima_keys.sh
 ima_kexec ima_kexec.sh
 ima_selinux ima_selinux.sh
+ima_conditionals ima_conditionals.sh
 evm_overlay evm_overlay.sh
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
new file mode 100755
index 000000000..102d29756
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
@@ -0,0 +1,62 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2021 VPI Technology
+# Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
+# Author: Alex Henrie <alexh@vpitech.com>
+#
+# Verify that conditional rules work.
+
+TST_NEEDS_CMDS="chgrp chown id sg sudo"
+TST_CNT=1
+TST_NEEDS_DEVICE=1
+
+. ima_setup.sh
+
+verify_measurement()
+{
+	local request="$1"
+	local user="nobody"
+	local test_file="$PWD/test.txt"
+	local cmd="cat $test_file > /dev/null"
+
+	local value="$(id -u $user)"
+	[ "$request" = 'gid' -o "$request" = 'fgroup' ] && value="$(id -g $user)"
+
+	require_policy_writable
+
+	ROD rm -f $test_file
+
+	tst_res TINFO "verify measuring user files when requested via $request"
+	ROD echo "measure $request=$value" \> $IMA_POLICY
+	ROD echo "$(date) $request test" \> $test_file
+
+	case "$request" in
+	fgroup)
+		chgrp $user $test_file
+		$cmd
+	fowner)
+		chown $user $test_file
+		$cmd
+		;;
+	gid) sudo sg $user "sh -c '$cmd'";;
+	uid) sudo -n -u $user sh -c "$cmd";;
+	*) tst_brk TBROK "Invalid res type '$1'";;
+	esac
+
+	ima_check $test_file
+}
+
+test1()
+{
+	verify_measurement uid
+	verify_measurement fowner
+
+	if tst_kvcmp -lt 5.16; then
+		tst_brk TCONF "gid and fgroup options require kernel 5.16 or newer"
+	fi
+
+	verify_measurement gid
+	verify_measurement fgroup
+}
+
+tst_run
-- 
2.33.0

