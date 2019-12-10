Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35714119A73
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2019 22:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfLJVzU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Dec 2019 16:55:20 -0500
Received: from mga04.intel.com ([192.55.52.120]:35698 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbfLJVzU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Dec 2019 16:55:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 13:55:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; 
   d="scan'208";a="264663126"
Received: from tstruk-mobl1.jf.intel.com (HELO [127.0.1.1]) ([10.7.196.67])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Dec 2019 13:55:19 -0800
Subject: [PATCH] tpm: selftests: cleanup after unseal with wrong policy test
From:   Tadeusz Struk <tadeusz.struk@intel.com>
To:     jarkko.sakkinen@linux.intel.com
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        tadeusz.struk@intel.com
Date:   Tue, 10 Dec 2019 13:55:20 -0800
Message-ID: <157601492070.15343.464606544465753590.stgit@tstruk-mobl1>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Unseal with wrong policy tests affects DA lockout and eventually
causes to fail with:
"ProtocolError: TPM_RC_LOCKOUT: cc=0x00000153, rc=0x00000921",
when the test runs multiple times. Send tpm clear command
after the test to reset the DA counters.

Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
---
 tools/testing/selftests/tpm2/test_smoke.sh |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/tpm2/test_smoke.sh b/tools/testing/selftests/tpm2/test_smoke.sh
index 80521d46220c..22ae4183f2b9 100755
--- a/tools/testing/selftests/tpm2/test_smoke.sh
+++ b/tools/testing/selftests/tpm2/test_smoke.sh
@@ -2,3 +2,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 
 python -m unittest -v tpm2_tests.SmokeTest
+
+CLEAR_CMD=$(which tpm2_clear)
+if [ -n $CLEAR_CMD ]; then
+	tpm2_clear -T device
+fi

