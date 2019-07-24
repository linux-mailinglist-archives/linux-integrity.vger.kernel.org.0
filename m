Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDC574039
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jul 2019 22:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfGXUmK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jul 2019 16:42:10 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:34292 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfGXUmJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jul 2019 16:42:09 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id A35A172CCDA;
        Wed, 24 Jul 2019 23:42:06 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 79A4F4A4AE8;
        Wed, 24 Jul 2019 23:42:06 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH] ima-evm-utils: Namespace some too generic function names
Date:   Wed, 24 Jul 2019 23:42:04 +0300
Message-Id: <20190724204204.25383-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Prefix `dump', `do_dump', and `params' with `ima_' to avoid colliding
with other global symbols.

`params' is prefixed with a #define trick to avoid change in half
hundred places.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---

I think all other exported functions (good example is verify_hash) should be
prefixed too.

 src/evmctl.c    | 6 +++---
 src/imaevm.h    | 9 ++++++---
 src/libimaevm.c | 6 +++---
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 3289061..b2e5af5 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -565,7 +565,7 @@ static int sign_evm(const char *file, const char *key)
 		sig[1] = 3; /* immutable signature version */
 
 	if (sigdump || params.verbose >= LOG_INFO)
-		dump(sig, len);
+		ima_dump(sig, len);
 
 	if (xattr) {
 		err = lsetxattr(file, xattr_evm, sig, len, 0);
@@ -604,7 +604,7 @@ static int hash_ima(const char *file)
 		log_info("hash: ");
 
 	if (sigdump || params.verbose >= LOG_INFO)
-		dump(hash, len);
+		ima_dump(hash, len);
 
 	if (xattr) {
 		err = lsetxattr(file, xattr_ima, hash, len, 0);
@@ -638,7 +638,7 @@ static int sign_ima(const char *file, const char *key)
 	sig[0] = EVM_IMA_XATTR_DIGSIG;
 
 	if (sigdump || params.verbose >= LOG_INFO)
-		dump(sig, len);
+		ima_dump(sig, len);
 
 	if (sigfile)
 		bin2file(file, "sig", sig, len);
diff --git a/src/imaevm.h b/src/imaevm.h
index 0414433..d00922c 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -49,9 +49,12 @@
 
 #include <openssl/rsa.h>
 
+/* Namespace some internal symbols */
+#define params		ima_params
+
 #ifdef USE_FPRINTF
 #define do_log(level, fmt, args...)	({ if (level <= params.verbose) fprintf(stderr, fmt, ##args); })
-#define do_log_dump(level, p, len, cr)	({ if (level <= params.verbose) do_dump(stderr, p, len, cr); })
+#define do_log_dump(level, p, len, cr)	({ if (level <= params.verbose) ima_do_dump(stderr, p, len, cr); })
 #else
 #define do_log(level, fmt, args...)	syslog(level, fmt, ##args)
 #define do_log_dump(level, p, len, cr)
@@ -206,8 +209,8 @@ struct RSA_ASN1_template {
 
 extern struct libevm_params params;
 
-void do_dump(FILE *fp, const void *ptr, int len, bool cr);
-void dump(const void *ptr, int len);
+void ima_do_dump(FILE *fp, const void *ptr, int len, bool cr);
+void ima_dump(const void *ptr, int len);
 int ima_calc_hash(const char *file, uint8_t *hash);
 int get_hash_algo(const char *algo);
 RSA *read_pub_key(const char *keyfile, int x509);
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 2d99570..afa978f 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -89,7 +89,7 @@ struct libevm_params params = {
 
 static void __attribute__ ((constructor)) libinit(void);
 
-void do_dump(FILE *fp, const void *ptr, int len, bool cr)
+void ima_do_dump(FILE *fp, const void *ptr, int len, bool cr)
 {
 	int i;
 	uint8_t *data = (uint8_t *) ptr;
@@ -100,9 +100,9 @@ void do_dump(FILE *fp, const void *ptr, int len, bool cr)
 		fprintf(fp, "\n");
 }
 
-void dump(const void *ptr, int len)
+void ima_dump(const void *ptr, int len)
 {
-	do_dump(stdout, ptr, len, true);
+	ima_do_dump(stdout, ptr, len, true);
 }
 
 const char *get_hash_algo_by_id(int algo)
-- 
2.11.0

