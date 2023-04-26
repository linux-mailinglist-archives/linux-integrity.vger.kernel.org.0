Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D383C6EF961
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Apr 2023 19:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbjDZR3h (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Apr 2023 13:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbjDZR3f (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Apr 2023 13:29:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E02297;
        Wed, 26 Apr 2023 10:29:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09856619AC;
        Wed, 26 Apr 2023 17:29:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164CCC433D2;
        Wed, 26 Apr 2023 17:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682530173;
        bh=w8SYslP+/DStWDE54MP5doZAdDsFjd/+Zv+AvTntQFw=;
        h=From:To:Cc:Subject:Date:From;
        b=rHwy80VQ/cFqPHrP1jkL+HCXnuOA8qamz5CwdsYIHl7cEdIFR6rGrNIfVnOXDcWkM
         CpoH+7y84wAqrhW43Hh3vhRgQGpbSmzFnj896/3AUvBz+TwVFCKr03WOXD4QKX598A
         Xr/L2zbbLOS/DDYaq5qswK8lqnWL7r7+vO/T4v4zfQfCAjAKjVvqTQS75jhFs1dsI6
         Vr1A8bcLDJGwbcqQqhZVcuzqG4HcW0+6bk+t6hKLbkKpD4RKTi1zvlTIA+sxvyjBCZ
         nU+pNdIKYjNf9DW1kt9I26dsNKhkT1ZAWCUa8gRkM5xdSYpjGOb5IdblSzGZKTjaa+
         /aBcD9YmsocJw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH 0/2] Fix TPM 1.2 resume
Date:   Wed, 26 Apr 2023 20:29:26 +0300
Message-Id: <20230426172928.3963287-1-jarkko@kernel.org>
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
tpm1_do_selftest() fails. Fix two bugs that can prevent the
operation from working.

Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Link: https://lore.kernel.org/linux-integrity/CS6UJMSTVA4L.FRQ5VL1I1EF4@suppilovahvero/T/#m236d62184229cc035605143fde10933bcde60065

Jarkko Sakkinen (2):
  tpm_tis: Use tpm_chip_{start,stop} decoration inside tpm_tis_resume
  tpm: Prevent hwrng from activating during resume

 drivers/char/tpm/tpm-chip.c      |  4 +++
 drivers/char/tpm/tpm-interface.c | 10 ++++++++
 drivers/char/tpm/tpm_tis_core.c  | 43 ++++++++++++++------------------
 include/linux/tpm.h              | 13 +++++-----
 4 files changed, 40 insertions(+), 30 deletions(-)

-- 
2.39.2

