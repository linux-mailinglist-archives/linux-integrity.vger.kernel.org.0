Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4B8F6D68C
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jul 2019 23:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfGRVfP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jul 2019 17:35:15 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:53014 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbfGRVfP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jul 2019 17:35:15 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 04B8E72CA65;
        Fri, 19 Jul 2019 00:35:13 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id D74EA4A4A29;
        Fri, 19 Jul 2019 00:35:12 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH 1/3] ima-evm-utils: Remove indirect call to subfunctions in verify_hash
Date:   Fri, 19 Jul 2019 00:35:08 +0300
Message-Id: <20190718213510.10829-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This is more human understandable and also will improve handling of
the sources by cscope.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/imaevm.h    |  3 ---
 src/libimaevm.c | 10 +++-------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/src/imaevm.h b/src/imaevm.h
index 36050f4..0414433 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -188,9 +188,6 @@ struct signature_v2_hdr {
 	uint8_t sig[0];		/* signature payload */
 } __packed;
 
-
-typedef int (*verify_hash_fn_t)(const char *file, const unsigned char *hash, int size, unsigned char *sig, int siglen, const char *keyfile);
-
 struct libevm_params {
 	int verbose;
 	int x509;
diff --git a/src/libimaevm.c b/src/libimaevm.c
index afd2105..97b7167 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -572,22 +572,18 @@ static int get_hash_algo_from_sig(unsigned char *sig)
 int verify_hash(const char *file, const unsigned char *hash, int size, unsigned char *sig,
 		int siglen)
 {
-	const char *key = NULL;
-	verify_hash_fn_t verify_hash;
-
 	/* Get signature type from sig header */
 	if (sig[0] == DIGSIG_VERSION_1) {
-		verify_hash = verify_hash_v1;
+		const char *key = NULL;
 
 		/* Read pubkey from RSA key */
 		if (!params.keyfile)
 			key = "/etc/keys/pubkey_evm.pem";
+		return verify_hash_v1(file, hash, size, sig, siglen, key);
 	} else if (sig[0] == DIGSIG_VERSION_2) {
-		verify_hash = verify_hash_v2;
+		return verify_hash_v2(file, hash, size, sig, siglen, NULL);
 	} else
 		return -1;
-
-	return verify_hash(file, hash, size, sig, siglen, key);
 }
 
 int ima_verify_signature(const char *file, unsigned char *sig, int siglen,
-- 
2.11.0

