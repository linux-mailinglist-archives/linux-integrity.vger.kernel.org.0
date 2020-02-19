Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A49F9163800
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Feb 2020 01:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgBSAGW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Feb 2020 19:06:22 -0500
Received: from linux.microsoft.com ([13.77.154.182]:44388 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbgBSAGW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Feb 2020 19:06:22 -0500
Received: from tusharsu-Ubuntu.corp.microsoft.com (unknown [131.107.147.225])
        by linux.microsoft.com (Postfix) with ESMTPSA id BB6D52007690;
        Tue, 18 Feb 2020 16:06:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BB6D52007690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1582070781;
        bh=lmmv8BwguvSfd0HKerD1hdGZVZFucntvwM9yetms1ek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eQZWim380eXo4NGuZOz5xcVFNBCtgOG5SBnQ7kkqq7jr9BmaenystKjJ8e6SZsADz
         NCzHkUmp1pSAQ+pTZWxfu9SFTrFatNytjLy5XKiovOb3r1xMELl+635YsioXacjhYD
         UIgb5lGIlffDMKATy0s2PgtTjK/YVdisvmACWWwk=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, joe@perches.com, skhan@linuxfoundation.org,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3]  IMA: Add log statements for failure conditions
Date:   Tue, 18 Feb 2020 16:06:10 -0800
Message-Id: <20200219000611.28141-3-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219000611.28141-1-tusharsu@linux.microsoft.com>
References: <20200219000611.28141-1-tusharsu@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

process_buffer_measurement() does not have log messages for failure
conditions.

This change adds a log statement in the above function. 

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Suggested-by: Joe Perches <joe@perches.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 9fe949c6a530..aac1c44fb11b 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -757,6 +757,9 @@ void process_buffer_measurement(const void *buf, int size,
 		ima_free_template_entry(entry);
 
 out:
+	if (ret < 0)
+		pr_devel("%s: failed, result: %d\n", __func__, ret);
+
 	return;
 }
 
-- 
2.17.1

