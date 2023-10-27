Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8187D924C
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Oct 2023 10:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbjJ0Imj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Oct 2023 04:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235146AbjJ0ImR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Oct 2023 04:42:17 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22A01B6;
        Fri, 27 Oct 2023 01:41:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SGwhj03xkz9xxn7;
        Fri, 27 Oct 2023 16:25:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwCX8JGqdjtlDvIBAw--.29710S20;
        Fri, 27 Oct 2023 09:40:55 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, mic@digikod.net
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 18/23] security: Introduce key_post_create_or_update hook
Date:   Fri, 27 Oct 2023 10:35:53 +0200
Message-Id: <20231027083558.484911-19-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027083558.484911-1-roberto.sassu@huaweicloud.com>
References: <20231027083558.484911-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwCX8JGqdjtlDvIBAw--.29710S20
X-Coremail-Antispam: 1UD129KBjvJXoWxGr43CFW3trWrXr1UWF4xtFb_yoWrZrykpa
        y5K3W5t395KFyaqrZxAF17Way5t3y0gry7K39xWryYkFnYvw4xXr42kFn8CrW5ZryfA340
        va17Zr43GF1qyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
        CY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQADBF1jj5WUaQABse
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

In preparation for moving IMA and EVM to the LSM infrastructure, introduce
the key_post_create_or_update hook.

Depending on policy, IMA measures the key content after creation or update,
so that remote verifiers are aware of the operation.

Other LSMs could similarly take some action after successful key creation
or update.

The new hook cannot return an error and cannot cause the operation to be
reverted.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/lsm_hook_defs.h |  3 +++
 include/linux/security.h      | 11 +++++++++++
 security/keys/key.c           |  7 ++++++-
 security/security.c           | 19 +++++++++++++++++++
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 8ff172ba5681..e5dcc649cb0c 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -403,6 +403,9 @@ LSM_HOOK(void, LSM_RET_VOID, key_free, struct key *key)
 LSM_HOOK(int, 0, key_permission, key_ref_t key_ref, const struct cred *cred,
 	 enum key_need_perm need_perm)
 LSM_HOOK(int, 0, key_getsecurity, struct key *key, char **buffer)
+LSM_HOOK(void, LSM_RET_VOID, key_post_create_or_update, struct key *keyring,
+	 struct key *key, const void *payload, size_t payload_len,
+	 unsigned long flags, bool create)
 #endif /* CONFIG_KEYS */
 
 #ifdef CONFIG_AUDIT
diff --git a/include/linux/security.h b/include/linux/security.h
index d8e359d651d2..0f57f315e067 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1994,6 +1994,9 @@ void security_key_free(struct key *key);
 int security_key_permission(key_ref_t key_ref, const struct cred *cred,
 			    enum key_need_perm need_perm);
 int security_key_getsecurity(struct key *key, char **_buffer);
+void security_key_post_create_or_update(struct key *keyring, struct key *key,
+					const void *payload, size_t payload_len,
+					unsigned long flags, bool create);
 
 #else
 
@@ -2021,6 +2024,14 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 	return 0;
 }
 
+static inline void security_key_post_create_or_update(struct key *keyring,
+						      struct key *key,
+						      const void *payload,
+						      size_t payload_len,
+						      unsigned long flags,
+						      bool create)
+{ }
+
 #endif
 #endif /* CONFIG_KEYS */
 
diff --git a/security/keys/key.c b/security/keys/key.c
index 5c0c7df833f8..0f9c6faf3491 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -934,6 +934,8 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
 		goto error_link_end;
 	}
 
+	security_key_post_create_or_update(keyring, key, payload, plen, flags,
+					   true);
 	ima_post_key_create_or_update(keyring, key, payload, plen,
 				      flags, true);
 
@@ -967,10 +969,13 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
 
 	key_ref = __key_update(key_ref, &prep);
 
-	if (!IS_ERR(key_ref))
+	if (!IS_ERR(key_ref)) {
+		security_key_post_create_or_update(keyring, key, payload, plen,
+						   flags, false);
 		ima_post_key_create_or_update(keyring, key,
 					      payload, plen,
 					      flags, false);
+	}
 
 	goto error_free_prep;
 }
diff --git a/security/security.c b/security/security.c
index 6ca8fdd1f037..b311d42817a5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5403,6 +5403,25 @@ int security_key_getsecurity(struct key *key, char **buffer)
 	*buffer = NULL;
 	return call_int_hook(key_getsecurity, 0, key, buffer);
 }
+
+/**
+ * security_key_post_create_or_update() - Notification of key create or update
+ * @keyring: keyring to which the key is linked to
+ * @key: created or updated key
+ * @payload: data used to instantiate or update the key
+ * @payload_len: length of payload
+ * @flags: key flags
+ * @create: flag indicating whether the key was created or updated
+ *
+ * Notify the caller of a key creation or update.
+ */
+void security_key_post_create_or_update(struct key *keyring, struct key *key,
+					const void *payload, size_t payload_len,
+					unsigned long flags, bool create)
+{
+	call_void_hook(key_post_create_or_update, keyring, key, payload,
+		       payload_len, flags, create);
+}
 #endif	/* CONFIG_KEYS */
 
 #ifdef CONFIG_AUDIT
-- 
2.34.1

