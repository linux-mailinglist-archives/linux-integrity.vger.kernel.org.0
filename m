Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA94393E1A
	for <lists+linux-integrity@lfdr.de>; Fri, 28 May 2021 09:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbhE1Hla (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 May 2021 03:41:30 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3103 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbhE1Hl3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 May 2021 03:41:29 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FrxHv0MHgz6N47p;
        Fri, 28 May 2021 15:33:31 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.62.217) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 28 May 2021 09:39:53 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@srcf.ucam.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 6/7] ima: Define new template evm-sig
Date:   Fri, 28 May 2021 09:38:11 +0200
Message-ID: <20210528073812.407936-7-roberto.sassu@huawei.com>
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
---
 Documentation/security/IMA-templates.rst | 1 +
 security/integrity/ima/ima_template.c    | 3 +++
 2 files changed, 4 insertions(+)

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
index 159a31d2fcdf..be435efe6122 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -22,6 +22,9 @@ static struct ima_template_desc builtin_templates[] = {
 	{.name = "ima-sig", .fmt = "d-ng|n-ng|sig"},
 	{.name = "ima-buf", .fmt = "d-ng|n-ng|buf"},
 	{.name = "ima-modsig", .fmt = "d-ng|n-ng|sig|d-modsig|modsig"},
+	{.name = "evm-sig",
+	 .fmt = "d-ng|n-ng|evmsig|"
+		"xattrnames|xattrlengths|xattrvalues|iuid|igid|imode"},
 	{.name = "", .fmt = ""},	/* placeholder for a custom format */
 };
 
-- 
2.25.1

