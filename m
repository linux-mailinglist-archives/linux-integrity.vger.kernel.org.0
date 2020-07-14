Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C15621F908
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jul 2020 20:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgGNSRS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Jul 2020 14:17:18 -0400
Received: from linux.microsoft.com ([13.77.154.182]:36926 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729248AbgGNSRR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Jul 2020 14:17:17 -0400
Received: from localhost.localdomain (c-73-187-218-229.hsd1.pa.comcast.net [73.187.218.229])
        by linux.microsoft.com (Postfix) with ESMTPSA id ECA8B20B490A;
        Tue, 14 Jul 2020 11:17:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ECA8B20B490A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594750636;
        bh=eCk7szO70aHIl8QR28yX9xAMF9C0bOdAZP5iZN94a5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kIUbruTBse3xCgdshieOemNlDe72NlmnDX0dUfTuZKdWJAiI7MOB/h2tzDkf+rUs4
         aVPn8xnHP6mhSoLp8acLtGat6VRmx2gi388uIPuCHEs2ZEQhrkJgA2J09kTK/pQTWw
         4ucpMKyv/FBci7XRSvITr1zR/qyY09jClFf1SmjM=
From:   Lachlan Sneff <t-josne@linux.microsoft.com>
To:     zohar@linux.ibm.com, pvorel@suse.cz, ltp@lists.linux.it
Cc:     nramas@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org
Subject: [PATCH v5 2/2] IMA: Add a test to verify importing a certificate into keyring
Date:   Tue, 14 Jul 2020 14:17:03 -0400
Message-Id: <20200714181703.6374-3-t-josne@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714181703.6374-1-t-josne@linux.microsoft.com>
References: <20200714181703.6374-1-t-josne@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add an IMA measurement test that verifies that an x509 certificate
can be imported into the .ima keyring and measured correctly.

Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
---
 .../kernel/security/integrity/ima/README.md   | 22 ++++++++++
 .../security/integrity/ima/tests/ima_keys.sh  | 44 ++++++++++++++++++-
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/README.md b/testcases/kernel/security/integrity/ima/README.md
index 16a1f48c3..9e6790306 100644
--- a/testcases/kernel/security/integrity/ima/README.md
+++ b/testcases/kernel/security/integrity/ima/README.md
@@ -16,6 +16,28 @@ CONFIG_INTEGRITY=y
 CONFIG_IMA=y
 ```
 
+IMA Key Import test
+-------------
+`ima_keys.sh` requires an x509 certificate to be signed by a key on one
+of the trusted keyrings. The x509 certificate must be placed at
+`/etc/keys/x509_ima.der` for this test or the path must be passed in
+the CERT_FILE env var.
+
+The x509 public key key must be signed by the private key you generate.
+Follow these instructions:
+https://manpages.ubuntu.com/manpages/disco/man1/evmctl.1.html#generate%20trusted%20keys.
+
+The test cannot be set-up automatically because the x509 public key must be
+built into the kernel and loaded onto a trusted keyring.
+
+As well as what's required for the IMA tests, the following are also required
+in the kernel configuration:
+```
+CONFIG_IMA_READ_POLICY=y
+CONFIG_SYSTEM_TRUSTED_KEYRING=y
+CONFIG_SYSTEM_TRUSTED_KEYS="/etc/keys/ima-local-ca.pem"
+```
+
 EVM tests
 ---------
 
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
index 4d53cd04f..c10427481 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
@@ -5,10 +5,12 @@
 #
 # Verify that keys are measured correctly based on policy.
 
-TST_NEEDS_CMDS="grep mktemp cut sed tr"
-TST_CNT=1
+TST_NEEDS_CMDS="grep mktemp cut sed tr xxd keyctl evmctl openssl cmp"
+TST_CNT=2
 TST_NEEDS_DEVICE=1
 
+CERT_FILE="${CERT_FILE:-/etc/keys/x509_ima.der}"
+
 . ima_setup.sh
 
 # Based on https://lkml.org/lkml/2019/12/13/564.
@@ -68,4 +70,42 @@ test1()
 	fi
 }
 
+
+# Test that a cert can be imported into the ".ima" keyring correctly.
+test2() {
+	local keyring_id key_id test_file="file.txt"
+
+	[ -f $CERT_FILE ] || tst_brk TCONF "missing $CERT_FILE"
+
+	if ! openssl x509 -in $CERT_FILE -inform der > /dev/null; then
+		tst_brk TCONF "The suppled cert file ($CERT_FILE) is not a valid x509 certificate"
+	fi
+
+	tst_res TINFO "adding a cert to the .ima keyring ($CERT_FILE)"
+	
+	keyring_id=$(keyctl describe %:.ima | cut -d' ' -f2 | tr -d ':') || \
+		tst_btk TCONF "unable to retrieve .ima keyring id"
+
+	if ! tst_is_num	"$keyring_id"; then
+		tst_brk TCONF "unable to parse keyring id from keyring"
+	fi
+
+	evmctl import $CERT_FILE "$keyring_id" > /dev/null || \
+		tst_brk TCONF "unable to import a cert into the .ima keyring"
+
+	grep -F ".ima" "$ASCII_MEASUREMENTS" | tail -n1 | cut -d' ' -f6 | \
+		xxd -r -p > $test_file || \
+		tst_brk TCONF "cert not found in ascii_runtime_measurements log"
+
+	if ! openssl x509 -in $test_file -inform der > /dev/null; then
+		tst_brk TCONF "The cert logged in ascii_runtime_measurements is not a valid x509 certificate"
+	fi
+
+	if cmp -s "$test_file" $CERT_FILE; then
+		tst_res TPASS "logged cert matches original cert"
+	else
+		tst_res TFAIL "logged cert does not match original cert"
+	fi
+}
+
 tst_run
-- 
2.25.1

