Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D9820BCC8
	for <lists+linux-integrity@lfdr.de>; Sat, 27 Jun 2020 00:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgFZWjt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jun 2020 18:39:49 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37900 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgFZWjk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jun 2020 18:39:40 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id B322D20B4905;
        Fri, 26 Jun 2020 15:39:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B322D20B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1593211180;
        bh=NgaFLRWS7qo3ujL0AXOQBEum655blqojaYopmjuWreY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TMlmjXk0FSfUS3DRx2rbvTApQ97nymuEYd2w1SK7TgThP+V41RqmU4Z20wPIc8pkr
         P/33ku1ExGN/cYx9Kc+qHlM4i5Z5o51b52HkECqtWNR1AL4dhZLJcAygDONh9dzScC
         RcmcidHdO+Wn0rMw2xLyQSp8mno3Zgb1qBauGVyk=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 07/11] ima: Shallow copy the args_p member of ima_rule_entry.lsm elements
Date:   Fri, 26 Jun 2020 17:38:56 -0500
Message-Id: <20200626223900.253615-8-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
References: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The args_p member is a simple string that is allocated by
ima_rule_init(). Shallow copy it like other non-LSM references in
ima_rule_entry structs.

There are no longer any necessary error path cleanups to do in
ima_lsm_copy_rule().

Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---

* v2
  - Adjusted context to account for ima_lsm_copy_rule() directly calling
    ima_lsm_free_rule() and the lack of explicit reference ownership
    transfers
  - Added comment to ima_lsm_copy_rule() to document the args_p
    reference ownership transfer

 security/integrity/ima/ima_policy.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index f9b1bdb897da..ef69c54266c6 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -300,10 +300,13 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 			continue;
 
 		nentry->lsm[i].type = entry->lsm[i].type;
-		nentry->lsm[i].args_p = kstrdup(entry->lsm[i].args_p,
-						GFP_KERNEL);
-		if (!nentry->lsm[i].args_p)
-			goto out_err;
+		nentry->lsm[i].args_p = entry->lsm[i].args_p;
+		/*
+		 * Remove the reference from entry so that the associated
+		 * memory will not be freed during a later call to
+		 * ima_lsm_free_rule(entry).
+		 */
+		entry->lsm[i].args_p = NULL;
 
 		security_filter_rule_init(nentry->lsm[i].type,
 					  Audit_equal,
@@ -314,11 +317,6 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 				(char *)entry->lsm[i].args_p);
 	}
 	return nentry;
-
-out_err:
-	ima_lsm_free_rule(nentry);
-	kfree(nentry);
-	return NULL;
 }
 
 static int ima_lsm_update_rule(struct ima_rule_entry *entry)
-- 
2.25.1

