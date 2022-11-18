Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C308462ECB1
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Nov 2022 05:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241103AbiKREFj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Nov 2022 23:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240920AbiKREEv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Nov 2022 23:04:51 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF8E97AAE;
        Thu, 17 Nov 2022 20:04:37 -0800 (PST)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1668744275;
        bh=yyfGMKlvc3gICF5CIzWsPIqJezUznxAxV3j5FqFAvY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N27Om10MNyxoOaU+H1dNgfmWFlf1aYFCHqmltycFCxSJ1lbggSSF0znzrYTDKDkeS
         CfGd370vDYUrdp85qP8TBY7ha6mqwvrKwWOMSt64V4oWP7E0V9oytioQ8j1dVGSW+L
         AO677ej05tx5ko/vl2imgoi5elp8/DXBSDzPACT0=
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
Subject: [PATCH v3 2/3] KEYS: Add key_create()
Date:   Fri, 18 Nov 2022 05:03:42 +0100
Message-Id: <20221118040343.2958-3-linux@weissschuh.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118040343.2958-1-linux@weissschuh.net>
References: <20221118040343.2958-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1668744218; l=7565; i=linux@weissschuh.net; s=20211113; h=from:subject; bh=yyfGMKlvc3gICF5CIzWsPIqJezUznxAxV3j5FqFAvY4=; b=I8+qaq/Nyxj31fcck6KCqGiFYJ5i0kFEc86k2bRxZNfpGx2u5+BWh7RlfiHGXq/NcRUaPukcBrRf 8B10cbEWAX7fJa0bOJ1701sM0eD+H1qXEf21KdONy8ME01v/5GWC
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
updating an existing key, instead returning -EEXIST.

This new function will be used by the blacklist keyring to handle EEXIST
errors specially by logging a different message with lower severity.

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

