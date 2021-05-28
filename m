Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FD7393E0D
	for <lists+linux-integrity@lfdr.de>; Fri, 28 May 2021 09:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbhE1HkS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 May 2021 03:40:18 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3099 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbhE1HkG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 May 2021 03:40:06 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FrxGH34l6z6N3fn;
        Fri, 28 May 2021 15:32:07 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.62.217) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 28 May 2021 09:38:29 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@srcf.ucam.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 2/7] ima: Define new template fields iuid and igid
Date:   Fri, 28 May 2021 09:38:07 +0200
Message-ID: <20210528073812.407936-3-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528073812.407936-1-roberto.sassu@huawei.com>
References: <20210528073812.407936-1-roberto.sassu@huawei.com>
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

This patch defines the new template fields iuid and igid, which include
respectively the inode UID and GID. For idmapped mounts, still the original
UID and GID are provided.

These fields can be used to verify the EVM portable signature, if it was
included with the template fields sig or evmsig.

Cc: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/security/IMA-templates.rst  |  2 +
 security/integrity/ima/ima_template.c     |  4 ++
 security/integrity/ima/ima_template_lib.c | 45 +++++++++++++++++++++++
 security/integrity/ima/ima_template_lib.h |  4 ++
 4 files changed, 55 insertions(+)

diff --git a/Documentation/security/IMA-templates.rst b/Documentation/security/IMA-templates.rst
index 9f3e86ab028a..bf8ce4cf5878 100644
--- a/Documentation/security/IMA-templates.rst
+++ b/Documentation/security/IMA-templates.rst
@@ -75,6 +75,8 @@ descriptors by adding their identifier to the format string
  - 'modsig' the appended file signature;
  - 'buf': the buffer data that was used to generate the hash without size limitations;
  - 'evmsig': the EVM portable signature;
+ - 'iuid': the inode UID;
+ - 'igid': the inode GID;
 
 
 Below, there is the list of defined template descriptors:
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 7a60848c04a5..a5ecd9e2581b 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -47,6 +47,10 @@ static const struct ima_template_field supported_fields[] = {
 	 .field_show = ima_show_template_sig},
 	{.field_id = "evmsig", .field_init = ima_eventevmsig_init,
 	 .field_show = ima_show_template_sig},
+	{.field_id = "iuid", .field_init = ima_eventinodeuid_init,
+	 .field_show = ima_show_template_uint},
+	{.field_id = "igid", .field_init = ima_eventinodegid_init,
+	 .field_show = ima_show_template_uint},
 };
 
 /*
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index f23296c33da1..87b40f391739 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -551,3 +551,48 @@ int ima_eventevmsig_init(struct ima_event_data *event_data,
 	kfree(xattr_data);
 	return rc;
 }
+
+static int ima_eventinodedac_init_common(struct ima_event_data *event_data,
+					 struct ima_field_data *field_data,
+					 bool get_uid)
+{
+	unsigned int id;
+
+	if (!event_data->file)
+		return 0;
+
+	if (get_uid)
+		id = i_uid_read(file_inode(event_data->file));
+	else
+		id = i_gid_read(file_inode(event_data->file));
+
+	if (ima_canonical_fmt) {
+		if (sizeof(id) == sizeof(u16))
+			id = cpu_to_le16(id);
+		else
+			id = cpu_to_le32(id);
+	}
+
+	return ima_write_template_field_data((void *)&id, sizeof(id),
+					     DATA_FMT_UINT, field_data);
+}
+
+/*
+ *  ima_eventinodeuid_init - include the inode UID as part of the template
+ *  data
+ */
+int ima_eventinodeuid_init(struct ima_event_data *event_data,
+			   struct ima_field_data *field_data)
+{
+	return ima_eventinodedac_init_common(event_data, field_data, true);
+}
+
+/*
+ *  ima_eventinodegid_init - include the inode GID as part of the template
+ *  data
+ */
+int ima_eventinodegid_init(struct ima_event_data *event_data,
+			   struct ima_field_data *field_data)
+{
+	return ima_eventinodedac_init_common(event_data, field_data, false);
+}
diff --git a/security/integrity/ima/ima_template_lib.h b/security/integrity/ima/ima_template_lib.h
index 54b67c80b315..b0aaf109f386 100644
--- a/security/integrity/ima/ima_template_lib.h
+++ b/security/integrity/ima/ima_template_lib.h
@@ -50,4 +50,8 @@ int ima_eventmodsig_init(struct ima_event_data *event_data,
 			 struct ima_field_data *field_data);
 int ima_eventevmsig_init(struct ima_event_data *event_data,
 			 struct ima_field_data *field_data);
+int ima_eventinodeuid_init(struct ima_event_data *event_data,
+			   struct ima_field_data *field_data);
+int ima_eventinodegid_init(struct ima_event_data *event_data,
+			   struct ima_field_data *field_data);
 #endif /* __LINUX_IMA_TEMPLATE_LIB_H */
-- 
2.25.1

