Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49251159D04
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2020 00:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgBKXO1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Feb 2020 18:14:27 -0500
Received: from linux.microsoft.com ([13.77.154.182]:36386 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbgBKXO1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Feb 2020 18:14:27 -0500
Received: from tusharsu-Ubuntu.corp.microsoft.com (unknown [131.107.147.225])
        by linux.microsoft.com (Postfix) with ESMTPSA id A17422010ADD;
        Tue, 11 Feb 2020 15:14:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A17422010ADD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1581462866;
        bh=v/89WOXLO/d+H6Z62W0I37EIbuMATJH4Hf50Leyxn5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RY0jWAqcb4fz7CmUheh+dsU9vasyPY+GxNMUlo4eUA3evCoLB8XEnp6pn61v9CV28
         Id/oORvPkvzZBBPWkCVkC+GTXn+gepgLuc71HxiNNN/xb9U4PEU1gMh5pMX7L6wlIP
         6cyi53mF2dwvmaJpZQLmia11iqjGISgA+/A8rGj4=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, joe@perches.com, skhan@linuxfoundation.org,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] IMA: Add log statements for failure conditions.
Date:   Tue, 11 Feb 2020 15:14:13 -0800
Message-Id: <20200211231414.6640-3-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211231414.6640-1-tusharsu@linux.microsoft.com>
References: <20200211231414.6640-1-tusharsu@linux.microsoft.com>
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
---
 security/integrity/ima/ima_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 9fe949c6a530..6e1576d9eb48 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -757,6 +757,9 @@ void process_buffer_measurement(const void *buf, int size,
 		ima_free_template_entry(entry);
 
 out:
+	if (ret < 0)
+		pr_err("%s: failed, result: %d\n", __func__, ret);
+
 	return;
 }
 
-- 
2.17.1

