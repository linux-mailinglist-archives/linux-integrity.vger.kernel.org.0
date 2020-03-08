Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD55017D513
	for <lists+linux-integrity@lfdr.de>; Sun,  8 Mar 2020 18:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgCHREh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 8 Mar 2020 13:04:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23250 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726438AbgCHREh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 8 Mar 2020 13:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583687075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=/kCt/AmtzbGfbmI9H2k3aFKT17BIacOKpSUSO5iFTyU=;
        b=Rgjqixj+dW9a1GbYmRGV+83APmqam0/cW1X/co5T8+XbEbu1u4qJFsoSOSguy603dTxcE1
        MJnJK1YODxPc1uaC8QeVqVzrIqelZelGuHQH3biY8jT+iXJIPLdC0gJ7Erej0HBe7wDVEb
        42hlXBXDrfBoyYICeZcEymlqQzb+Rcw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-mU65sZXEOp2RH0nVCNxe6Q-1; Sun, 08 Mar 2020 13:04:31 -0400
X-MC-Unique: mU65sZXEOp2RH0nVCNxe6Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D17B800D50;
        Sun,  8 Mar 2020 17:04:29 +0000 (UTC)
Received: from llong.com (ovpn-120-251.rdu2.redhat.com [10.10.120.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E94F85D9C5;
        Sun,  8 Mar 2020 17:04:27 +0000 (UTC)
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
Subject: [PATCH v2 2/2] KEYS: Avoid false positive ENOMEM error on key read
Date:   Sun,  8 Mar 2020 13:04:10 -0400
Message-Id: <20200308170410.14166-3-longman@redhat.com>
In-Reply-To: <20200308170410.14166-1-longman@redhat.com>
References: <20200308170410.14166-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

By allocating a kernel buffer with an user-supplied buffer length, it
is possible that a false positive ENOMEM error may be returned because
the user-supplied length is just too large even if the system do have
enough memory to hold the actual key data.

To reduce this possibility, we set a threshold (1024) over which we
do check the actual key length first before allocating a buffer of the
right size to hold it.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 security/keys/keyctl.c | 46 ++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 89a14e71eb0a..662a638a680d 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -855,28 +855,52 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
 		 * deadlock involving page fault and mmap_sem.
 		 */
 		char *tmpbuf = NULL;
+		size_t tbuflen = buflen;
 
-		if (buffer && buflen) {
-			tmpbuf = kmalloc(buflen, GFP_KERNEL);
+		/*
+		 * We don't want an erronous -ENOMEM error due to an
+		 * arbitrary large user-supplied buflen. So if buflen
+		 * exceeds a threshold (1024 bytes in this case), we call
+		 * the read method twice. The first time to get the buffer
+		 * length and the second time to read out the key data.
+		 *
+		 * N.B. All the read methods will return the required
+		 *      buffer length with a NULL input buffer or when
+		 *      the input buffer length isn't large enough.
+		 */
+		if (buflen && buffer && (buflen <= 0x400)) {
+allocbuf:
+			tmpbuf = kmalloc(tbuflen, GFP_KERNEL);
 			if (!tmpbuf) {
 				ret = -ENOMEM;
 				goto error2;
 			}
 		}
+
 		down_read(&key->sem);
 		ret = key_validate(key);
 		if (ret == 0)
-			ret = key->type->read(key, tmpbuf, buflen);
+			ret = key->type->read(key, tmpbuf, tbuflen);
 		up_read(&key->sem);
 
-		/*
-		 * Read methods will just return the required length
-		 * without any copying if the provided length isn't big
-		 * enough.
-		 */
-		if ((ret > 0) && (ret <= buflen) && buffer &&
-		    copy_to_user(buffer, tmpbuf, ret))
-			ret = -EFAULT;
+		if ((ret > 0) && (ret <= buflen) && buffer) {
+			/*
+			 * It is possible, though unlikely, that the key
+			 * changes in between the up_read->down_read period.
+			 * If the key becomes longer, we will have to
+			 * allocate a larger buffer and redo the key read
+			 * again.
+			 */
+			if (!tmpbuf || unlikely(ret > tbuflen)) {
+				tbuflen = ret;
+				if (unlikely(tmpbuf))
+					kzfree(tmpbuf);
+				goto allocbuf;
+			}
+
+			if (copy_to_user(buffer, tmpbuf, ret))
+				ret = -EFAULT;
+		}
 
 		if (tmpbuf)
 			kzfree(tmpbuf);
-- 
2.18.1

