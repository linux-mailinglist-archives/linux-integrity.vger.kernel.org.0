Return-Path: <linux-integrity+bounces-5514-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7818A759C9
	for <lists+linux-integrity@lfdr.de>; Sun, 30 Mar 2025 13:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 479E2169292
	for <lists+linux-integrity@lfdr.de>; Sun, 30 Mar 2025 11:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C0919AA63;
	Sun, 30 Mar 2025 11:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ld6/Hdu7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF85C4A05;
	Sun, 30 Mar 2025 11:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743333419; cv=none; b=Zh2EpVe8mG3VpbjCESuy6PpMrwQhS2bqPjL5p5lXXYeo9B9ZPpaOEY5a1nBI08uaUKM0mjAH6bH5zQVyL5LW8LP49s3q336GzZMnKKV1bMxDLG2pUxneKbiPsipPIN80NTZoJcD8br1Xkba4McYLTlNqKGhIlzRTeDJjBRjgfdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743333419; c=relaxed/simple;
	bh=bTzXpKprA2KMypybMT7l/o4/hn/A7pY8SKGCCVw2Oes=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JukzJFSBjRhmBPxYNniyQIqf1mbas+si9BXwcrVev1hcal2QfdOVNHTimLMJzS7YePs1GdDIMExFPtlUtrjxw47EXDiE8GyQ/ymsp+qQXUgfyKe5bAlnqTmSFzCGypD43KI3+ytvPQ7HLddoyukNVGLK0JQrawSzSTlkR8CsQ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ld6/Hdu7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826D1C4CEDD;
	Sun, 30 Mar 2025 11:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743333419;
	bh=bTzXpKprA2KMypybMT7l/o4/hn/A7pY8SKGCCVw2Oes=;
	h=From:To:Cc:Subject:Date:From;
	b=ld6/Hdu7glJQ/4jJ8525vkS46srn/5xoTzoUTe59aGH42X/8RuGAEM+HjJN41bXwv
	 bYNYcwW0slK5ouHNHGgjtTwfhkR9GrTCPptjOLIUWaa6d6i2nk/UGdCc6pF8sEPaes
	 7pm39Q+kKyLSEBG9zP2+EIgWe0pqu8vaSuxffGy2BcMdZLMKUfNX8TzzxNgM630IBX
	 jrEAxyfDpjJ1kIXzoYUcqTrKdDa0A3BO7+PpX4uBfs3cbz/T+YMWewPJQ+/CvvPw8M
	 Ej5JB+9Bm8patk2Tx5Qh3nbH23W2p4ItnsgbNGFUFtERiJszRHP6gV810ftflK9I7F
	 0NGzixSJUqgZA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyrings@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: [RFC PATCH v2] KEYS: Add a list for unreferenced keys
Date: Sun, 30 Mar 2025 14:16:49 +0300
Message-Id: <20250330111649.13547-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an isolated list for unreferenced keys. This splits key deletion as
separate phase, after the key reaper. This makes the whole process more
rigid, as these two distinct tasks don't intervene each other.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2:
- Rename key_gc_unused_keys as key_gc_graveyard, and re-document the
  function.
---
 include/linux/key.h      |  1 -
 security/keys/gc.c       | 27 +++++++--------------------
 security/keys/internal.h |  1 +
 security/keys/key.c      |  7 +++++--
 4 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index ba05de8579ec..074dca3222b9 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -236,7 +236,6 @@ struct key {
 #define KEY_FLAG_ROOT_CAN_INVAL	7	/* set if key can be invalidated by root without permission */
 #define KEY_FLAG_KEEP		8	/* set if key should not be removed */
 #define KEY_FLAG_UID_KEYRING	9	/* set if key is a user or user session keyring */
-#define KEY_FLAG_FINAL_PUT	10	/* set if final put has happened on key */
 
 	/* the key type and key description string
 	 * - the desc is used to match a key against search criteria
diff --git a/security/keys/gc.c b/security/keys/gc.c
index f27223ea4578..ffd456b6967d 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -130,9 +130,9 @@ void key_gc_keytype(struct key_type *ktype)
 }
 
 /*
- * Garbage collect a list of unreferenced, detached keys
+ * Takes ownership of the given list, and deinitializes and destroys the keys.
  */
-static noinline void key_gc_unused_keys(struct list_head *keys)
+static noinline void key_gc_graveyard(struct list_head *keys)
 {
 	while (!list_empty(keys)) {
 		struct key *key =
@@ -218,11 +218,6 @@ static void key_garbage_collector(struct work_struct *work)
 		key = rb_entry(cursor, struct key, serial_node);
 		cursor = rb_next(cursor);
 
-		if (test_bit(KEY_FLAG_FINAL_PUT, &key->flags)) {
-			smp_mb(); /* Clobber key->user after FINAL_PUT seen. */
-			goto found_unreferenced_key;
-		}
-
 		if (unlikely(gc_state & KEY_GC_REAPING_DEAD_1)) {
 			if (key->type == key_gc_dead_keytype) {
 				gc_state |= KEY_GC_FOUND_DEAD_KEY;
@@ -286,6 +281,10 @@ static void key_garbage_collector(struct work_struct *work)
 		key_schedule_gc(new_timer);
 	}
 
+	spin_lock(&key_serial_lock);
+	list_splice_init(&key_graveyard, &graveyard);
+	spin_unlock(&key_serial_lock);
+
 	if (unlikely(gc_state & KEY_GC_REAPING_DEAD_2) ||
 	    !list_empty(&graveyard)) {
 		/* Make sure that all pending keyring payload destructions are
@@ -299,7 +298,7 @@ static void key_garbage_collector(struct work_struct *work)
 
 	if (!list_empty(&graveyard)) {
 		kdebug("gc keys");
-		key_gc_unused_keys(&graveyard);
+		key_gc_graveyard(&graveyard);
 	}
 
 	if (unlikely(gc_state & (KEY_GC_REAPING_DEAD_1 |
@@ -328,18 +327,6 @@ static void key_garbage_collector(struct work_struct *work)
 	kleave(" [end %x]", gc_state);
 	return;
 
-	/* We found an unreferenced key - once we've removed it from the tree,
-	 * we can safely drop the lock.
-	 */
-found_unreferenced_key:
-	kdebug("unrefd key %d", key->serial);
-	rb_erase(&key->serial_node, &key_serial_tree);
-	spin_unlock(&key_serial_lock);
-
-	list_add_tail(&key->graveyard_link, &graveyard);
-	gc_state |= KEY_GC_REAP_AGAIN;
-	goto maybe_resched;
-
 	/* We found a restricted keyring and need to update the restriction if
 	 * it is associated with the dead key type.
 	 */
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 2cffa6dc8255..c1b6f0b5817c 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -66,6 +66,7 @@ struct key_user {
 extern struct rb_root	key_user_tree;
 extern spinlock_t	key_user_lock;
 extern struct key_user	root_key_user;
+extern struct list_head key_graveyard;
 
 extern struct key_user *key_user_lookup(kuid_t uid);
 extern void key_user_put(struct key_user *user);
diff --git a/security/keys/key.c b/security/keys/key.c
index 7198cd2ac3a3..b34b4cba6ce7 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -22,6 +22,7 @@ DEFINE_SPINLOCK(key_serial_lock);
 
 struct rb_root	key_user_tree; /* tree of quota records indexed by UID */
 DEFINE_SPINLOCK(key_user_lock);
+LIST_HEAD(key_graveyard);
 
 unsigned int key_quota_root_maxkeys = 1000000;	/* root's key count quota */
 unsigned int key_quota_root_maxbytes = 25000000; /* root's key space quota */
@@ -658,8 +659,10 @@ void key_put(struct key *key)
 				key->user->qnbytes -= key->quotalen;
 				spin_unlock_irqrestore(&key->user->lock, flags);
 			}
-			smp_mb(); /* key->user before FINAL_PUT set. */
-			set_bit(KEY_FLAG_FINAL_PUT, &key->flags);
+			spin_lock(&key_serial_lock);
+			rb_erase(&key->serial_node, &key_serial_tree);
+			list_add_tail(&key->graveyard_link, &key_graveyard);
+			spin_unlock(&key_serial_lock);
 			schedule_work(&key_gc_work);
 		}
 	}
-- 
2.39.5


