Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DF1219888
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Jul 2020 08:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgGIGUL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Jul 2020 02:20:11 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38084 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgGIGUK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Jul 2020 02:20:10 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5EFC920B4908;
        Wed,  8 Jul 2020 23:20:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5EFC920B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594275610;
        bh=swamC2p17c6UKzr2WevLUTCfz2mHFf5f2mrMDFbXG8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rRADIsmhSYlLAiAJQcVPCqnYL6wmzgpKYtO/Dz5lZF93n2jW9H5eYRZN5lngLAYUH
         VUKbzAf1KQ7TTYCPIFqUtM/dCJT/3wf1FN3/h4R8i0M2wcUTIwm0gCYjbmiupKmW+l
         JyRbR4xc18NzQUyh4ecdxDFUsXfJj1tG5xQotZHQ=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v3 07/12] ima: Fail rule parsing when appraise_flag=blacklist is unsupportable
Date:   Thu,  9 Jul 2020 01:19:06 -0500
Message-Id: <20200709061911.954326-8-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709061911.954326-1-tyhicks@linux.microsoft.com>
References: <20200709061911.954326-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The "appraise_flag" option is only appropriate for appraise actions
and its "blacklist" value is only appropriate when
CONFIG_IMA_APPRAISE_MODSIG is enabled and "appraise_flag=blacklist" is
only appropriate when "appraise_type=imasig|modsig" is also present.
Make this clear at policy load so that IMA policy authors don't assume
that other uses of "appraise_flag=blacklist" are supported.

Fixes: 273df864cf74 ("ima: Check against blacklisted hashes for files with modsig")
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
Cc: Nayna Jain <nayna@linux.ibm.com>
---

* v3
  - New patch

 security/integrity/ima/ima_policy.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 81da02071d41..9842e2e0bc6d 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1035,6 +1035,11 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 		return false;
 	}
 
+	/* Ensure that combinations of flags are compatible with each other */
+	if (entry->flags & IMA_CHECK_BLACKLIST &&
+	    !(entry->flags & IMA_MODSIG_ALLOWED))
+		return false;
+
 	return true;
 }
 
@@ -1371,8 +1376,14 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				result = -EINVAL;
 			break;
 		case Opt_appraise_flag:
+			if (entry->action != APPRAISE) {
+				result = -EINVAL;
+				break;
+			}
+
 			ima_log_string(ab, "appraise_flag", args[0].from);
-			if (strstr(args[0].from, "blacklist"))
+			if (IS_ENABLED(CONFIG_IMA_APPRAISE_MODSIG) &&
+			    strstr(args[0].from, "blacklist"))
 				entry->flags |= IMA_CHECK_BLACKLIST;
 			break;
 		case Opt_permit_directio:
-- 
2.25.1

