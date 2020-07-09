Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFFD21987E
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Jul 2020 08:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgGIGU3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Jul 2020 02:20:29 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38148 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgGIGUQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Jul 2020 02:20:16 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3B7EE20B4908;
        Wed,  8 Jul 2020 23:20:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3B7EE20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594275615;
        bh=BMSHcV0geP8nXHQf+FFpMe4jNDRwHDKhciy8Y9r1M+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W8eLV97P7p0IM4hLJkbuHBItHUgBy+0JExAUlJYkp5ITVj9/c00A9U7e1CUhptlGe
         66bplnYDOKmdhx6SXsZLTj8eE2CNEU8q5ucpVitY+vtHoaIQEJUGzK1pmrT2jCV8Pv
         8FS1LSPf9KtgFE83S9DUi6KyViJdu4lgj2YT96cI=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v3 11/12] ima: Use the common function to detect LSM conditionals in a rule
Date:   Thu,  9 Jul 2020 01:19:10 -0500
Message-Id: <20200709061911.954326-12-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709061911.954326-1-tyhicks@linux.microsoft.com>
References: <20200709061911.954326-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Make broader use of ima_rule_contains_lsm_cond() to check if a given
rule contains an LSM conditional. This is a code cleanup and has no
user-facing change.

Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---

* v3
  - No change
* v2
  - No change

 security/integrity/ima/ima_policy.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index c4d0a0c1f896..81ee8fd1d83a 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -360,17 +360,10 @@ static bool ima_rule_contains_lsm_cond(struct ima_rule_entry *entry)
 static void ima_lsm_update_rules(void)
 {
 	struct ima_rule_entry *entry, *e;
-	int i, result, needs_update;
+	int result;
 
 	list_for_each_entry_safe(entry, e, &ima_policy_rules, list) {
-		needs_update = 0;
-		for (i = 0; i < MAX_LSM_RULES; i++) {
-			if (entry->lsm[i].args_p) {
-				needs_update = 1;
-				break;
-			}
-		}
-		if (!needs_update)
+		if (!ima_rule_contains_lsm_cond(entry))
 			continue;
 
 		result = ima_lsm_update_rule(entry);
-- 
2.25.1

