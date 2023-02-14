Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CCF696EC6
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Feb 2023 22:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjBNVAn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Feb 2023 16:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjBNVAn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Feb 2023 16:00:43 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D1928235
        for <linux-integrity@vger.kernel.org>; Tue, 14 Feb 2023 13:00:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 81DEA21A00;
        Tue, 14 Feb 2023 21:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676408440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TYcJm+mUzwv//7qeypwELJys5BsZ8uqh8Zo88thCzq0=;
        b=Ow/MSTXm37PvJJ+A1Pxjr43VyPAxHuInXRNMCv0jtY3NBlLw3qU7TczB9nkO3SkuhmhgB+
        tHsbXOz+dlnbVvtj1U9dSjkmcaPpaNlbKL+dNTDAcstkFV/4bar/pG/wOX0IFndUViLsz7
        hwP4CsodA5fgOT28h5jbW3Is4+O9jUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676408440;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TYcJm+mUzwv//7qeypwELJys5BsZ8uqh8Zo88thCzq0=;
        b=7e2sO5R0SCHTZCbvW3AXXajetxkaOwIFxMQ1QwZuFe+kETEdz1y/B3KSDdHt4FzcdVOQNS
        1yJyR0UMuwb8a/Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 29FAA13A21;
        Tue, 14 Feb 2023 21:00:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kKmVCHj262OqeAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 14 Feb 2023 21:00:40 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     dmitry.kasatkin@gmail.com, vt@altlinux.org, stefanb@linux.ibm.com,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Petr Vorel <petr.vorel@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>
Subject: [PATCH ima-evm-utils 1/3] tests/install-swtpm.sh: Update ibmswtpm2 to 1682
Date:   Tue, 14 Feb 2023 22:00:33 +0100
Message-Id: <20230214210035.585395-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214210035.585395-1-pvorel@suse.cz>
References: <20230214210035.585395-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Petr Vorel <petr.vorel@gmail.com>

At least on Tumbleweed build fails due openSSL 3.0.7
being installed from package.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Tested:
https://github.com/pevik/ima-evm-utils/actions/runs/4177940689

 tests/install-swtpm.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/install-swtpm.sh b/tests/install-swtpm.sh
index 51aa377..de9b5c7 100755
--- a/tests/install-swtpm.sh
+++ b/tests/install-swtpm.sh
@@ -9,7 +9,7 @@ else
 	SUDO=sudo
 fi
 
-version=1637
+version=1682
 
 wget --no-check-certificate https://sourceforge.net/projects/ibmswtpm2/files/ibmtpm${version}.tar.gz/download
 mkdir ibmtpm$version
-- 
2.39.1

