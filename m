Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973D66F3BBC
	for <lists+linux-integrity@lfdr.de>; Tue,  2 May 2023 03:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjEBBQK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 May 2023 21:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjEBBQJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 May 2023 21:16:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C27A3A9C;
        Mon,  1 May 2023 18:16:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9731861BFD;
        Tue,  2 May 2023 01:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA18C433EF;
        Tue,  2 May 2023 01:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682990167;
        bh=mpizqtC9n7gms+NgcPrguFcPPmQI6Fuzo7V2f0cMDa4=;
        h=From:To:Cc:Subject:Date:From;
        b=RzXIqAlcvmLbZKzQCurP61KJBmXAQpcTUBtXyghMwpEF613okk/tcfVTZ4vJYyJR2
         rbbysmSArzN9JXJtwh3s8OxrbOqwxK3ZYh3zztRzCteqa49JDhVxi+f/NJsaV10v9s
         Xi3XoJnTXZ5caQqMH+9yZvx5Q337twKn9IkyB4X8UFuv978XhuSlKE86iqVGdU1rw2
         Ik/xirR+8zL08M1yNSRPga+V5JXF15a0D67Xe9yzLOiMMO+yjHGsStmB588WhVR+mX
         I/lSf9tu3V0b5F8Y/m2yCwM/ljx6lJq4cWRs0jnqGnFyYXWg8YinVwUMpQvff0004J
         kMH7NDkcRckOw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH v2 0/2] Fix TPM 1.2 resume
Date:   Tue,  2 May 2023 04:15:56 +0300
Message-Id: <20230502011558.10743-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

During TPM 1.2 resume, the first PCR read operation used inside
tpm1_do_selftest() fails. Fix the bugs preventing resume from working.

v2:
* Added Jerry's reviewed-by's.
* Rebased to 865fdb08197e ("Merge tag 'input-for-v6.4-rc0' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input").
* Mirrored patches to linux-next.

Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>

Link: https://lore.kernel.org/linux-integrity/CS6UJMSTVA4L.FRQ5VL1I1EF4@suppilovahvero/T/#m236d62184229cc035605143fde10933bcde60065
Jarkko Sakkinen (2):
  tpm_tis: Use tpm_chip_{start,stop} decoration inside tpm_tis_resume
  tpm: Prevent hwrng from activating during resume

 drivers/char/tpm/tpm-chip.c      |  4 +++
 drivers/char/tpm/tpm-interface.c | 10 ++++++++
 drivers/char/tpm/tpm_tis_core.c  | 43 ++++++++++++++------------------
 include/linux/tpm.h              |  1 +
 4 files changed, 34 insertions(+), 24 deletions(-)

-- 
2.39.2

