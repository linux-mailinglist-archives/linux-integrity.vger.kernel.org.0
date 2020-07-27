Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA2722FC25
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jul 2020 00:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgG0Wax (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jul 2020 18:30:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:39986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbgG0Waw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jul 2020 18:30:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 47999AEB6;
        Mon, 27 Jul 2020 22:31:02 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>,
        Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        balajib@linux.microsoft.com, linux-integrity@vger.kernel.org
Subject: [PATCH v5 2/4] IMA: Add policy related helpers
Date:   Tue, 28 Jul 2020 00:30:39 +0200
Message-Id: <20200727223041.13110-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727223041.13110-1-pvorel@suse.cz>
References: <20200727223041.13110-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v5.

 .../security/integrity/ima/tests/ima_setup.sh | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 975ce9cbb..c46f273ab 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -54,6 +54,45 @@ compute_digest()
 	return 1
 }
 
+check_policy_readable()
+{
+	if [ -f $IMA_POLICY ]; then
+		tst_res TINFO "missing $IMA_POLICY (reboot or CONFIG_IMA_WRITE_POLICY=y required)"
+		return 1
+	fi
+	cat $IMA_POLICY > /dev/null 2>/dev/null
+}
+
+require_policy_readable()
+{
+	if [ -f $IMA_POLICY ]; then
+		tst_brk TCONF "missing $IMA_POLICY (reboot or CONFIG_IMA_WRITE_POLICY=y required)"
+	fi
+	if ! check_policy_readable; then
+		tst_brk TCONF "cannot read IMA policy (CONFIG_IMA_READ_POLICY=y required)"
+	fi
+}
+
+check_ima_policy_content()
+{
+	local pattern="$1"
+	local grep_params="${2--q}"
+
+	check_policy_readable || return 1
+	grep $grep_params "$pattern" $IMA_POLICY
+}
+
+require_ima_policy_content()
+{
+	local pattern="$1"
+	local grep_params="${2--q}"
+
+	require_policy_readable
+	if ! grep $grep_params "$pattern" $IMA_POLICY; then
+		tst_brk TCONF "IMA policy does not specify '$pattern'"
+	fi
+}
+
 require_ima_policy_cmdline()
 {
 	local policy="$1"
-- 
2.27.0

