Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBB2204596
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2020 02:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732028AbgFWAe3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Jun 2020 20:34:29 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47580 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732021AbgFWAe2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jun 2020 20:34:28 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 890B420B7192;
        Mon, 22 Jun 2020 17:34:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 890B420B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1592872467;
        bh=Y5ysTcnc8ex1gbvAHEo/9BZnD1yJjGDPGX41BGpYbwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MN1AOiW9ETq4J8oKSAivyX2LFGyYaKssqDKG5oDCFNV0m108t66VbR27VYwz+OmhJ
         L6sJptsPbR1Q17toW+SnS+5RZDpzZSx9R+vXadGFjWQVquiawt8FUW5G4HEZosyD/x
         Xo/EgmKKf9ngpFzm5hZKPmWzpxw8IiIcosPnC2FQ=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 10/12] ima: Move validation of the keyrings conditional into ima_validate_rule()
Date:   Mon, 22 Jun 2020 19:32:34 -0500
Message-Id: <20200623003236.830149-11-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623003236.830149-1-tyhicks@linux.microsoft.com>
References: <20200623003236.830149-1-tyhicks@linux.microsoft.com>
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
 security/integrity/ima/ima_policy.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 514baf24d6a5..ae2ec2a9cdb9 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -999,6 +999,12 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 		case KEXEC_KERNEL_CHECK:
 		case KEXEC_INITRAMFS_CHECK:
 		case POLICY_CHECK:
+			if (entry->flags & ~(IMA_FUNC | IMA_MASK | IMA_FSMAGIC |
+					     IMA_UID | IMA_FOWNER | IMA_FSUUID |
+					     IMA_INMASK | IMA_EUID | IMA_PCR |
+					     IMA_FSNAME))
+				return false;
+
 			break;
 		case KEXEC_CMDLINE:
 			if (entry->action & ~(MEASURE | DONT_MEASURE))
@@ -1026,7 +1032,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 		default:
 			return false;
 		}
-	}
+	} else if (entry->flags & IMA_KEYRINGS)
+		return false;
 
 	return true;
 }
@@ -1208,7 +1215,6 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			keyrings_len = strlen(args[0].from) + 1;
 
 			if ((entry->keyrings) ||
-			    (entry->func != KEY_CHECK) ||
 			    (keyrings_len < 2)) {
 				result = -EINVAL;
 				break;
-- 
2.25.1

