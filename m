Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E304220BCC9
	for <lists+linux-integrity@lfdr.de>; Sat, 27 Jun 2020 00:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgFZWjt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jun 2020 18:39:49 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37936 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgFZWjn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jun 2020 18:39:43 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id EE15120B4908;
        Fri, 26 Jun 2020 15:39:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EE15120B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1593211182;
        bh=lDUDSl/J2tMl17zuExKPD6HFUxjBs8GdZNpGG6MWTno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WekBJFwMheMIKbdKrLA71n4R1zeKG7X4smVnVlKG7hugGkAPMsp8x8Ew7R1+YEfac
         63BP0tUtg5iBBMqkjWqBBBtXu5RJjVQJLNHrPtlTTdNmJC3eC2k7CtWCYn3369FAWd
         SWaRS1p+xRshAazJYS0IAn2o+W1bWmHQSeJT6eM0=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 09/11] ima: Move validation of the keyrings conditional into ima_validate_rule()
Date:   Fri, 26 Jun 2020 17:38:58 -0500
Message-Id: <20200626223900.253615-10-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
References: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Use ima_validate_rule() to ensure that the combination of a hook
function and the keyrings conditional is valid and that the keyrings
conditional is not specified without an explicit KEY_CHECK func
conditional. This is a code cleanup and has no user-facing change.

Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---

* v2
  - Allowed IMA_DIGSIG_REQUIRED, IMA_PERMIT_DIRECTIO,
    IMA_MODSIG_ALLOWED, and IMA_CHECK_BLACKLIST conditionals to be
    present in the rule entry flags for non-buffer hook functions.

 security/integrity/ima/ima_policy.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 8cdca2399d59..43d49ad958fb 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1000,6 +1000,15 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 		case KEXEC_KERNEL_CHECK:
 		case KEXEC_INITRAMFS_CHECK:
 		case POLICY_CHECK:
+			if (entry->flags & ~(IMA_FUNC | IMA_MASK | IMA_FSMAGIC |
+					     IMA_UID | IMA_FOWNER | IMA_FSUUID |
+					     IMA_INMASK | IMA_EUID | IMA_PCR |
+					     IMA_FSNAME | IMA_DIGSIG_REQUIRED |
+					     IMA_PERMIT_DIRECTIO |
+					     IMA_MODSIG_ALLOWED |
+					     IMA_CHECK_BLACKLIST))
+				return false;
+
 			break;
 		case KEXEC_CMDLINE:
 			if (entry->action & ~(MEASURE | DONT_MEASURE))
@@ -1027,7 +1036,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 		default:
 			return false;
 		}
-	}
+	} else if (entry->flags & IMA_KEYRINGS)
+		return false;
 
 	return true;
 }
@@ -1209,7 +1219,6 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			keyrings_len = strlen(args[0].from) + 1;
 
 			if ((entry->keyrings) ||
-			    (entry->func != KEY_CHECK) ||
 			    (keyrings_len < 2)) {
 				result = -EINVAL;
 				break;
-- 
2.25.1

