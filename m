Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F55285DBD
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Oct 2020 13:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgJGLCu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Oct 2020 07:02:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46048 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgJGLCu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Oct 2020 07:02:50 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kQ7DY-0007qH-4x; Wed, 07 Oct 2020 11:02:44 +0000
From:   Colin King <colin.king@canonical.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Roberto Sassu <roberto.sassu@polito.it>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ima: Fix sizeof mismatches
Date:   Wed,  7 Oct 2020 12:02:43 +0100
Message-Id: <20201007110243.19033-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

An incorrect sizeof is being used, sizeof(*fields) is not correct,
it should be sizeof(**fields). This is not causing a problem since
the size of these is the same. Fix this in the kmalloc_array and
memcpy calls.

Addresses-Coverity: ("Sizeof not portable (SIZEOF_MISMATCH)")
Fixes: 1bd7face7439 ("ima: allocate field pointers array on demand in template_desc_init_fields()")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 security/integrity/ima/ima_template.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 1e89e2d3851f..8884bbf03b43 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -216,11 +216,11 @@ int template_desc_init_fields(const char *template_fmt,
 	}
 
 	if (fields && num_fields) {
-		*fields = kmalloc_array(i, sizeof(*fields), GFP_KERNEL);
+		*fields = kmalloc_array(i, sizeof(**fields), GFP_KERNEL);
 		if (*fields == NULL)
 			return -ENOMEM;
 
-		memcpy(*fields, found_fields, i * sizeof(*fields));
+		memcpy(*fields, found_fields, i * sizeof(**fields));
 		*num_fields = i;
 	}
 
-- 
2.27.0

