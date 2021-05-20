Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9336538A04D
	for <lists+linux-integrity@lfdr.de>; Thu, 20 May 2021 10:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhETI6o (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 May 2021 04:58:44 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3083 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhETI6o (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 May 2021 04:58:44 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Fm3Gn5cyRz6Vyjj;
        Thu, 20 May 2021 16:45:37 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.62.217) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 10:57:20 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@srcf.ucam.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 1/7] ima: Add ima_show_template_uint() template library function
Date:   Thu, 20 May 2021 10:56:55 +0200
Message-ID: <20210520085701.465369-2-roberto.sassu@huawei.com>
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

This patch introduces the new function ima_show_template_uint(). This can
be used for showing integers of different sizes in ASCII format. The
function ima_show_template_data_ascii() automatically determines how to
print a stored integer by checking the integer size.

If integers have been written in canonical format,
ima_show_template_data_ascii() calls the appropriate leXX_to_cpu() function
to correctly display the value.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_template_lib.c | 38 ++++++++++++++++++++++-
 security/integrity/ima/ima_template_lib.h |  2 ++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 4314d9a3514c..f23296c33da1 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -24,7 +24,8 @@ enum data_formats {
 	DATA_FMT_DIGEST = 0,
 	DATA_FMT_DIGEST_WITH_ALGO,
 	DATA_FMT_STRING,
-	DATA_FMT_HEX
+	DATA_FMT_HEX,
+	DATA_FMT_UINT
 };
 
 static int ima_write_template_field_data(const void *data, const u32 datalen,
@@ -88,6 +89,35 @@ static void ima_show_template_data_ascii(struct seq_file *m,
 	case DATA_FMT_STRING:
 		seq_printf(m, "%s", buf_ptr);
 		break;
+	case DATA_FMT_UINT:
+		switch (field_data->len) {
+		case sizeof(u8):
+			seq_printf(m, "%u", *(u8 *)buf_ptr);
+			break;
+		case sizeof(u16):
+			if (ima_canonical_fmt)
+				seq_printf(m, "%u",
+					   le16_to_cpu(*(u16 *)buf_ptr));
+			else
+				seq_printf(m, "%u", *(u16 *)buf_ptr);
+			break;
+		case sizeof(u32):
+			if (ima_canonical_fmt)
+				seq_printf(m, "%u",
+					   le32_to_cpu(*(u32 *)buf_ptr));
+			else
+				seq_printf(m, "%u", *(u32 *)buf_ptr);
+			break;
+		case sizeof(u64):
+			if (ima_canonical_fmt)
+				seq_printf(m, "%llu",
+					   le64_to_cpu(*(u64 *)buf_ptr));
+			else
+				seq_printf(m, "%llu", *(u64 *)buf_ptr);
+			break;
+		default:
+			break;
+		}
 	default:
 		break;
 	}
@@ -163,6 +193,12 @@ void ima_show_template_buf(struct seq_file *m, enum ima_show_type show,
 	ima_show_template_field_data(m, show, DATA_FMT_HEX, field_data);
 }
 
+void ima_show_template_uint(struct seq_file *m, enum ima_show_type show,
+			    struct ima_field_data *field_data)
+{
+	ima_show_template_field_data(m, show, DATA_FMT_UINT, field_data);
+}
+
 /**
  * ima_parse_buf() - Parses lengths and data from an input buffer
  * @bufstartp:       Buffer start address.
diff --git a/security/integrity/ima/ima_template_lib.h b/security/integrity/ima/ima_template_lib.h
index f4b2a2056d1d..54b67c80b315 100644
--- a/security/integrity/ima/ima_template_lib.h
+++ b/security/integrity/ima/ima_template_lib.h
@@ -27,6 +27,8 @@ void ima_show_template_sig(struct seq_file *m, enum ima_show_type show,
 			   struct ima_field_data *field_data);
 void ima_show_template_buf(struct seq_file *m, enum ima_show_type show,
 			   struct ima_field_data *field_data);
+void ima_show_template_uint(struct seq_file *m, enum ima_show_type show,
+			    struct ima_field_data *field_data);
 int ima_parse_buf(void *bufstartp, void *bufendp, void **bufcurp,
 		  int maxfields, struct ima_field_data *fields, int *curfields,
 		  unsigned long *len_mask, int enforce_mask, char *bufname);
-- 
2.25.1

