Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2B139A206
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jun 2021 15:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhFCNTe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Jun 2021 09:19:34 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3141 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhFCNTe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Jun 2021 09:19:34 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FwmRr5FFtz6V09Q;
        Thu,  3 Jun 2021 21:08:40 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.62.217) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 15:17:47 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@srcf.ucam.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RESEND][PATCH v2 6/7] ima: Define new template evm-sig
Date:   Thu, 3 Jun 2021 15:17:05 +0200
Message-ID: <20210603131705.1426671-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <9e5f5ddca94fb1915fb15302e2b7b5f2bf4a68a7.camel@linux.ibm.com>
References: <9e5f5ddca94fb1915fb15302e2b7b5f2bf4a68a7.camel@linux.ibm.com>
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

With the recent introduction of the evmsig template field, remote verifiers
can obtain the EVM portable signature instead of the IMA signature, to
verify file metadata.

After introducing the new fields to include file metadata in the
measurement list, this patch finally defines the evm-sig template, whose
format is:

d-ng|n-ng|evmsig|xattrnames|xattrlengths|xattrvalues|iuid|igid|imode

xattrnames, xattrlengths and xattrvalues are populated only from defined
EVM protected xattrs, i.e. the ones that EVM considers to verify the
portable signature. xattrnames and xattrlengths are populated only if the
xattr is present.

xattrnames and xattrlengths are not necessary for verifying the EVM
portable signature, but they are included for completeness of information,
if a remote verifier wants to infer more from file metadata.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 Documentation/security/IMA-templates.rst | 1 +
 security/integrity/ima/ima_template.c    | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/security/IMA-templates.rst b/Documentation/security/IMA-templates.rst
index 6a58760a0a35..5adc22f99496 100644
--- a/Documentation/security/IMA-templates.rst
+++ b/Documentation/security/IMA-templates.rst
@@ -91,6 +91,7 @@ Below, there is the list of defined template descriptors:
  - "ima-sig": its format is ``d-ng|n-ng|sig``;
  - "ima-buf": its format is ``d-ng|n-ng|buf``;
  - "ima-modsig": its format is ``d-ng|n-ng|sig|d-modsig|modsig``;
+ - "evm-sig": its format is ``d-ng|n-ng|evmsig|xattrnames|xattrlengths|xattrvalues|iuid|igid|imode``;
 
 
 Use
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 159a31d2fcdf..a85963853a91 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -22,6 +22,8 @@ static struct ima_template_desc builtin_templates[] = {
 	{.name = "ima-sig", .fmt = "d-ng|n-ng|sig"},
 	{.name = "ima-buf", .fmt = "d-ng|n-ng|buf"},
 	{.name = "ima-modsig", .fmt = "d-ng|n-ng|sig|d-modsig|modsig"},
+	{.name = "evm-sig",
+	 .fmt = "d-ng|n-ng|evmsig|xattrnames|xattrlengths|xattrvalues|iuid|igid|imode"},
 	{.name = "", .fmt = ""},	/* placeholder for a custom format */
 };
 
@@ -69,7 +71,8 @@ static const struct ima_template_field supported_fields[] = {
  * need to be accounted for since they shouldn't be defined in the same template
  * description as 'd-ng' and 'n-ng' respectively.
  */
-#define MAX_TEMPLATE_NAME_LEN sizeof("d-ng|n-ng|sig|buf|d-modisg|modsig")
+#define MAX_TEMPLATE_NAME_LEN \
+	sizeof("d-ng|n-ng|evmsig|xattrnames|xattrlengths|xattrvalues|iuid|igid|imode")
 
 static struct ima_template_desc *ima_template;
 static struct ima_template_desc *ima_buf_template;
-- 
2.25.1

