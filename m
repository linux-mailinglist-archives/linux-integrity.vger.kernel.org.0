Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F3C4A6C03
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Feb 2022 07:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238083AbiBBG7t (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Feb 2022 01:59:49 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:44640 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbiBBG7t (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Feb 2022 01:59:49 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id A48BE72C8FA;
        Wed,  2 Feb 2022 09:59:47 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [193.43.10.9])
        by imap.altlinux.org (Postfix) with ESMTPSA id 7871F4A46F0;
        Wed,  2 Feb 2022 09:59:47 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Eric Biggers <ebiggers@kernel.org>
Subject: [RFC PATCH] KEYS: Double max_size to make keyctl pkey_verify work
Date:   Wed,  2 Feb 2022 09:59:06 +0300
Message-Id: <20220202065906.2598366-1-vt@altlinux.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Rarely used `keyctl pkey_verify' can verify raw signatures, but was
failing, because ECDSA/EC-RDSA signature sizes are twice key sizes which
does not pass in/out sizes check in keyctl_pkey_params_get_2.
This in turn because these values cannot be distinguished by a single
`max_size' callback return value.
Also, `keyctl pkey_query` displays incorrect `max_sig_size' about these
algorithms.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 crypto/asymmetric_keys/public_key.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index 4fefb219bfdc..3ffbab07ed2a 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -143,8 +143,19 @@ static int software_key_query(const struct kernel_pkey_params *params,
 
 	len = crypto_akcipher_maxsize(tfm);
 	info->key_size = len * 8;
-	info->max_data_size = len;
-	info->max_sig_size = len;
+	if (strcmp(alg_name, "ecrdsa") == 0 ||
+	    strncmp(alg_name, "ecdsa-", 6) == 0) {
+		/*
+		 * For these algos sig size is twice key size.
+		 * keyctl uses max_sig_size as minimum input size, and
+		 * max_data_size as minimum output size for a signature.
+		 */
+		info->max_data_size = len * 2;
+		info->max_sig_size = len * 2;
+	} else {
+		info->max_data_size = len;
+		info->max_sig_size = len;
+	}
 	info->max_enc_size = len;
 	info->max_dec_size = len;
 	info->supported_ops = (KEYCTL_SUPPORTS_ENCRYPT |
-- 
2.33.0

