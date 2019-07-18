Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 500FF6D693
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jul 2019 23:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbfGRVh7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jul 2019 17:37:59 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:55254 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfGRVh7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jul 2019 17:37:59 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 3F8AD72CA65;
        Fri, 19 Jul 2019 00:37:57 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id EFD354A4A29;
        Fri, 19 Jul 2019 00:37:56 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH] ima-evm-utils: Remove ERR_load_crypto_strings from read_priv_pkey
Date:   Fri, 19 Jul 2019 00:37:52 +0300
Message-Id: <20190718213752.11194-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

ERR_load_crypto_strings() is already called in other place.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/libimaevm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 2a0486f..6f7a704 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -736,7 +736,6 @@ static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
 		log_err("Failed to open keyfile: %s\n", keyfile);
 		return NULL;
 	}
-	ERR_load_crypto_strings();
 	pkey = PEM_read_PrivateKey(fp, NULL, NULL, (void *)keypass);
 	if (!pkey) {
 		log_err("Failed to PEM_read_PrivateKey key file: %s\n",
-- 
2.11.0

