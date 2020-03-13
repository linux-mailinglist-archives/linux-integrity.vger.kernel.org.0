Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A17D184A85
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Mar 2020 16:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgCMPVo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Mar 2020 11:21:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45773 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726949AbgCMPVf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Mar 2020 11:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584112894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=IgMdwtUBEGAuM/8z5e97O8Otg6NfgxXQdFDc4jd+DZ0=;
        b=HI7pP3qmZp4wLPpLWhs902AtRKBnJ4juj3R8nt7Mb4VVCALqWwZoK+d6PCM0fA6ZYJjnko
        iUrmiAIj2A0gE07Mi76XBYR/fuZE8+OWxZ3tWynhSU4L19ydyx5Gwfg08wfAwe4+Gv+37r
        YOiKY0ujYz5SjTiDUwS10sxY7+v6dEQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-7l5v2bgOOHicxRo9VhQqFw-1; Fri, 13 Mar 2020 11:21:30 -0400
X-MC-Unique: 7l5v2bgOOHicxRo9VhQqFw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14CE8107B767;
        Fri, 13 Mar 2020 15:21:28 +0000 (UTC)
Received: from llong.com (ovpn-125-21.rdu2.redhat.com [10.10.125.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1316492D30;
        Fri, 13 Mar 2020 15:21:25 +0000 (UTC)
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
Subject: [PATCH v3 2/3] KEYS: Avoid false positive ENOMEM error on key read
Date:   Fri, 13 Mar 2020 11:21:01 -0400
Message-Id: <20200313152102.1707-3-longman@redhat.com>
In-Reply-To: <20200313152102.1707-1-longman@redhat.com>
References: <20200313152102.1707-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
 security/keys/keyctl.c | 48 ++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 81f68e434b9f..a05a4dd2f9ce 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -877,24 +877,50 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
 		 * transferring them to user buffer to avoid potential
 		 * deadlock involving page fault and mmap_sem.
 		 */
-		char *tmpbuf = kmalloc(buflen, GFP_KERNEL);
-
-		if (!tmpbuf) {
-			ret = -ENOMEM;
-			goto error2;
-		}
-		ret = __keyctl_read_key(key, tmpbuf, buflen);
+		char *tmpbuf = NULL;
+		size_t tmpbuflen = buflen;
 
 		/*
-		 * Read methods will just return the required length
-		 * without any copying if the provided length isn't big
-		 * enough.
+		 * We don't want an erronous -ENOMEM error due to an
+		 * arbitrary large user-supplied buflen. So if buflen
+		 * exceeds a threshold (1024 bytes in this case), we call
+		 * the read method twice. The first time to get the buffer
+		 * length and the second time to read out the key data.
+		 *
+		 * N.B. All the read methods will return the required
+		 *      buffer length with a NULL input buffer or when
+		 *      the input buffer length isn't large enough.
 		 */
+		if (buflen <= 0x400) {
+allocbuf:
+			tmpbuf = kmalloc(tmpbuflen, GFP_KERNEL);
+			if (!tmpbuf) {
+				ret = -ENOMEM;
+				goto error2;
+			}
+		}
+
+		ret = __keyctl_read_key(key, tmpbuf, tmpbuflen);
 		if ((ret > 0) && (ret <= buflen)) {
+			/*
+			 * It is possible, though unlikely, that the key
+			 * changes in between the up_read->down_read period.
+			 * If the key becomes longer, we will have to
+			 * allocate a larger buffer and redo the key read
+			 * again.
+			 */
+			if (!tmpbuf || unlikely(ret > tmpbuflen)) {
+				if (unlikely(tmpbuf))
+					kzfree(tmpbuf);
+				tmpbuflen = ret;
+				goto allocbuf;
+			}
+
 			if (copy_to_user(buffer, tmpbuf, ret))
 				ret = -EFAULT;
 		}
-		kzfree(tmpbuf);
+		if (tmpbuf)
+			kzfree(tmpbuf);
 	}
 
 error2:
-- 
2.18.1

