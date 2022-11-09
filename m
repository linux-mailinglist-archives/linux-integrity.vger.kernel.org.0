Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7201622237
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Nov 2022 03:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiKICuh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Nov 2022 21:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiKICuf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Nov 2022 21:50:35 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253B51F9E0;
        Tue,  8 Nov 2022 18:50:34 -0800 (PST)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1667962230;
        bh=233BTp1qcjOzql0dhORHYGs7Wq5WOY1ovusjn60vP/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gvg2aRUlRtnPD1ft+cXSUo/Zs8u/wtM3kR2n4ZjvrLYTOaf+eQr3478AXBgfgtcbZ
         jBzcLoXgYwAFD7y71goq75WkjvW4HUsRxNsq5esZUWpYw8sp2KCGt0Ivk3+Ps+Tox1
         y4OPNTxjB6F5tYGsCZ7y5452+e9ZUjkPczgz2ev8=
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 2/3] KEYS: Add key_create()
Date:   Wed,  9 Nov 2022 03:50:18 +0100
Message-Id: <20221109025019.1855-3-linux@weissschuh.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221109025019.1855-1-linux@weissschuh.net>
References: <20221109025019.1855-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1667962214; l=7478; s=20211113; h=from:subject; bh=233BTp1qcjOzql0dhORHYGs7Wq5WOY1ovusjn60vP/A=; b=M29uzVeJh9KDc+GsHlHkuBqH80ld+ZcrMEUOp0kpS7GWmStL1oLs4Ylh5Kw/qgjZDJbP5jHzBKCl dNVBRqy7CotdiIxIBKPjDfbNUN8yzxCvz/ITfDz23Fvd8me1dqIY
X-Developer-Key: i=linux@weissschuh.net; a=ed25519; pk=9LP6KM4vD/8CwHW7nouRBhWLyQLcK1MkP6aTZbzUlj4=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This function works like key_create_or_update() but does not allow
updating an existing key instead returning -EEXIST.

This new function will be used by the blacklist keyring.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/key.h |   8 +++
 security/keys/key.c | 149 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 120 insertions(+), 37 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index d27477faf00d..8dc7f7c3088b 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -386,6 +386,14 @@ extern int wait_for_key_construction(struct key *key, bool intr);
 
 extern int key_validate(const struct key *key);
 
+extern key_ref_t key_create(key_ref_t keyring,
+			    const char *type,
+			    const char *description,
+			    const void *payload,
+			    size_t plen,
+			    key_perm_t perm,
+			    unsigned long flags);
+
 extern key_ref_t key_create_or_update(key_ref_t keyring,
 				      const char *type,
 				      const char *description,
diff --git a/security/keys/key.c b/security/keys/key.c
index c45afdd1dfbb..f84bcd8457f4 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -788,38 +788,18 @@ static inline key_ref_t __key_update(key_ref_t key_ref,
 	goto out;
 }
 
-/**
- * key_create_or_update - Update or create and instantiate a key.
- * @keyring_ref: A pointer to the destination keyring with possession flag.
- * @type: The type of key.
- * @description: The searchable description for the key.
- * @payload: The data to use to instantiate or update the key.
- * @plen: The length of @payload.
- * @perm: The permissions mask for a new key.
- * @flags: The quota flags for a new key.
- *
- * Search the destination keyring for a key of the same description and if one
- * is found, update it, otherwise create and instantiate a new one and create a
- * link to it from that keyring.
- *
- * If perm is KEY_PERM_UNDEF then an appropriate key permissions mask will be
- * concocted.
- *
- * Returns a pointer to the new key if successful, -ENODEV if the key type
- * wasn't available, -ENOTDIR if the keyring wasn't a keyring, -EACCES if the
- * caller isn't permitted to modify the keyring or the LSM did not permit
- * creation of the key.
- *
- * On success, the possession flag from the keyring ref will be tacked on to
- * the key ref before it is returned.
+/*
+ * Create or potentially update a key. The combined logic behind
+ * key_create_or_update() and key_create()
  */
-key_ref_t key_create_or_update(key_ref_t keyring_ref,
-			       const char *type,
-			       const char *description,
-			       const void *payload,
-			       size_t plen,
-			       key_perm_t perm,
-			       unsigned long flags)
+static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
+					const char *type,
+					const char *description,
+					const void *payload,
+					size_t plen,
+					key_perm_t perm,
+					unsigned long flags,
+					bool allow_update)
 {
 	struct keyring_index_key index_key = {
 		.description	= description,
@@ -906,14 +886,23 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 		goto error_link_end;
 	}
 
-	/* if it's possible to update this type of key, search for an existing
-	 * key of the same type and description in the destination keyring and
-	 * update that instead if possible
+	/* if it's requested and possible to update this type of key, search
+	 * for an existing key of the same type and description in the
+	 * destination keyring and update that instead if possible
 	 */
-	if (index_key.type->update) {
+	if (allow_update) {
+		if (index_key.type->update) {
+			key_ref = find_key_to_update(keyring_ref, &index_key);
+			if (key_ref)
+				goto found_matching_key;
+		}
+	} else {
 		key_ref = find_key_to_update(keyring_ref, &index_key);
-		if (key_ref)
-			goto found_matching_key;
+		if (key_ref) {
+			key_ref_put(key_ref);
+			key_ref = ERR_PTR(-EEXIST);
+			goto error_link_end;
+		}
 	}
 
 	/* if the client doesn't provide, decide on the permissions we want */
@@ -985,8 +974,94 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 
 	goto error_free_prep;
 }
+
+/**
+ * key_create_or_update - Update or create and instantiate a key.
+ * @keyring_ref: A pointer to the destination keyring with possession flag.
+ * @type: The type of key.
+ * @description: The searchable description for the key.
+ * @payload: The data to use to instantiate or update the key.
+ * @plen: The length of @payload.
+ * @perm: The permissions mask for a new key.
+ * @flags: The quota flags for a new key.
+ *
+ * Search the destination keyring for a key of the same description and if one
+ * is found, update it, otherwise create and instantiate a new one and create a
+ * link to it from that keyring.
+ *
+ * If perm is KEY_PERM_UNDEF then an appropriate key permissions mask will be
+ * concocted.
+ *
+ * Returns a pointer to the new key if successful, -ENODEV if the key type
+ * wasn't available, -ENOTDIR if the keyring wasn't a keyring, -EACCES if the
+ * caller isn't permitted to modify the keyring or the LSM did not permit
+ * creation of the key.
+ *
+ * On success, the possession flag from the keyring ref will be tacked on to
+ * the key ref before it is returned.
+ */
+key_ref_t key_create_or_update(key_ref_t keyring_ref,
+			       const char *type,
+			       const char *description,
+			       const void *payload,
+			       size_t plen,
+			       key_perm_t perm,
+			       unsigned long flags)
+{
+	return __key_create_or_update(keyring_ref,
+				      type,
+				      description,
+				      payload,
+				      plen,
+				      perm,
+				      flags,
+				      true);
+}
 EXPORT_SYMBOL(key_create_or_update);
 
+/**
+ * key_create - Create and instantiate a key.
+ * @keyring_ref: A pointer to the destination keyring with possession flag.
+ * @type: The type of key.
+ * @description: The searchable description for the key.
+ * @payload: The data to use to instantiate or update the key.
+ * @plen: The length of @payload.
+ * @perm: The permissions mask for a new key.
+ * @flags: The quota flags for a new key.
+ *
+ * Create and instantiate a new key and link to it from the destination keyring.
+ *
+ * If perm is KEY_PERM_UNDEF then an appropriate key permissions mask will be
+ * concocted.
+ *
+ * Returns a pointer to the new key if successful, -EEXIST if a key with the
+ * same description already exists, -ENODEV if the key type wasn't available,
+ * -ENOTDIR if the keyring wasn't a keyring, -EACCES if the caller isn't
+ * permitted to modify the keyring or the LSM did not permit creation of the
+ * key.
+ *
+ * On success, the possession flag from the keyring ref will be tacked on to
+ * the key ref before it is returned.
+ */
+key_ref_t key_create(key_ref_t keyring_ref,
+		     const char *type,
+		     const char *description,
+		     const void *payload,
+		     size_t plen,
+		     key_perm_t perm,
+		     unsigned long flags)
+{
+	return __key_create_or_update(keyring_ref,
+				      type,
+				      description,
+				      payload,
+				      plen,
+				      perm,
+				      flags,
+				      false);
+}
+EXPORT_SYMBOL(key_create);
+
 /**
  * key_update - Update a key's contents.
  * @key_ref: The pointer (plus possession flag) to the key.
-- 
2.38.1

