Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C424638A055
	for <lists+linux-integrity@lfdr.de>; Thu, 20 May 2021 10:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhETI6q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 May 2021 04:58:46 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3085 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhETI6p (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 May 2021 04:58:45 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Fm3Gq13nkz6Vykc;
        Thu, 20 May 2021 16:45:39 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.62.217) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 10:57:22 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@srcf.ucam.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 3/7] ima: Introduce template fields mntuidmap and mntgidmap
Date:   Thu, 20 May 2021 10:56:57 +0200
Message-ID: <20210520085701.465369-4-roberto.sassu@huawei.com>
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

This patch introduces the new template fields mntuidmap and mntgidmap,
which include respectively the UID and GID mappings of the idmapped mount,
if the user namespace is not the initial one.

These template fields, which should be included whenever the iuid and the
igid fields are included, allow remote verifiers to find the original UID
and GID of the inode during signature verification. The iuid and igid
fields include the mapped UID and GID when the inode is in an idmapped
mount.

This solution has been preferred to providing always the original UID and
GID, regardless of whether the inode is in an idmapped mount or not, as
the mapped UID and GID are those seen by processes and matched with the IMA
policy.

Cc: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/security/IMA-templates.rst  |  4 ++
 security/integrity/ima/ima_template.c     |  6 ++
 security/integrity/ima/ima_template_lib.c | 83 +++++++++++++++++++++++
 security/integrity/ima/ima_template_lib.h |  4 ++
 4 files changed, 97 insertions(+)

diff --git a/Documentation/security/IMA-templates.rst b/Documentation/security/IMA-templates.rst
index bf8ce4cf5878..48a2df22a1a1 100644
--- a/Documentation/security/IMA-templates.rst
+++ b/Documentation/security/IMA-templates.rst
@@ -77,6 +77,10 @@ descriptors by adding their identifier to the format string
  - 'evmsig': the EVM portable signature;
  - 'iuid': the inode UID;
  - 'igid': the inode GID;
+ - 'mntuidmap': the UID mappings of the idmapped mount (nr extents,
+    [ uid_gid_extent1 ] ... [ uid_gid_extentN ], all u32 in canonical format);
+ - 'mntgidmap': the GID mappings of the idmapped mount (same format as
+   'mntuidmap');
 
 
 Below, there is the list of defined template descriptors:
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index a5ecd9e2581b..19de115b985b 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -51,6 +51,12 @@ static const struct ima_template_field supported_fields[] = {
 	 .field_show = ima_show_template_uint},
 	{.field_id = "igid", .field_init = ima_eventinodegid_init,
 	 .field_show = ima_show_template_uint},
+	{.field_id = "mntuidmap",
+	 .field_init = ima_eventmnt_userns_uid_map_init,
+	 .field_show = ima_show_template_sig},
+	{.field_id = "mntgidmap",
+	 .field_init = ima_eventmnt_userns_gid_map_init,
+	 .field_show = ima_show_template_sig},
 };
 
 /*
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index a191b861548b..bc4919d90c3a 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -609,3 +609,86 @@ int ima_eventinodegid_init(struct ima_event_data *event_data,
 {
 	return ima_eventinodedac_init_common(event_data, field_data, false);
 }
+
+int ima_eventmnt_userns_common_init(struct ima_event_data *event_data,
+				    struct ima_field_data *field_data,
+				    bool get_uid_map)
+{
+	struct user_namespace *mnt_userns;
+	u8 *buf, *buf_ptr;
+	struct uid_gid_map *map;
+	int rc, i;
+
+	if (!event_data->file)
+		return 0;
+
+	mnt_userns = file_mnt_user_ns(event_data->file);
+	if (mnt_userns == &init_user_ns)
+		return 0;
+
+	map = &mnt_userns->uid_map;
+	if (!get_uid_map)
+		map = &mnt_userns->gid_map;
+
+	buf_ptr = buf = kmalloc(sizeof(map->nr_extents) +
+				map->nr_extents * sizeof(*map->extent),
+				GFP_KERNEL);
+	if (!buf)
+		return 0;
+
+	memcpy(buf_ptr, &map->nr_extents, sizeof(map->nr_extents));
+
+	if (ima_canonical_fmt)
+		*(u32 *)buf_ptr = cpu_to_le32(*(u32 *)buf_ptr);
+
+	buf_ptr += sizeof(u32);
+
+	for (i = 0; i < map->nr_extents; i++) {
+		struct uid_gid_extent *extent;
+
+		/* Taken from m_start() in kernel/user_namespace.c. */
+		if (map->nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
+			extent = &map->extent[i];
+		else
+			extent = &map->forward[i];
+
+		memcpy(buf_ptr, &extent->first, sizeof(extent->first));
+		if (ima_canonical_fmt)
+			*(u32 *)buf_ptr = cpu_to_le32(*(u32 *)buf_ptr);
+		buf_ptr += sizeof(extent->first);
+		memcpy(buf_ptr, &extent->lower_first,
+		       sizeof(extent->lower_first));
+		if (ima_canonical_fmt)
+			*(u32 *)buf_ptr = cpu_to_le32(*(u32 *)buf_ptr);
+		buf_ptr += sizeof(extent->lower_first);
+		memcpy(buf_ptr, &extent->count, sizeof(extent->count));
+		if (ima_canonical_fmt)
+			*(u32 *)buf_ptr = cpu_to_le32(*(u32 *)buf_ptr);
+		buf_ptr += sizeof(extent->count);
+	}
+
+	rc = ima_write_template_field_data((char *)buf, buf_ptr - buf,
+					   DATA_FMT_HEX, field_data);
+	kfree(buf);
+	return rc;
+}
+
+/*
+ *  ima_eventmnt_userns_uid_map_init - include the UID mappings of the idmapped
+ *  mount as part of the template data
+ */
+int ima_eventmnt_userns_uid_map_init(struct ima_event_data *event_data,
+				     struct ima_field_data *field_data)
+{
+	return ima_eventmnt_userns_common_init(event_data, field_data, true);
+}
+
+/*
+ *  ima_eventmnt_userns_gid_map_init - include the GID mappings of the idmapped
+ *  mount as part of the template data
+ */
+int ima_eventmnt_userns_gid_map_init(struct ima_event_data *event_data,
+				     struct ima_field_data *field_data)
+{
+	return ima_eventmnt_userns_common_init(event_data, field_data, false);
+}
diff --git a/security/integrity/ima/ima_template_lib.h b/security/integrity/ima/ima_template_lib.h
index b0aaf109f386..51ee66fc7230 100644
--- a/security/integrity/ima/ima_template_lib.h
+++ b/security/integrity/ima/ima_template_lib.h
@@ -54,4 +54,8 @@ int ima_eventinodeuid_init(struct ima_event_data *event_data,
 			   struct ima_field_data *field_data);
 int ima_eventinodegid_init(struct ima_event_data *event_data,
 			   struct ima_field_data *field_data);
+int ima_eventmnt_userns_uid_map_init(struct ima_event_data *event_data,
+				     struct ima_field_data *field_data);
+int ima_eventmnt_userns_gid_map_init(struct ima_event_data *event_data,
+				     struct ima_field_data *field_data);
 #endif /* __LINUX_IMA_TEMPLATE_LIB_H */
-- 
2.25.1

