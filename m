Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E337545163
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Jun 2019 03:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfFNBy2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 21:54:28 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:41132 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfFNBy2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 21:54:28 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 7CF2672CCAE;
        Fri, 14 Jun 2019 04:54:26 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 5F5944A4AE7;
        Fri, 14 Jun 2019 04:54:26 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v4 1/5] ima-avm-utils: Make sure sig buffer is always MAX_SIGNATURE_SIZE
Date:   Fri, 14 Jun 2019 04:54:06 +0300
Message-Id: <20190614015410.26039-2-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190614015410.26039-1-vt@altlinux.org>
References: <20190614015410.26039-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Fix off-by-one error of the output buffer passed to sign_hash().

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/evmctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 15a7226..b6333bf 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -510,7 +510,7 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 static int sign_evm(const char *file, const char *key)
 {
 	unsigned char hash[MAX_DIGEST_SIZE];
-	unsigned char sig[MAX_SIGNATURE_SIZE];
+	unsigned char sig[MAX_SIGNATURE_SIZE + 1];
 	int len, err;
 
 	len = calc_evm_hash(file, hash);
@@ -519,7 +519,7 @@ static int sign_evm(const char *file, const char *key)
 		return len;
 
 	len = sign_hash(params.hash_algo, hash, len, key, NULL, sig + 1);
-	assert(len < sizeof(sig));
+	assert(len < MAX_SIGNATURE_SIZE);
 	if (len <= 1)
 		return len;
 
-- 
2.11.0

