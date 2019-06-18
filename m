Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 901014A2E6
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Jun 2019 15:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfFRN5R (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Jun 2019 09:57:17 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:52918 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFRN5R (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Jun 2019 09:57:17 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 57A2172CC58;
        Tue, 18 Jun 2019 16:57:15 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 1468F4A4A14;
        Tue, 18 Jun 2019 16:57:15 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v5 01/11] ima-evm-utils: Make sure sig buffer is always MAX_SIGNATURE_SIZE
Date:   Tue, 18 Jun 2019 16:56:13 +0300
Message-Id: <20190618135623.6861-2-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190618135623.6861-1-vt@altlinux.org>
References: <20190618135623.6861-1-vt@altlinux.org>
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
index 15a7226..03f41fe 100644
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
+	assert(len <= MAX_SIGNATURE_SIZE);
 	if (len <= 1)
 		return len;
 
-- 
2.11.0

