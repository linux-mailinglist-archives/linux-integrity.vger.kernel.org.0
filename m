Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2F0477D98
	for <lists+linux-integrity@lfdr.de>; Sun, 28 Jul 2019 06:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbfG1EEA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 28 Jul 2019 00:04:00 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:49130 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfG1EEA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 28 Jul 2019 00:04:00 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 8077B72CCE7;
        Sun, 28 Jul 2019 07:03:56 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 393B94A4A29;
        Sun, 28 Jul 2019 07:03:56 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH] ima-evm-utils: Do not load keys from x509 certs if user pass --rsa
Date:   Sun, 28 Jul 2019 07:03:54 +0300
Message-Id: <20190728040354.14983-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If user wants to verify v1 signature and specify RSA public key in `-k'
option, this key will be attempted to be loaded as x509 certificate and
this process will output errors.

Do not load a key as a x509 cert if user pass `--rsa'.

This is not perfect solution. As now it's possible to specify `-k' and
`--rsa' and v2 signatures will not verify, because of no keys.

This improvement is not added into ima_measurement().

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/evmctl.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index e0a835f..0f821e4 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -843,10 +843,12 @@ static int cmd_verify_evm(struct command *cmd)
 		return -1;
 	}
 
-	if (imaevm_params.keyfile)	/* Support multiple public keys */
-		init_public_keys(imaevm_params.keyfile);
-	else				/* assume read pubkey from x509 cert */
-		init_public_keys("/etc/keys/x509_evm.der");
+	if (imaevm_params.x509) {
+		if (imaevm_params.keyfile) /* Support multiple public keys */
+			init_public_keys(imaevm_params.keyfile);
+		else			   /* assume read pubkey from x509 cert */
+			init_public_keys("/etc/keys/x509_evm.der");
+	}
 
 	err = verify_evm(file);
 	if (!err && imaevm_params.verbose >= LOG_INFO)
@@ -889,10 +891,12 @@ static int cmd_verify_ima(struct command *cmd)
 	char *file = g_argv[optind++];
 	int err, fails = 0;
 
-	if (imaevm_params.keyfile)	/* Support multiple public keys */
-		init_public_keys(imaevm_params.keyfile);
-	else				/* assume read pubkey from x509 cert */
-		init_public_keys("/etc/keys/x509_evm.der");
+	if (imaevm_params.x509) {
+		if (imaevm_params.keyfile) /* Support multiple public keys */
+			init_public_keys(imaevm_params.keyfile);
+		else			   /* assume read pubkey from x509 cert */
+			init_public_keys("/etc/keys/x509_evm.der");
+	}
 
 	errno = 0;
 	if (!file) {
-- 
2.11.0

