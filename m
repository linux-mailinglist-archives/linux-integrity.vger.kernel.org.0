Return-Path: <linux-integrity+bounces-5623-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD907A7D22D
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 04:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9195D16B734
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 02:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0A2212B39;
	Mon,  7 Apr 2025 02:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTM/iaS9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF9217BA3;
	Mon,  7 Apr 2025 02:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743993567; cv=none; b=tSlIf+rrejox4wnqBCcSgy8wO9fu9V6/GcZvuID1ZEx09yPhb7qsUu3WIP2SvzlSOFomNp1JNFR1uDGiWgj380/KzVoimAfPaiFbKah8PUaKz+i1zHY26Enj26WCzOqTGDCdx4PH4XvNrmFx/HFPndqzx5ahkxRb8KqL6Dnb8Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743993567; c=relaxed/simple;
	bh=KQMsWCMT4TtG0LbnlHpbZgQ5ITAtVM5iwetYpYMVVqc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lk182YP13D22nBICXCFW4+HicvyaRlIFzdBZuYbQ04lQeE0ApoONBThwOY3PmakqkmoMJ1nQ3QodMEkmEHpNcQAxZLcrlI5dpGyjPIWtraG17H0a+9BtxIa/vik6KIUuakiwqhIJ+j4KarstiQYfc/AEKQtxk2AI8TwaIWIXBJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTM/iaS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F94C4CEE3;
	Mon,  7 Apr 2025 02:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743993567;
	bh=KQMsWCMT4TtG0LbnlHpbZgQ5ITAtVM5iwetYpYMVVqc=;
	h=From:To:Cc:Subject:Date:From;
	b=uTM/iaS9R22uVhBrylGj3xZPiDPi+88i2y338gm4Al1M8ghKJN2Zq6R/0db5kJVH9
	 lk6IhSw10DUFfEXYOyCkNQuomq//u/bnUR6E0oLf1fjANuI24F82SzXGdO4DaBJkHl
	 a8mArc2K5tswTyymGcEDD5r5a2Y85Rg9WAka022kORDl+QYXfX0f3SWcbWFMWsVxCp
	 +M/R85PSx9a7/LkM3dv2U5K1Ghb6kiAxiWRmdwyVc+UeqfbMjTlvyHZz4XwjktqBBJ
	 9GSGt2ng931SZN4Se6svz5Swq9UzYvzF5JHCOEvmT7vLa6kHw/n8ywlQZlFzWgt8WN
	 vJOkjpcLI/2dA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyrings@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	stable@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@cloudflare.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v7] KEYS: Add a list for unreferenced keys
Date: Mon,  7 Apr 2025 05:39:18 +0300
Message-Id: <20250407023918.29956-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Add an isolated list of unreferenced keys to be queued for deletion, and
try to pin the keys in the garbage collector before processing anything.
Skip unpinnable keys.

Use this list for blocking the reaping process during the teardown:

1. First off, the keys added to `keys_graveyard` are snapshotted, and the
   list is flushed. This the very last step in `key_put()`.
2. `key_put()` reaches zero. This will mark key as busy for the garbage
   collector.
3. `key_garbage_collector()` will try to increase refcount, which won't go
   above zero. Whenever this happens, the key will be skipped.

Cc: stable@vger.kernel.org # v6.1+
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
---
v7:
- Fixed multiple definitions (from rebasing, sorry).
v6:
- Rebase went wrong in v5.
v5:
- Rebased on top of v6.15-rc
- Updated commit message to explain how spin lock and refcount
  isolate the time window in key_put().
v4:
- Pin the key while processing key type teardown. Skip dead keys.
- Revert key_gc_graveyard back key_gc_unused_keys.
- Rewrote the commit message.
- "unsigned long flags" declaration somehow did make to the previous
  patch (sorry).
v3:
- Using spin_lock() fails since key_put() is executed inside IRQs.
  Using spin_lock_irqsave() would neither work given the lock is
  acquired for /proc/keys. Therefore, separate the lock for
  graveyard and key_graveyard before reaping key_serial_tree.
v2:
- Rename key_gc_unused_keys as key_gc_graveyard, and re-document the
  function.
---
 include/linux/key.h      |  7 ++-----
 security/keys/gc.c       | 40 ++++++++++++++++++++++++----------------
 security/keys/internal.h |  5 +++++
 security/keys/key.c      |  7 +++++--
 4 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index ba05de8579ec..c50659184bdf 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -195,10 +195,8 @@ enum key_state {
 struct key {
 	refcount_t		usage;		/* number of references */
 	key_serial_t		serial;		/* key serial number */
-	union {
-		struct list_head graveyard_link;
-		struct rb_node	serial_node;
-	};
+	struct list_head	graveyard_link; /* key->usage == 0 */
+	struct rb_node		serial_node;
 #ifdef CONFIG_KEY_NOTIFICATIONS
 	struct watch_list	*watchers;	/* Entities watching this key for changes */
 #endif
@@ -236,7 +234,6 @@ struct key {
 #define KEY_FLAG_ROOT_CAN_INVAL	7	/* set if key can be invalidated by root without permission */
 #define KEY_FLAG_KEEP		8	/* set if key should not be removed */
 #define KEY_FLAG_UID_KEYRING	9	/* set if key is a user or user session keyring */
-#define KEY_FLAG_FINAL_PUT	10	/* set if final put has happened on key */
 
 	/* the key type and key description string
 	 * - the desc is used to match a key against search criteria
diff --git a/security/keys/gc.c b/security/keys/gc.c
index f27223ea4578..0a3beb68633c 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -189,6 +189,7 @@ static void key_garbage_collector(struct work_struct *work)
 	struct rb_node *cursor;
 	struct key *key;
 	time64_t new_timer, limit, expiry;
+	unsigned long flags;
 
 	kenter("[%lx,%x]", key_gc_flags, gc_state);
 
@@ -206,21 +207,35 @@ static void key_garbage_collector(struct work_struct *work)
 
 	new_timer = TIME64_MAX;
 
+	spin_lock_irqsave(&key_graveyard_lock, flags);
+	list_splice_init(&key_graveyard, &graveyard);
+	spin_unlock_irqrestore(&key_graveyard_lock, flags);
+
+	list_for_each_entry(key, &graveyard, graveyard_link) {
+		spin_lock(&key_serial_lock);
+		kdebug("unrefd key %d", key->serial);
+		rb_erase(&key->serial_node, &key_serial_tree);
+		spin_unlock(&key_serial_lock);
+	}
+
 	/* As only this function is permitted to remove things from the key
 	 * serial tree, if cursor is non-NULL then it will always point to a
 	 * valid node in the tree - even if lock got dropped.
 	 */
 	spin_lock(&key_serial_lock);
+	key = NULL;
 	cursor = rb_first(&key_serial_tree);
 
 continue_scanning:
+	key_put(key);
 	while (cursor) {
 		key = rb_entry(cursor, struct key, serial_node);
 		cursor = rb_next(cursor);
-
-		if (test_bit(KEY_FLAG_FINAL_PUT, &key->flags)) {
-			smp_mb(); /* Clobber key->user after FINAL_PUT seen. */
-			goto found_unreferenced_key;
+		/* key_get(), unless zero: */
+		if (!refcount_inc_not_zero(&key->usage)) {
+			key = NULL;
+			gc_state |= KEY_GC_REAP_AGAIN;
+			goto skip_dead_key;
 		}
 
 		if (unlikely(gc_state & KEY_GC_REAPING_DEAD_1)) {
@@ -274,6 +289,7 @@ static void key_garbage_collector(struct work_struct *work)
 		spin_lock(&key_serial_lock);
 		goto continue_scanning;
 	}
+	key_put(key);
 
 	/* We've completed the pass.  Set the timer if we need to and queue a
 	 * new cycle if necessary.  We keep executing cycles until we find one
@@ -286,6 +302,10 @@ static void key_garbage_collector(struct work_struct *work)
 		key_schedule_gc(new_timer);
 	}
 
+	spin_lock(&key_graveyard_lock);
+	list_splice_init(&key_graveyard, &graveyard);
+	spin_unlock(&key_graveyard_lock);
+
 	if (unlikely(gc_state & KEY_GC_REAPING_DEAD_2) ||
 	    !list_empty(&graveyard)) {
 		/* Make sure that all pending keyring payload destructions are
@@ -328,18 +348,6 @@ static void key_garbage_collector(struct work_struct *work)
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
index 2cffa6dc8255..4e3d9b322390 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -63,9 +63,14 @@ struct key_user {
 	int			qnbytes;	/* number of bytes allocated to this user */
 };
 
+extern struct list_head key_graveyard;
+extern spinlock_t key_graveyard_lock;
+
 extern struct rb_root	key_user_tree;
 extern spinlock_t	key_user_lock;
 extern struct key_user	root_key_user;
+extern struct list_head	key_graveyard;
+extern spinlock_t	key_graveyard_lock;
 
 extern struct key_user *key_user_lookup(kuid_t uid);
 extern void key_user_put(struct key_user *user);
diff --git a/security/keys/key.c b/security/keys/key.c
index 7198cd2ac3a3..7511f2017b6b 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -22,6 +22,8 @@ DEFINE_SPINLOCK(key_serial_lock);
 
 struct rb_root	key_user_tree; /* tree of quota records indexed by UID */
 DEFINE_SPINLOCK(key_user_lock);
+LIST_HEAD(key_graveyard);
+DEFINE_SPINLOCK(key_graveyard_lock);
 
 unsigned int key_quota_root_maxkeys = 1000000;	/* root's key count quota */
 unsigned int key_quota_root_maxbytes = 25000000; /* root's key space quota */
@@ -658,8 +660,9 @@ void key_put(struct key *key)
 				key->user->qnbytes -= key->quotalen;
 				spin_unlock_irqrestore(&key->user->lock, flags);
 			}
-			smp_mb(); /* key->user before FINAL_PUT set. */
-			set_bit(KEY_FLAG_FINAL_PUT, &key->flags);
+			spin_lock_irqsave(&key_graveyard_lock, flags);
+			list_add_tail(&key->graveyard_link, &key_graveyard);
+			spin_unlock_irqrestore(&key_graveyard_lock, flags);
 			schedule_work(&key_gc_work);
 		}
 	}
-- 
2.39.5


