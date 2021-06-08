Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC5639F6AF
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Jun 2021 14:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbhFHMdz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Jun 2021 08:33:55 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3168 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbhFHMdz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Jun 2021 08:33:55 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Fzq6Y1YHhz6G862;
        Tue,  8 Jun 2021 20:19:17 +0800 (CST)
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
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 1/5] doc: Fix warning in Documentation/security/IMA-templates.rst
Date:   Tue, 8 Jun 2021 14:31:20 +0200
Message-ID: <20210608123124.335868-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
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

This patch fixes the warning:

Documentation/security/IMA-templates.rst:81: WARNING: Inline
substitution_reference start-string without end-string.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/security/IMA-templates.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/security/IMA-templates.rst b/Documentation/security/IMA-templates.rst
index 5adc22f99496..1a91d92950a7 100644
--- a/Documentation/security/IMA-templates.rst
+++ b/Documentation/security/IMA-templates.rst
@@ -78,7 +78,7 @@ descriptors by adding their identifier to the format string
  - 'iuid': the inode UID;
  - 'igid': the inode GID;
  - 'imode': the inode mode;
- - 'xattrnames': a list of xattr names (separated by |), only if the xattr is
+ - 'xattrnames': a list of xattr names (separated by ``|``), only if the xattr is
     present;
  - 'xattrlengths': a list of xattr lengths (u32), only if the xattr is present;
  - 'xattrvalues': a list of xattr values;
-- 
2.25.1

