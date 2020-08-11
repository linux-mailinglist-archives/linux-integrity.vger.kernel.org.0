Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47BC24203F
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Aug 2020 21:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgHKT0s (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Aug 2020 15:26:48 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44148 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgHKT0s (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Aug 2020 15:26:48 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 277AD20B4908;
        Tue, 11 Aug 2020 12:26:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 277AD20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597174007;
        bh=jJ2rgICpl7Ac8oj5RgbaV+jcSTEuj2wOFf50Lb2rAUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l51wiNdGi8pI/2ncryg66PgtYZzWL2/t5aAvy/pkofTt061C9sCIth86D0pAWX2mU
         dWd5TtUkYfs2QSCz6naMLnNfPILoREyX9UptZPz+XzwqO9SorxiW9V8vbO3FpnRk3D
         hgA5sqkOogvZEy1gfNUNzK7kAkv1PLBiUuIEvR00=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Nayna Jain <nayna@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 2/2] ima: Fail rule parsing when asymmetric key measurement isn't supportable
Date:   Tue, 11 Aug 2020 14:26:21 -0500
Message-Id: <20200811192621.281675-3-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200811192621.281675-1-tyhicks@linux.microsoft.com>
References: <20200811192621.281675-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Measuring keys is currently only supported for asymmetric keys. In the
future, this might change.

For now, the "func=KEY_CHECK" and "keyrings=" options are only
appropriate when CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS is enabled. Make
this clear at policy load so that IMA policy authors don't assume that
these policy language constructs are supported.

Fixes: 2b60c0ecedf8 ("IMA: Read keyrings= option from the IMA policy")
Fixes: 5808611cccb2 ("IMA: Add KEY_CHECK func to measure keys")
Suggested-by: Nayna Jain <nayna@linux.ibm.com>
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_policy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index ea224f00b305..fe1df373c113 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1233,7 +1233,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->func = POLICY_CHECK;
 			else if (strcmp(args[0].from, "KEXEC_CMDLINE") == 0)
 				entry->func = KEXEC_CMDLINE;
-			else if (strcmp(args[0].from, "KEY_CHECK") == 0)
+			else if (IS_ENABLED(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) &&
+				 strcmp(args[0].from, "KEY_CHECK") == 0)
 				entry->func = KEY_CHECK;
 			else
 				result = -EINVAL;
@@ -1290,7 +1291,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 		case Opt_keyrings:
 			ima_log_string(ab, "keyrings", args[0].from);
 
-			if (entry->keyrings) {
+			if (!IS_ENABLED(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) ||
+			    entry->keyrings) {
 				result = -EINVAL;
 				break;
 			}
-- 
2.25.1

