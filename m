Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C436D4FADB
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Jun 2019 11:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfFWJBX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Jun 2019 05:01:23 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:41964 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfFWJBX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Jun 2019 05:01:23 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 882CA72CCDA;
        Sun, 23 Jun 2019 12:01:21 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 4A5A14A4A29;
        Sun, 23 Jun 2019 12:01:21 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v7 11/11] ima-evm-utils: Log hash_algo with hash value in verbose mode
Date:   Sun, 23 Jun 2019 12:00:27 +0300
Message-Id: <20190623090027.11852-12-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190623090027.11852-1-vt@altlinux.org>
References: <20190623090027.11852-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

It's useful to know not just a hash value but also which algorithm is
used.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/libimaevm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 158b9d1..5bff414 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -459,7 +459,7 @@ int verify_hash_v2(const char *file, const unsigned char *hash, int size,
 	const EVP_MD *md;
 
 	if (params.verbose > LOG_INFO) {
-		log_info("hash: ");
+		log_info("hash(%s): ", params.hash_algo);
 		log_dump(hash, size);
 	}
 
@@ -871,7 +871,7 @@ int sign_hash_v2(const char *algo, const unsigned char *hash, int size, const ch
 		return -1;
 	}
 
-	log_info("hash: ");
+	log_info("hash(%s): ", params.hash_algo);
 	log_dump(hash, size);
 
 	pkey = read_priv_pkey(keyfile, params.keypass);
-- 
2.11.0

