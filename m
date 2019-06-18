Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E53254A2EC
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Jun 2019 15:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfFRN5m (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Jun 2019 09:57:42 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:53352 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfFRN5m (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Jun 2019 09:57:42 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 905D072CC58;
        Tue, 18 Jun 2019 16:57:40 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 701D74A4A14;
        Tue, 18 Jun 2019 16:57:40 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v5 05/11] ima-evm-utils: Convert cmd_import to use EVP_PKEY API
Date:   Tue, 18 Jun 2019 16:56:17 +0300
Message-Id: <20190618135623.6861-6-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190618135623.6861-1-vt@altlinux.org>
References: <20190618135623.6861-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This is where we call calc_pkeyid_v2() for a first time.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/evmctl.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 03f41fe..224cb1f 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -891,7 +891,6 @@ static int cmd_import(struct command *cmd)
 	int id, len, err = 0;
 	char name[20];
 	uint8_t keyid[8];
-	RSA *key;
 
 	inkey = g_argv[optind++];
 	if (!inkey) {
@@ -925,18 +924,26 @@ static int cmd_import(struct command *cmd)
 		}
 	}
 
-	key = read_pub_key(inkey, params.x509);
-	if (!key)
-		return 1;
-
 	if (params.x509) {
+		EVP_PKEY *pkey = read_pub_pkey(inkey, params.x509);
+
+		if (!pkey)
+			return 1;
 		pub = file2bin(inkey, NULL, &len);
-		if (!pub)
-			goto out;
-		calc_keyid_v2((uint32_t *)keyid, name, key);
+		if (!pub) {
+			EVP_PKEY_free(pkey);
+			return 1;
+		}
+		calc_pkeyid_v2((uint32_t *)keyid, name, pkey);
+		EVP_PKEY_free(pkey);
 	} else {
+		RSA *key = read_pub_key(inkey, params.x509);
+
+		if (!key)
+			return 1;
 		len = key2bin(key, pub);
 		calc_keyid_v1(keyid, name, pub, len);
+		RSA_free(key);
 	}
 
 	log_info("Importing public key %s from file %s into keyring %d\n", name, inkey, id);
@@ -951,8 +958,6 @@ static int cmd_import(struct command *cmd)
 	}
 	if (params.x509)
 		free(pub);
-out:
-	RSA_free(key);
 	return err;
 }
 
-- 
2.11.0

