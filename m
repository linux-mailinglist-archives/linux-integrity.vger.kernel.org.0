Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38B4618E5BA
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Mar 2020 02:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgCVBLw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 21 Mar 2020 21:11:52 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:37123 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727944AbgCVBLu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 21 Mar 2020 21:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584839508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=68srroxVO8t4m8KDSzYFB9tDrvV53dK+58Y/C/+aWXU=;
        b=eOproAYgTf4t5cWJp1KoZ5WxSHWX/dcAFur+ygtwZOP4GMSM/NTMzTQaYaSgz7E7+hEywR
        AWThsvP6upRNCN0hTbJqouUguq4SMndqLZ8heZ4aPvL30A2yN75l5/0YGzci/ljyG/5s0d
        ReJluoo/ZR+r3ai+Eok74nEQkU754cg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-YolrCFwmMKqfpQy_rCz9MA-1; Sat, 21 Mar 2020 21:11:44 -0400
X-MC-Unique: YolrCFwmMKqfpQy_rCz9MA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E88841857BF4;
        Sun, 22 Mar 2020 01:11:41 +0000 (UTC)
Received: from llong.com (ovpn-112-193.rdu2.redhat.com [10.10.112.193])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 137D99B90A;
        Sun, 22 Mar 2020 01:11:39 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, netdev@vger.kernel.org,
        linux-afs@lists.infradead.org, Sumit Garg <sumit.garg@linaro.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Eric Biggers <ebiggers@google.com>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v8 2/2] KEYS: Avoid false positive ENOMEM error on key read
Date:   Sat, 21 Mar 2020 21:11:25 -0400
Message-Id: <20200322011125.24327-3-longman@redhat.com>
In-Reply-To: <20200322011125.24327-1-longman@redhat.com>
References: <20200322011125.24327-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

By allocating a kernel buffer with a user-supplied buffer length, it
is possible that a false positive ENOMEM error may be returned because
the user-supplied length is just too large even if the system do have
enough memory to hold the actual key data.

Moreover, if the buffer length is larger than the maximum amount of
memory that can be returned by kmalloc() (2^(MAX_ORDER-1) number of
pages), a warning message will also be printed.

To reduce this possibility, we set a threshold (PAGE_SIZE) over which we
do check the actual key length first before allocating a buffer of the
right size to hold it. The threshold is arbitrary, it is just used to
trigger a buffer length check. It does not limit the actual key length
as long as there is enough memory to satisfy the memory request.

To further avoid large buffer allocation failure due to page
fragmentation, kvmalloc() is used to allocate the buffer so that vmapped
pages can be used when there is not a large enough contiguous set of
pages available for allocation.

In the extremely unlikely scenario that the key keeps on being changed
and made longer (still <= buflen) in between 2 __keyctl_read_key()
calls, the __keyctl_read_key() calling loop in keyctl_read_key() may
have to be iterated a large number of times, but definitely not infinite.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 security/keys/internal.h | 12 +++++++++
 security/keys/keyctl.c   | 58 +++++++++++++++++++++++++++++-----------
 2 files changed, 55 insertions(+), 15 deletions(-)

diff --git a/security/keys/internal.h b/security/keys/internal.h
index ba3e2da14cef..6d0ca48ae9a5 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -16,6 +16,8 @@
 #include <linux/keyctl.h>
 #include <linux/refcount.h>
 #include <linux/compat.h>
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
 
 struct iovec;
 
@@ -349,4 +351,14 @@ static inline void key_check(const struct key *key)
 
 #endif
 
+/*
+ * Helper function to clear and free a kvmalloc'ed memory object.
+ */
+static inline void __kvzfree(const void *addr, size_t len)
+{
+	if (addr) {
+		memset((void *)addr, 0, len);
+		kvfree(addr);
+	}
+}
 #endif /* _INTERNAL_H */
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 434ed9defd3a..0062e422e0fd 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -339,7 +339,7 @@ long keyctl_update_key(key_serial_t id,
 	payload = NULL;
 	if (plen) {
 		ret = -ENOMEM;
-		payload = kmalloc(plen, GFP_KERNEL);
+		payload = kvmalloc(plen, GFP_KERNEL);
 		if (!payload)
 			goto error;
 
@@ -360,7 +360,7 @@ long keyctl_update_key(key_serial_t id,
 
 	key_ref_put(key_ref);
 error2:
-	kzfree(payload);
+	__kvzfree(payload, plen);
 error:
 	return ret;
 }
@@ -827,7 +827,8 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
 	struct key *key;
 	key_ref_t key_ref;
 	long ret;
-	char *key_data;
+	char *key_data = NULL;
+	size_t key_data_len;
 
 	/* find the key first */
 	key_ref = lookup_user_key(keyid, 0, 0);
@@ -878,24 +879,51 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
 	 * Allocating a temporary buffer to hold the keys before
 	 * transferring them to user buffer to avoid potential
 	 * deadlock involving page fault and mmap_sem.
+	 *
+	 * key_data_len = (buflen <= PAGE_SIZE)
+	 *		? buflen : actual length of key data
+	 *
+	 * This prevents allocating arbitrary large buffer which can
+	 * be much larger than the actual key length. In the latter case,
+	 * at least 2 passes of this loop is required.
 	 */
-	key_data = kmalloc(buflen, GFP_KERNEL);
+	key_data_len = (buflen <= PAGE_SIZE) ? buflen : 0;
+	for (;;) {
+		if (key_data_len) {
+			key_data = kvmalloc(key_data_len, GFP_KERNEL);
+			if (!key_data) {
+				ret = -ENOMEM;
+				goto key_put_out;
+			}
+		}
 
-	if (!key_data) {
-		ret = -ENOMEM;
-		goto key_put_out;
-	}
-	ret = __keyctl_read_key(key, key_data, buflen);
+		ret = __keyctl_read_key(key, key_data, key_data_len);
+
+		/*
+		 * Read methods will just return the required length without
+		 * any copying if the provided length isn't large enough.
+		 */
+		if (ret <= 0 || ret > buflen)
+			break;
+
+		/*
+		 * The key may change (unlikely) in between 2 consecutive
+		 * __keyctl_read_key() calls. In this case, we reallocate
+		 * a larger buffer and redo the key read when
+		 * key_data_len < ret <= buflen.
+		 */
+		if (ret > key_data_len) {
+			if (unlikely(key_data))
+				__kvzfree(key_data, key_data_len);
+			key_data_len = ret;
+			continue;	/* Allocate buffer */
+		}
 
-	/*
-	 * Read methods will just return the required length without
-	 * any copying if the provided length isn't large enough.
-	 */
-	if (ret > 0 && ret <= buflen) {
 		if (copy_to_user(buffer, key_data, ret))
 			ret = -EFAULT;
+		break;
 	}
-	kzfree(key_data);
+	__kvzfree(key_data, key_data_len);
 
 key_put_out:
 	key_put(key);
-- 
2.18.1

