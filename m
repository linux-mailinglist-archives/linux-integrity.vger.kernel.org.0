Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0FF11D4C4
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2019 19:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbfLLSAr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Dec 2019 13:00:47 -0500
Received: from mga14.intel.com ([192.55.52.115]:9975 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730169AbfLLSAr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Dec 2019 13:00:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 09:48:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,306,1571727600"; 
   d="scan'208";a="414006063"
Received: from tstruk-mobl1.jf.intel.com (HELO [127.0.1.1]) ([10.7.196.67])
  by fmsmga005.fm.intel.com with ESMTP; 12 Dec 2019 09:48:55 -0800
Subject: [PATCH =v2 3/3] tpm: selftest: cleanup after unseal with wrong
 auth/policy test
From:   Tadeusz Struk <tadeusz.struk@intel.com>
To:     jarkko.sakkinen@linux.intel.com
Cc:     tadeusz.struk@intel.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, jgg@ziepe.ca, mingo@redhat.com,
        jeffrin@rajagiritech.edu.in, linux-integrity@vger.kernel.org,
        will@kernel.org, peterhuewe@gmx.de
Date:   Thu, 12 Dec 2019 09:48:59 -0800
Message-ID: <157617293957.8172.1404790695313599409.stgit@tstruk-mobl1>
In-Reply-To: <157617292787.8172.9586296287013438621.stgit@tstruk-mobl1>
References: <157617292787.8172.9586296287013438621.stgit@tstruk-mobl1>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Unseal with wrong auth or wrong policy test affects DA lockout
and eventually causes the tests to fail with:
"ProtocolError: TPM_RC_LOCKOUT: rc=0x00000921"
when the tests run multiple times.
Send tpm clear command after the test to reset the DA counters.

Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
---
 tools/testing/selftests/tpm2/test_smoke.sh |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/tpm2/test_smoke.sh b/tools/testing/selftests/tpm2/test_smoke.sh
index cb54ab637ea6..8155c2ea7ccb 100755
--- a/tools/testing/selftests/tpm2/test_smoke.sh
+++ b/tools/testing/selftests/tpm2/test_smoke.sh
@@ -3,3 +3,8 @@
 
 python -m unittest -v tpm2_tests.SmokeTest
 python -m unittest -v tpm2_tests.AsyncTest
+
+CLEAR_CMD=$(which tpm2_clear)
+if [ -n $CLEAR_CMD ]; then
+	tpm2_clear -T device
+fi

