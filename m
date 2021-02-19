Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0A931F60A
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Feb 2021 09:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhBSIt2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Feb 2021 03:49:28 -0500
Received: from us2-ob3-3.mailhostbox.com ([208.91.199.218]:44415 "EHLO
        us2-ob3-3.mailhostbox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhBSItY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Feb 2021 03:49:24 -0500
X-Greylist: delayed 464 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Feb 2021 03:49:23 EST
Received: from g3.oswalpalash.com (unknown [49.36.75.42])
        (Authenticated sender: hello@oswalpalash.com)
        by us2.outbound.mailhostbox.com (Postfix) with ESMTPA id 18B5ED7950;
        Fri, 19 Feb 2021 08:40:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oswalpalash.com;
        s=20160715; t=1613724058;
        bh=w/MXL5PWmCp6/RiRm7vqAcjP+5e8CSmCtNdJkAowHAs=;
        h=Date:From:To:Subject;
        b=RUooY/WU58HYaVw2VLZRyGk0gPGIrnWEfh9vecP0GJ+iMAauzMJd/Q8hpLq0a0Wlz
         RGpymqgRDQqRhd7eLkq2GaGLQsfkaM4hbR6nVBpiAZAWYjbWbV0wMLrLedgt8IAiJS
         sbxFTnoOpYWp1Egb+dt0czPbuHun3PLDivZl6lsA=
Date:   Fri, 19 Feb 2021 14:10:38 +0530
From:   Palash Oswal <hello@oswalpalash.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ima: Replacing deprecated strlcpy with strscpy
Message-ID: <20210219084038.GA7564@g3.oswalpalash.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=R5t95uZX c=1 sm=1 tr=0
        a=CHsQ1LQruS7B59iI9LpjmQ==:117 a=CHsQ1LQruS7B59iI9LpjmQ==:17
        a=kj9zAlcOel0A:10 a=xUbBMDKt3BKPAhSvupEA:9 a=CjuIK1q_8ugA:10
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The strlcpy() function is unsafe in that the source buffer length
is unbounded or possibly be non NULL terminated. This can cause
memory over-reads, crashes, etc.

Link: https://github.com/KSPP/linux/issues/89
Signed-off-by: Palash Oswal <hello@oswalpalash.com>
---
 security/integrity/ima/ima_api.c    | 2 +-
 security/integrity/ima/ima_policy.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 1dd70dc68ffd..2f3b8257181d 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -399,7 +399,7 @@ const char *ima_d_path(const struct path *path, char **pathbuf, char *namebuf)
 	}
 
 	if (!pathname) {
-		strlcpy(namebuf, path->dentry->d_name.name, NAME_MAX);
+		strscpy(namebuf, path->dentry->d_name.name, NAME_MAX);
 		pathname = namebuf;
 	}
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 9b45d064a87d..010839aef6ba 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -791,7 +791,7 @@ static int __init ima_init_arch_policy(void)
 		char rule[255];
 		int result;
 
-		result = strlcpy(rule, *rules, sizeof(rule));
+		strscpy(rule, *rules, sizeof(rule));
 
 		INIT_LIST_HEAD(&arch_policy_entry[i].list);
 		result = ima_parse_rule(rule, &arch_policy_entry[i]);

base-commit: f6692213b5045dc461ce0858fb18cf46f328c202
-- 
2.27.0

