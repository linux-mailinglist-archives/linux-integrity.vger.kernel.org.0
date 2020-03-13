Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73501184A82
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Mar 2020 16:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgCMPVh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Mar 2020 11:21:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37075 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726965AbgCMPVg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Mar 2020 11:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584112896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=Guy49jz/MclwiKRYm/R98tQ5vcDgMGGlebOY5cev/kE=;
        b=FNo2trNcrJmZ0QJZlhswX8JU608mHHfo4O4ua6RXnTjZTIiL8jHP1uzuZhSmyNJJQ/gnaD
        vaqewAKUEBMSa7AGrx6yite9hp2nxzlvulFIprIF9gYTNz/cjahr3WSJ7qU9YaCsgIpZX+
        AfFTGTTbMJorZHTC6F9kD+md3ya+ps4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-VNOdMdZHMWGwBA7EAb8cFg-1; Fri, 13 Mar 2020 11:21:32 -0400
X-MC-Unique: VNOdMdZHMWGwBA7EAb8cFg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E882808245;
        Fri, 13 Mar 2020 15:21:30 +0000 (UTC)
Received: from llong.com (ovpn-125-21.rdu2.redhat.com [10.10.125.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46A8291D61;
        Fri, 13 Mar 2020 15:21:28 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Eric Biggers <ebiggers@google.com>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v3 3/3] KEYS: Use kvmalloc() to better handle large buffer allocation
Date:   Fri, 13 Mar 2020 11:21:02 -0400
Message-Id: <20200313152102.1707-4-longman@redhat.com>
In-Reply-To: <20200313152102.1707-1-longman@redhat.com>
References: <20200313152102.1707-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

For large multi-page temporary buffer allocation, the security/keys
subsystem don't need contiguous physical pages. It will work perfectly
fine with virtually mapped pages.

Replace the kmalloc() call by kvmalloc() and provide a __kvzfree()
helper function to clear and free the kvmalloc'ed buffer. This will
reduce the chance of memory allocation failure just because of highly
fragmented pages.

Suggested-by: David Howells <dhowells@redhat.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 security/keys/internal.h | 14 ++++++++++++++
 security/keys/keyctl.c   | 10 +++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/security/keys/internal.h b/security/keys/internal.h
index ba3e2da14cef..855b11eb73ee 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -16,6 +16,8 @@
 #include <linux/keyctl.h>
 #include <linux/refcount.h>
 #include <linux/compat.h>
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
 
 struct iovec;
 
@@ -349,4 +351,16 @@ static inline void key_check(const struct key *key)
 
 #endif
 
+/*
+ * Helper function to clear and free a kvmalloc'ed memory object.
+ */
+static inline void __kvzfree(const void *addr, size_t len)
+{
+	if (is_vmalloc_addr(addr)) {
+		memset((void *)addr, 0, len);
+		vfree(addr);
+	} else {
+		kzfree(addr);
+	}
+}
 #endif /* _INTERNAL_H */
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index a05a4dd2f9ce..878259cf35d5 100644
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
@@ -893,7 +893,7 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
 		 */
 		if (buflen <= 0x400) {
 allocbuf:
-			tmpbuf = kmalloc(tmpbuflen, GFP_KERNEL);
+			tmpbuf = kvmalloc(tmpbuflen, GFP_KERNEL);
 			if (!tmpbuf) {
 				ret = -ENOMEM;
 				goto error2;
@@ -911,7 +911,7 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
 			 */
 			if (!tmpbuf || unlikely(ret > tmpbuflen)) {
 				if (unlikely(tmpbuf))
-					kzfree(tmpbuf);
+					__kvzfree(tmpbuf, tmpbuflen);
 				tmpbuflen = ret;
 				goto allocbuf;
 			}
@@ -920,7 +920,7 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
 				ret = -EFAULT;
 		}
 		if (tmpbuf)
-			kzfree(tmpbuf);
+			__kvzfree(tmpbuf, tmpbuflen);
 	}
 
 error2:
-- 
2.18.1

