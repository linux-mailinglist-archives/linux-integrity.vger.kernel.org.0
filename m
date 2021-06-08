Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F85539F6BB
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Jun 2021 14:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbhFHMeA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Jun 2021 08:34:00 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3171 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbhFHMd6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Jun 2021 08:33:58 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FzqBX0HMcz6G7hy;
        Tue,  8 Jun 2021 20:22:44 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.62.217) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 14:32:01 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <sfr@canb.auug.org.au>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-next@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 3/5] ima/evm: Fix type mismatch
Date:   Tue, 8 Jun 2021 14:31:22 +0200
Message-ID: <20210608123124.335868-3-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210608123124.335868-1-roberto.sassu@huawei.com>
References: <20210608123124.335868-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.62.217]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The endianness of a variable written to the measurement list cannot be
determined at compile time, as it depends on the value of the
ima_canonical_fmt global variable (set through a kernel option with the
same name if the machine is big endian).

If ima_canonical_fmt is false, the endianness of a variable is the same as
the machine; if ima_canonical_fmt is true, the endianness is little endian.
The warning arises due to this type of instruction:

var = cpu_to_leXX(var)

which tries to assign a value in little endian to a variable with native
endianness (little or big endian).

Given that the variables set with this instruction are not used in any
operation but just written to a buffer, it is safe to force the type of the
value being set to be the same of the type of the variable with:

var = (__force <var type>)cpu_to_leXX(var)

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/evm/evm_main.c         |  2 +-
 security/integrity/ima/ima_crypto.c       |  4 ++--
 security/integrity/ima/ima_fs.c           |  6 +++---
 security/integrity/ima/ima_template_lib.c | 11 ++++++-----
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 2c226e634ae9..977208aecd06 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -360,7 +360,7 @@ int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
 			size = sizeof(u32);
 			if (buffer) {
 				if (canonical_fmt)
-					rc = cpu_to_le32(rc);
+					rc = (__force int)cpu_to_le32(rc);
 
 				*(u32 *)(buffer + total_size) = rc;
 			}
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index f6a7e9643b54..a7206cc1d7d1 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -598,8 +598,8 @@ static int ima_calc_field_array_hash_tfm(struct ima_field_data *field_data,
 		u8 buffer[IMA_EVENT_NAME_LEN_MAX + 1] = { 0 };
 		u8 *data_to_hash = field_data[i].data;
 		u32 datalen = field_data[i].len;
-		u32 datalen_to_hash =
-		    !ima_canonical_fmt ? datalen : cpu_to_le32(datalen);
+		u32 datalen_to_hash = !ima_canonical_fmt ?
+				datalen : (__force u32)cpu_to_le32(datalen);
 
 		if (strcmp(td->name, IMA_TEMPLATE_IMA_NAME) != 0) {
 			rc = crypto_shash_update(shash,
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index ea8ff8a07b36..3d8e9d5db5aa 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -147,7 +147,7 @@ int ima_measurements_show(struct seq_file *m, void *v)
 	 * PCR used defaults to the same (config option) in
 	 * little-endian format, unless set in policy
 	 */
-	pcr = !ima_canonical_fmt ? e->pcr : cpu_to_le32(e->pcr);
+	pcr = !ima_canonical_fmt ? e->pcr : (__force u32)cpu_to_le32(e->pcr);
 	ima_putc(m, &pcr, sizeof(e->pcr));
 
 	/* 2nd: template digest */
@@ -155,7 +155,7 @@ int ima_measurements_show(struct seq_file *m, void *v)
 
 	/* 3rd: template name size */
 	namelen = !ima_canonical_fmt ? strlen(template_name) :
-		cpu_to_le32(strlen(template_name));
+		(__force u32)cpu_to_le32(strlen(template_name));
 	ima_putc(m, &namelen, sizeof(namelen));
 
 	/* 4th:  template name */
@@ -167,7 +167,7 @@ int ima_measurements_show(struct seq_file *m, void *v)
 
 	if (!is_ima_template) {
 		template_data_len = !ima_canonical_fmt ? e->template_data_len :
-			cpu_to_le32(e->template_data_len);
+			(__force u32)cpu_to_le32(e->template_data_len);
 		ima_putc(m, &template_data_len, sizeof(e->template_data_len));
 	}
 
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 3f8d53a03612..8e2a121af5e1 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -133,7 +133,8 @@ static void ima_show_template_data_binary(struct seq_file *m,
 	    strlen(field_data->data) : field_data->len;
 
 	if (show != IMA_SHOW_BINARY_NO_FIELD_LEN) {
-		u32 field_len = !ima_canonical_fmt ? len : cpu_to_le32(len);
+		u32 field_len = !ima_canonical_fmt ?
+				len : (__force u32)cpu_to_le32(len);
 
 		ima_putc(m, &field_len, sizeof(field_len));
 	}
@@ -570,9 +571,9 @@ static int ima_eventinodedac_init_common(struct ima_event_data *event_data,
 
 	if (ima_canonical_fmt) {
 		if (sizeof(id) == sizeof(u16))
-			id = cpu_to_le16(id);
+			id = (__force u16)cpu_to_le16(id);
 		else
-			id = cpu_to_le32(id);
+			id = (__force u32)cpu_to_le32(id);
 	}
 
 	return ima_write_template_field_data((void *)&id, sizeof(id),
@@ -607,7 +608,7 @@ int ima_eventinodemode_init(struct ima_event_data *event_data,
 			    struct ima_field_data *field_data)
 {
 	struct inode *inode;
-	umode_t mode;
+	u16 mode;
 
 	if (!event_data->file)
 		return 0;
@@ -615,7 +616,7 @@ int ima_eventinodemode_init(struct ima_event_data *event_data,
 	inode = file_inode(event_data->file);
 	mode = inode->i_mode;
 	if (ima_canonical_fmt)
-		mode = cpu_to_le16(mode);
+		mode = (__force u16)cpu_to_le16(mode);
 
 	return ima_write_template_field_data((char *)&mode, sizeof(mode),
 					     DATA_FMT_UINT, field_data);
-- 
2.25.1

