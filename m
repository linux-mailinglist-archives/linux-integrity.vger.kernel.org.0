Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5712452138C
	for <lists+linux-integrity@lfdr.de>; Tue, 10 May 2022 13:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240881AbiEJLYF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 May 2022 07:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240892AbiEJLYB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 May 2022 07:24:01 -0400
Received: from smtp2.infineon.com (smtp2.infineon.com [IPv6:2a00:18f0:1e00:4::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A31C1868CB;
        Tue, 10 May 2022 04:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1652181603; x=1683717603;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jSzBja/18U0bgtuUTZtzvvQV6oPRcRl5G5R14KGtuhg=;
  b=Lazj3NP43+1oVQdKC8jrD7zh298PkoaKAugxCureygvdggLdRXKDbMz+
   RS1NiUZdiK9XSTlsSVK9D88VYh7sIIUIZOkQH7ep5d30hlFP5XV65sNeD
   idemTFFcFCU+7gsYleoUaRCEZ1bANOQ/Rpxcl917g46x/4qCXjpfh6qEz
   U=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="176812916"
X-IronPort-AV: E=Sophos;i="5.91,214,1647298800"; 
   d="scan'208";a="176812916"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 13:20:01 +0200
Received: from MUCSE819.infineon.com (MUCSE819.infineon.com [172.23.29.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS;
        Tue, 10 May 2022 13:20:01 +0200 (CEST)
Received: from ISCN5CG1067W80.muc.infineon.com (172.23.8.247) by
 MUCSE819.infineon.com (172.23.29.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 10 May 2022 13:20:00 +0200
From:   Johannes Holland <johannes.holland@infineon.com>
To:     <jarkko@kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        Johannes Holland <johannes.holland@infineon.com>
Subject: [PATCH] tpm: increase timeout for kselftests
Date:   Tue, 10 May 2022 13:16:08 +0200
Message-ID: <20220510111607.22984-1-johannes.holland@infineon.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE803.infineon.com (172.23.29.29) To
 MUCSE819.infineon.com (172.23.29.45)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Due to CreatePrimary commands which need to create RSA keys of
increasing size, the timeout value need to be raised, as well.
Default is 300s.

Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
---
A timeout of anything below 600s still lead to occasional timeouts for
me. Therefore, I propose 600s as a new value. 

 tools/testing/selftests/tpm2/settings | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 tools/testing/selftests/tpm2/settings

diff --git a/tools/testing/selftests/tpm2/settings b/tools/testing/selftests/tpm2/settings
new file mode 100644
index 000000000000..919bc3803f03
--- /dev/null
+++ b/tools/testing/selftests/tpm2/settings
@@ -0,0 +1,2 @@
+timeout=600
+
-- 
2.34.1

