Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2FE438A056
	for <lists+linux-integrity@lfdr.de>; Thu, 20 May 2021 10:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhETI6r (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 May 2021 04:58:47 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3086 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbhETI6q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 May 2021 04:58:46 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Fm3Gq5Z4zz6VylS;
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
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 4/7] ima: Introduce template field imode
Date:   Thu, 20 May 2021 10:56:58 +0200
Message-ID: <20210520085701.465369-5-roberto.sassu@huawei.com>
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

This patch introduces the new template field imode, which includes the
inode mode. It can be used by a remote verifier to verify the EVM portable
signature, if it was included with the template fields sig or evmsig.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/security/IMA-templates.rst  |  1 +
 security/integrity/ima/ima_template.c     |  2 ++
 security/integrity/ima/ima_template_lib.c | 22 ++++++++++++++++++++++
 security/integrity/ima/ima_template_lib.h |  2 ++
 4 files changed, 27 insertions(+)

diff --git a/Documentation/security/IMA-templates.rst b/Documentation/security/IMA-templates.rst
index 48a2df22a1a1..6e98bce20029 100644
--- a/Documentation/security/IMA-templates.rst
+++ b/Documentation/security/IMA-templates.rst
@@ -81,6 +81,7 @@ descriptors by adding their identifier to the format string
     [ uid_gid_extent1 ] ... [ uid_gid_extentN ], all u32 in canonical format);
  - 'mntgidmap': the GID mappings of the idmapped mount (same format as
    'mntuidmap');
+ - 'imode': the inode mode;
 
 
 Below, there is the list of defined template descriptors:
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 19de115b985b..34674aef1cc5 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -57,6 +57,8 @@ static const struct ima_template_field supported_fields[] = {
 	{.field_id = "mntgidmap",
 	 .field_init = ima_eventmnt_userns_gid_map_init,
 	 .field_show = ima_show_template_sig},
+	{.field_id = "imode", .field_init = ima_eventinodemode_init,
+	 .field_show = ima_show_template_uint},
 };
 
 /*
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index bc4919d90c3a..b82fb8f35e5d 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -692,3 +692,25 @@ int ima_eventmnt_userns_gid_map_init(struct ima_event_data *event_data,
 {
 	return ima_eventmnt_userns_common_init(event_data, field_data, false);
 }
+
+/*
+ *  ima_eventinodemode_init - include the inode mode as part of the template
+ *  data
+ */
+int ima_eventinodemode_init(struct ima_event_data *event_data,
+			    struct ima_field_data *field_data)
+{
+	struct inode *inode;
+	umode_t mode;
+
+	if (!event_data->file)
+		return 0;
+
+	inode = file_inode(event_data->file);
+	mode = inode->i_mode;
+	if (ima_canonical_fmt)
+		mode = cpu_to_le16(mode);
+
+	return ima_write_template_field_data((char *)&mode, sizeof(mode),
+					     DATA_FMT_UINT, field_data);
+}
diff --git a/security/integrity/ima/ima_template_lib.h b/security/integrity/ima/ima_template_lib.h
index 51ee66fc7230..dc3c16912f6d 100644
--- a/security/integrity/ima/ima_template_lib.h
+++ b/security/integrity/ima/ima_template_lib.h
@@ -58,4 +58,6 @@ int ima_eventmnt_userns_uid_map_init(struct ima_event_data *event_data,
 				     struct ima_field_data *field_data);
 int ima_eventmnt_userns_gid_map_init(struct ima_event_data *event_data,
 				     struct ima_field_data *field_data);
+int ima_eventinodemode_init(struct ima_event_data *event_data,
+			    struct ima_field_data *field_data);
 #endif /* __LINUX_IMA_TEMPLATE_LIB_H */
-- 
2.25.1

