Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439EA320F77
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Feb 2021 03:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhBVCg1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 21 Feb 2021 21:36:27 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51760 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbhBVCgZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 21 Feb 2021 21:36:25 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id A37DD20B6C40;
        Sun, 21 Feb 2021 18:35:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A37DD20B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1613961344;
        bh=LkWB75n09GiV7ZOI8kEIlFzc10vE1kUc2HXSUsQPCEc=;
        h=From:To:Cc:Subject:Date:From;
        b=LPs2CBrJ5SzLFG9t71KqMUUZo7rW7Lq9x+zAAVVHgo8vgUwg16x73i4FX4HitreXT
         8GEsg5XMvV8P/hVnN6mcwjbu3z4P1UyxCVzhp73Lsi+mzIDgMMKppqAns2wJ2pMC+J
         2TXD/EUhiK0Rjrnpfofp83T576Da8CpPmARBue3s=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     pvorel@suse.cz, zohar@linux.ibm.com
Cc:     tusharsu@linux.microsoft.com, ltp@lists.linux.it,
        linux-integrity@vger.kernel.org
Subject: [PATCH] IMA: Check for ima-buf template is not required for keys tests
Date:   Sun, 21 Feb 2021 18:34:21 -0800
Message-Id: <20210222023421.12576-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

ima-buf is the default IMA template used for all buffer measurements.
Therefore, IMA policy rule for measuring keys need not specify
an IMA template.

Update keys tests to not check for ima template in the policy rule.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
This patch is based
in https://github.com/pevik/ltp/commits/ima/selinux.v2.draft
in branch ima/selinux.v2.draft.

 testcases/kernel/security/integrity/ima/tests/ima_keys.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
index c9eef4b68..a3a7afbf7 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
@@ -15,8 +15,7 @@ TST_CLEANUP=cleanup
 . ima_setup.sh
 
 FUNC_KEYCHECK='func=KEY_CHECK'
-TEMPLATE_BUF='template=ima-buf'
-REQUIRED_POLICY="^measure.*($FUNC_KEYCHECK.*$TEMPLATE_BUF|$TEMPLATE_BUF.*$FUNC_KEYCHECK)"
+REQUIRED_POLICY="^measure.*($FUNC_KEYCHECK)"
 
 setup()
 {
@@ -33,7 +32,7 @@ check_keys_policy()
 	local pattern="$1"
 
 	if ! grep -E "$pattern" $TST_TMPDIR/policy.txt; then
-		tst_res TCONF "IMA policy must specify $pattern, $FUNC_KEYCHECK, $TEMPLATE_BUF"
+		tst_res TCONF "IMA policy must specify $pattern, $FUNC_KEYCHECK"
 		return 1
 	fi
 	return 0
-- 
2.30.0

