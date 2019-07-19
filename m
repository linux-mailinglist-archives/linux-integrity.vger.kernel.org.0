Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B74D6EC2F
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jul 2019 23:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbfGSVok (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Jul 2019 17:44:40 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:59204 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfGSVok (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Jul 2019 17:44:40 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 20F7E72CA65;
        Sat, 20 Jul 2019 00:44:38 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id F0AFB4A4A29;
        Sat, 20 Jul 2019 00:44:37 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH] ima-evm-utils: Show information about x509 cert when loading public key
Date:   Sat, 20 Jul 2019 00:44:36 +0300
Message-Id: <20190719214436.22871-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If verbose output is specified output some interesting x509 cert flags
and if it have defined Digital Signature purpose of not. While these
constraints are not enforced anywhere this may be useful for user to
know.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/libimaevm.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 2280add..1c85397 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -56,6 +56,7 @@
 #include <openssl/pem.h>
 #include <openssl/evp.h>
 #include <openssl/x509.h>
+#include <openssl/x509v3.h>
 #include <openssl/err.h>
 
 #include "imaevm.h"
@@ -333,6 +334,26 @@ EVP_PKEY *read_pub_pkey(const char *keyfile, int x509)
 				keyfile);
 			goto out;
 		}
+
+		if (params.verbose > LOG_INFO) {
+			uint32_t flags;
+
+			flags = X509_get_extension_flags(crt);
+			log_info("Load x509 cert: %s flags:", keyfile);
+			if (flags & EXFLAG_CA)
+				log_info(" CA");
+			if (flags & EXFLAG_SI)
+				log_info(" Self-issued");
+			if (flags & EXFLAG_SS)
+				log_info(" Self-signed");
+			flags = X509_get_key_usage(crt);
+			if (flags & KU_DIGITAL_SIGNATURE)
+				log_info(" Digital-Signature");
+			else
+				log_info(" No-Digital-Signature");
+			log_info("\n");
+		}
+
 		pkey = X509_extract_key(crt);
 		X509_free(crt);
 		if (!pkey) {
-- 
2.11.0

