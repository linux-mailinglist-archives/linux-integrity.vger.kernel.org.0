Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086AA426674
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Oct 2021 11:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237487AbhJHJQr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 8 Oct 2021 05:16:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53662 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237588AbhJHJQo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Oct 2021 05:16:44 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BEC3E222CF;
        Fri,  8 Oct 2021 09:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633684488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ls/8dDLnJmODImTi/jhdtVtNwsMN4XukXZqZ7MTdDXE=;
        b=zQXDFJHrL5z7P00K2TyZHUJI944h0gZwxh+LFGEq/gUioNhaX9t1wKwSYdZyKH2oPF0I+Z
        E+Yz9+m16tplMljDL4iEUVaIdHe8d9uY+9pD95VYcVn1KVV5X6CacKtzZcDn4flVQ1vXSV
        m3OzgQ14CJHTJzQKurl9wCbiF1wCLjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633684488;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ls/8dDLnJmODImTi/jhdtVtNwsMN4XukXZqZ7MTdDXE=;
        b=SGFc657u3Umxkye0bpHWuwxZtrsO6NwuO8zf43wvFkySnuGoReyZGrsfhAja6T/rc888op
        IMfx6sXpP/LescDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8969F13D13;
        Fri,  8 Oct 2021 09:14:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sJnrHwgMYGHsewAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 08 Oct 2021 09:14:48 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Alex Henrie <alexh@vpitech.com>,
        alexhenrie24@gmail.com, Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v6 2/2] ima: Use strscpy instead of strlcpy
Date:   Fri,  8 Oct 2021 11:14:30 +0200
Message-Id: <20211008091430.22392-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211008091430.22392-1-pvorel@suse.cz>
References: <20211008091430.22392-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

strlcpy is deprecated, use its safer replacement.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 security/integrity/ima/ima_api.c    | 2 +-
 security/integrity/ima/ima_policy.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 2c6c3a5228b5..a64fb0130b01 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -403,7 +403,7 @@ const char *ima_d_path(const struct path *path, char **pathbuf, char *namebuf)
 	}
 
 	if (!pathname) {
-		strlcpy(namebuf, path->dentry->d_name.name, NAME_MAX);
+		strscpy(namebuf, path->dentry->d_name.name, NAME_MAX);
 		pathname = namebuf;
 	}
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index a4396967dce4..f136ef2b0225 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -866,7 +866,7 @@ static int __init ima_init_arch_policy(void)
 		char rule[255];
 		int result;
 
-		result = strlcpy(rule, *rules, sizeof(rule));
+		result = strscpy(rule, *rules, sizeof(rule));
 
 		INIT_LIST_HEAD(&arch_policy_entry[i].list);
 		result = ima_parse_rule(rule, &arch_policy_entry[i]);
-- 
2.33.0

