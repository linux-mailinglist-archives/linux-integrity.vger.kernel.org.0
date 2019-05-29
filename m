Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6F072E373
	for <lists+linux-integrity@lfdr.de>; Wed, 29 May 2019 19:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfE2Rkt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 May 2019 13:40:49 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.35]:23810 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725917AbfE2Rkt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 May 2019 13:40:49 -0400
X-Greylist: delayed 1501 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 May 2019 13:40:49 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 0AE7E138E24
        for <linux-integrity@vger.kernel.org>; Wed, 29 May 2019 11:53:45 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id W1phh8umd90onW1phhBwf0; Wed, 29 May 2019 11:53:45 -0500
X-Authority-Reason: nr=8
Received: from [189.250.47.159] (port=50894 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hW1pf-002Frw-RX; Wed, 29 May 2019 11:53:44 -0500
Date:   Wed, 29 May 2019 11:53:43 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ima: use struct_size() in kzalloc()
Message-ID: <20190529165343.GA2584@embeddedor>
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
X-Source-IP: 189.250.47.159
X-Source-L: No
X-Exim-ID: 1hW1pf-002Frw-RX
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.47.159]:50894
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 14
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
   int stuff;
   struct boo entry[];
};

instance = kzalloc(sizeof(struct foo) + count * sizeof(struct boo), GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 security/integrity/ima/ima_template.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index b631b8bc7624..b945dff2ed14 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -281,9 +281,8 @@ static int ima_restore_template_data(struct ima_template_desc *template_desc,
 	int ret = 0;
 	int i;
 
-	*entry = kzalloc(sizeof(**entry) +
-		    template_desc->num_fields * sizeof(struct ima_field_data),
-		    GFP_NOFS);
+	*entry = kzalloc(struct_size(*entry, template_data,
+				     template_desc->num_fields), GFP_NOFS);
 	if (!*entry)
 		return -ENOMEM;
 
-- 
2.21.0

