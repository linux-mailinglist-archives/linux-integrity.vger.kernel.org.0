Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD5F155EF1
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2020 20:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgBGTx6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Feb 2020 14:53:58 -0500
Received: from linux.microsoft.com ([13.77.154.182]:34366 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgBGTx5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Feb 2020 14:53:57 -0500
Received: from tusharsu-Ubuntu.corp.microsoft.com (unknown [131.107.147.225])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2658620B9C2F;
        Fri,  7 Feb 2020 11:53:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2658620B9C2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1581105237;
        bh=Wab1wguScTHzyucAMlQCj1mKaKzqP1xmnn185QvjsKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZLirIX/+w1TwBojZeVAPRJrlBrd9uVHI3mOygG8PkXqz9Mwc6MVyjXMZRtjWLbFqY
         tBcUxhyMnGrZaRWKqbN6BACT0NAGhV58vBJdPZ0xUYZp002svVWlTqvDZqr8EiblGE
         wYTiDg4G6HG4KUbsXkKb6KXBDuRuo6brhDJgCNkg=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] IMA: Add log statements for failure conditions.
Date:   Fri,  7 Feb 2020 11:53:46 -0800
Message-Id: <20200207195346.4017-2-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200207195346.4017-1-tusharsu@linux.microsoft.com>
References: <20200207195346.4017-1-tusharsu@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

process_buffer_measurement() and ima_alloc_key_entry()
functions do not have log messages for failure conditions.

This change adds log statements in the above functions. 

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_main.c       | 4 ++++
 security/integrity/ima/ima_queue_keys.c | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 9fe949c6a530..afab796fb765 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -757,6 +757,10 @@ void process_buffer_measurement(const void *buf, int size,
 		ima_free_template_entry(entry);
 
 out:
+	if (ret < 0)
+		pr_err("Process buffer measurement failed, result: %d\n",
+			ret);
+
 	return;
 }
 
diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
index c87c72299191..2cc52f17ea81 100644
--- a/security/integrity/ima/ima_queue_keys.c
+++ b/security/integrity/ima/ima_queue_keys.c
@@ -90,6 +90,8 @@ static struct ima_key_entry *ima_alloc_key_entry(struct key *keyring,
 
 out:
 	if (rc) {
+		pr_err("Key entry allocation failed, result: %d\n",
+			rc);
 		ima_free_key_entry(entry);
 		entry = NULL;
 	}
-- 
2.17.1

