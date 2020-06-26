Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C1420BCC2
	for <lists+linux-integrity@lfdr.de>; Sat, 27 Jun 2020 00:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgFZWjt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jun 2020 18:39:49 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37918 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgFZWjm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jun 2020 18:39:42 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id D458C20B4907;
        Fri, 26 Jun 2020 15:39:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D458C20B4907
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1593211181;
        bh=pFH0+7shWtBIUXAmbHtVKgktKeESMvnpMqcT4wbOKOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f7hcNvHDSHVz89ZYcTH8jm/9afQX8d2xQHOymnOCi8MW2q3iziXSWxRIqVU82cCgx
         k00c3DtUTLZGu8CBpzcsJsPyUV3oAbOyUe1Irxj3eWlEvraFkb5pbK3V1U/BOtklnw
         GJI5ljgnWFCuty17kaOGHNS0pdOxiYdYsQkyQuqo=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 08/11] ima: Use correct type for the args_p member of ima_rule_entry.lsm elements
Date:   Fri, 26 Jun 2020 17:38:57 -0500
Message-Id: <20200626223900.253615-9-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
References: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
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

* v2
  - No change

 security/integrity/ima/ima_policy.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index ef69c54266c6..8cdca2399d59 100644
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
@@ -1667,27 +1667,27 @@ int ima_policy_show(struct seq_file *m, void *v)
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

