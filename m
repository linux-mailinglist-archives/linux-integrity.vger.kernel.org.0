Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E69423B85
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Oct 2021 12:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237890AbhJFKdA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Oct 2021 06:33:00 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38044 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhJFKc7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Oct 2021 06:32:59 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 154F920365;
        Wed,  6 Oct 2021 10:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633516267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=bhI8v0dWLz4v8mTrfH8TZlqOSCTA2uCpFWtGIM/0/vU=;
        b=KoCemSL3rVZ/f/MtybUr0MH1F1RkKIiCsMcSrCL3DsflFjW74kmsDyUXmIXuMhaL7kVpqL
        l+S0PaGeA6K5CjIGe7VcgjH2IiAgBnC8pHsYz2za45ukYTlhUNlO/dgBlZuzj+v3pv0r70
        +JVsvZ8mehGz4hxitkIeNe0Ck5eJ22U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633516267;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=bhI8v0dWLz4v8mTrfH8TZlqOSCTA2uCpFWtGIM/0/vU=;
        b=z3/0AXJGp64+5kSHcu7cSlh3Lcx4shuGPYcVYmL642YCsHt7u8bwkU9+ATC7bUL5kcLRAG
        R3dqnJgPvQzO3ZBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C0C6A13E19;
        Wed,  6 Oct 2021 10:31:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cSLHLOp6XWF/dAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 06 Oct 2021 10:31:06 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, Alex Henrie <alexh@vpitech.com>,
        alexhenrie24@gmail.com, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v8 0/3] IMA: Add tests for uid, gid, fowner, and fgroup options
Date:   Wed,  6 Oct 2021 12:30:56 +0200
Message-Id: <20211006103059.9617-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

changes v7->v8:
* Add missing ;; case separator

Alex Henrie (3):
  IMA: Move check_policy_writable() to ima_setup.sh and rename it
  IMA: Move ima_check to ima_setup.sh
  IMA: Add tests for uid, gid, fowner, and fgroup options

 runtest/ima                                   |  1 +
 .../integrity/ima/tests/ima_conditionals.sh   | 63 +++++++++++++++++++
 .../integrity/ima/tests/ima_measurements.sh   | 31 +--------
 .../integrity/ima/tests/ima_policy.sh         | 16 +----
 .../security/integrity/ima/tests/ima_setup.sh | 38 +++++++++++
 5 files changed, 107 insertions(+), 42 deletions(-)
 create mode 100755 testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh

-- 
2.33.0

