Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F2E30F86E
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Feb 2021 17:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238109AbhBDQtF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Feb 2021 11:49:05 -0500
Received: from linux.microsoft.com ([13.77.154.182]:52914 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238055AbhBDQnf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Feb 2021 11:43:35 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1BE6F20B6C49;
        Thu,  4 Feb 2021 08:42:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1BE6F20B6C49
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1612456925;
        bh=j+m2dR5ww3SCw8oyyZKjTEpLaO6j8YaYz0eXbFOJGks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XqMv0O331GqkREnDVAzOHFGxCo7GVTqw2Avx6Ws9r4a3pfiBlYy3873CU7aRY8ks/
         DiUi04CRZrwWifQlps/Faz87RtB92C12EnLlTlS+pGqmEy5JzpZ6FEwAMIzds4D6nv
         RyGv80vBtgXh9fB2WwCZsGaO/ztZqb+PMV1tS3mQ=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, joe@perches.com, catalin.marinas@arm.com,
        mpe@ellerman.id.au
Cc:     james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v16 09/12] of: Define functions to allocate and free FDT
Date:   Thu,  4 Feb 2021 08:41:32 -0800
Message-Id: <20210204164135.29856-10-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210204164135.29856-1-nramas@linux.microsoft.com>
References: <20210204164135.29856-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Kernel components that use Flattened Device Tree (FDT) allocate kernel
memory and call fdt_open_into() to reorganize the tree into a form
suitable for the read-write operations.  These operations can be
combined into a single function to allocate and initialize the FDT
so the different architecures do not have to duplicate the code.

Define of_alloc_and_init_fdt() and of_free_fdt() in drivers/of/kexec.c
to allocate and initialize FDT, and to free the FDT buffer respectively.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Suggested-by: Rob Herring <robh@kernel.org>
Suggested-by: Joe Perches <joe@perches.com>
---
 drivers/of/kexec.c | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/of.h |  2 ++
 2 files changed, 39 insertions(+)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 5ae0e5d90f55..197e71104f47 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -11,6 +11,7 @@
 
 #include <linux/kernel.h>
 #include <linux/kexec.h>
+#include <linux/mm.h>
 #include <linux/memblock.h>
 #include <linux/libfdt.h>
 #include <linux/of.h>
@@ -28,6 +29,42 @@
 #define FDT_PROP_RNG_SEED	"rng-seed"
 #define RNG_SEED_SIZE		128
 
+/**
+ * of_alloc_and_init_fdt - Allocate and initialize a Flattened device tree
+ *
+ * @fdt_size:	Flattened device tree size
+ *
+ * Return the allocated FDT buffer on success, or NULL on error.
+ */
+void *of_alloc_and_init_fdt(unsigned int fdt_size)
+{
+	void *fdt;
+	int ret;
+
+	fdt = kvmalloc(fdt_size, GFP_KERNEL);
+	if (!fdt)
+		return NULL;
+
+	ret = fdt_open_into(initial_boot_params, fdt, fdt_size);
+	if (ret < 0) {
+		pr_err("Error setting up the new device tree.\n");
+		kvfree(fdt);
+		fdt = NULL;
+	}
+
+	return fdt;
+}
+
+/**
+ * of_free_fdt - Free the buffer for Flattened device tree
+ *
+ * @fdt:	Flattened device tree buffer to free
+ */
+void of_free_fdt(void *fdt)
+{
+	kvfree(fdt);
+}
+
 /**
  * fdt_find_and_del_mem_rsv - delete memory reservation with given address and size
  *
diff --git a/include/linux/of.h b/include/linux/of.h
index 19f77dd12507..9f0261761e28 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -563,6 +563,8 @@ struct kimage;
 int of_kexec_setup_new_fdt(const struct kimage *image, void *fdt,
 			   unsigned long initrd_load_addr, unsigned long initrd_len,
 			   const char *cmdline);
+void *of_alloc_and_init_fdt(unsigned int fdt_size);
+void of_free_fdt(void *fdt);
 
 #ifdef CONFIG_IMA_KEXEC
 int of_ima_add_kexec_buffer(struct kimage *image,
-- 
2.30.0

