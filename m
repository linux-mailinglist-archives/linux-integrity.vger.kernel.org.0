Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27815267C07
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Sep 2020 21:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgILTg1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 12 Sep 2020 15:36:27 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:45562 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgILTgV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 12 Sep 2020 15:36:21 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id DCC0072CA54;
        Sat, 12 Sep 2020 22:36:19 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [83.220.44.62])
        by imap.altlinux.org (Postfix) with ESMTPSA id 97ABE4A4A16;
        Sat, 12 Sep 2020 22:36:19 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 2/2] ima-evm-utils: Add test for sigfile reading
Date:   Sat, 12 Sep 2020 22:36:14 +0300
Message-Id: <20200912193614.12903-2-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200912193614.12903-1-vt@altlinux.org>
References: <20200912193614.12903-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Test reading of detached IMA signature (--sigfile).

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 tests/sign_verify.test | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/sign_verify.test b/tests/sign_verify.test
index 118c3f6..cddeb15 100755
--- a/tests/sign_verify.test
+++ b/tests/sign_verify.test
@@ -93,7 +93,8 @@ _test_sigfile() {
     return "$FAIL"
   fi
 
-  rm "$file_sig" "$file_sig2"
+  # Leave '$file_sig' for ima_verify --sigfile test.
+  rm "$file_sig2"
 }
 
 # Run single sign command
@@ -254,9 +255,12 @@ sign_verify() {
 
     # Normal verify with proper key should pass
     expect_pass check_verify
+    expect_pass check_verify OPTS="--sigfile"
 
     # Multiple files and some don't verify
     expect_fail check_verify FILE="/dev/null $file"
+
+    rm "$FILE.sig"
   fi
 
   TYPE=evm
-- 
2.11.0

