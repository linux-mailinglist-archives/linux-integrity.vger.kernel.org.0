Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4145BC37F
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Sep 2022 09:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiISHa2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Sep 2022 03:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiISHa1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Sep 2022 03:30:27 -0400
X-Greylist: delayed 420 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 19 Sep 2022 00:30:24 PDT
Received: from mail.steuer-voss.de (mail.steuer-voss.de [85.183.69.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898531A052;
        Mon, 19 Sep 2022 00:30:24 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id E41421357; Mon, 19 Sep 2022 09:23:17 +0200 (CEST)
From:   Nikolaus Voss <nv@vosn.de>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 16 Sep 2022 07:45:29 +0200
Subject: [PATCH] KEYS: encrypted: fix key instantiation with user-provided
 data
Message-Id: <20220919072317.E41421357@mail.steuer-voss.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Commit cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided
decrypted data") added key instantiation with user provided decrypted data.
The user data is hex-ascii-encoded but was just memcpy'ed to the binary buffer.
Fix this to use hex2bin instead.

Fixes: cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided decrypted data")
Cc: stable <stable@kernel.org>
Signed-off-by: Nikolaus Voss <nikolaus.voss@haag-streit.com>
---
 security/keys/encrypted-keys/encrypted.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index e05cfc2e49ae..1e313982af02 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -627,7 +627,7 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
 			pr_err("encrypted key: instantiation of keys using provided decrypted data is disabled since CONFIG_USER_DECRYPTED_DATA is set to false\n");
 			return ERR_PTR(-EINVAL);
 		}
-		if (strlen(decrypted_data) != decrypted_datalen) {
+		if (strlen(decrypted_data) != decrypted_datalen * 2) {
 			pr_err("encrypted key: decrypted data provided does not match decrypted data length provided\n");
 			return ERR_PTR(-EINVAL);
 		}
@@ -791,8 +791,8 @@ static int encrypted_init(struct encrypted_key_payload *epayload,
 		ret = encrypted_key_decrypt(epayload, format, hex_encoded_iv);
 	} else if (decrypted_data) {
 		get_random_bytes(epayload->iv, ivsize);
-		memcpy(epayload->decrypted_data, decrypted_data,
-				   epayload->decrypted_datalen);
+		ret = hex2bin(epayload->decrypted_data, decrypted_data,
+			      epayload->decrypted_datalen);
 	} else {
 		get_random_bytes(epayload->iv, ivsize);
 		get_random_bytes(epayload->decrypted_data, epayload->decrypted_datalen);
-- 
2.34.1

