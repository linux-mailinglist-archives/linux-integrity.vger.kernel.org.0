Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606272FF0E7
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Jan 2021 17:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387892AbhAUQsf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 21 Jan 2021 11:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732426AbhAUP6j (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Jan 2021 10:58:39 -0500
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE09C061221
        for <linux-integrity@vger.kernel.org>; Thu, 21 Jan 2021 07:57:19 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4DM6Rm4WDMzMr6dq;
        Thu, 21 Jan 2021 16:55:32 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4DM6Rm1Cf9zlppys;
        Thu, 21 Jan 2021 16:55:32 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Ben Boeckel <mathstuf@gmail.com>
Subject: [PATCH v4 07/10] certs/blacklist: fix kernel doc interface issue
Date:   Thu, 21 Jan 2021 16:55:10 +0100
Message-Id: <20210121155513.539519-8-mic@digikod.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121155513.539519-1-mic@digikod.net>
References: <20210121155513.539519-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Alex Shi <alex.shi@linux.alibaba.com>

certs/blacklist.c:84: warning: Function parameter or member 'hash' not
described in 'mark_hash_blacklisted'

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: keyrings@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Ben Boeckel <mathstuf@gmail.com>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---

Changes since v3:
* Add Reviewed-by Jarkko Sakkinen.

Changes since v2:
* Cherry-pick patch from
  https://lore.kernel.org/lkml/2659836.1607940186@warthog.procyon.org.uk/
  to avoid future merge conflicts.
* Rearrange Signed-off-by and Reviewed-by order.
---
 certs/blacklist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/certs/blacklist.c b/certs/blacklist.c
index 069050884bd2..334ab7b964bc 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -105,7 +105,7 @@ static struct key_type key_type_blacklist = {
 
 /**
  * mark_hash_blacklisted - Add a hash to the system blacklist
- * @hash - The hash as a hex string with a type prefix (eg. "tbs:23aa429783")
+ * @hash: The hash as a hex string with a type prefix (eg. "tbs:23aa429783")
  */
 int mark_hash_blacklisted(const char *hash)
 {
-- 
2.30.0

