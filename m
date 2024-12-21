Return-Path: <linux-integrity+bounces-4448-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C77819FA073
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Dec 2024 12:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE571692F3
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Dec 2024 11:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F381F2397;
	Sat, 21 Dec 2024 11:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5groNJX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F672594AE;
	Sat, 21 Dec 2024 11:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734780808; cv=none; b=N6p7wtoz1pZCo6MsE2yWBg4GvjFhnw5NZMYx2MrG9Uor67akr7Shl1DG5HC0xz8CebXlKS2DEEwMXpVzg9wPOdCHi8d8Bf4nFG3ZCJ1qLSNOZJJFC1hfQX5kk9+xtueby5Y2bMpIKPrdQsnADvFj7bWrj6hjA3MfqXq7wUaiUCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734780808; c=relaxed/simple;
	bh=PZI/vbZ8+kg40jgJ4A27Ci+mznlX51web6exHfKr+r0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oFs7cQWD0Amul1yPbl9TOC0CeIlfT2x3Tq8lYfsDxbAKnsYsjKUo9w0zGyaYYN//9AHL6FaEmQ0iy1Do96nBduy5TW3w6iWNNJs7PMSjPlYQsGCA6CEikFXJ6zWFPSwBjqEThOr/tvbnDFrMCd3EwSbjsXoSyxxBxtUkh+NRdOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5groNJX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF4BC4CECE;
	Sat, 21 Dec 2024 11:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734780807;
	bh=PZI/vbZ8+kg40jgJ4A27Ci+mznlX51web6exHfKr+r0=;
	h=From:To:Cc:Subject:Date:From;
	b=G5groNJXMYOtLnV/7cZv6nd2yyLRvgUvH033c7MgzIVgaNk/24Idu5DL46eX3SYgy
	 bPoHE508oTvcRK7PklFN5yLTEkjvC0kxxx5tnaKMVA6csXaVliNsmNz3IC90q54xjF
	 6Z2nYSMOOqJAC7ecOvyX2n0Cga1ff801aKfSklTO63gaNcIWxRl91Taij9bMt3Ohzw
	 2dI+EI5C7BjB9ofJYlk+U75n8Mg3Dnar1NA+pMCOpv5nWKVW9YgdavHD5jhytwGN+6
	 DbJj0qqg5PgEsYpnE8RMF6LHPpSt49ro/39qQE7/Oebs/BKn/unOH+CRcq455owbkL
	 Yl0qZQyHkeSow==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Colin Ian King <colin.i.king@gmail.com>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Andy Liang <andy.liang@hpe.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: Map the ACPI provided event log
Date: Sat, 21 Dec 2024 13:33:08 +0200
Message-ID: <20241221113318.562138-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following failure was reported:

[   10.693310][    T1] tpm_tis STM0925:00: 2.0 TPM (device-id 0x3, rev-id 0)
[   10.848132][    T1] ------------[ cut here ]------------
[   10.853559][    T1] WARNING: CPU: 59 PID: 1 at mm/page_alloc.c:4727 __alloc_pages_noprof+0x2ca/0x330
[   10.862827][    T1] Modules linked in:
[   10.866671][    T1] CPU: 59 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-lp155.2.g52785e2-default #1 openSUSE Tumbleweed (unreleased) 588cd98293a7c9eba9013378d807364c088c9375
[   10.882741][    T1] Hardware name: HPE ProLiant DL320 Gen12/ProLiant DL320 Gen12, BIOS 1.20 10/28/2024
[   10.892170][    T1] RIP: 0010:__alloc_pages_noprof+0x2ca/0x330
[   10.898103][    T1] Code: 24 08 e9 4a fe ff ff e8 34 36 fa ff e9 88 fe ff ff 83 fe 0a 0f 86 b3 fd ff ff 80 3d 01 e7 ce 01 00 75 09 c6 05 f8 e6 ce 01 01 <0f> 0b 45 31 ff e9 e5 fe ff ff f7 c2 00 00 08 00 75 42 89 d9 80 e1
[   10.917750][    T1] RSP: 0000:ffffb7cf40077980 EFLAGS: 00010246
[   10.923777][    T1] RAX: 0000000000000000 RBX: 0000000000040cc0 RCX: 0000000000000000
[   10.931727][    T1] RDX: 0000000000000000 RSI: 000000000000000c RDI: 0000000000040cc0

Above shows that ACPI pointed a 16 MiB buffer for the log events because
RSI maps to the 'order' parameter of __alloc_pages_noprof(). Address the
bug by mapping the region when needed instead of copying.

Reported-by: Andy Liang <andy.liang@hpe.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219495
Suggested-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/eventlog/acpi.c   | 30 +++++--------------
 drivers/char/tpm/eventlog/common.c | 33 ++++++++++++--------
 drivers/char/tpm/eventlog/common.h |  6 ++++
 drivers/char/tpm/eventlog/tpm1.c   | 38 +++++++++++++++--------
 drivers/char/tpm/eventlog/tpm2.c   | 48 +++++++++++++++++++-----------
 include/linux/tpm.h                |  1 +
 6 files changed, 91 insertions(+), 65 deletions(-)

diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
index 69533d0bfb51..8d8db66ce876 100644
--- a/drivers/char/tpm/eventlog/acpi.c
+++ b/drivers/char/tpm/eventlog/acpi.c
@@ -22,8 +22,6 @@
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include <linux/tpm_eventlog.h>
-
-#include "../tpm.h"
 #include "common.h"
 
 struct acpi_tcpa {
@@ -70,14 +68,11 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 	acpi_status status;
 	void __iomem *virt;
 	u64 len, start;
-	struct tpm_bios_log *log;
 	struct acpi_table_tpm2 *tbl;
 	struct acpi_tpm2_phy *tpm2_phy;
 	int format;
 	int ret;
 
-	log = &chip->log;
-
 	/* Unfortuntely ACPI does not associate the event log with a specific
 	 * TPM, like PPI. Thus all ACPI TPMs will read the same log.
 	 */
@@ -135,36 +130,27 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 		return -EIO;
 	}
 
-	/* malloc EventLog space */
-	log->bios_event_log = devm_kmalloc(&chip->dev, len, GFP_KERNEL);
-	if (!log->bios_event_log)
-		return -ENOMEM;
-
-	log->bios_event_log_end = log->bios_event_log + len;
-
 	virt = acpi_os_map_iomem(start, len);
 	if (!virt) {
 		dev_warn(&chip->dev, "%s: Failed to map ACPI memory\n", __func__);
 		/* try EFI log next */
-		ret = -ENODEV;
-		goto err;
+		return -ENODEV;
 	}
 
-	memcpy_fromio(log->bios_event_log, virt, len);
-
-	acpi_os_unmap_iomem(virt, len);
-
-	if (chip->flags & TPM_CHIP_FLAG_TPM2 &&
-	    !tpm_is_tpm2_log(log->bios_event_log, len)) {
+	if (chip->flags & TPM_CHIP_FLAG_TPM2 && !tpm_is_tpm2_log(virt, len)) {
+		acpi_os_unmap_iomem(virt, len);
 		/* try EFI log next */
 		ret = -ENODEV;
 		goto err;
 	}
 
+	acpi_os_unmap_iomem(virt, len);
+	chip->flags |= TPM_CHIP_FLAG_ACPI_LOG;
+	chip->log.bios_event_log = (void *)start;
+	chip->log.bios_event_log_end = (void *)start + len;
 	return format;
 
 err:
-	devm_kfree(&chip->dev, log->bios_event_log);
-	log->bios_event_log = NULL;
+	acpi_os_unmap_iomem(virt, len);
 	return ret;
 }
diff --git a/drivers/char/tpm/eventlog/common.c b/drivers/char/tpm/eventlog/common.c
index 4c0bbba64ee5..d934ef8c8b7f 100644
--- a/drivers/char/tpm/eventlog/common.c
+++ b/drivers/char/tpm/eventlog/common.c
@@ -25,11 +25,12 @@
 static int tpm_bios_measurements_open(struct inode *inode,
 					    struct file *file)
 {
-	int err;
-	struct seq_file *seq;
+	struct tpm_measurements *priv;
 	struct tpm_chip_seqops *chip_seqops;
 	const struct seq_operations *seqops;
 	struct tpm_chip *chip;
+	struct seq_file *seq;
+	int ret;
 
 	inode_lock(inode);
 	if (!inode->i_private) {
@@ -42,27 +43,35 @@ static int tpm_bios_measurements_open(struct inode *inode,
 	get_device(&chip->dev);
 	inode_unlock(inode);
 
-	/* now register seq file */
-	err = seq_open(file, seqops);
-	if (!err) {
-		seq = file->private_data;
-		seq->private = chip;
-	} else {
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	priv->chip = chip;
+
+	ret = seq_open(file, seqops);
+	if (ret) {
+		kfree(priv);
 		put_device(&chip->dev);
+	} else {
+		seq = file->private_data;
+		seq->private = priv;
 	}
 
-	return err;
+	return ret;
 }
 
 static int tpm_bios_measurements_release(struct inode *inode,
 					 struct file *file)
 {
 	struct seq_file *seq = file->private_data;
-	struct tpm_chip *chip = seq->private;
+	struct tpm_measurements *priv = seq->private;
+	int ret;
 
-	put_device(&chip->dev);
+	put_device(&priv->chip->dev);
+	ret = seq_release(inode, file);
+	kfree(priv);
 
-	return seq_release(inode, file);
+	return ret;
 }
 
 static const struct file_operations tpm_bios_measurements_ops = {
diff --git a/drivers/char/tpm/eventlog/common.h b/drivers/char/tpm/eventlog/common.h
index 47ff8136ceb5..ad89a0daf585 100644
--- a/drivers/char/tpm/eventlog/common.h
+++ b/drivers/char/tpm/eventlog/common.h
@@ -7,6 +7,12 @@ extern const struct seq_operations tpm1_ascii_b_measurements_seqops;
 extern const struct seq_operations tpm1_binary_b_measurements_seqops;
 extern const struct seq_operations tpm2_binary_b_measurements_seqops;
 
+struct tpm_measurements {
+	struct tpm_chip *chip;
+	void *start;
+	void *end;
+};
+
 #if defined(CONFIG_ACPI)
 int tpm_read_log_acpi(struct tpm_chip *chip);
 #else
diff --git a/drivers/char/tpm/eventlog/tpm1.c b/drivers/char/tpm/eventlog/tpm1.c
index 12ee42a31c71..6141a580e99c 100644
--- a/drivers/char/tpm/eventlog/tpm1.c
+++ b/drivers/char/tpm/eventlog/tpm1.c
@@ -22,11 +22,8 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/tpm_eventlog.h>
-
-#include "../tpm.h"
 #include "common.h"
 
-
 static const char* tcpa_event_type_strings[] = {
 	"PREBOOT",
 	"POST CODE",
@@ -70,20 +67,32 @@ static const char* tcpa_pc_event_id_strings[] = {
 static void *tpm1_bios_measurements_start(struct seq_file *m, loff_t *pos)
 {
 	loff_t i = 0;
-	struct tpm_chip *chip = m->private;
+	struct tpm_measurements *priv = m->private;
+	struct tpm_chip *chip = priv->chip;
 	struct tpm_bios_log *log = &chip->log;
-	void *addr = log->bios_event_log;
-	void *limit = log->bios_event_log_end;
 	struct tcpa_event *event;
 	u32 converted_event_size;
 	u32 converted_event_type;
+	size_t log_size;
+	void *addr;
+
+	log_size = log->bios_event_log_end - log->bios_event_log;
+
+	priv->start = !(chip->flags & TPM_CHIP_FLAG_ACPI_LOG) ?
+		      log->bios_event_log :
+		      acpi_os_map_iomem((unsigned long)log->bios_event_log, log_size);
+	if (!priv->start)
+		return NULL;
+	priv->end = priv->start + log_size;
+
+	addr = priv->start;
 
 	/* read over *pos measurements */
 	do {
 		event = addr;
 
 		/* check if current entry is valid */
-		if (addr + sizeof(struct tcpa_event) > limit)
+		if (addr + sizeof(struct tcpa_event) > priv->end)
 			return NULL;
 
 		converted_event_size =
@@ -93,7 +102,7 @@ static void *tpm1_bios_measurements_start(struct seq_file *m, loff_t *pos)
 
 		if (((converted_event_type == 0) && (converted_event_size == 0))
 		    || ((addr + sizeof(struct tcpa_event) + converted_event_size)
-			> limit))
+			> priv->end))
 			return NULL;
 
 		if (i++ == *pos)
@@ -108,10 +117,8 @@ static void *tpm1_bios_measurements_start(struct seq_file *m, loff_t *pos)
 static void *tpm1_bios_measurements_next(struct seq_file *m, void *v,
 					loff_t *pos)
 {
+	struct tpm_measurements *priv = m->private;
 	struct tcpa_event *event = v;
-	struct tpm_chip *chip = m->private;
-	struct tpm_bios_log *log = &chip->log;
-	void *limit = log->bios_event_log_end;
 	u32 converted_event_size;
 	u32 converted_event_type;
 
@@ -121,7 +128,7 @@ static void *tpm1_bios_measurements_next(struct seq_file *m, void *v,
 	v += sizeof(struct tcpa_event) + converted_event_size;
 
 	/* now check if current entry is valid */
-	if ((v + sizeof(struct tcpa_event)) > limit)
+	if ((v + sizeof(struct tcpa_event)) > priv->end)
 		return NULL;
 
 	event = v;
@@ -130,7 +137,7 @@ static void *tpm1_bios_measurements_next(struct seq_file *m, void *v,
 	converted_event_type = do_endian_conversion(event->event_type);
 
 	if (((converted_event_type == 0) && (converted_event_size == 0)) ||
-	    ((v + sizeof(struct tcpa_event) + converted_event_size) > limit))
+	    ((v + sizeof(struct tcpa_event) + converted_event_size) > priv->end))
 		return NULL;
 
 	return v;
@@ -138,6 +145,11 @@ static void *tpm1_bios_measurements_next(struct seq_file *m, void *v,
 
 static void tpm1_bios_measurements_stop(struct seq_file *m, void *v)
 {
+	struct tpm_measurements *priv = m->private;
+	struct tpm_chip *chip = priv->chip;
+
+	if (!!(chip->flags & TPM_CHIP_FLAG_ACPI_LOG))
+		acpi_os_unmap_iomem(priv->start, priv->end - priv->start);
 }
 
 static int get_event_name(char *dest, struct tcpa_event *event,
diff --git a/drivers/char/tpm/eventlog/tpm2.c b/drivers/char/tpm/eventlog/tpm2.c
index 37a05800980c..79e090dd751a 100644
--- a/drivers/char/tpm/eventlog/tpm2.c
+++ b/drivers/char/tpm/eventlog/tpm2.c
@@ -12,14 +12,13 @@
  * content.
  */
 
+#include "linux/tpm.h"
 #include <linux/seq_file.h>
 #include <linux/fs.h>
 #include <linux/security.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/tpm_eventlog.h>
-
-#include "../tpm.h"
 #include "common.h"
 
 /*
@@ -41,20 +40,31 @@ static size_t calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 
 static void *tpm2_bios_measurements_start(struct seq_file *m, loff_t *pos)
 {
-	struct tpm_chip *chip = m->private;
+	struct tpm_measurements *priv = m->private;
+	struct tpm_chip *chip = priv->chip;
 	struct tpm_bios_log *log = &chip->log;
-	void *addr = log->bios_event_log;
-	void *limit = log->bios_event_log_end;
 	struct tcg_pcr_event *event_header;
 	struct tcg_pcr_event2_head *event;
-	size_t size;
+	size_t size, log_size;
+	void *addr;
 	int i;
 
+	log_size = log->bios_event_log_end - log->bios_event_log;
+
+	priv->start = !(chip->flags & TPM_CHIP_FLAG_ACPI_LOG) ?
+		      log->bios_event_log :
+		      acpi_os_map_iomem((unsigned long)log->bios_event_log, log_size);
+	if (!priv->start)
+		return NULL;
+
+	priv->end = priv->start + log_size;
+
+	addr = priv->start;
 	event_header = addr;
 	size = struct_size(event_header, event, event_header->event_size);
 
 	if (*pos == 0) {
-		if (addr + size < limit) {
+		if (addr + size < priv->end) {
 			if ((event_header->event_type == 0) &&
 			    (event_header->event_size == 0))
 				return NULL;
@@ -66,7 +76,7 @@ static void *tpm2_bios_measurements_start(struct seq_file *m, loff_t *pos)
 		addr += size;
 		event = addr;
 		size = calc_tpm2_event_size(event, event_header);
-		if ((addr + size >=  limit) || (size == 0))
+		if ((addr + size >= priv->end) || !size)
 			return NULL;
 	}
 
@@ -74,7 +84,7 @@ static void *tpm2_bios_measurements_start(struct seq_file *m, loff_t *pos)
 		event = addr;
 		size = calc_tpm2_event_size(event, event_header);
 
-		if ((addr + size >= limit) || (size == 0))
+		if ((addr + size >= priv->end) || !size)
 			return NULL;
 		addr += size;
 	}
@@ -85,16 +95,14 @@ static void *tpm2_bios_measurements_start(struct seq_file *m, loff_t *pos)
 static void *tpm2_bios_measurements_next(struct seq_file *m, void *v,
 					 loff_t *pos)
 {
+	struct tpm_measurements *priv = m->private;
 	struct tcg_pcr_event *event_header;
 	struct tcg_pcr_event2_head *event;
-	struct tpm_chip *chip = m->private;
-	struct tpm_bios_log *log = &chip->log;
-	void *limit = log->bios_event_log_end;
 	size_t event_size;
 	void *marker;
 
 	(*pos)++;
-	event_header = log->bios_event_log;
+	event_header = priv->start;
 
 	if (v == SEQ_START_TOKEN) {
 		event_size = struct_size(event_header, event,
@@ -109,13 +117,13 @@ static void *tpm2_bios_measurements_next(struct seq_file *m, void *v,
 	}
 
 	marker = marker + event_size;
-	if (marker >= limit)
+	if (marker >= priv->end)
 		return NULL;
 	v = marker;
 	event = v;
 
 	event_size = calc_tpm2_event_size(event, event_header);
-	if (((v + event_size) >= limit) || (event_size == 0))
+	if (((v + event_size) >= priv->end) || !event_size)
 		return NULL;
 
 	return v;
@@ -123,13 +131,17 @@ static void *tpm2_bios_measurements_next(struct seq_file *m, void *v,
 
 static void tpm2_bios_measurements_stop(struct seq_file *m, void *v)
 {
+	struct tpm_measurements *priv = m->private;
+	struct tpm_chip *chip = priv->chip;
+
+	if (!!(chip->flags & TPM_CHIP_FLAG_ACPI_LOG))
+		acpi_os_unmap_iomem(priv->start, priv->end - priv->start);
 }
 
 static int tpm2_binary_bios_measurements_show(struct seq_file *m, void *v)
 {
-	struct tpm_chip *chip = m->private;
-	struct tpm_bios_log *log = &chip->log;
-	struct tcg_pcr_event *event_header = log->bios_event_log;
+	struct tpm_measurements *priv = m->private;
+	struct tcg_pcr_event *event_header = priv->start;
 	struct tcg_pcr_event2_head *event = v;
 	void *temp_ptr;
 	size_t size;
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 20a40ade8030..f3d12738b93b 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -348,6 +348,7 @@ enum tpm_chip_flags {
 	TPM_CHIP_FLAG_SUSPENDED			= BIT(8),
 	TPM_CHIP_FLAG_HWRNG_DISABLED		= BIT(9),
 	TPM_CHIP_FLAG_DISABLE			= BIT(10),
+	TPM_CHIP_FLAG_ACPI_LOG		= BIT(11),
 };
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
-- 
2.47.1


