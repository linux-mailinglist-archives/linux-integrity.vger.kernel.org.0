Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2522396EDC
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Jun 2021 10:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbhFAIZd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Jun 2021 04:25:33 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3109 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbhFAIZc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Jun 2021 04:25:32 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FvQ4d1WMlz6P3Ck;
        Tue,  1 Jun 2021 16:17:21 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.62.217) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 10:23:49 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@srcf.ucam.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        kernel test robot <lkp@intel.com>
Subject: [RESEND][PATCH v2 5/7] ima: Define new template fields xattrnames, xattrlengths and xattrvalues
Date:   Tue, 1 Jun 2021 10:23:38 +0200
Message-ID: <20210601082338.908390-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528073812.407936-6-roberto.sassu@huawei.com>
References: <20210528073812.407936-6-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.62.217]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch defines the new template fields xattrnames, xattrlengths and
xattrvalues, which contain respectively a list of xattr names (strings,
separated by |), lengths (u32, hex) and values (hex). If an xattr is not
present, the name and length are not displayed in the measurement list.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 Documentation/security/IMA-templates.rst  |  4 ++
 include/linux/evm.h                       | 10 ++++
 security/integrity/evm/evm_main.c         | 69 +++++++++++++++++++++++
 security/integrity/ima/ima_template.c     |  9 +++
 security/integrity/ima/ima_template_lib.c | 64 +++++++++++++++++++++
 security/integrity/ima/ima_template_lib.h |  6 ++
 6 files changed, 162 insertions(+)

diff --git a/Documentation/security/IMA-templates.rst b/Documentation/security/IMA-templates.rst
index 65c1ce451d08..6a58760a0a35 100644
--- a/Documentation/security/IMA-templates.rst
+++ b/Documentation/security/IMA-templates.rst
@@ -78,6 +78,10 @@ descriptors by adding their identifier to the format string
  - 'iuid': the inode UID;
  - 'igid': the inode GID;
  - 'imode': the inode mode;
+ - 'xattrnames': a list of xattr names (separated by |), only if the xattr is
+    present;
+ - 'xattrlengths': a list of xattr lengths (u32), only if the xattr is present;
+ - 'xattrvalues': a list of xattr values;
 
 
 Below, there is the list of defined template descriptors:
diff --git a/include/linux/evm.h b/include/linux/evm.h
index 5011a299c251..4c374be70247 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -39,6 +39,9 @@ extern int evm_inode_init_security(struct inode *inode,
 				   struct xattr *evm);
 extern bool evm_revalidate_status(const char *xattr_name);
 extern int evm_protected_xattr_if_enabled(const char *req_xattr_name);
+extern int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
+				     int buffer_size, char type,
+				     bool canonical_fmt);
 #ifdef CONFIG_FS_POSIX_ACL
 extern int posix_xattr_acl(const char *xattrname);
 #else
@@ -120,5 +123,12 @@ static inline int evm_protected_xattr_if_enabled(const char *req_xattr_name)
 	return false;
 }
 
+static inline int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
+					    int buffer_size, char type,
+					    bool canonical_fmt)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_EVM */
 #endif /* LINUX_EVM_H */
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index ee4e17a790fb..2c226e634ae9 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -317,6 +317,75 @@ int evm_protected_xattr_if_enabled(const char *req_xattr_name)
 	return evm_protected_xattr_common(req_xattr_name, true);
 }
 
+/**
+ * evm_read_protected_xattrs - read EVM protected xattr names, lengths, values
+ * @dentry: dentry of the read xattrs
+ * @inode: inode of the read xattrs
+ * @buffer: buffer xattr names, lengths or values are copied to
+ * @buffer_size: size of buffer
+ * @type: n: names, l: lengths, v: values
+ * @canonical_fmt: data format (true: little endian, false: native format)
+ *
+ * Read protected xattr names (separated by |), lengths (u32) or values for a
+ * given dentry and return the total size of copied data. If buffer is NULL,
+ * just return the total size.
+ *
+ * Returns the total size on success, a negative value on error.
+ */
+int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
+			      int buffer_size, char type, bool canonical_fmt)
+{
+	struct xattr_list *xattr;
+	int rc, size, total_size = 0;
+
+	list_for_each_entry_lockless(xattr, &evm_config_xattrnames, list) {
+		rc = __vfs_getxattr(dentry, d_backing_inode(dentry),
+				    xattr->name, NULL, 0);
+		if (rc < 0 && rc == -ENODATA)
+			continue;
+		else if (rc < 0)
+			return rc;
+
+		switch (type) {
+		case 'n':
+			size = strlen(xattr->name) + 1;
+			if (buffer) {
+				if (total_size)
+					*(buffer + total_size - 1) = '|';
+
+				memcpy(buffer + total_size, xattr->name, size);
+			}
+			break;
+		case 'l':
+			size = sizeof(u32);
+			if (buffer) {
+				if (canonical_fmt)
+					rc = cpu_to_le32(rc);
+
+				*(u32 *)(buffer + total_size) = rc;
+			}
+			break;
+		case 'v':
+			size = rc;
+			if (buffer) {
+				rc = __vfs_getxattr(dentry,
+					d_backing_inode(dentry), xattr->name,
+					buffer + total_size,
+					buffer_size - total_size);
+				if (rc < 0)
+					return rc;
+			}
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		total_size += size;
+	}
+
+	return total_size;
+}
+
 /**
  * evm_verifyxattr - verify the integrity of the requested xattr
  * @dentry: object of the verify xattr
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 43784f2bf8bd..159a31d2fcdf 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -53,6 +53,15 @@ static const struct ima_template_field supported_fields[] = {
 	 .field_show = ima_show_template_uint},
 	{.field_id = "imode", .field_init = ima_eventinodemode_init,
 	 .field_show = ima_show_template_uint},
+	{.field_id = "xattrnames",
+	 .field_init = ima_eventinodexattrnames_init,
+	 .field_show = ima_show_template_string},
+	{.field_id = "xattrlengths",
+	 .field_init = ima_eventinodexattrlengths_init,
+	 .field_show = ima_show_template_sig},
+	{.field_id = "xattrvalues",
+	 .field_init = ima_eventinodexattrvalues_init,
+	 .field_show = ima_show_template_sig},
 };
 
 /*
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 3156fb34b1af..518fd50ea48a 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -11,6 +11,7 @@
 
 #include "ima_template_lib.h"
 #include <linux/xattr.h>
+#include <linux/evm.h>
 
 static bool ima_template_hash_algo_allowed(u8 algo)
 {
@@ -618,3 +619,66 @@ int ima_eventinodemode_init(struct ima_event_data *event_data,
 	return ima_write_template_field_data((char *)&mode, sizeof(mode),
 					     DATA_FMT_UINT, field_data);
 }
+
+static int ima_eventinodexattrs_init_common(struct ima_event_data *event_data,
+					    struct ima_field_data *field_data,
+					    char type)
+{
+	u8 *buffer = NULL;
+	int rc;
+
+	if (!event_data->file)
+		return 0;
+
+	rc = evm_read_protected_xattrs(file_dentry(event_data->file), NULL, 0,
+				       type, ima_canonical_fmt);
+	if (rc < 0)
+		return 0;
+
+	buffer = kmalloc(rc, GFP_KERNEL);
+	if (!buffer)
+		return 0;
+
+	rc = evm_read_protected_xattrs(file_dentry(event_data->file), buffer,
+				       rc, type, ima_canonical_fmt);
+	if (rc < 0) {
+		rc = 0;
+		goto out;
+	}
+
+	rc = ima_write_template_field_data((char *)buffer, rc, DATA_FMT_HEX,
+					   field_data);
+out:
+	kfree(buffer);
+	return rc;
+}
+
+/*
+ *  ima_eventinodexattrnames_init - include a list of xattr names as part of the
+ *  template data
+ */
+int ima_eventinodexattrnames_init(struct ima_event_data *event_data,
+				  struct ima_field_data *field_data)
+{
+	return ima_eventinodexattrs_init_common(event_data, field_data, 'n');
+}
+
+/*
+ *  ima_eventinodexattrlengths_init - include a list of xattr lengths as part of
+ *  the template data
+ */
+int ima_eventinodexattrlengths_init(struct ima_event_data *event_data,
+				    struct ima_field_data *field_data)
+{
+	return ima_eventinodexattrs_init_common(event_data, field_data, 'l');
+}
+
+/*
+ *  ima_eventinodexattrvalues_init - include a list of xattr values as part of
+ *  the template data
+ */
+int ima_eventinodexattrvalues_init(struct ima_event_data *event_data,
+				   struct ima_field_data *field_data)
+{
+	return ima_eventinodexattrs_init_common(event_data, field_data, 'v');
+}
diff --git a/security/integrity/ima/ima_template_lib.h b/security/integrity/ima/ima_template_lib.h
index 6509af4a97ee..c71f1de95753 100644
--- a/security/integrity/ima/ima_template_lib.h
+++ b/security/integrity/ima/ima_template_lib.h
@@ -56,4 +56,10 @@ int ima_eventinodegid_init(struct ima_event_data *event_data,
 			   struct ima_field_data *field_data);
 int ima_eventinodemode_init(struct ima_event_data *event_data,
 			    struct ima_field_data *field_data);
+int ima_eventinodexattrnames_init(struct ima_event_data *event_data,
+				  struct ima_field_data *field_data);
+int ima_eventinodexattrlengths_init(struct ima_event_data *event_data,
+				    struct ima_field_data *field_data);
+int ima_eventinodexattrvalues_init(struct ima_event_data *event_data,
+				   struct ima_field_data *field_data);
 #endif /* __LINUX_IMA_TEMPLATE_LIB_H */
-- 
2.25.1

