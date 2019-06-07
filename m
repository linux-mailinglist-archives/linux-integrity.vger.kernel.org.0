Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 782A339711
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jun 2019 22:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbfFGUwF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Jun 2019 16:52:05 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:51495 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbfFGUwF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Jun 2019 16:52:05 -0400
Received: by mail-qk1-f201.google.com with SMTP id n126so2619499qkc.18
        for <linux-integrity@vger.kernel.org>; Fri, 07 Jun 2019 13:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=oqbsRsWn+lQnRxXZU32fYir680/IiGRNUy7p5L8zLFI=;
        b=UZttm1p/WIT8JCZ/ttox/tS2Mt/NPmTQwUtwKpjK44/+VnCi5SzX1c92BwLeHuEmlJ
         rHmsub04+Ve9iWoi9nVh/TtTjoIToNeGDPXZ7+9xqAVvL6QSVmbDfDfPDE1rJWTXWp9R
         nEsbw/Yq6d+IN58qoH0ixZ2akLLfkGEAstNDG8FyjL8GeBsegtJqGsAFinzjVhpKdRg6
         09yDeehQbCM3h0biK9BOia3H+ECFY4irebfu/eWthA5yGYNLXyNPVbp4rQy4a/RJBerI
         SlBYAEqi7x0BWoAG6pDyfZxpiXjmfzzrM1n0BLUDO8oUwSASyJQenQOKDR+I0e0mT8UZ
         ZTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=oqbsRsWn+lQnRxXZU32fYir680/IiGRNUy7p5L8zLFI=;
        b=mB149jJR/LcJhwQ2y3naZA8UhNqUeNjU6edjhOpc+2TpQzgAvsltnmBT1S/NCd6Nre
         v1nwdTygH52tb2PdneDcDsDyqrS2DI0Fybeh4E1HnSGiriUJYycIRyMLkYIpZa9/HH+G
         ZIZmMIIPIad95nX1shrxGRWFqmlUkBu0MVfBP3t7Lbr3vYDHDAo8JPB/Dh4QNe9fe9K+
         j4AGBEfG4I2y/nk5KPTHojv6ZdGGietCAVk2UQYFORhZc14XbO2xLRuZ8D1hmD/aCtME
         XMHtvDkfd6eZGBQ6iO/0sIQjw6ng6olED+WiOTp1KY59NoHO0NXhtCyXSbPtqwP+LA9V
         KbJw==
X-Gm-Message-State: APjAAAVj713QvHe6l+rkX1I0MDf6Oj3OAZNjABaEg2HK4Xbhj5R5HPTz
        7MqUndJEMFkQJ8YKeY87/XBxKXHN/aF7dXOQCqHLPfC48mF+7Ka+1gnZkNT84uuKvizmQH61ARs
        JnzolzkUcJ32TUNEqdxW+S3S4RAsPmXMXNLp7G0Sx9H6YbAe8/yZQfYL6W4OUT2Hwb61+hX38BA
        iwSDSTYJN4kPbjVxUxsZc=
X-Google-Smtp-Source: APXvYqyV8OrlWrDFoL1lsF8h0Vxl4PaO+yiXlppqDfBbK4qEUZGyxMvuEfys1BCENICS6FJaRYPWcdHdDcq5FQ4QMPuGTQ==
X-Received: by 2002:ad4:5345:: with SMTP id v5mr33982623qvs.103.1559940724590;
 Fri, 07 Jun 2019 13:52:04 -0700 (PDT)
Date:   Fri,  7 Jun 2019 13:51:46 -0700
Message-Id: <20190607205147.102904-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH V2 1/2] Abstract out support for locating an EFI config table
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        linux-efi@vger.kernel.org, ard.biesheuvel@linaro.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

We want to grab a pointer to the TPM final events table, so abstract out
the existing code for finding an FDT table and make it generic.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 .../firmware/efi/libstub/efi-stub-helper.c    | 15 +++++++++++
 drivers/firmware/efi/libstub/efistub.h        |  2 ++
 drivers/firmware/efi/libstub/fdt.c            | 27 +++++++------------
 3 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index e4610e72b78f..1db780c0f07b 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -926,3 +926,18 @@ efi_status_t efi_exit_boot_services(efi_system_table_t *sys_table_arg,
 fail:
 	return status;
 }
+
+void *get_efi_config_table(efi_system_table_t *sys_table, efi_guid_t guid)
+{
+	efi_config_table_t *tables = (efi_config_table_t *)sys_table->tables;
+	int i;
+
+	for (i = 0; i < sys_table->nr_tables; i++) {
+		if (efi_guidcmp(tables[i].guid, guid) != 0)
+			continue;
+
+		return (void *)tables[i].table;
+	}
+
+	return NULL;
+}
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 1b1dfcaa6fb9..7f1556fd867d 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -65,6 +65,8 @@ efi_status_t check_platform_features(efi_system_table_t *sys_table_arg);
 
 efi_status_t efi_random_get_seed(efi_system_table_t *sys_table_arg);
 
+void *get_efi_config_table(efi_system_table_t *sys_table, efi_guid_t guid);
+
 /* Helper macros for the usual case of using simple C variables: */
 #ifndef fdt_setprop_inplace_var
 #define fdt_setprop_inplace_var(fdt, node_offset, name, var) \
diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 5440ba17a1c5..0bf0190917e0 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -363,26 +363,17 @@ efi_status_t allocate_new_fdt_and_exit_boot(efi_system_table_t *sys_table,
 
 void *get_fdt(efi_system_table_t *sys_table, unsigned long *fdt_size)
 {
-	efi_guid_t fdt_guid = DEVICE_TREE_GUID;
-	efi_config_table_t *tables;
-	int i;
+	void *fdt;
 
-	tables = (efi_config_table_t *)sys_table->tables;
+	fdt = get_efi_config_table(sys_table, DEVICE_TREE_GUID);
 
-	for (i = 0; i < sys_table->nr_tables; i++) {
-		void *fdt;
+	if (!fdt)
+		return NULL;
 
-		if (efi_guidcmp(tables[i].guid, fdt_guid) != 0)
-			continue;
-
-		fdt = (void *)tables[i].table;
-		if (fdt_check_header(fdt) != 0) {
-			pr_efi_err(sys_table, "Invalid header detected on UEFI supplied FDT, ignoring ...\n");
-			return NULL;
-		}
-		*fdt_size = fdt_totalsize(fdt);
-		return fdt;
+	if (fdt_check_header(fdt) != 0) {
+		pr_efi_err(sys_table, "Invalid header detected on UEFI supplied FDT, ignoring ...\n");
+		return NULL;
 	}
-
-	return NULL;
+	*fdt_size = fdt_totalsize(fdt);
+	return fdt;
 }
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

