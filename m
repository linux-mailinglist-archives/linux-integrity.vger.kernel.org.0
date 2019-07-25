Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66AAA746EE
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jul 2019 08:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfGYGNJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jul 2019 02:13:09 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:36570 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfGYGNJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jul 2019 02:13:09 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 816B672CC6C;
        Thu, 25 Jul 2019 09:13:07 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 5EE074A4AE8;
        Thu, 25 Jul 2019 09:13:07 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH 1/2] ima-evm-utils: Do not allow fallback and unknown hash algos
Date:   Thu, 25 Jul 2019 09:13:05 +0300
Message-Id: <20190725061306.30515-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Falling back and permissiveness could have security implications.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/evmctl.c    | 4 ++++
 src/libimaevm.c | 7 +++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 3289061..3766343 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -584,6 +584,10 @@ static int hash_ima(const char *file)
 	int len, err, offset;
 	int algo = get_hash_algo(params.hash_algo);
 
+	if (algo < 0) {
+		log_err("Unknown hash algo: %s\n", params.hash_algo);
+		return -1;
+	}
 	if (algo > PKEY_HASH_SHA1) {
 		hash[0] = IMA_XATTR_DIGEST_NG;
 		hash[1] = algo;
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 2d99570..86c5784 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -571,8 +571,7 @@ int get_hash_algo(const char *algo)
 		    !strcmp(algo, hash_algo_name[i]))
 			return i;
 
-	log_info("digest %s not found, fall back to sha1\n", algo);
-	return PKEY_HASH_SHA1;
+	return -1;
 }
 
 static int get_hash_algo_from_sig(unsigned char *sig)
@@ -920,6 +919,10 @@ int sign_hash_v2(const char *algo, const unsigned char *hash, int size, const ch
 	hdr->version = (uint8_t) DIGSIG_VERSION_2;
 
 	hdr->hash_algo = get_hash_algo(algo);
+	if (hdr->hash_algo == -1) {
+		log_err("sign_hash_v2: hash algo is unknown: %s\n", algo);
+		return -1;
+	}
 
 	calc_keyid_v2(&keyid, name, pkey);
 	hdr->keyid = keyid;
-- 
2.11.0

