Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D76C8A22BA
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Aug 2019 19:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfH2RtY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Aug 2019 13:49:24 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.113]:11341 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727495AbfH2RtY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Aug 2019 13:49:24 -0400
X-Greylist: delayed 1203 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Aug 2019 13:49:24 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 9ED183CDB853
        for <linux-integrity@vger.kernel.org>; Thu, 29 Aug 2019 12:29:19 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 3OEZiR2nX90on3OEZiCuL9; Thu, 29 Aug 2019 12:29:19 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aJiyb7UI2K/+R2F5a3fw1EU55SbvNGjQFMYnPqg0Gq4=; b=L2GNazUZvM+5uFV9vAPkne/b+V
        VCYDR6dk/keOSuL7t2Ng6N1LuKCPYSDSgz3Q29kbR5AbTVVHhqfnlixvTZ+l59IE2T416t9h/2Ehk
        dPWLzEDR/sdRSe9+UUwp0iqG3rq7WkiU4O+jzUngKmVQBTcJJRyzPtGdmEh1gxVcjkRKtibbxpHau
        Yq7XwKT+IRk9FTtAs0NtZfp1/0KuvasEG9iEbH5p8OxCYHbRZmiP+3OYkVrz104HNV+n16cLndP9Z
        aaG3M/FVu/869oXP0fQ22APe6+XNNVUntMVC+DCeeU0zhbSW/WBIXLvwCkVT49oyH6kRqq3A0xjFk
        ec85EGXA==;
Received: from [189.152.216.116] (port=41274 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1i3OEX-000tZz-V9; Thu, 29 Aug 2019 12:29:18 -0500
Date:   Thu, 29 Aug 2019 12:29:16 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ima: ima_api: Use struct_size() in kzalloc()
Message-ID: <20190829172916.GA10261@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.152.216.116
X-Source-L: No
X-Exim-ID: 1i3OEX-000tZz-V9
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.152.216.116]:41274
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct ima_template_entry {
	...
        struct ima_field_data template_data[0]; /* template related data */
};

instance = kzalloc(sizeof(struct ima_template_entry) + count * sizeof(struct ima_field_data), GFP_NOFS);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kzalloc(struct_size(instance, entry, count), GFP_NOFS);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 security/integrity/ima/ima_api.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 65224474675b..610759fe63b8 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -45,8 +45,8 @@ int ima_alloc_init_template(struct ima_event_data *event_data,
 	else
 		template_desc = ima_template_desc_current();
 
-	*entry = kzalloc(sizeof(**entry) + template_desc->num_fields *
-			 sizeof(struct ima_field_data), GFP_NOFS);
+	*entry = kzalloc(struct_size(*entry, template_data,
+				     template_desc->num_fields), GFP_NOFS);
 	if (!*entry)
 		return -ENOMEM;
 
-- 
2.23.0

