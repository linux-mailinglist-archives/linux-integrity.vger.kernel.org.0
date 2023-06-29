Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DC3742EAA
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jun 2023 22:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjF2Umy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Jun 2023 16:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjF2Umw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Jun 2023 16:42:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23CE2689
        for <linux-integrity@vger.kernel.org>; Thu, 29 Jun 2023 13:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688071315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Y1w2wveQj5ZjtvSYiiPZCbehKWVYDK8itGEibs3X60w=;
        b=NiRapyswkJWY4O+CHprdcjiat12/laJIOyOnzXJIyU51o+uA68oge3CRgSKA6XYyRZlrVo
        mFZkAUx9SE6arphFmF9M8RrR1upvuKyI/V8gikwWK2T722yjOR4nO1ajALGteKccSXI+6p
        0aNQx72kwMVyjrGrquCWC1p9JjP409o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-OIXoYfhEM3SMriDDhuPqcQ-1; Thu, 29 Jun 2023 16:41:51 -0400
X-MC-Unique: OIXoYfhEM3SMriDDhuPqcQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1DC6A803FDF;
        Thu, 29 Jun 2023 20:41:51 +0000 (UTC)
Received: from cantor.redhat.com (unknown [10.2.17.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1012C00049;
        Thu, 29 Jun 2023 20:41:49 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>, stable@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Sachin Sant <sachinp@linux.ibm.com>
Subject: [PATCH] tpm: return false from tpm_amd_is_rng_defective on non-x86 platforms
Date:   Thu, 29 Jun 2023 13:41:47 -0700
Message-Id: <20230629204147.1852823-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

tpm_amd_is_rng_defective is for dealing with an issue related to the
AMD firmware TPM, so on non-x86 architectures just have it inline and
return false.

Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: stable@vger.kernel.org
Cc: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Reported-by: Aneesh Kumar K. V <aneesh.kumar@linux.ibm.com>
Reported-by: Sachin Sant <sachinp@linux.ibm.com>
Closes: https://lore.kernel.org/lkml/99B81401-DB46-49B9-B321-CF832B50CAC3@linux.ibm.com/
Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD designs")
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/char/tpm/tpm-chip.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index cd48033b804a..cf5499e51999 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -518,6 +518,7 @@ static int tpm_add_legacy_sysfs(struct tpm_chip *chip)
  * 6.x.y.z series: 6.0.18.6 +
  * 3.x.y.z series: 3.57.y.5 +
  */
+#ifdef CONFIG_X86
 static bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
 {
 	u32 val1, val2;
@@ -566,6 +567,12 @@ static bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
 
 	return true;
 }
+#else
+static inline bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
+{
+	return false;
+}
+#endif /* CONFIG_X86 */
 
 static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 {
-- 
2.38.1

