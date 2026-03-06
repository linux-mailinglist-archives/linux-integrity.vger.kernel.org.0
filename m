Return-Path: <linux-integrity+bounces-8938-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AK40MQ7uqmmOYAEAu9opvQ
	(envelope-from <linux-integrity+bounces-8938-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 06 Mar 2026 16:09:02 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8583D2237E7
	for <lists+linux-integrity@lfdr.de>; Fri, 06 Mar 2026 16:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F32630B6F3C
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Mar 2026 15:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E388D3AE706;
	Fri,  6 Mar 2026 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l00mYyAe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8F33AE1A5;
	Fri,  6 Mar 2026 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809471; cv=none; b=Op0oCCLsF8Z8ctny1vV0/kqo+fHO74t4T08x3eq1YQ8RTzJTOt255/FkmPzr/qTKnogMaKWF8s/B4P4qFelqMY/6JdzqSZuMbuVj4MU0W1ucvxb3rN36WybN29cKmSjAiJ5qcQZC+gpBBACnaloC+upZhmOODf9HrnShcXMf5zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809471; c=relaxed/simple;
	bh=25CPe4EGSUbqlSDNHofrLGG8PR/WzU7sNEADToXqfos=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QbkRlYC9YA5e/aZwWrJSIW3Enogz5yBcpzz5yTIgtq4bKxafm9YwK9akO0pZcVBUs5oioZEdwZlnvcxmyY0nVQF16QLlDQwjxPqHo5cZTr9pHxwo45K1xgLvkfFnOhq3K4lR5I7VXoy6B4d2Nv2WnUxwgomEE+emADQN0LfVuOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l00mYyAe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2D7C4CEF7;
	Fri,  6 Mar 2026 15:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772809471;
	bh=25CPe4EGSUbqlSDNHofrLGG8PR/WzU7sNEADToXqfos=;
	h=From:To:Cc:Subject:Date:From;
	b=l00mYyAeVzZNhOkHGoBqNdxgrGLiNdHhVl3kHwWYeL1Y9cFWXVlXooc68wEuF7L0Q
	 OF2NVmz98U+4tMbNLueBvXb1fQq7cXDImpDKIGf4tKnWW++vZxu/EY+wexkETnxwFD
	 MWqyCam4Ic8JyGq5WqejMJe9U3A1XlNrnepTU7jea0jQaiV8DaUy+MCEWae68Risxu
	 qkBXP3twWnqgmthNNhGJ5AZYReddCWjdC3dgnUrpIrec7ooGju9tx+THX/KeuImLH8
	 yhx06aMwr48pfMFdKNoEE3NgYZYj6wC+11wNOWM+t5CSAxsd0lxY8gLOiIilbMEZIm
	 dZ/eso6rn5L2w==
From: Arnd Bergmann <arnd@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Coiby Xu <coxu@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andrew Donnellan <ajd@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	keyrings@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] integrity: avoid using __weak functions
Date: Fri,  6 Mar 2026 16:03:24 +0100
Message-Id: <20260306150421.270124-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8583D2237E7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8938-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux.ibm.com,ellerman.id.au,arndb.de,huawei.com,gmail.com,paul-moore.com,namei.org,hallyn.com,kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux.ibm.com,oracle.com,google.com,lists.ozlabs.org,vger.kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity,lkml];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Arnd Bergmann <arnd@arndb.de>

The security/integrity/secure_boot.c file containing only a __weak function
leads to a build failure with clang:

Cannot find symbol for section 2: .text.
security/integrity/secure_boot.o: failed

Moving the function into another file that has at least one non-__weak
symbol would solve this, but this is always fragile.

Avoid __weak definitions entirely and instead move the stub helper into
an asm-generic header that gets used by default on architectures that
do not provide their own version. This is consistent with how a lot
of other architecture specific functionality works, and is more reliable.

Fixes: a0f87ede3bf4 ("integrity: Make arch_ima_get_secureboot integrity-wide")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This is a larger change than I had hoped for.

If you prefer a different way to address the build failure, please
treat this as a Reported-by when you apply your own fix
---
 arch/powerpc/include/asm/secure_boot.h        |  6 +++
 arch/powerpc/kernel/secure_boot.c             |  1 -
 arch/s390/include/asm/secure_boot.h           |  9 +++++
 include/asm-generic/Kbuild                    |  1 +
 include/asm-generic/secure_boot.h             | 37 +++++++++++++++++++
 include/linux/secure_boot.h                   |  8 +---
 security/integrity/Makefile                   |  2 +-
 .../integrity/platform_certs/load_powerpc.c   |  2 +-
 security/integrity/secure_boot.c              | 16 --------
 9 files changed, 56 insertions(+), 26 deletions(-)
 create mode 100644 arch/s390/include/asm/secure_boot.h
 create mode 100644 include/asm-generic/secure_boot.h
 delete mode 100644 security/integrity/secure_boot.c

diff --git a/arch/powerpc/include/asm/secure_boot.h b/arch/powerpc/include/asm/secure_boot.h
index a2ff556916c6..db72dcdf5bb3 100644
--- a/arch/powerpc/include/asm/secure_boot.h
+++ b/arch/powerpc/include/asm/secure_boot.h
@@ -10,11 +10,17 @@
 
 #ifdef CONFIG_PPC_SECURE_BOOT
 
+bool arch_get_secureboot(void);
 bool is_ppc_secureboot_enabled(void);
 bool is_ppc_trustedboot_enabled(void);
 
 #else
 
+static inline bool arch_get_secureboot(void)
+{
+	return false;
+}
+
 static inline bool is_ppc_secureboot_enabled(void)
 {
 	return false;
diff --git a/arch/powerpc/kernel/secure_boot.c b/arch/powerpc/kernel/secure_boot.c
index 28436c1599e0..e3ea46124180 100644
--- a/arch/powerpc/kernel/secure_boot.c
+++ b/arch/powerpc/kernel/secure_boot.c
@@ -7,7 +7,6 @@
 #include <linux/of.h>
 #include <linux/secure_boot.h>
 #include <linux/string_choices.h>
-#include <asm/secure_boot.h>
 
 static struct device_node *get_ppc_fw_sb_node(void)
 {
diff --git a/arch/s390/include/asm/secure_boot.h b/arch/s390/include/asm/secure_boot.h
new file mode 100644
index 000000000000..4086fdfb9e5c
--- /dev/null
+++ b/arch/s390/include/asm/secure_boot.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_S390_SECURE_BOOT_H
+#define _ASM_S390_SECURE_BOOT_H
+
+#include <linux/types.h
+
+bool arch_get_secureboot(void);
+
+#endif
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index 0f97f7b594c3..8c0a499141fb 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -51,6 +51,7 @@ mandatory-y += rqspinlock.h
 mandatory-y += runtime-const.h
 mandatory-y += rwonce.h
 mandatory-y += sections.h
+mandatory-y += secure_boot.h
 mandatory-y += serial.h
 mandatory-y += shmparam.h
 mandatory-y += simd.h
diff --git a/include/asm-generic/secure_boot.h b/include/asm-generic/secure_boot.h
new file mode 100644
index 000000000000..08d8e294576c
--- /dev/null
+++ b/include/asm-generic/secure_boot.h
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 Red Hat, Inc. All Rights Reserved.
+ *
+ * Author: Coiby Xu <coxu@redhat.com>
+ */
+#ifndef _ASM_SECURE_BOOT_H
+#define _ASM_SECURE_BOOT_H
+
+
+#include <linux/types.h>
+
+#ifdef CONFIG_EFI
+
+/*
+ * Default implementation.
+ * Architectures that support secure boot must override this.
+ *
+ * Returns true if the platform secure boot is enabled.
+ * Returns false if disabled or not supported.
+ */
+bool arch_get_secureboot(void);
+
+#else
+
+/*
+ * Default implementation.
+ * Architectures that support secure boot must override this.
+ */
+static inline bool arch_get_secureboot(void)
+{
+	return false;
+}
+
+#endif
+
+#endif
diff --git a/include/linux/secure_boot.h b/include/linux/secure_boot.h
index 3ded3f03655c..9ddfbe109b1d 100644
--- a/include/linux/secure_boot.h
+++ b/include/linux/secure_boot.h
@@ -8,12 +8,6 @@
 #ifndef _LINUX_SECURE_BOOT_H
 #define _LINUX_SECURE_BOOT_H
 
-#include <linux/types.h>
-
-/*
- * Returns true if the platform secure boot is enabled.
- * Returns false if disabled or not supported.
- */
-bool arch_get_secureboot(void);
+#include <asm/secure_boot.h>
 
 #endif /* _LINUX_SECURE_BOOT_H */
diff --git a/security/integrity/Makefile b/security/integrity/Makefile
index 548665e2b702..45dfdedbdad4 100644
--- a/security/integrity/Makefile
+++ b/security/integrity/Makefile
@@ -5,7 +5,7 @@
 
 obj-$(CONFIG_INTEGRITY) += integrity.o
 
-integrity-y := iint.o secure_boot.o
+integrity-y := iint.o
 integrity-$(CONFIG_INTEGRITY_AUDIT) += integrity_audit.o
 integrity-$(CONFIG_INTEGRITY_SIGNATURE) += digsig.o
 integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) += digsig_asymmetric.o
diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c
index 714c961a00f5..ab74e947a8bc 100644
--- a/security/integrity/platform_certs/load_powerpc.c
+++ b/security/integrity/platform_certs/load_powerpc.c
@@ -10,7 +10,7 @@
 #include <linux/cred.h>
 #include <linux/err.h>
 #include <linux/slab.h>
-#include <asm/secure_boot.h>
+#include <linux/secure_boot.h>
 #include <asm/secvar.h>
 #include "keyring_handler.h"
 #include "../integrity.h"
diff --git a/security/integrity/secure_boot.c b/security/integrity/secure_boot.c
deleted file mode 100644
index fc2693c286f8..000000000000
--- a/security/integrity/secure_boot.c
+++ /dev/null
@@ -1,16 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2026 Red Hat, Inc. All Rights Reserved.
- *
- * Author: Coiby Xu <coxu@redhat.com>
- */
-#include <linux/secure_boot.h>
-
-/*
- * Default weak implementation.
- * Architectures that support secure boot must override this.
- */
-__weak bool arch_get_secureboot(void)
-{
-	return false;
-}
-- 
2.39.5


