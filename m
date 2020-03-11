Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDA76181C5C
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Mar 2020 16:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbgCKPeE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Mar 2020 11:34:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56243 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729691AbgCKPeE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Mar 2020 11:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583940842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u0xU1PIw/tg3wOhypjxZL8zbVhPE6xy4N+qm1n6mhVU=;
        b=V51LSMFH10RI2xvo6TfB8DX30zWk+wMXagDlTOFZKSx4VlLP3lgiqiwCMtPASb0SzwTHLC
        c+IgR5gy4JbETdS4LnadiS5OSYgJ7+lal/E+tb+zWhqi7T7mCfi/PUzwkmzkDzwz8tEd5f
        ed4D1ES5zv8ldS5CxzoQsYT5cR1l5Pw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-JzqYz28jPcSBOwpmBU3X3g-1; Wed, 11 Mar 2020 11:33:59 -0400
X-MC-Unique: JzqYz28jPcSBOwpmBU3X3g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5922189D6C0;
        Wed, 11 Mar 2020 15:33:56 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F24EA8D553;
        Wed, 11 Mar 2020 15:33:54 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] KEYS: Avoid false positive ENOMEM error on key
 read
To:     David Howells <dhowells@redhat.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Eric Biggers <ebiggers@google.com>,
        Chris von Recklinghausen <crecklin@redhat.com>
References: <da226448-4b76-0456-4c29-742a1a24fe79@redhat.com>
 <20200308170410.14166-3-longman@redhat.com>
 <20200308170410.14166-1-longman@redhat.com>
 <416690.1583771540@warthog.procyon.org.uk>
 <a4c92057-c364-965c-a251-02cbe46229b6@redhat.com>
 <675400.1583860343@warthog.procyon.org.uk>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <7d0b0c5f-98e7-0fb6-69cd-76a31a010bcb@redhat.com>
Date:   Wed, 11 Mar 2020 11:33:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <675400.1583860343@warthog.procyon.org.uk>
Content-Type: multipart/mixed;
 boundary="------------38FC0D37D8A890979402365F"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This is a multi-part message in MIME format.
--------------38FC0D37D8A890979402365F
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 3/10/20 1:12 PM, David Howells wrote:
> Waiman Long <longman@redhat.com> wrote:
>
>> That is not as simple as I thought. First of that, there is not an
>> equivalent kzvfree() helper to clear the buffer first before clearing.
>> Of course, I can do that manually.
> Yeah, the actual substance of vfree() may get deferred.  It may be worth
> adding a kvzfree() that switches between kzfree() and memset(),vfree().
>
>> With patch 2, the allocated buffer length will be max(1024, keylen). The
>> security code uses kmalloc() for allocation. If we use kvalloc() here,
>> perhaps we should also use that for allocation that can be potentially
>> large like that in big_key. What do you think?
> Not for big_key: if it's larger than BIG_KEY_FILE_THRESHOLD (~1KiB) it gets
> written encrypted into shmem so that it can be swapped out to disk when not in
> use.
>
> However, other cases, sure - just be aware that on a 32-bit system,
> vmalloc/vmap space is a strictly limited resource.

Attached is an additional patch to make the transition from kmalloc() to
kvmalloc(). I put the __kvzfree() helper in internal.h for now. I plan
to send a patch later to add a kvzfree() API once there is a use case in
the kernel.

I am not going to touch other places for now to make thing simpler.

Cheers,
Longman


--------------38FC0D37D8A890979402365F
Content-Type: text/x-patch;
 name="v2-0003-KEYS-Use-kvmalloc-to-better-handle-large-buffer-a.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="v2-0003-KEYS-Use-kvmalloc-to-better-handle-large-buffer-a.pa";
 filename*1="tch"

From e2e73e2bc0c5cd168de273b0fe9df1e5c48cd232 Mon Sep 17 00:00:00 2001
From: Waiman Long <longman@redhat.com>
Date: Wed, 11 Mar 2020 11:01:59 -0400
Subject: [PATCH v2 3/3] KEYS: Use kvmalloc() to better handle large buffer
 allocation

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
 security/keys/keyctl.c   | 12 ++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/security/keys/internal.h b/security/keys/internal.h
index ba3e2da14cef..1b6e2d66e378 100644
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
+		memset((char *)addr, 0, len);
+		vfree(addr);
+	} else {
+		kzfree(addr);
+	}
+}
 #endif /* _INTERNAL_H */
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 662a638a680d..ca05604bc9c0 100644
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
@@ -870,7 +870,7 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
 		 */
 		if (buflen && buffer && (buflen <= 0x400)) {
 allocbuf:
-			tmpbuf = kmalloc(tbuflen, GFP_KERNEL);
+			tmpbuf = kvmalloc(tbuflen, GFP_KERNEL);
 			if (!tmpbuf) {
 				ret = -ENOMEM;
 				goto error2;
@@ -892,9 +892,9 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
 			 * again.
 			 */
 			if (!tmpbuf || unlikely(ret > tbuflen)) {
-				tbuflen = ret;
 				if (unlikely(tmpbuf))
-					kzfree(tmpbuf);
+					__kvzfree(tmpbuf, tbuflen);
+				tbuflen = ret;
 				goto allocbuf;
 			}
 
@@ -903,7 +903,7 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
 		}
 
 		if (tmpbuf)
-			kzfree(tmpbuf);
+			__kvzfree(tmpbuf, tbuflen);
 	}
 
 error2:
-- 
2.18.1


--------------38FC0D37D8A890979402365F--

