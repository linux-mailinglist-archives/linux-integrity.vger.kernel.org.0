Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F117A219882
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Jul 2020 08:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgGIGUF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Jul 2020 02:20:05 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38020 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgGIGUE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Jul 2020 02:20:04 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5A5A120B490A;
        Wed,  8 Jul 2020 23:20:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5A5A120B490A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594275604;
        bh=z5BEppbXhpdSAyDudc6kYWlfCNHPdX4otoJgm257sFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aJKK1MaGaR61+T37x4NLFrTDg7UzgxY0bbvDNRKTeO0N00x56mP6ZuB9w0Ri0uvr3
         UxXXsGpThVKOY+Fz0po2J1zTGi76glRbydOf7jY8ne+uemlI5bKRPSJOMuzCC0nvtG
         f/VeQXvFJkeUU50VyYVvW8MN0JKJlcRS1202n82w=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v3 05/12] ima: Fail rule parsing when the KEXEC_CMDLINE hook is combined with an invalid cond
Date:   Thu,  9 Jul 2020 01:19:04 -0500
Message-Id: <20200709061911.954326-6-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709061911.954326-1-tyhicks@linux.microsoft.com>
References: <20200709061911.954326-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The KEXEC_CMDLINE hook function only supports the pcr conditional. Make
this clear at policy load so that IMA policy authors don't assume that
other conditionals are supported.

Since KEXEC_CMDLINE's inception, ima_match_rules() has always returned
true on any loaded KEXEC_CMDLINE rule without any consideration for
other conditionals present in the rule. Make it clear that pcr is the
only supported KEXEC_CMDLINE conditional by returning an error during
policy load.

An example of why this is a problem can be explained with the following
rule:

 dont_measure func=KEXEC_CMDLINE obj_type=foo_t

An IMA policy author would have assumed that rule is valid because the
parser accepted it but the result was that measurements for all
KEXEC_CMDLINE operations would be disabled.

Fixes: b0935123a183 ("IMA: Define a new hook to measure the kexec boot command line arguments")
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---

* v3
  - Adjust for the indentation change introduced in patch #4
  - Added Lakshmi's Reviewed-by
* v2
  - Added Mimi's Reviewed-by

 security/integrity/ima/ima_policy.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 40c28f1a6a5a..1c64bd6f1728 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -343,6 +343,17 @@ static int ima_lsm_update_rule(struct ima_rule_entry *entry)
 	return 0;
 }
 
+static bool ima_rule_contains_lsm_cond(struct ima_rule_entry *entry)
+{
+	int i;
+
+	for (i = 0; i < MAX_LSM_RULES; i++)
+		if (entry->lsm[i].args_p)
+			return true;
+
+	return false;
+}
+
 /*
  * The LSM policy can be reloaded, leaving the IMA LSM based rules referring
  * to the old, stale LSM policy.  Update the IMA LSM based rules to reflect
@@ -998,6 +1009,16 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 		/* Validation of these hook functions is in ima_parse_rule() */
 		break;
 	case KEXEC_CMDLINE:
+		if (entry->action & ~(MEASURE | DONT_MEASURE))
+			return false;
+
+		if (entry->flags & ~(IMA_FUNC | IMA_PCR))
+			return false;
+
+		if (ima_rule_contains_lsm_cond(entry))
+			return false;
+
+		break;
 	case KEY_CHECK:
 		if (entry->action & ~(MEASURE | DONT_MEASURE))
 			return false;
-- 
2.25.1

