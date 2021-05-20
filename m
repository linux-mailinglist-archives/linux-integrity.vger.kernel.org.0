Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C769A38A06D
	for <lists+linux-integrity@lfdr.de>; Thu, 20 May 2021 10:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhETI76 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 May 2021 04:59:58 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3089 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbhETI75 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 May 2021 04:59:57 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Fm3Mq47Q9z6wjYg;
        Thu, 20 May 2021 16:49:59 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.62.217) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 10:58:34 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@srcf.ucam.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 6/7] ima: Introduce template field evmxattrs
Date:   Thu, 20 May 2021 10:57:00 +0200
Message-ID: <20210520085701.465369-7-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210520085701.465369-1-roberto.sassu@huawei.com>
References: <20210520085701.465369-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.62.217]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch introduces the new template field evmxattrs, which contains the
number of EVM protected xattrs (u32 in little endian), the xattr names
separated by \0, the xattr lengths (u32 in little endian) and the xattr
values. Xattrs can be used to verify the EVM portable signature, if it was
included with the template fields sig or evmsig.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/security/IMA-templates.rst  |   3 +
 security/integrity/ima/ima_template.c     |   2 +
 security/integrity/ima/ima_template_lib.c | 121 ++++++++++++++++++++++
 security/integrity/ima/ima_template_lib.h |   2 +
 4 files changed, 128 insertions(+)

diff --git a/Documentation/security/IMA-templates.rst b/Documentation/security/IMA-templates.rst
index 6e98bce20029..a9684fde3871 100644
--- a/Documentation/security/IMA-templates.rst
+++ b/Documentation/security/IMA-templates.rst
@@ -82,6 +82,9 @@ descriptors by adding their identifier to the format string
  - 'mntgidmap': the GID mappings of the idmapped mount (same format as
    'mntuidmap');
  - 'imode': the inode mode;
+ - 'evmxattrs': the EVM protected xattrs (num xattrs (u32 in canonical format),
+    xattr names separated by \0, xattr lengths (u32 in canonical format) and
+    xattr values);
 
 
 Below, there is the list of defined template descriptors:
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 34674aef1cc5..b9dd900db0ff 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -59,6 +59,8 @@ static const struct ima_template_field supported_fields[] = {
 	 .field_show = ima_show_template_sig},
 	{.field_id = "imode", .field_init = ima_eventinodemode_init,
 	 .field_show = ima_show_template_uint},
+	{.field_id = "evmxattrs", .field_init = ima_eventinodeevmxattrs_init,
+	 .field_show = ima_show_template_sig},
 };
 
 /*
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index b82fb8f35e5d..71e642d90e63 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -11,6 +11,7 @@
 
 #include "ima_template_lib.h"
 #include <linux/xattr.h>
+#include <linux/evm.h>
 
 static bool ima_template_hash_algo_allowed(u8 algo)
 {
@@ -714,3 +715,123 @@ int ima_eventinodemode_init(struct ima_event_data *event_data,
 	return ima_write_template_field_data((char *)&mode, sizeof(mode),
 					     DATA_FMT_UINT, field_data);
 }
+
+/*
+ *  ima_eventinodeevmxattrs_init - include the number of EVM protected xattrs,
+ *  the xattr names, lengths and values as part of the template data
+ */
+int ima_eventinodeevmxattrs_init(struct ima_event_data *event_data,
+				 struct ima_field_data *field_data)
+
+{
+	struct inode *inode;
+	u8 *buffer = NULL;
+	char *xattr_names, *xattr_names_ptr, *xattr_name;
+	size_t names_size, total_size;
+	u32 num_xattrs = 0, xattr_value_len;
+	loff_t names_offset, lengths_offset, values_offset;
+	int rc, evm_present = 0;
+
+	if (!event_data->file)
+		return 0;
+
+	inode = file_inode(event_data->file);
+	if (!inode->i_op->listxattr || !(inode->i_opflags & IOP_XATTR))
+		return 0;
+
+	names_size = inode->i_op->listxattr(file_dentry(event_data->file),
+					    NULL, 0);
+	if (names_size <= 0)
+		return 0;
+
+	xattr_names = kmalloc(names_size, GFP_KERNEL);
+	if (!xattr_names)
+		return 0;
+
+	names_size = inode->i_op->listxattr(file_dentry(event_data->file),
+					    xattr_names, names_size);
+	if (names_size <= 0)
+		goto out;
+
+	xattr_names_ptr = xattr_names;
+	total_size = sizeof(num_xattrs);
+	lengths_offset = total_size;
+
+	while (xattr_names_ptr < xattr_names + names_size) {
+		xattr_name = xattr_names_ptr;
+		xattr_names_ptr += strlen(xattr_names_ptr) + 1;
+
+		if (!strcmp(xattr_name, XATTR_NAME_EVM)) {
+			evm_present = 1;
+			continue;
+		}
+
+		if (!evm_protected_xattr_if_enabled(xattr_name))
+			continue;
+
+		total_size += xattr_names_ptr - xattr_name;
+		lengths_offset += xattr_names_ptr - xattr_name;
+		total_size += sizeof(xattr_value_len);
+		rc = __vfs_getxattr(file_dentry(event_data->file),
+				    file_inode(event_data->file), xattr_name,
+				    NULL, 0);
+		xattr_value_len = (rc >= 0) ? rc : 0;
+		total_size += xattr_value_len;
+		num_xattrs++;
+	}
+
+	/*
+	 * Don't provide data if security.evm is not found or there are no
+	 * protected xattrs.
+	 */
+	if (!evm_present || !num_xattrs)
+		return 0;
+
+	buffer = kmalloc(total_size, GFP_KERNEL);
+	if (!buffer)
+		goto out;
+
+	*(u32 *)buffer = num_xattrs;
+	if (ima_canonical_fmt)
+		*(u32 *)buffer = cpu_to_le32(*(u32 *)buffer);
+
+	names_offset = sizeof(num_xattrs);
+	values_offset = lengths_offset + num_xattrs * sizeof(xattr_value_len);
+
+	xattr_names_ptr = xattr_names;
+
+	while (xattr_names_ptr < xattr_names + names_size) {
+		xattr_name = xattr_names_ptr;
+		xattr_names_ptr += strlen(xattr_names_ptr) + 1;
+
+		if (!strcmp(xattr_name, XATTR_NAME_EVM))
+			continue;
+
+		if (!evm_protected_xattr_if_enabled(xattr_name))
+			continue;
+
+		memcpy(buffer + names_offset, xattr_name,
+		       xattr_names_ptr - xattr_name);
+		names_offset += xattr_names_ptr - xattr_name;
+
+		rc = __vfs_getxattr(file_dentry(event_data->file),
+				    file_inode(event_data->file), xattr_name,
+				    buffer + values_offset,
+				    total_size - values_offset);
+		xattr_value_len = (rc >= 0) ? rc : 0;
+		*(u32 *)(buffer + lengths_offset) = xattr_value_len;
+		if (ima_canonical_fmt)
+			*(u32 *)(buffer + lengths_offset) =
+				cpu_to_le32(*(u32 *)(buffer + lengths_offset));
+
+		lengths_offset += sizeof(xattr_value_len);
+		values_offset += xattr_value_len;
+	}
+
+	rc = ima_write_template_field_data((char *)buffer, total_size,
+					   DATA_FMT_HEX, field_data);
+out:
+	kfree(xattr_names);
+	kfree(buffer);
+	return rc;
+}
diff --git a/security/integrity/ima/ima_template_lib.h b/security/integrity/ima/ima_template_lib.h
index dc3c16912f6d..ee8f53847305 100644
--- a/security/integrity/ima/ima_template_lib.h
+++ b/security/integrity/ima/ima_template_lib.h
@@ -60,4 +60,6 @@ int ima_eventmnt_userns_gid_map_init(struct ima_event_data *event_data,
 				     struct ima_field_data *field_data);
 int ima_eventinodemode_init(struct ima_event_data *event_data,
 			    struct ima_field_data *field_data);
+int ima_eventinodeevmxattrs_init(struct ima_event_data *event_data,
+				 struct ima_field_data *field_data);
 #endif /* __LINUX_IMA_TEMPLATE_LIB_H */
-- 
2.25.1

