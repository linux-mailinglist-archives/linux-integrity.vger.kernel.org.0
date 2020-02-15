Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81D3015FC3C
	for <lists+linux-integrity@lfdr.de>; Sat, 15 Feb 2020 02:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgBOBsN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 14 Feb 2020 20:48:13 -0500
Received: from linux.microsoft.com ([13.77.154.182]:57484 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbgBOBrt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Feb 2020 20:47:49 -0500
Received: from tusharsu-Ubuntu.corp.microsoft.com (unknown [131.107.147.225])
        by linux.microsoft.com (Postfix) with ESMTPSA id 46079200889D;
        Fri, 14 Feb 2020 17:47:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 46079200889D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1581731269;
        bh=gheApcamLsI0c+q9A7msGcmf+VN3q+eHMy9K2vxEMxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hvL1YLAhKmpNI7mEI19hcJDdmGUUbDOr1E0nINyUnuTAelZg7MI4mw9ONe+DseXpJ
         2j8geTps/l9pkUN8H2guZcjxJs/zOUoBJAAST1hhtqkQ98ssNKLVxrL3epXttrtH1O
         fXtOsyTIF57B3D1KdNfH49IfOEQRN2SbQQ/qMLbk=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, joe@perches.com, skhan@linuxfoundation.org,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3]  IMA: Add log statements for failure conditions
Date:   Fri, 14 Feb 2020 17:47:08 -0800
Message-Id: <20200215014709.3006-3-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200215014709.3006-1-tusharsu@linux.microsoft.com>
References: <20200215014709.3006-1-tusharsu@linux.microsoft.com>
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

