Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA4C496317
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jan 2022 17:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiAUQry (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Jan 2022 11:47:54 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:59234 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349736AbiAUQrx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Jan 2022 11:47:53 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EBC2B1F37D;
        Fri, 21 Jan 2022 16:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642783672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=b1um77LyIcT3kM+QPiOLu37uASdtw6FsdVH7aECFnuA=;
        b=bJrLu6RSki4vChpBtV2o+GhFMdLYBr5Q5DiT2dM+2fBcGJlAA1i28mN+C5pjIRV71ewGid
        /fy8kvERFWWWZhL9vK7CSfCKslCMv8JseCJFLGxQ+z6rC9PaFU32JE38kSWykfGMGYaBvs
        IaVy5E5BiQ90o7H8ks/EuA5CRohEHM8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642783672;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=b1um77LyIcT3kM+QPiOLu37uASdtw6FsdVH7aECFnuA=;
        b=Ag1IBhvMOwuKSipCp5fUYojnEE98Csp1jv/3nu3Yh581WmuSIVSRFKVOWMuU0W7oH05MKx
        gZIq8/qzqwloVbCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B87E913A66;
        Fri, 21 Jan 2022 16:47:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zg3UKbjj6mFrLAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 21 Jan 2022 16:47:52 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <petr.vorel@gmail.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v3 1/1] ci/travis: Replace groovy -> impish
Date:   Fri, 21 Jan 2022 17:47:48 +0100
Message-Id: <20220121164748.6536-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Petr Vorel <petr.vorel@gmail.com>

follow previous commit also for Travis.

Fixes: 024c02d ("ci: Replace groovy -> impish")

Reported-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
Update only for Travis, as previous patch has been merged.

Kind regards,
Petr

 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 534c41d..bdf78a1 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -40,7 +40,7 @@ matrix:
           compiler: gcc
 
         - os: linux
-          env: DISTRO=ubuntu:groovy TSS=ibmtss COMPILE_SSL=openssl-3.0.0-beta1
+          env: DISTRO=ubuntu:impish TSS=ibmtss COMPILE_SSL=openssl-3.0.0-beta1
           compiler: gcc
 
         - os: linux
-- 
2.34.1

