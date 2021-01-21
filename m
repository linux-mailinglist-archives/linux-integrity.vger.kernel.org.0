Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEAAE2FEF9E
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Jan 2021 16:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbhAUP6g (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 21 Jan 2021 10:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732077AbhAUP6Y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Jan 2021 10:58:24 -0500
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [IPv6:2001:1600:3:17::42ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61878C06121C
        for <linux-integrity@vger.kernel.org>; Thu, 21 Jan 2021 07:55:37 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4DM6Rr1BKfzMr5GF;
        Thu, 21 Jan 2021 16:55:36 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4DM6Rq5lVXzlppys;
        Thu, 21 Jan 2021 16:55:35 +0100 (CET)
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
        Ben Boeckel <mathstuf@gmail.com>
Subject: [PATCH v4 09/10] PKCS#7: Fix missing include
Date:   Thu, 21 Jan 2021 16:55:12 +0100
Message-Id: <20210121155513.539519-10-mic@digikod.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121155513.539519-1-mic@digikod.net>
References: <20210121155513.539519-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

Add missing linux/types.h for size_t.

[DH: Changed from stddef.h]

Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Ben Boeckel <mathstuf@gmail.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---

Changes since v3:
* Add Reviewed-by Jarkko Sakkinen.

Changes since v2:
* Cherry-pick v1 patch from
  https://lore.kernel.org/lkml/2659836.1607940186@warthog.procyon.org.uk/
  to rebase on v5.11-rc3.
---
 include/linux/verification.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/verification.h b/include/linux/verification.h
index 911ab7c2b1ab..a655923335ae 100644
--- a/include/linux/verification.h
+++ b/include/linux/verification.h
@@ -8,6 +8,8 @@
 #ifndef _LINUX_VERIFICATION_H
 #define _LINUX_VERIFICATION_H
 
+#include <linux/types.h>
+
 /*
  * Indicate that both builtin trusted keys and secondary trusted keys
  * should be used.
-- 
2.30.0

