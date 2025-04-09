Return-Path: <linux-integrity+bounces-5721-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F94A82FB5
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 20:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CB927AA1AD
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 18:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C9127CB05;
	Wed,  9 Apr 2025 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Jxs6a4yq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090F927C861
	for <linux-integrity@vger.kernel.org>; Wed,  9 Apr 2025 18:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224837; cv=none; b=KGNksxmKqQVRMTSyQC+SgGngzwIMiSfeRm8ibj2LzcSDbVyNhSBt8Dnx2lM6DI4kzwIFNGeygwaw4EnCwQ3mHGv0Ijz7e3iTBcGDk205JZ4J46/eBTSboUUoFuq/jGsBV/DNuK3Gz5XRa/Aij/wTiI1cYb037ECqv+OdWYP5TDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224837; c=relaxed/simple;
	bh=utztmI35MpdP47rjxg0B2XjEZ9UWOwImBPwZUXo9w+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ciISnNryV/G1GQY8P+JOi7pKBR2s1lJiCORoBmIBPbSENKqCKW2YWEZFnChlLvWtPkkl4asXc+3GK3zchQymDhdFDYG52cOowRmQlBWak1uJIQ+Zm8b93khi+9SOjJLJFunpayAvIiZ3MxAsPCpFa/siWg/ywCthC1Ck9sviI+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Jxs6a4yq; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e8f6970326so69134976d6.0
        for <linux-integrity@vger.kernel.org>; Wed, 09 Apr 2025 11:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224834; x=1744829634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fi2ZbxP1dCxAkMqJls0a7AvY5T+kQXoKTuD9ZugI9O0=;
        b=Jxs6a4yqdMaewRKM1DFFcakJWQDuNlDj2RpB8Fc/4HBXEr4Ha5QejtX0SQm09k4gH2
         T2VG4dTFJY2+stV6SmDpNym2DGnp36SQk9iyE4oD6spjDhznVineOvVCDb4nt6BrFvVH
         PE6oGHrj2GeydMRBgUW+OwrakPbI95F2B1hF6lYPYDQ1Eb3mB5EcKwsBExjmqceBjB+v
         tTx9rcxFhRzEk1gE63EVTnADD2oXZsd17joY2HOPuCwP/YqO0AjJDri94wJ6tn/eZBfs
         2eVBpROeeXLZ9LWcY0pG0X1XxrgALi66yyAvr1gimgEKR4Ks6TrGOEMHUAQfVK20/l8L
         OW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224834; x=1744829634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fi2ZbxP1dCxAkMqJls0a7AvY5T+kQXoKTuD9ZugI9O0=;
        b=SgLNnHULOBUAHFu3MkWkRZuVKtBdITJln2p/4YSKRK8G7de+tI/lDM/qJK40G7CWM2
         Syz/oaOo20zFqz4hHWu1Fklxk+K47LrkwkqPvAadg8qQO5i51SdzXShCq6v+meJL6Znh
         0U4S69mbmGfWxDoYXxJr2dxAVzCY163swrdfcfaceZYiOVqP9eEonOEIRDznIsaK/pek
         fc0oQohdkEkHIZJTUX1QitZFA3SmnYbrKYxZsdMj4d2+b+eloMPQ9WSQx7dN/GFGLxVG
         dMXdODYGG2mWAM9V5O40m6uEBc8yJ07LMdNwJDd/ZwxbmL4BJFprFSIDF/Y6/Yaq+pXn
         wW0w==
X-Forwarded-Encrypted: i=1; AJvYcCUQCRuwwXs/ouDYliiFmBR9KoDCGzzI44PVTtsEEW/ytLjbGiEyn3dkmemXiDK9IFdjg13zS/1CW/WhjpWPPyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGgtvE6N4zQ+oO7KJWHoL62DmHoLqqzVNn7yv2QtPz+BE/vjN4
	VFTsT1ygeINISDPrl/Hxhjd7dQcgjvA6DQd6OGH9e96/qIzw/xSAkH0vAD7GDw==
X-Gm-Gg: ASbGnctkPGP9ah35MDtNP1sHR/3hkgueU24K2k5vaQigWpXbg4CujaWw8QpM5ZyiEQA
	f6k2PpnPnrro5JTPV1QKSCuol6A1dMXI2c0rkJOCpoEkrR093OjEFggFxHfuJ9jp6nxT8lExoxd
	08ShipbSqfd5HCWvLQcJKrOGZIDCs0mGA9Y13UWibfK4evtvcbvVk6bsMbxFgpyEclfrcMD77kC
	2jBoewPjL26rbKCaX4wpwzQb1Emzxh2sDHe2O0QAbNxg+5WjsiY4VDtVUuWt9GIROmSYmNob/i+
	XiwwSVAn1gnL2T0/Smfcg7t9b7/D+pbeDUW84q5GeNy/eQ/n95b8Ci/vpdlbLia89nmAPBi7L8t
	BxDnO+8jK0dWPphDslu1B
X-Google-Smtp-Source: AGHT+IFl66cH2RPOfrpETumLCEBM5Q5jzQ5/Cpv5i0rzGC0zuvYeprgQ/1/FXLHgr/Q4H7qe9913Yw==
X-Received: by 2002:a05:6214:252c:b0:6e4:4085:9f72 with SMTP id 6a1803df08f44-6f0e5a67103mr742576d6.7.1744224833948;
        Wed, 09 Apr 2025 11:53:53 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0dea107a3sm10467746d6.114.2025.04.09.11.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:53 -0700 (PDT)
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
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 26/29] selinux: move initcalls to the LSM framework
Date: Wed,  9 Apr 2025 14:50:11 -0400
Message-ID: <20250409185019.238841-57-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10675; i=paul@paul-moore.com; h=from:subject; bh=utztmI35MpdP47rjxg0B2XjEZ9UWOwImBPwZUXo9w+w=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sII2T89dnUOGapoKo7YIS43SbOGs1ek/wqFy Re6iuI6meKJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bCCAAKCRDqIPLalzeJ c8aWEAClRdwnan2ftM0+IAQ9rlfu+hkp88V5wXZ5vnX4E62Wq7OB+9t1zquaqVAWXJCWudAuN1b a9ZaGZ95p8KONGykdvsNSJo6a3OuCSgsMU7ssFgW8XV34327OCLef4z4FVIz2peFbtAZsUeL8D3 1N/nhzvML5mYrPK54Gn5MCphFojDJ4oIwt+yQwgvlBvJO63gz4q2HeHvOk3E/SZSBUsyHsWzSdk Q5Y75IDXLTvCtVBy0JAvwkiUXztUVR0iPVmiJxnXF+Q9VqbtIROkI02cjONlASzQHwuVy1yTAiH CMVced8V9KEGI3c6W+0TXwEV74Ng61oZKFXsH10inYzL8PFTkavC1AfTT/Es8UtDv7lbnQx0Yj5 srytN/imfEm1+kX0fmVnWkhWfG6ZYPwPIjtZFvC07GjVjDuwt2WCrthQyF4gHTeHzkx9WeQvn2T DjmUuruDKsWc5JgWBUuIobk38fMN4Iyy30Fgf0FpA1nRor/yTd6kj3epvD/Ch7u0st9fRH1UKWK whJPXsWpfZls3K1vZtoHtAGehRNgAmzIb8N2CEaPGljJMMXwB+HWfJI0Vas4G1r4Aoaq79Q54hE CFCO+O7d5M1Lj0xq20K7GGkAJ1cwlH+c64AACErheXwEOIAyY4E7WOwbHiiy6kvQIjhpgA12Bxp xQYjiP7KyFj9n+w==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

SELinux currently has a number of initcalls so we've created a new
function, selinux_initcall(), which wraps all of these initcalls so
that we have a single initcall function that can be registered with the
LSM framework.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/Makefile            |  2 +-
 security/selinux/hooks.c             |  9 +++--
 security/selinux/ibpkey.c            |  5 ++-
 security/selinux/include/audit.h     |  5 +++
 security/selinux/include/initcalls.h | 19 +++++++++++
 security/selinux/initcalls.c         | 50 ++++++++++++++++++++++++++++
 security/selinux/netif.c             |  5 ++-
 security/selinux/netlink.c           |  5 ++-
 security/selinux/netnode.c           |  5 ++-
 security/selinux/netport.c           |  5 ++-
 security/selinux/selinuxfs.c         |  5 ++-
 security/selinux/ss/services.c       | 26 ++++-----------
 12 files changed, 101 insertions(+), 40 deletions(-)
 create mode 100644 security/selinux/include/initcalls.h
 create mode 100644 security/selinux/initcalls.c

diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index 66e56e9011df..72d3baf7900c 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -15,7 +15,7 @@ ccflags-y := -I$(srctree)/security/selinux -I$(srctree)/security/selinux/include
 ccflags-$(CONFIG_SECURITY_SELINUX_DEBUG) += -DDEBUG
 
 selinux-y := avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o netif.o \
-	     netnode.o netport.o status.o \
+	     netnode.o netport.o status.o initcalls.o \
 	     ss/ebitmap.o ss/hashtab.o ss/symtab.o ss/sidtab.o ss/avtab.o \
 	     ss/policydb.o ss/services.o ss/conditional.o ss/mls.o ss/context.o
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f28a12a0a1c8..95b2399b1f4d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -95,6 +95,7 @@
 #include <linux/io_uring/cmd.h>
 #include <uapi/linux/lsm.h>
 
+#include "initcalls.h"
 #include "avc.h"
 #include "objsec.h"
 #include "netif.h"
@@ -7535,6 +7536,10 @@ static __init int selinux_init(void)
 	if (avc_add_callback(selinux_lsm_notifier_avc_callback, AVC_CALLBACK_RESET))
 		panic("SELinux: Unable to register AVC LSM notifier callback\n");
 
+	if (avc_add_callback(selinux_audit_rule_avc_callback,
+			     AVC_CALLBACK_RESET))
+		panic("SELinux: Unable to register AVC audit callback\n");
+
 	if (selinux_enforcing_boot)
 		pr_debug("SELinux:  Starting in enforcing mode\n");
 	else
@@ -7567,6 +7572,7 @@ DEFINE_LSM(selinux) = {
 	.enabled = &selinux_enabled_boot,
 	.blobs = &selinux_blob_sizes,
 	.init = selinux_init,
+	.initcall_device = selinux_initcall,
 };
 
 #if defined(CONFIG_NETFILTER)
@@ -7628,7 +7634,7 @@ static struct pernet_operations selinux_net_ops = {
 	.exit = selinux_nf_unregister,
 };
 
-static int __init selinux_nf_ip_init(void)
+int __init selinux_nf_ip_init(void)
 {
 	int err;
 
@@ -7643,5 +7649,4 @@ static int __init selinux_nf_ip_init(void)
 
 	return 0;
 }
-__initcall(selinux_nf_ip_init);
 #endif /* CONFIG_NETFILTER */
diff --git a/security/selinux/ibpkey.c b/security/selinux/ibpkey.c
index 48f537b41c58..2609913f338a 100644
--- a/security/selinux/ibpkey.c
+++ b/security/selinux/ibpkey.c
@@ -23,6 +23,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 
+#include "initcalls.h"
 #include "ibpkey.h"
 #include "objsec.h"
 
@@ -219,7 +220,7 @@ void sel_ib_pkey_flush(void)
 	spin_unlock_irqrestore(&sel_ib_pkey_lock, flags);
 }
 
-static __init int sel_ib_pkey_init(void)
+int __init sel_ib_pkey_init(void)
 {
 	int iter;
 
@@ -233,5 +234,3 @@ static __init int sel_ib_pkey_init(void)
 
 	return 0;
 }
-
-subsys_initcall(sel_ib_pkey_init);
diff --git a/security/selinux/include/audit.h b/security/selinux/include/audit.h
index d5b0425055e4..5989f8dd1e86 100644
--- a/security/selinux/include/audit.h
+++ b/security/selinux/include/audit.h
@@ -15,6 +15,11 @@
 #include <linux/audit.h>
 #include <linux/types.h>
 
+/**
+ * XXX
+ */
+int selinux_audit_rule_avc_callback(u32 event);
+
 /**
  * selinux_audit_rule_init - alloc/init an selinux audit rule structure.
  * @field: the field this rule refers to
diff --git a/security/selinux/include/initcalls.h b/security/selinux/include/initcalls.h
new file mode 100644
index 000000000000..6674cf489473
--- /dev/null
+++ b/security/selinux/include/initcalls.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SELinux initcalls
+ */
+
+#ifndef _SELINUX_INITCALLS_H
+#define _SELINUX_INITCALLS_H
+
+int init_sel_fs(void);
+int sel_netport_init(void);
+int sel_netnode_init(void);
+int sel_netif_init(void);
+int sel_netlink_init(void);
+int sel_ib_pkey_init(void);
+int selinux_nf_ip_init(void);
+
+int selinux_initcall(void);
+
+#endif
diff --git a/security/selinux/initcalls.c b/security/selinux/initcalls.c
new file mode 100644
index 000000000000..81f01f8ad215
--- /dev/null
+++ b/security/selinux/initcalls.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SELinux initcalls
+ */
+
+#include <linux/init.h>
+
+#include "initcalls.h"
+
+/**
+ * selinux_initcall - Perform the SELinux initcalls
+ *
+ * Used as a device initcall in the SELinux LSM definition.
+ */
+int __init selinux_initcall(void)
+{
+	int rc = 0, rc_tmp = 0;
+
+	rc_tmp = init_sel_fs();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+
+	rc_tmp = sel_netport_init();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+
+	rc_tmp = sel_netnode_init();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+
+	rc_tmp = sel_netif_init();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+
+	rc_tmp = sel_netlink_init();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+
+	rc_tmp = sel_ib_pkey_init();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+
+#if defined(CONFIG_NETFILTER)
+	rc_tmp = selinux_nf_ip_init();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+#endif
+
+	return rc;
+}
diff --git a/security/selinux/netif.c b/security/selinux/netif.c
index 43a0d3594b72..69f660721dc8 100644
--- a/security/selinux/netif.c
+++ b/security/selinux/netif.c
@@ -22,6 +22,7 @@
 #include <linux/rcupdate.h>
 #include <net/net_namespace.h>
 
+#include "initcalls.h"
 #include "security.h"
 #include "objsec.h"
 #include "netif.h"
@@ -261,7 +262,7 @@ static struct notifier_block sel_netif_netdev_notifier = {
 	.notifier_call = sel_netif_netdev_notifier_handler,
 };
 
-static __init int sel_netif_init(void)
+int __init sel_netif_init(void)
 {
 	int i;
 
@@ -276,5 +277,3 @@ static __init int sel_netif_init(void)
 	return 0;
 }
 
-__initcall(sel_netif_init);
-
diff --git a/security/selinux/netlink.c b/security/selinux/netlink.c
index 1760aee712fd..eb40e4603475 100644
--- a/security/selinux/netlink.c
+++ b/security/selinux/netlink.c
@@ -17,6 +17,7 @@
 #include <net/net_namespace.h>
 #include <net/netlink.h>
 
+#include "initcalls.h"
 #include "security.h"
 
 static struct sock *selnl __ro_after_init;
@@ -105,7 +106,7 @@ void selnl_notify_policyload(u32 seqno)
 	selnl_notify(SELNL_MSG_POLICYLOAD, &seqno);
 }
 
-static int __init selnl_init(void)
+int __init sel_netlink_init(void)
 {
 	struct netlink_kernel_cfg cfg = {
 		.groups	= SELNLGRP_MAX,
@@ -117,5 +118,3 @@ static int __init selnl_init(void)
 		panic("SELinux:  Cannot create netlink socket.");
 	return 0;
 }
-
-__initcall(selnl_init);
diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index 5c8c77e50aad..11b5eac30641 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -30,6 +30,7 @@
 #include <net/ip.h>
 #include <net/ipv6.h>
 
+#include "initcalls.h"
 #include "netnode.h"
 #include "objsec.h"
 
@@ -287,7 +288,7 @@ void sel_netnode_flush(void)
 	spin_unlock_bh(&sel_netnode_lock);
 }
 
-static __init int sel_netnode_init(void)
+int __init sel_netnode_init(void)
 {
 	int iter;
 
@@ -301,5 +302,3 @@ static __init int sel_netnode_init(void)
 
 	return 0;
 }
-
-__initcall(sel_netnode_init);
diff --git a/security/selinux/netport.c b/security/selinux/netport.c
index 2e22ad9c2bd0..d1c12f58a628 100644
--- a/security/selinux/netport.c
+++ b/security/selinux/netport.c
@@ -29,6 +29,7 @@
 #include <net/ip.h>
 #include <net/ipv6.h>
 
+#include "initcalls.h"
 #include "netport.h"
 #include "objsec.h"
 
@@ -220,7 +221,7 @@ void sel_netport_flush(void)
 	spin_unlock_bh(&sel_netport_lock);
 }
 
-static __init int sel_netport_init(void)
+int __init sel_netport_init(void)
 {
 	int iter;
 
@@ -234,5 +235,3 @@ static __init int sel_netport_init(void)
 
 	return 0;
 }
-
-__initcall(sel_netport_init);
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 47480eb2189b..88d16c1dbb5a 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -35,6 +35,7 @@
 /* selinuxfs pseudo filesystem for exporting the security policy API.
    Based on the proc code and the fs/nfsd/nfsctl.c code. */
 
+#include "initcalls.h"
 #include "flask.h"
 #include "avc.h"
 #include "avc_ss.h"
@@ -2131,7 +2132,7 @@ static struct file_system_type sel_fs_type = {
 
 struct path selinux_null __ro_after_init;
 
-static int __init init_sel_fs(void)
+int __init init_sel_fs(void)
 {
 	struct qstr null_name = QSTR_INIT(NULL_FILE_NAME,
 					  sizeof(NULL_FILE_NAME)-1);
@@ -2175,5 +2176,3 @@ static int __init init_sel_fs(void)
 
 	return err;
 }
-
-__initcall(init_sel_fs);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index e431772c6168..d84a496e5f7f 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3534,6 +3534,13 @@ struct selinux_audit_rule {
 	struct context au_ctxt;
 };
 
+int selinux_audit_rule_avc_callback(u32 event)
+{
+	if (event == AVC_CALLBACK_RESET)
+		return audit_update_lsm_rules();
+	return 0;
+}
+
 void selinux_audit_rule_free(void *vrule)
 {
 	struct selinux_audit_rule *rule = vrule;
@@ -3784,25 +3791,6 @@ int selinux_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op, void *vru
 	return match;
 }
 
-static int aurule_avc_callback(u32 event)
-{
-	if (event == AVC_CALLBACK_RESET)
-		return audit_update_lsm_rules();
-	return 0;
-}
-
-static int __init aurule_init(void)
-{
-	int err;
-
-	err = avc_add_callback(aurule_avc_callback, AVC_CALLBACK_RESET);
-	if (err)
-		panic("avc_add_callback() failed, error %d\n", err);
-
-	return err;
-}
-__initcall(aurule_init);
-
 #ifdef CONFIG_NETLABEL
 /**
  * security_netlbl_cache_add - Add an entry to the NetLabel cache
-- 
2.49.0


