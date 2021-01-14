Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83DCF2F645E
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Jan 2021 16:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbhANPU7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Jan 2021 10:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729601AbhANPU7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Jan 2021 10:20:59 -0500
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEFAC061575
        for <linux-integrity@vger.kernel.org>; Thu, 14 Jan 2021 07:19:54 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4DGnyx49bPzMqK38;
        Thu, 14 Jan 2021 16:19:05 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4DGnyw1V8nzlpq09;
        Thu, 14 Jan 2021 16:19:04 +0100 (CET)
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
        "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Ben Boeckel <mathstuf@gmail.com>
Subject: [PATCH v3 01/10] certs/blacklist: fix kernel doc interface issue
Date:   Thu, 14 Jan 2021 16:19:00 +0100
Message-Id: <20210114151909.2344974-2-mic@digikod.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210114151909.2344974-1-mic@digikod.net>
References: <20210114151909.2344974-1-mic@digikod.net>
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
---

Changes since v2:
* Cherry-pick patch from
  https://lore.kernel.org/lkml/2659836.1607940186@warthog.procyon.org.uk/
  to avoid future merge conflicts.
* Rearrange Signed-off-by and Reviewed-by order.
---
 certs/blacklist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/certs/blacklist.c b/certs/blacklist.c
index 6514f9ebc943..2719fb2fbc1c 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -78,7 +78,7 @@ static struct key_type key_type_blacklist = {
 
 /**
  * mark_hash_blacklisted - Add a hash to the system blacklist
- * @hash - The hash as a hex string with a type prefix (eg. "tbs:23aa429783")
+ * @hash: The hash as a hex string with a type prefix (eg. "tbs:23aa429783")
  */
 int mark_hash_blacklisted(const char *hash)
 {
-- 
2.30.0

