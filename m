Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16AAA77633
	for <lists+linux-integrity@lfdr.de>; Sat, 27 Jul 2019 05:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfG0DTD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jul 2019 23:19:03 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:44652 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfG0DTD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jul 2019 23:19:03 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id C1C5872CC6C;
        Sat, 27 Jul 2019 06:19:01 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 9CF8C4A4AE8;
        Sat, 27 Jul 2019 06:19:01 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH 1/2] ima-evm-utils: Fix ima_verify return value on multiple files
Date:   Sat, 27 Jul 2019 06:18:59 +0300
Message-Id: <20190727031900.7140-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If any tested file results in failure produce failure exit code.
Previously exit code affected only by the last file tested.

Fixes: "Allow multiple files in ima_verify"
Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---

I decided not to rebase "Allow multiple files in ima_verify" to not create
merge conflicts with "Namespace some too generic object names".

 src/evmctl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index b02be8b..d33a91e 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -887,7 +887,7 @@ static int verify_ima(const char *file)
 static int cmd_verify_ima(struct command *cmd)
 {
 	char *file = g_argv[optind++];
-	int err;
+	int err, fails = 0;
 
 	if (imaevm_params.keyfile)	/* Support multiple public keys */
 		init_public_keys(imaevm_params.keyfile);
@@ -903,10 +903,12 @@ static int cmd_verify_ima(struct command *cmd)
 
 	do {
 		err = verify_ima(file);
+		if (err)
+			fails++;
 		if (!err && imaevm_params.verbose >= LOG_INFO)
 			log_info("%s: verification is OK\n", file);
 	} while ((file = g_argv[optind++]));
-	return err;
+	return fails > 0;
 }
 
 static int cmd_convert(struct command *cmd)
-- 
2.11.0

