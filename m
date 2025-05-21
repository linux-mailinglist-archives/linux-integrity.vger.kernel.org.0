Return-Path: <linux-integrity+bounces-6277-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F8BABF71A
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 16:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942873BE2DE
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 14:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E2318FDBE;
	Wed, 21 May 2025 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b="Y2Nr2i4A"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.nightmared.fr (mail.nightmared.fr [51.158.148.24])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD60188A0E;
	Wed, 21 May 2025 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.158.148.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747836366; cv=none; b=lo94xxamcsClAGuZlZdU52gVA7qFQ5eV76mucCKG/UbiVYxbHZXXDysAKXJxXCoCNFs3vPl0vyPWs1NYNBn2qMluu0ikArLv3A/rnELFI3mciASmYcrPg/U3y5pIRgF9xzrSXW25D84wRTgRtIyH7Tt7i/013JyHBn47WEL0i78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747836366; c=relaxed/simple;
	bh=tkmqbrBmAjjvJj58KwygE1BUBwRU37CR2evbRqQsdms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aa9tuAq/D5we9PXxLQc5oGK2ehvf+uyO+j78WDhixTU5qCHzGINhh74tnEQo6JSsFjcK24AS6FbWF7XatMls8DDGz8JUAVCu6J5gfMKlc2l5VNmb9pkwiCvPRIeifk2lv3czsPIYfNWS8ne1o0M56g/AoS8kAqxkK7YuQxyr724=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr; spf=pass smtp.mailfrom=nightmared.fr; dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b=Y2Nr2i4A; arc=none smtp.client-ip=51.158.148.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nightmared.fr
Received: from localhost.localdomain (atoulon-651-1-170-218.w83-113.abo.wanadoo.fr [83.113.65.218])
	by mail.nightmared.fr (Postfix) with ESMTPSA id 35B041087A40;
	Wed, 21 May 2025 14:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nightmared.fr;
	s=docker; t=1747836107;
	bh=tkmqbrBmAjjvJj58KwygE1BUBwRU37CR2evbRqQsdms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y2Nr2i4AKFb9FMPxyeG3PDK/fojf5re/IbyBApfNUgcfNNhoidcVtUPCv0sDUpgri
	 OPfsZPlI427v4txIO6KEsELrdOAZHWWNPKCFJaEPx2uPDpovv3hSHaw65UcLy4wybk
	 HAOEraPY5iWUYq5xheuobvOliwVhW+vM1R4PsRfNrTa3eREFzNEktMRG4P8TrAzyuO
	 jTQBXniqbtmD8EDc2E+6lkjzFLM+7unppkEYMLrVuMWq/UgpSyyv+Q/WVDhWq9mB0V
	 iEWTZE6eAeQhCWU08010IFOnrmoLxCL+mpZJK7y5R2vBzF7auzaUAy53QsgyQYcoQm
	 bKOsNrRu9BzvA==
From: Simon THOBY <git@nightmared.fr>
To: linux-security-module@vger.kernel.org
Cc: Simon THOBY <git@nightmared.fr>,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [RFC PATCH 2/9] Introduce a new LSM: loadpol
Date: Wed, 21 May 2025 16:01:06 +0200
Message-ID: <20250521140121.591482-3-git@nightmared.fr>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521140121.591482-1-git@nightmared.fr>
References: <20250521140121.591482-1-git@nightmared.fr>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a new LSM to filter the load of kernel modules according
to a user-provided policy.

Signed-off-by: Simon THOBY <git@nightmared.fr>
---
 include/linux/lsm_count.h  |  7 +++++++
 include/uapi/linux/lsm.h   |  1 +
 security/Kconfig           |  1 +
 security/Makefile          |  1 +
 security/loadpol/Kconfig   | 12 ++++++++++++
 security/loadpol/Makefile  |  1 +
 security/loadpol/loadpol.c | 29 +++++++++++++++++++++++++++++
 security/loadpol/loadpol.h |  8 ++++++++
 8 files changed, 60 insertions(+)
 create mode 100644 security/loadpol/Kconfig
 create mode 100644 security/loadpol/Makefile
 create mode 100644 security/loadpol/loadpol.c
 create mode 100644 security/loadpol/loadpol.h

diff --git a/include/linux/lsm_count.h b/include/linux/lsm_count.h
index 16eb49761b25..9e0d96dfe9d2 100644
--- a/include/linux/lsm_count.h
+++ b/include/linux/lsm_count.h
@@ -84,6 +84,12 @@
 #define LANDLOCK_ENABLED
 #endif
 
+#if IS_ENABLED(CONFIG_SECURITY_LOADPOL)
+#define LOADPOL_ENABLED 1,
+#else
+#define LOADPOL_ENABLED
+#endif
+
 #if IS_ENABLED(CONFIG_IMA)
 #define IMA_ENABLED 1,
 #else
@@ -122,6 +128,7 @@
 		SAFESETID_ENABLED	\
 		BPF_LSM_ENABLED		\
 		LANDLOCK_ENABLED	\
+		LOADPOL_ENABLED		\
 		IMA_ENABLED		\
 		EVM_ENABLED		\
 		IPE_ENABLED)
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index 938593dfd5da..ec8bdb415562 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -65,6 +65,7 @@ struct lsm_ctx {
 #define LSM_ID_IMA		111
 #define LSM_ID_EVM		112
 #define LSM_ID_IPE		113
+#define LSM_ID_LOADPOL		114
 
 /*
  * LSM_ATTR_XXX definitions identify different LSM attributes
diff --git a/security/Kconfig b/security/Kconfig
index 4816fc74f81e..e492c0d6768c 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -230,6 +230,7 @@ source "security/safesetid/Kconfig"
 source "security/lockdown/Kconfig"
 source "security/landlock/Kconfig"
 source "security/ipe/Kconfig"
+source "security/loadpol/Kconfig"
 
 source "security/integrity/Kconfig"
 
diff --git a/security/Makefile b/security/Makefile
index 22ff4c8bd8ce..562c572b7f23 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_CGROUPS)			+= device_cgroup.o
 obj-$(CONFIG_BPF_LSM)			+= bpf/
 obj-$(CONFIG_SECURITY_LANDLOCK)		+= landlock/
 obj-$(CONFIG_SECURITY_IPE)		+= ipe/
+obj-$(CONFIG_SECURITY_LOADPOL)		+= loadpol/
 
 # Object integrity file lists
 obj-$(CONFIG_INTEGRITY)			+= integrity/
diff --git a/security/loadpol/Kconfig b/security/loadpol/Kconfig
new file mode 100644
index 000000000000..8945e210ef69
--- /dev/null
+++ b/security/loadpol/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config SECURITY_LOADPOL
+	bool "LOADPOL support"
+	depends on SECURITY && MODULES
+	help
+	  Loadpol allows restricting the kernel modules that can be loaded
+	  dynamically according to a user-defined policy.
+
+	  If you are unsure how to answer this question, answer N. Otherwise,
+	  enable this and append "loadpol," to the CONFIG_LSM variable to
+	  enable Loadpol.
diff --git a/security/loadpol/Makefile b/security/loadpol/Makefile
new file mode 100644
index 000000000000..a794c8cfbfee
--- /dev/null
+++ b/security/loadpol/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SECURITY_LOADPOL) := loadpol.o
diff --git a/security/loadpol/loadpol.c b/security/loadpol/loadpol.c
new file mode 100644
index 000000000000..3fc29263e2f8
--- /dev/null
+++ b/security/loadpol/loadpol.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "linux/array_size.h"
+#include <linux/lsm_hooks.h>
+#include <uapi/linux/lsm.h>
+
+#include "loadpol.h"
+
+static int __init loadpol_init(void);
+
+static const struct lsm_id loadpol_lsmid = {
+	.name = LOADPOL_NAME,
+	.id = LSM_ID_LOADPOL,
+};
+
+static struct security_hook_list loadpol_hooks[] __ro_after_init = {
+};
+
+DEFINE_LSM(LOADPOL_NAME) = {
+	.name = LOADPOL_NAME,
+	.init = loadpol_init,
+};
+
+static int __init loadpol_init(void)
+{
+	security_add_hooks(loadpol_hooks, ARRAY_SIZE(loadpol_hooks), &loadpol_lsmid);
+	pr_info("Loadpol started.\n");
+	return 0;
+}
diff --git a/security/loadpol/loadpol.h b/security/loadpol/loadpol.h
new file mode 100644
index 000000000000..5e11474191f0
--- /dev/null
+++ b/security/loadpol/loadpol.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _SECURITY_LOADPOL_LOADPOL_H
+#define _SECURITY_LOADPOL_LOADPOL_H
+
+#define LOADPOL_NAME "loadpol"
+
+#endif /* _SECURITY_LOADPOL_LOADPOL_H */
-- 
2.49.0


