Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6B9E69C52
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jul 2019 22:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731008AbfGOUGH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Jul 2019 16:06:07 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:58332 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730872AbfGOUGH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jul 2019 16:06:07 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 3407072CA65;
        Mon, 15 Jul 2019 23:06:05 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id F383F4A4AE9;
        Mon, 15 Jul 2019 23:06:04 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v2 2/5] ima-evm-utils: Fix possible xattr_value overflows in calc_evm_hash
Date:   Mon, 15 Jul 2019 23:05:50 +0300
Message-Id: <20190715200553.22403-2-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190715200553.22403-1-vt@altlinux.org>
References: <20190715200553.22403-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

`selinux_str',`caps_str', and `ima_str' are passed from the command line
but copied into the fixed-size buffer.

Yes, length of `selinux_str' is calculated differently than of `caps_str'.

Fixes: CID 229895.
---
 src/evmctl.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index d6e0b2c..04dc546 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -401,16 +401,31 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 
 	for (xattrname = evm_config_xattrnames; *xattrname != NULL; xattrname++) {
 		if (!strcmp(*xattrname, XATTR_NAME_SELINUX) && selinux_str) {
-			strcpy(xattr_value, selinux_str);
 			err = strlen(selinux_str) + 1;
+			if (err > sizeof(xattr_value)) {
+				log_err("selinux[%u] value is too long to fit into xattr[%zu]\n",
+					err, sizeof(xattr_value));
+				return -1;
+			}
+			strcpy(xattr_value, selinux_str);
 		} else if (!strcmp(*xattrname, XATTR_NAME_IMA) && ima_str) {
-			hex2bin(xattr_value, ima_str, strlen(ima_str) / 2);
 			err = strlen(ima_str) / 2;
+			if (err > sizeof(xattr_value)) {
+				log_err("ima[%u] value is too long to fit into xattr[%zu]\n",
+					err, sizeof(xattr_value));
+				return -1;
+			}
+			hex2bin(xattr_value, ima_str, err);
 		} else if (!strcmp(*xattrname, XATTR_NAME_CAPS) && (hmac_flags & HMAC_FLAG_CAPS_SET)) {
 			if (!caps_str)
 				continue;
-			strcpy(xattr_value, caps_str);
 			err = strlen(caps_str);
+			if (err >= sizeof(xattr_value)) {
+				log_err("caps[%u] value is too long to fit into xattr[%zu]\n",
+					err + 1, sizeof(xattr_value));
+				return -1;
+			}
+			strcpy(xattr_value, caps_str);
 		} else {
 			err = lgetxattr(file, *xattrname, xattr_value, sizeof(xattr_value));
 			if (err < 0) {
-- 
2.11.0

