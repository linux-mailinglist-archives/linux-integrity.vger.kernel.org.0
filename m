Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9778267BC5D
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jan 2023 21:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbjAYUME (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Jan 2023 15:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236389AbjAYUL6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Jan 2023 15:11:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233EA5D11D
        for <linux-integrity@vger.kernel.org>; Wed, 25 Jan 2023 12:11:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55734B81B9F
        for <linux-integrity@vger.kernel.org>; Wed, 25 Jan 2023 20:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E39C4339B
        for <linux-integrity@vger.kernel.org>; Wed, 25 Jan 2023 20:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674677482;
        bh=Ei9wz/tRgDjf7mRNrozJSS7N6OMP6SE/RPl8qRYpDkM=;
        h=From:To:Subject:Date:From;
        b=cXVcZMNjHQwEO+VQnlKIQCOFFCDJCi3O6BSUHTqNK4gGY5ry8+2zh9xMfQwLst0b/
         beh2md1vPPj4EqiH9VF3maFaqYxnFwtroeCOgVAPqE4ODwIaCn4tYFYeyGTIKJ/xop
         thfX0FYn4+WDFppNfXGToPoqiFHS+SWM8+Q7+e5LgHmYKs9/iHtCDu9OhrWW2AfODY
         NqvaaOnu0rPh0N6aOuJNdzyYad++YWW3es4Cby1vx5kqRMqeS4IOkeXgEQG8ClciDV
         8dJfrnrvqEjbH3/+J74EYqvqm1SDs64N8E/WpHqVF07vhBvZr9IwlPNN+AundlwjAJ
         RaBRBT3ehtEIw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-integrity@vger.kernel.org
Subject: [ima-evm-utils PATCH] tests: use new git repo URL for fsverity-utils
Date:   Wed, 25 Jan 2023 12:10:33 -0800
Message-Id: <20230125201033.24145-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

See the announcement at "[ANNOUNCE] Moving the fsverity-utils git repo"
(https://lore.kernel.org/r/Y9GKm+hcm70myZkr@sol.localdomain).

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tests/install-fsverity.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/install-fsverity.sh b/tests/install-fsverity.sh
index 418fc42..051075f 100755
--- a/tests/install-fsverity.sh
+++ b/tests/install-fsverity.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-git clone https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/fsverity-utils.git
+git clone https://git.kernel.org/pub/scm/fs/fsverity/fsverity-utils.git
 cd fsverity-utils
 CC=gcc make -j$(nproc) && sudo make install
 cd ..

base-commit: 8ecded5683f2b1d96119f1c9ccd74107e96e0656
-- 
2.39.1

