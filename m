Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5350F219872
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Jul 2020 08:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgGIGUP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Jul 2020 02:20:15 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38110 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbgGIGUN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Jul 2020 02:20:13 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6076D20B4908;
        Wed,  8 Jul 2020 23:20:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6076D20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594275613;
        bh=b/gDO+rf9EfxqDQma9/U3xASpX0quKJnLQDBOzf+I4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KJKtKRLUoa5UEYM0CWjDMPyGH0lii/OV71RzS5iuN2qnZhRPXaExoAD/Gfw/Yc4hb
         ScuFZ46zLV61LaA/TtWMBdCXHfKDDy9SB2BhQV9ody45FZbuFU+qJ1IQfrLPuZXwRT
         K90uNkcAvqV9QUJsDKTUpWOMkF9gq82xm9+LxGo8=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v3 09/12] ima: Use correct type for the args_p member of ima_rule_entry.lsm elements
Date:   Thu,  9 Jul 2020 01:19:08 -0500
Message-Id: <20200709061911.954326-10-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709061911.954326-1-tyhicks@linux.microsoft.com>
References: <20200709061911.954326-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Make args_p be of the char pointer type rather than have it be a void
pointer that gets casted to char pointer when it is used. It is a simple
NUL-terminated string as returned by match_strdup().

Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---

* v3
  - No change
* v2
  - No change

 security/integrity/ima/ima_policy.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index b02e1ffd10c9..13a178c70b44 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -74,7 +74,7 @@ struct ima_rule_entry {
 	int pcr;
 	struct {
 		void *rule;	/* LSM file metadata specific */
-		void *args_p;	/* audit value */
+		char *args_p;	/* audit value */
 		int type;	/* audit type */
 	} lsm[MAX_LSM_RULES];
 	char *fsname;
@@ -314,7 +314,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 					  &nentry->lsm[i].rule);
 		if (!nentry->lsm[i].rule)
 			pr_warn("rule for LSM \'%s\' is undefined\n",
-				(char *)entry->lsm[i].args_p);
+				entry->lsm[i].args_p);
 	}
 	return nentry;
 }
@@ -918,7 +918,7 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 					   &entry->lsm[lsm_rule].rule);
 	if (!entry->lsm[lsm_rule].rule) {
 		pr_warn("rule for LSM \'%s\' is undefined\n",
-			(char *)entry->lsm[lsm_rule].args_p);
+			entry->lsm[lsm_rule].args_p);
 
 		if (ima_rules == &ima_default_rules) {
 			kfree(entry->lsm[lsm_rule].args_p);
@@ -1682,27 +1682,27 @@ int ima_policy_show(struct seq_file *m, void *v)
 			switch (i) {
 			case LSM_OBJ_USER:
 				seq_printf(m, pt(Opt_obj_user),
-					   (char *)entry->lsm[i].args_p);
+					   entry->lsm[i].args_p);
 				break;
 			case LSM_OBJ_ROLE:
 				seq_printf(m, pt(Opt_obj_role),
-					   (char *)entry->lsm[i].args_p);
+					   entry->lsm[i].args_p);
 				break;
 			case LSM_OBJ_TYPE:
 				seq_printf(m, pt(Opt_obj_type),
-					   (char *)entry->lsm[i].args_p);
+					   entry->lsm[i].args_p);
 				break;
 			case LSM_SUBJ_USER:
 				seq_printf(m, pt(Opt_subj_user),
-					   (char *)entry->lsm[i].args_p);
+					   entry->lsm[i].args_p);
 				break;
 			case LSM_SUBJ_ROLE:
 				seq_printf(m, pt(Opt_subj_role),
-					   (char *)entry->lsm[i].args_p);
+					   entry->lsm[i].args_p);
 				break;
 			case LSM_SUBJ_TYPE:
 				seq_printf(m, pt(Opt_subj_type),
-					   (char *)entry->lsm[i].args_p);
+					   entry->lsm[i].args_p);
 				break;
 			}
 			seq_puts(m, " ");
-- 
2.25.1

