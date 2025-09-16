Return-Path: <linux-integrity+bounces-7106-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D58FB7D23E
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Sep 2025 14:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ECBB526287
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 22:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9931229B8D3;
	Tue, 16 Sep 2025 22:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="f20TK0x2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C741529B8D8
	for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060818; cv=none; b=lm2j1bjdjxJKNcg3tTXEbbIP6e6MhX9moT/Wuu5z2MC1WxayQMntCcD2PR4Hmo04jB8sK1rpi+N5ttKgS1uZHn7Q93PR3JJSaO9Z1+ucPFFq2Mb7IfGh5K5+xgckh1JUYprHENImR4bhxfyUSQaJ4PW54CbUmhSPljZsjZB5+EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060818; c=relaxed/simple;
	bh=ZsTsUe7KB/fRG4hPi39EVd0SPkYeMqo4l7LfiwrcD5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=De2VnEJHnsUkrlGOUL4ikkU7HlNIB19361Gvt27Aoct/LPBCl1lAvKmyzGGwZo7dfS8puImXoxb0+CEt1cVbUP87YsuUO/igdX0eeG2HMHACX6C15vCATbWFwgUeZXCFSc5uPJsC+q5MjnuS6W6A8ThYUOT9lHdc9TGT117YOL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=f20TK0x2; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-812bc4ff723so555333585a.0
        for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 15:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060816; x=1758665616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXBE0miAvJCPRe/3P3rRPrUOzckIx/T6Dok4h3Vo8co=;
        b=f20TK0x2wi7MOxEdV68n6Ay2kPEFVW3hfREmi8pa88/FyAKGe84F0JEA/VI96duPMA
         zNSizRt6m47EslA1az2YXmBeT1dDJQWztzNYjWgLD6JGBCZB/nCHR2k2vip59EFt8SZE
         R7oxrwcTVunZ3TVaVS9hunrOEA7HsSfAkX2e3dwoYxwTekrKZWkPrFXL3K76UKNUfV9l
         Q2pfFW0WKK9SzNDsSKcvsIZn0sNtMgkr9iuYge29IJzZXQzmiVzo+X5QSrOEo5jOZkDj
         nlAFhd6PVEJQrytO2zT5XbWYEg8+WGEER7aSU/P3k/bi/N7xULcT5HEXx6IP/Lm5HK6Y
         atCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060816; x=1758665616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXBE0miAvJCPRe/3P3rRPrUOzckIx/T6Dok4h3Vo8co=;
        b=H3OyQjjiNtDRaBaC9QcANd65alAt/+2F3fSVJOJYF31qmKPx1xkF3y7boO5iJmZzA+
         zJB49+b8pTzKuXxLiugUno2YSUvdSgtMPLUuh3atl7bwlXHOcL9duX4dibRpCTez3PUu
         dVxhZ9P0EW9uOgiI5t6JIQs3b3kjICUgyXJ6F+l8mNg6RSxqi7XyWU6HQ9YRfAL35bp+
         SkBMzRVkMrEnxiXJ8VdDo2f8Z9uNYBZMG0fc3IREQ70trPFztO8r4azP7tcpXrnIaxhf
         rnKWt2Y0tkX9a2vdHoGln9GnTofPpW0qIinU8GiK8zQ9YVJfU03aeaK0jFQK27sOefzD
         R2lw==
X-Forwarded-Encrypted: i=1; AJvYcCWmmiyeQWTJXk+zhGhb+H8AUYVapWojRlifsI2VtJBjgHXstLnlPjo/rIb7axMurq9VJt1+vOHv46tPflC1WGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrJnUwq4XMe+T4KRhssDJ6YF8J8xWM3Hw73xabJ/KeAc2IBCXb
	CODted1gDCJkkKDTGT3qr/vSt483Km+/653jVZW0ejYFxmxH1yJ+WIQo5alMx5Lipg==
X-Gm-Gg: ASbGncuVHFFJFt78kdQXC4dfs8stUo/Nr3k5FLNV0XhHHyqFLsP++Dlinkx9ZNDslMK
	L6R4wv2Y82aqOkGxhwhb62+fdST2jCKxLzVAe8LmokDtdKs2t5cG6vPzbKIaCHHSvfi94/Sgsw4
	xHtwMFBbch8rnL6JSvYvR8ykJrODSxC3qVCwCHVFw6x/m+j47b4rE9JzItG//Kejl9yQGtkgqUk
	V+4z3t6+xBn+uI0RoA3qlGKGooqJ3+TWZXyrhaVPvOQFWOQk2DV9d5du//UFIebiQcwIAR/rPX4
	QP58NyT61tF2lGU38z51sDU0Pupdbv6bV6Py6ak/A/DdDEikN5E2NcXAai6/edAZkBbEBH0Oc/0
	1CUSL0W49nUOhMB+8NhmO3Rb57acHaIz2GPg5VCRS/zcmyWYfRkKkRDy4P3yTVCPPDx9J
X-Google-Smtp-Source: AGHT+IHq+f6shHxcmeNJbOvuYFprXFIs6WlA6JRRiS4W0Ba91fs8M9m425h2rAz5G7lBGwp1PxjWTw==
X-Received: by 2002:a05:620a:2684:b0:82a:9b78:3db1 with SMTP id af79cd13be357-82a9b784c45mr794623485a.69.1758060815642;
        Tue, 16 Sep 2025 15:13:35 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-820c9846379sm1032458785a.18.2025.09.16.15.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:13:34 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [PATCH v4 01/34] lsm: split the notifier code out into lsm_notifier.c
Date: Tue, 16 Sep 2025 18:03:28 -0400
Message-ID: <20250916220355.252592-37-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3528; i=paul@paul-moore.com; h=from:subject; bh=ZsTsUe7KB/fRG4hPi39EVd0SPkYeMqo4l7LfiwrcD5A=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd7LWvt4xxRbzM1uI28EP/r5t765x5ZVKeyqR mDjbKS5kU+JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMneywAKCRDqIPLalzeJ c9kSD/9azawztAREfYvFT88o1nxfOc2gVmnIT3Jh/NK9fFD5HNFKYUvSPilyfEQ/rhVgOm3ROXU eWNZxOi9jcq6jxFvYMnmvJe0eH8dnS8t5dbHJUVVbrG2DSMZeI3KhcZXQjVOklWdN/FQ4CQWI0W 4O/cAcRGZqli48ysoXBTz3SNWimouDU/4xE/D3q/RIjYM0ptrSC47W20regn9dn/GOMaJe4wdmM LEO3DrD07BaNg7DLqMqg59Uch173R7jQh/Wl3e8YF3AK9G64zP2r6kg7QykqZ9vGS1nGRNrgN8Q tVJhqAzrPKMW4HpdtUikinqjxvL0n/Cc9rUtWObWfuntLOUhQRXwaHIllmpyGyhM9t+7vYrKtha RhJCut3vu+UsEui1+TPcFY3NA2XoarXqZ4kIadsnKGTZi0DGllpAQSEyZm3TkPr9ZCX0o1O9/EC ApbW6ogqDoG1oPGp57vNmk4DFMclIMMSrjCizNAx4qEN0JyU/EIXYB51DagC+SpXIbQXBqrQTLC aVUSJTGhsMvbv7Tp8Mtlvd2HmTGsIvf6rCZOoa/eeKts0zAa5qSHtxtXexK3750lTV49Cz4CS4v os9GXTDstDufVgWfILaQG7LKbMzGYU4TsZ6rn07vBDPm8BY3cSwtG0LdAEukOEblg/hJ2UMtWTd 7ZfWB6gq8fayWww==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

In an effort to decompose security/security.c somewhat to make it less
twisted and unwieldy, pull out the LSM notifier code into a new file
as it is fairly well self-contained.

No code changes.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/Makefile       |  2 +-
 security/lsm_notifier.c | 31 +++++++++++++++++++++++++++++++
 security/security.c     | 23 -----------------------
 3 files changed, 32 insertions(+), 24 deletions(-)
 create mode 100644 security/lsm_notifier.c

diff --git a/security/Makefile b/security/Makefile
index 22ff4c8bd8ce..14d87847bce8 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_SECURITY) 			+= lsm_syscalls.o
 obj-$(CONFIG_MMU)			+= min_addr.o
 
 # Object file lists
-obj-$(CONFIG_SECURITY)			+= security.o
+obj-$(CONFIG_SECURITY)			+= security.o lsm_notifier.o
 obj-$(CONFIG_SECURITYFS)		+= inode.o
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/
 obj-$(CONFIG_SECURITY_SMACK)		+= smack/
diff --git a/security/lsm_notifier.c b/security/lsm_notifier.c
new file mode 100644
index 000000000000..c92fad5d57d4
--- /dev/null
+++ b/security/lsm_notifier.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * LSM notifier functions
+ *
+ */
+
+#include <linux/notifier.h>
+#include <linux/security.h>
+
+static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
+
+int call_blocking_lsm_notifier(enum lsm_event event, void *data)
+{
+	return blocking_notifier_call_chain(&blocking_lsm_notifier_chain,
+					    event, data);
+}
+EXPORT_SYMBOL(call_blocking_lsm_notifier);
+
+int register_blocking_lsm_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&blocking_lsm_notifier_chain,
+						nb);
+}
+EXPORT_SYMBOL(register_blocking_lsm_notifier);
+
+int unregister_blocking_lsm_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&blocking_lsm_notifier_chain,
+						  nb);
+}
+EXPORT_SYMBOL(unregister_blocking_lsm_notifier);
diff --git a/security/security.c b/security/security.c
index ca126b02d2fe..8cb049bebc57 100644
--- a/security/security.c
+++ b/security/security.c
@@ -90,8 +90,6 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
-
 static struct kmem_cache *lsm_file_cache;
 static struct kmem_cache *lsm_inode_cache;
 
@@ -649,27 +647,6 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	}
 }
 
-int call_blocking_lsm_notifier(enum lsm_event event, void *data)
-{
-	return blocking_notifier_call_chain(&blocking_lsm_notifier_chain,
-					    event, data);
-}
-EXPORT_SYMBOL(call_blocking_lsm_notifier);
-
-int register_blocking_lsm_notifier(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_register(&blocking_lsm_notifier_chain,
-						nb);
-}
-EXPORT_SYMBOL(register_blocking_lsm_notifier);
-
-int unregister_blocking_lsm_notifier(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_unregister(&blocking_lsm_notifier_chain,
-						  nb);
-}
-EXPORT_SYMBOL(unregister_blocking_lsm_notifier);
-
 /**
  * lsm_blob_alloc - allocate a composite blob
  * @dest: the destination for the blob
-- 
2.51.0


