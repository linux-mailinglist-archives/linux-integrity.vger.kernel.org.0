Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED77D696EC8
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Feb 2023 22:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjBNVAp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Feb 2023 16:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbjBNVAo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Feb 2023 16:00:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0CD2823B
        for <linux-integrity@vger.kernel.org>; Tue, 14 Feb 2023 13:00:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3D33821A01;
        Tue, 14 Feb 2023 21:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676408441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3GLxVLXyYH4+Xd+oEAaJtUiHvKOA8sWLpZi86XveBWI=;
        b=fBXpB//qgKKdikmDsfqPBG3rkoaHS9R8To19pG78z06QFE8dZyKf4nwL2RVvfH03UHixyU
        GW2AEsyLV2KQ2cmXr24Ph4NHQ/q0A8RN8Y8bNRXb4AyQ4vbQXu5BJYkd4Kesc8GApZN9js
        ErhctTkU9aV3O092GVo2dxha8ONywkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676408441;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3GLxVLXyYH4+Xd+oEAaJtUiHvKOA8sWLpZi86XveBWI=;
        b=9vvHMfo+LSXDbCyUXBfZR8Sag3K1afsUOZ9A8EMLL8UQlkQVTXJfivwWhAPBBbFZ56hFFP
        unWLlWc/ks0U9JCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC2AF13A21;
        Tue, 14 Feb 2023 21:00:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YFTDN3j262OqeAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 14 Feb 2023 21:00:40 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     dmitry.kasatkin@gmail.com, vt@altlinux.org, stefanb@linux.ibm.com,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Petr Vorel <petr.vorel@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>
Subject: [PATCH ima-evm-utils 3/3] github: Put openSSL build into own section
Date:   Tue, 14 Feb 2023 22:00:35 +0100
Message-Id: <20230214210035.585395-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214210035.585395-1-pvorel@suse.cz>
References: <20230214210035.585395-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Petr Vorel <petr.vorel@gmail.com>

That helps readability when reviewing logs.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Tested:
https://github.com/pevik/ima-evm-utils/actions/runs/4177976359/jobs/7236222413

 .github/workflows/ci.yml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index c76c70a..e3dcf3d 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -192,7 +192,12 @@ jobs:
         INSTALL="${INSTALL%%/*}"
         if [ "$VARIANT" ]; then ARCH="$ARCH" ./ci/$INSTALL.$VARIANT.sh; fi
         ARCH="$ARCH" CC="$CC" TSS="$TSS" ./ci/$INSTALL.sh
-        if [ "$COMPILE_SSL" ]; then COMPILE_SSL="$COMPILE_SSL" VARIANT="$VARIANT" ./tests/install-openssl3.sh; fi
+
+    - name: Build openSSL
+      run: |
+        if [ "$COMPILE_SSL" ]; then
+          COMPILE_SSL="$COMPILE_SSL" VARIANT="$VARIANT" ./tests/install-openssl3.sh; \
+        fi
 
     - name: Build swtpm
       run: |
-- 
2.39.1

