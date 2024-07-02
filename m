Return-Path: <linux-integrity+bounces-2965-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FBE924350
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jul 2024 18:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45D11C20B14
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jul 2024 16:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2F61BD016;
	Tue,  2 Jul 2024 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rl62NnDN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35EE1BA095;
	Tue,  2 Jul 2024 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936653; cv=none; b=ngFDLXUw61e0FqcjNzovoshrJk1kXEIqfAxsjjiU/8j7X9OBXDCz/6lHwUiEqYLPghCElLj1iDQE1NKUMnw3r9VpaZYm0hm5oX15sl7j+knMH7nSacfzrdY5MLKirVAPfy2Q8PgSfCTbvpA7mnbNlV5zW4pdGpkOMDaSA41mkxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936653; c=relaxed/simple;
	bh=Foqi+0/w6QnfJwz2VBdmJaLu5Vl+j/wJ903/i+1ldcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d2HfWz82Fv5TYMsnajK1nwlvIb5tg8N0Duy1Eo/WL+UNagodjOzjBvgMIpxuIXQHr/4rHmEpbprt8L1Fl5LR0B1ppNJOGC2uuUQJX4I8rjUC0m2cqutpiO8jIxW43kJGUQKCSHxmeFZa7aRFyWABB3mzKl4uCcDIKl2xdTUIFf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rl62NnDN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D657C116B1;
	Tue,  2 Jul 2024 16:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719936653;
	bh=Foqi+0/w6QnfJwz2VBdmJaLu5Vl+j/wJ903/i+1ldcg=;
	h=From:To:Cc:Subject:Date:From;
	b=Rl62NnDNF9JhDP74QvAcJyvVTBjtpbLuaawoOdvQGQbrtt4n+EWSvZ0r2Wf4SCw/W
	 7qgY0VPU4QaPEForh2kUFrHCbwm3gXxXKQ2Gbyow/va+DaoWzARQy3bLk0cHGR7BH2
	 9sG5NJonwRs9aLZhzN4rW8S4v3PMqoE4f90mu5APy2a+KyrwCPVJkRe3Ss8CVLOiuw
	 t/d3OVUoVqPw1EtAeRNiJ+oTxGEQe5bbA4FUUflRlHf66Vje4qORWQfCZSnWV/1JHa
	 qLMfsIWUTHvJOgDmrPQT6ouYgz/EZUCZhp+APJnNhTmWsgBsUyMJ1D787wGiZN0U57
	 K9mCBG7NfM8sA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] tpm: atmel: Drop PPC64 specific MMIO setup
Date: Tue,  2 Jul 2024 10:10:48 -0600
Message-ID: <20240702161052.3563599-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PPC64 specific MMIO setup open codes DT address functions rather
than using standard address parsing functions. The open-coded version
fails to handle any address translation and is not endian safe.

I haven't found any evidence of what platform used this. The only thing
that turned up was a PPC405 platform, but that is 32-bit and PPC405
support is being removed as well. CONFIG_TCG_ATMEL is not enabled for
any powerpc config and never was. The support was added in 2005 and
hasn't been touched since.

Rather than try to modernize and fix this code, just remove it.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/char/tpm/Kconfig     |   2 +-
 drivers/char/tpm/tpm_atmel.c |  64 +++++++++++++++-
 drivers/char/tpm/tpm_atmel.h | 140 -----------------------------------
 3 files changed, 62 insertions(+), 144 deletions(-)
 delete mode 100644 drivers/char/tpm/tpm_atmel.h

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index e63a6a17793c..9b655e9fc7ab 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -162,7 +162,7 @@ config TCG_NSC
 
 config TCG_ATMEL
 	tristate "Atmel TPM Interface"
-	depends on PPC64 || HAS_IOPORT_MAP
+	depends on HAS_IOPORT_MAP
 	depends on HAS_IOPORT
 	help
 	  If you have a TPM security chip from Atmel say Yes and it 
diff --git a/drivers/char/tpm/tpm_atmel.c b/drivers/char/tpm/tpm_atmel.c
index 9fb2defa9dc4..622c4abe8cb3 100644
--- a/drivers/char/tpm/tpm_atmel.c
+++ b/drivers/char/tpm/tpm_atmel.c
@@ -15,7 +15,67 @@
  */
 
 #include "tpm.h"
-#include "tpm_atmel.h"
+
+struct tpm_atmel_priv {
+	int region_size;
+	int have_region;
+	unsigned long base;
+	void __iomem *iobase;
+};
+
+#define atmel_getb(chip, offset) inb(atmel_get_priv(chip)->base + offset)
+#define atmel_putb(val, chip, offset) \
+	outb(val, atmel_get_priv(chip)->base + offset)
+#define atmel_request_region request_region
+#define atmel_release_region release_region
+/* Atmel definitions */
+enum tpm_atmel_addr {
+	TPM_ATMEL_BASE_ADDR_LO = 0x08,
+	TPM_ATMEL_BASE_ADDR_HI = 0x09
+};
+
+static inline int tpm_read_index(int base, int index)
+{
+	outb(index, base);
+	return inb(base+1) & 0xFF;
+}
+
+/* Verify this is a 1.1 Atmel TPM */
+static int atmel_verify_tpm11(void)
+{
+
+	/* verify that it is an Atmel part */
+	if (tpm_read_index(TPM_ADDR, 4) != 'A' ||
+	    tpm_read_index(TPM_ADDR, 5) != 'T' ||
+	    tpm_read_index(TPM_ADDR, 6) != 'M' ||
+	    tpm_read_index(TPM_ADDR, 7) != 'L')
+		return 1;
+
+	/* query chip for its version number */
+	if (tpm_read_index(TPM_ADDR, 0x00) != 1 ||
+	    tpm_read_index(TPM_ADDR, 0x01) != 1)
+		return 1;
+
+	/* This is an atmel supported part */
+	return 0;
+}
+
+/* Determine where to talk to device */
+static void __iomem * atmel_get_base_addr(unsigned long *base, int *region_size)
+{
+	int lo, hi;
+
+	if (atmel_verify_tpm11() != 0)
+		return NULL;
+
+	lo = tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_LO);
+	hi = tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_HI);
+
+	*base = (hi << 8) | lo;
+	*region_size = 2;
+
+	return ioport_map(*base, *region_size);
+}
 
 /* write status bits */
 enum tpm_atmel_write_status {
@@ -142,7 +202,6 @@ static void atml_plat_remove(void)
 	tpm_chip_unregister(chip);
 	if (priv->have_region)
 		atmel_release_region(priv->base, priv->region_size);
-	atmel_put_base_addr(priv->iobase);
 	platform_device_unregister(pdev);
 }
 
@@ -211,7 +270,6 @@ static int __init init_atmel(void)
 err_unreg_dev:
 	platform_device_unregister(pdev);
 err_rel_reg:
-	atmel_put_base_addr(iobase);
 	if (have_region)
 		atmel_release_region(base,
 				     region_size);
diff --git a/drivers/char/tpm/tpm_atmel.h b/drivers/char/tpm/tpm_atmel.h
deleted file mode 100644
index 7ac3f69dcf0f..000000000000
--- a/drivers/char/tpm/tpm_atmel.h
+++ /dev/null
@@ -1,140 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2005 IBM Corporation
- *
- * Authors:
- * Kylene Hall <kjhall@us.ibm.com>
- *
- * Maintained by: <tpmdd-devel@lists.sourceforge.net>
- *
- * Device driver for TCG/TCPA TPM (trusted platform module).
- * Specifications at www.trustedcomputinggroup.org
- *
- * These difference are required on power because the device must be
- * discovered through the device tree and iomap must be used to get
- * around the need for holes in the io_page_mask.  This does not happen
- * automatically because the tpm is not a normal pci device and lives
- * under the root node.
- */
-
-struct tpm_atmel_priv {
-	int region_size;
-	int have_region;
-	unsigned long base;
-	void __iomem *iobase;
-};
-
-#ifdef CONFIG_PPC64
-
-#include <linux/of.h>
-
-#define atmel_getb(priv, offset) readb(priv->iobase + offset)
-#define atmel_putb(val, priv, offset) writeb(val, priv->iobase + offset)
-#define atmel_request_region request_mem_region
-#define atmel_release_region release_mem_region
-
-static inline void atmel_put_base_addr(void __iomem *iobase)
-{
-	iounmap(iobase);
-}
-
-static void __iomem * atmel_get_base_addr(unsigned long *base, int *region_size)
-{
-	struct device_node *dn;
-	unsigned long address, size;
-	const unsigned int *reg;
-	int reglen;
-	int naddrc;
-	int nsizec;
-
-	dn = of_find_node_by_name(NULL, "tpm");
-
-	if (!dn)
-		return NULL;
-
-	if (!of_device_is_compatible(dn, "AT97SC3201")) {
-		of_node_put(dn);
-		return NULL;
-	}
-
-	reg = of_get_property(dn, "reg", &reglen);
-	naddrc = of_n_addr_cells(dn);
-	nsizec = of_n_size_cells(dn);
-
-	of_node_put(dn);
-
-
-	if (naddrc == 2)
-		address = ((unsigned long) reg[0] << 32) | reg[1];
-	else
-		address = reg[0];
-
-	if (nsizec == 2)
-		size =
-		    ((unsigned long) reg[naddrc] << 32) | reg[naddrc + 1];
-	else
-		size = reg[naddrc];
-
-	*base = address;
-	*region_size = size;
-	return ioremap(*base, *region_size);
-}
-#else
-#define atmel_getb(chip, offset) inb(atmel_get_priv(chip)->base + offset)
-#define atmel_putb(val, chip, offset) \
-	outb(val, atmel_get_priv(chip)->base + offset)
-#define atmel_request_region request_region
-#define atmel_release_region release_region
-/* Atmel definitions */
-enum tpm_atmel_addr {
-	TPM_ATMEL_BASE_ADDR_LO = 0x08,
-	TPM_ATMEL_BASE_ADDR_HI = 0x09
-};
-
-static inline int tpm_read_index(int base, int index)
-{
-	outb(index, base);
-	return inb(base+1) & 0xFF;
-}
-
-/* Verify this is a 1.1 Atmel TPM */
-static int atmel_verify_tpm11(void)
-{
-
-	/* verify that it is an Atmel part */
-	if (tpm_read_index(TPM_ADDR, 4) != 'A' ||
-	    tpm_read_index(TPM_ADDR, 5) != 'T' ||
-	    tpm_read_index(TPM_ADDR, 6) != 'M' ||
-	    tpm_read_index(TPM_ADDR, 7) != 'L')
-		return 1;
-
-	/* query chip for its version number */
-	if (tpm_read_index(TPM_ADDR, 0x00) != 1 ||
-	    tpm_read_index(TPM_ADDR, 0x01) != 1)
-		return 1;
-
-	/* This is an atmel supported part */
-	return 0;
-}
-
-static inline void atmel_put_base_addr(void __iomem *iobase)
-{
-}
-
-/* Determine where to talk to device */
-static void __iomem * atmel_get_base_addr(unsigned long *base, int *region_size)
-{
-	int lo, hi;
-
-	if (atmel_verify_tpm11() != 0)
-		return NULL;
-
-	lo = tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_LO);
-	hi = tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_HI);
-
-	*base = (hi << 8) | lo;
-	*region_size = 2;
-
-	return ioport_map(*base, *region_size);
-}
-#endif
-- 
2.43.0


