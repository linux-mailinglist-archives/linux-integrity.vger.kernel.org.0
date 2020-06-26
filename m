Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100E620BCD5
	for <lists+linux-integrity@lfdr.de>; Sat, 27 Jun 2020 00:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgFZWkR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jun 2020 18:40:17 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37860 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgFZWji (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jun 2020 18:39:38 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4C9B220B4901;
        Fri, 26 Jun 2020 15:39:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4C9B220B4901
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1593211178;
        bh=D75oD57lun0GUBDulxMpvcNQCA9bpPWPblxeS6BsHiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SYNtdukF8WEuz0MozMQkGjt/TuIV1td+43ZBbQaQYfXdSMHB7c7JnasCv+ABi4s58
         Yrs4vxRExlI6ToqPUWxi7kFrS73ra+bGLwRG4feO1XSnsul1fTAWcFptNfUuRJ6Mse
         h6TVINC7vEgxKpaYPE5Xe0zsQta2Rwrv8rax/mYY=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 05/11] ima: Fail rule parsing when the KEXEC_CMDLINE hook is combined with an invalid cond
Date:   Fri, 26 Jun 2020 17:38:54 -0500
Message-Id: <20200626223900.253615-6-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
References: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
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
---

* v2
  - Added Mimi's Reviewed-by

 security/integrity/ima/ima_policy.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 166124d67774..676d5557af1a 100644
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
@@ -993,6 +1004,16 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 		case POLICY_CHECK:
 			break;
 		case KEXEC_CMDLINE:
+			if (entry->action & ~(MEASURE | DONT_MEASURE))
+				return false;
+
+			if (entry->flags & ~(IMA_FUNC | IMA_PCR))
+				return false;
+
+			if (ima_rule_contains_lsm_cond(entry))
+				return false;
+
+			break;
 		case KEY_CHECK:
 			if (entry->action & ~(MEASURE | DONT_MEASURE))
 				return false;
-- 
2.25.1

