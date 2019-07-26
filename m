Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA9D773F8
	for <lists+linux-integrity@lfdr.de>; Sat, 27 Jul 2019 00:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfGZWXO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jul 2019 18:23:14 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:58704 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbfGZWXO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jul 2019 18:23:14 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 9950672CC6C;
        Sat, 27 Jul 2019 01:23:12 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 6C3F24A4AE8;
        Sat, 27 Jul 2019 01:23:12 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH] ima-evm-utils: Fix ima_verify for v1 signatures
Date:   Sat, 27 Jul 2019 01:23:09 +0300
Message-Id: <20190726222309.8106-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Use user supplied key in verify_hash for DIGSIG_VERSION_1.
Otherwise v1 signatures don't pass verification.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/libimaevm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index a582872..97f193e 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -612,6 +612,8 @@ int verify_hash(const char *file, const unsigned char *hash, int size, unsigned
 		/* Read pubkey from RSA key */
 		if (!imaevm_params.keyfile)
 			key = "/etc/keys/pubkey_evm.pem";
+		else
+			key = imaevm_params.keyfile;
 		return verify_hash_v1(file, hash, size, sig, siglen, key);
 	} else if (sig[0] == DIGSIG_VERSION_2) {
 		return verify_hash_v2(file, hash, size, sig, siglen);
-- 
2.11.0

