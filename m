Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73FB22F277
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Jul 2020 16:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733023AbgG0OkC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jul 2020 10:40:02 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53218 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbgG0OJU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jul 2020 10:09:20 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1D0C420B490C;
        Mon, 27 Jul 2020 07:09:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1D0C420B490C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595858959;
        bh=TojaKA1D2bkgSvEtbI6kYJOINajUXiJCFMf+z5sO/JQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lz5Tn0sm1IzQZ1ivUGl55HsNtgLm9JrFalLP6KB8PaOGy/cMdp//VBy2HXc3Kvj8e
         513MuEEb5DlQ32PSGav+mjEkH0LFKHp7NdtnSxjQ9/s+EIlXcGDy8kLQc9eJiAMn/t
         Hyu2V1PUciKf3kn07uOQVVZsHW09V9z4pxJ8H+uo=
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
Subject: [PATCH 2/2] ima: Fail rule parsing when asymmetric key measurement isn't supportable
Date:   Mon, 27 Jul 2020 09:08:31 -0500
Message-Id: <20200727140831.64251-3-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200727140831.64251-1-tyhicks@linux.microsoft.com>
References: <20200727140831.64251-1-tyhicks@linux.microsoft.com>
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
---
 security/integrity/ima/ima_policy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index c328cfa0fc49..05f012fd3dca 100644
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

