Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC8139F6C1
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Jun 2021 14:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbhFHMeB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Jun 2021 08:34:01 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3172 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbhFHMd6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Jun 2021 08:33:58 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FzqFY2jYhz6G7Wk;
        Tue,  8 Jun 2021 20:25:21 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.62.217) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 14:32:00 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <sfr@canb.auug.org.au>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-next@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 2/5] ima: Set correct casting types
Date:   Tue, 8 Jun 2021 14:31:21 +0200
Message-ID: <20210608123124.335868-2-roberto.sassu@huawei.com>
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

The code expects that the values being parsed from a buffer when the
ima_canonical_fmt global variable is true are in little endian. Thus, this
patch sets the casting types accordingly.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_template.c     |  8 ++++----
 security/integrity/ima/ima_template_lib.c | 11 ++++++-----
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index a85963853a91..694560396be0 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -423,9 +423,9 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 		return 0;
 
 	if (ima_canonical_fmt) {
-		khdr->version = le16_to_cpu(khdr->version);
-		khdr->count = le64_to_cpu(khdr->count);
-		khdr->buffer_size = le64_to_cpu(khdr->buffer_size);
+		khdr->version = le16_to_cpu((__force __le16)khdr->version);
+		khdr->count = le64_to_cpu((__force __le64)khdr->count);
+		khdr->buffer_size = le64_to_cpu((__force __le64)khdr->buffer_size);
 	}
 
 	if (khdr->version != 1) {
@@ -515,7 +515,7 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 		}
 
 		entry->pcr = !ima_canonical_fmt ? *(u32 *)(hdr[HDR_PCR].data) :
-			     le32_to_cpu(*(u32 *)(hdr[HDR_PCR].data));
+			     le32_to_cpu(*(__le32 *)(hdr[HDR_PCR].data));
 		ret = ima_restore_measurement_entry(entry);
 		if (ret < 0)
 			break;
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 518fd50ea48a..3f8d53a03612 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -98,21 +98,21 @@ static void ima_show_template_data_ascii(struct seq_file *m,
 		case sizeof(u16):
 			if (ima_canonical_fmt)
 				seq_printf(m, "%u",
-					   le16_to_cpu(*(u16 *)buf_ptr));
+					   le16_to_cpu(*(__le16 *)buf_ptr));
 			else
 				seq_printf(m, "%u", *(u16 *)buf_ptr);
 			break;
 		case sizeof(u32):
 			if (ima_canonical_fmt)
 				seq_printf(m, "%u",
-					   le32_to_cpu(*(u32 *)buf_ptr));
+					   le32_to_cpu(*(__le32 *)buf_ptr));
 			else
 				seq_printf(m, "%u", *(u32 *)buf_ptr);
 			break;
 		case sizeof(u64):
 			if (ima_canonical_fmt)
 				seq_printf(m, "%llu",
-					   le64_to_cpu(*(u64 *)buf_ptr));
+					   le64_to_cpu(*(__le64 *)buf_ptr));
 			else
 				seq_printf(m, "%llu", *(u64 *)buf_ptr);
 			break;
@@ -226,9 +226,10 @@ int ima_parse_buf(void *bufstartp, void *bufendp, void **bufcurp,
 			if (bufp > (bufendp - sizeof(u32)))
 				break;
 
-			fields[i].len = *(u32 *)bufp;
 			if (ima_canonical_fmt)
-				fields[i].len = le32_to_cpu(fields[i].len);
+				fields[i].len = le32_to_cpu(*(__le32 *)bufp);
+			else
+				fields[i].len = *(u32 *)bufp;
 
 			bufp += sizeof(u32);
 		}
-- 
2.25.1

