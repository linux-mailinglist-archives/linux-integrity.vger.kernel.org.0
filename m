Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034F5426673
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Oct 2021 11:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237945AbhJHJQq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 8 Oct 2021 05:16:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53648 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236616AbhJHJQo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Oct 2021 05:16:44 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7F41F222C3;
        Fri,  8 Oct 2021 09:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633684488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VfUeqCsfcq0GuHbADZdhhZqgK6g4eNDE2g2XDL5vLyQ=;
        b=x8IBcuFHUOsU2/QAczgIoPZvjnJmMKGYltLzlt58xN3pxZQGvVVNLYPMemovqr3sDO+nUN
        QVydkyUspUCZOcn/h3b8zFhOw3XJFrR6cunjOYLPd6IAs6o9livblj010FidVzBgKjtcNr
        22or6nrjpMFrTDTfLbAgbqtJw8wnEnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633684488;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VfUeqCsfcq0GuHbADZdhhZqgK6g4eNDE2g2XDL5vLyQ=;
        b=ubGNUhHChq9wMNBRMHnyA0bRQRvZf1/Ibirt8hfXXPMcCXpdxTYMkxBmxDTZInqVgfq8c8
        iNfNZDla4q9WfPAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 363BD13EAC;
        Fri,  8 Oct 2021 09:14:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WDM3CwgMYGHsewAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 08 Oct 2021 09:14:48 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Alex Henrie <alexh@vpitech.com>,
        alexhenrie24@gmail.com, Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v6 1/2] ima_policy: Remove duplicate 'the' in docs comment
Date:   Fri,  8 Oct 2021 11:14:29 +0200
Message-Id: <20211008091430.22392-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211008091430.22392-1-pvorel@suse.cz>
References: <20211008091430.22392-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Also join string (short enough to be on single line).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 security/integrity/ima/ima_policy.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index ad3c2af5f163..a4396967dce4 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -885,8 +885,7 @@ static int __init ima_init_arch_policy(void)
 /**
  * ima_init_policy - initialize the default measure rules.
  *
- * ima_rules points to either the ima_default_rules or the
- * the new ima_policy_rules.
+ * ima_rules points to either the ima_default_rules or the new ima_policy_rules.
  */
 void __init ima_init_policy(void)
 {
-- 
2.33.0

