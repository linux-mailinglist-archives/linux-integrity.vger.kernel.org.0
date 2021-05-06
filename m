Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2542374E22
	for <lists+linux-integrity@lfdr.de>; Thu,  6 May 2021 05:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhEFDsc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 May 2021 23:48:32 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:49918 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbhEFDsa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 May 2021 23:48:30 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id E935E72C8B5;
        Thu,  6 May 2021 06:47:31 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [193.43.10.250])
        by imap.altlinux.org (Postfix) with ESMTPSA id CA6264A46E9;
        Thu,  6 May 2021 06:47:31 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v5 3/3] ima-evm-utils: Read keyid from the cert appended to the key file
Date:   Thu,  6 May 2021 06:47:02 +0300
Message-Id: <20210506034702.216842-4-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210506034702.216842-1-vt@altlinux.org>
References: <20210506034702.216842-1-vt@altlinux.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Allow to have certificate appended to the private key of `--key'
specified (PEM) file (for v2 signing) to facilitate reading of keyid
from the associated cert. This will allow users to have private and
public key as a single file. There is no check that public key form the
cert matches associated private key.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 README          | 3 +++
 src/libimaevm.c | 8 +++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/README b/README
index 0e1f6ba..ea11bde 100644
--- a/README
+++ b/README
@@ -127,6 +127,9 @@ for signing and importing the key.
 Second key format uses X509 DER encoded public key certificates and uses asymmetric key support
 in the kernel (since kernel 3.9). CONFIG_INTEGRITY_ASYMMETRIC_KEYS must be enabled (default).
 
+For v2 signatures x509 certificate with the public key could be appended to the private
+key (both are in PEM format) to properly determine its Subject Key Identifier (SKID).
+
 
 Integrity keyrings
 ----------------
diff --git a/src/libimaevm.c b/src/libimaevm.c
index ea8ef5e..e3d619b 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -1021,10 +1021,12 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 		return -1;
 	}
 
-	if (imaevm_params.keyid)
+	if (imaevm_params.keyid) {
 		hdr->keyid = htonl(imaevm_params.keyid);
-	else
-		calc_keyid_v2(&hdr->keyid, name, pkey);
+	} else {
+		if (!__read_keyid(&hdr->keyid, keyfile, KEYID_FILE_PEM_KEY))
+			calc_keyid_v2(&hdr->keyid, name, pkey);
+	}
 
 	st = "EVP_PKEY_CTX_new";
 	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))
-- 
2.11.0

