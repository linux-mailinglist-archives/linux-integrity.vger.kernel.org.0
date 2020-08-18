Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E2A248A43
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 17:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgHRPoi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 11:44:38 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2636 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726685AbgHRPob (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 11:44:31 -0400
Received: from lhreml722-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 87348B7096922947690A;
        Tue, 18 Aug 2020 16:44:30 +0100 (IST)
Received: from kstruczy-linux-box (10.204.65.138) by
 lhreml722-chm.china.huawei.com (10.201.108.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 16:44:28 +0100
Received: by kstruczy-linux-box (sSMTP sendmail emulation); Tue, 18 Aug 2020 17:44:31 +0200
From:   <krzysztof.struczynski@huawei.com>
To:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <containers@lists.linux-foundation.org>,
        <linux-security-module@vger.kernel.org>
CC:     <zohar@linux.ibm.com>, <stefanb@linux.vnet.ibm.com>,
        <sunyuqiong1988@gmail.com>, <mkayaalp@cs.binghamton.edu>,
        <dmitry.kasatkin@gmail.com>, <serge@hallyn.com>,
        <jmorris@namei.org>, <christian@brauner.io>,
        <silviu.vlasceanu@huawei.com>, <roberto.sassu@huawei.com>,
        Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
Subject: [RFC PATCH 13/30] ima: Add a new ima template that includes namespace ID
Date:   Tue, 18 Aug 2020 17:42:13 +0200
Message-ID: <20200818154230.14016-4-krzysztof.struczynski@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200818154230.14016-1-krzysztof.struczynski@huawei.com>
References: <20200818154230.14016-1-krzysztof.struczynski@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.65.138]
X-ClientProxiedBy: fraeml707-chm.china.huawei.com (10.206.15.35) To
 lhreml722-chm.china.huawei.com (10.201.108.73)
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>

Add a new ima-ns template:
"d-ng|n-ng|ns"

Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
---
 security/integrity/ima/ima_template.c     |  5 ++++-
 security/integrity/ima/ima_template_lib.c | 13 +++++++++++++
 security/integrity/ima/ima_template_lib.h |  2 ++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 945e70fafd2e..2020bd5176a4 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -22,6 +22,7 @@ static struct ima_template_desc builtin_templates[] = {
 	{.name = "ima-sig", .fmt = "d-ng|n-ng|sig"},
 	{.name = "ima-buf", .fmt = "d-ng|n-ng|buf"},
 	{.name = "ima-modsig", .fmt = "d-ng|n-ng|sig|d-modsig|modsig"},
+	{.name = "ima-ns", .fmt = "d-ng|n-ng|ns"},
 	{.name = "", .fmt = ""},	/* placeholder for a custom format */
 };
 
@@ -45,6 +46,8 @@ static const struct ima_template_field supported_fields[] = {
 	 .field_show = ima_show_template_digest_ng},
 	{.field_id = "modsig", .field_init = ima_eventmodsig_init,
 	 .field_show = ima_show_template_sig},
+	{.field_id = "ns", .field_init = ima_eventns_init,
+	 .field_show = ima_show_template_buf},
 };
 
 /*
@@ -52,7 +55,7 @@ static const struct ima_template_field supported_fields[] = {
  * need to be accounted for since they shouldn't be defined in the same template
  * description as 'd-ng' and 'n-ng' respectively.
  */
-#define MAX_TEMPLATE_NAME_LEN sizeof("d-ng|n-ng|sig|buf|d-modisg|modsig")
+#define MAX_TEMPLATE_NAME_LEN sizeof("d-ng|n-ng|sig|buf|d-modisg|modsig|ns")
 
 static struct ima_template_desc *ima_template;
 
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 635c6ac05050..cda5374dbbc4 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -484,3 +484,16 @@ int ima_eventmodsig_init(struct ima_event_data *event_data,
 	return ima_write_template_field_data(data, data_len, DATA_FMT_HEX,
 					     field_data);
 }
+
+/*
+ *  ima_eventns_init - include the ima namespace id as part of the
+ *  template data
+ */
+int ima_eventns_init(struct ima_event_data *event_data,
+		     struct ima_field_data *field_data)
+{
+	return ima_write_template_field_data(&(event_data->ns_id),
+					     sizeof(event_data->ns_id),
+					     DATA_FMT_HEX,
+					     field_data);
+}
diff --git a/security/integrity/ima/ima_template_lib.h b/security/integrity/ima/ima_template_lib.h
index 9a88c79a7a61..7e67d1402192 100644
--- a/security/integrity/ima/ima_template_lib.h
+++ b/security/integrity/ima/ima_template_lib.h
@@ -46,4 +46,6 @@ int ima_eventbuf_init(struct ima_event_data *event_data,
 		      struct ima_field_data *field_data);
 int ima_eventmodsig_init(struct ima_event_data *event_data,
 			 struct ima_field_data *field_data);
+int ima_eventns_init(struct ima_event_data *event_data,
+		     struct ima_field_data *field_data);
 #endif /* __LINUX_IMA_TEMPLATE_LIB_H */
-- 
2.20.1

