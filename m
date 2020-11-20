Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B772BB2CB
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Nov 2020 19:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgKTSZm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Nov 2020 13:25:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:47092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728416AbgKTSZm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Nov 2020 13:25:42 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 812CB2224C;
        Fri, 20 Nov 2020 18:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605896741;
        bh=AiYFtsLjV0u9Bb2aXIHKzTabREy1yEWQo6B0+R+mk5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nZiiEaONGZCiRQd8Tg2KbZLlgvo9NPq72Wj693BLQERiQm+K6VEm5pdegEukxEOH9
         DJSL6tYSn61KBlNMAC8dBHW4pbbSDOarsmqdvAeYEohbhdk/egvhF/xbVz/o2i/5Qp
         XJ0nHsyaV0XWPvJHDHwrkqVlalxeBwc+0Q4QDmIE=
Date:   Fri, 20 Nov 2020 12:25:46 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 010/141] ima: Fix fall-through warnings for Clang
Message-ID: <ae416f97079da13568026228d930e9e59118cc4c.1605896059.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
warnings by explicitly adding multiple break statements instead of just
letting the code fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 security/integrity/ima/ima_main.c   | 1 +
 security/integrity/ima/ima_policy.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 2d1af8899cab..600b97677085 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -743,6 +743,7 @@ int ima_load_data(enum kernel_load_data_id id, bool contents)
 			pr_err("impossible to appraise a module without a file descriptor. sig_enforce kernel parameter might help\n");
 			return -EACCES;	/* INTEGRITY_UNKNOWN */
 		}
+		break;
 	default:
 		break;
 	}
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 9b5adeaa47fc..ea634fc3b82f 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -566,6 +566,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 			rc = ima_filter_rule_match(secid, rule->lsm[i].type,
 						   Audit_equal,
 						   rule->lsm[i].rule);
+			break;
 		default:
 			break;
 		}
@@ -802,6 +803,7 @@ void __init ima_init_policy(void)
 		add_rules(default_measurement_rules,
 			  ARRAY_SIZE(default_measurement_rules),
 			  IMA_DEFAULT_POLICY);
+		break;
 	default:
 		break;
 	}
-- 
2.27.0

