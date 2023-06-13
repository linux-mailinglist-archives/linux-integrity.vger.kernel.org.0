Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3B772EA70
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Jun 2023 20:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240008AbjFMSDT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Jun 2023 14:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjFMSDS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Jun 2023 14:03:18 -0400
Received: from smtp2.infineon.com (smtp2.infineon.com [IPv6:2a00:18f0:1e00:4::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870C910F7;
        Tue, 13 Jun 2023 11:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1686679398; x=1718215398;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B4ZD5tbd5kcrG2mZGow9/hJKyOdGd/RWXV0OEPt+meg=;
  b=DHWv5aYUqUzTxjsZePzeSyauy59hOx+7/z+WVGvUgVYuW41WpfJec4Zo
   +hr6BbJUhn+uOnQDzsprzHYDLHN06dibAqagOAaEZr68da+zHUVP/vGne
   YZDrUWgrcSDozqe3gV/mqhW+HATHLBQ0I9EyG+lM99lTJAeF4fkqv5Upf
   A=;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="41820519"
X-IronPort-AV: E=Sophos;i="6.00,240,1681164000"; 
   d="scan'208";a="41820519"
Received: from unknown (HELO MUCSE822.infineon.com) ([172.23.29.53])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 20:03:15 +0200
Received: from KLUSE818.infineon.com (172.28.156.171) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 13 Jun
 2023 20:03:15 +0200
Received: from ISCNPC0VBFBX.infineon.com (10.161.6.196) by
 KLUSE818.infineon.com (172.28.156.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 13 Jun 2023 20:03:15 +0200
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
To:     <jarkko@kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [PATCH v3 0/4] Recovery from data transfer errors for tpm_tis
Date:   Tue, 13 Jun 2023 20:02:55 +0200
Message-ID: <20230613180259.3525-1-Alexander.Steffen@infineon.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.161.6.196]
X-ClientProxiedBy: MUCSE821.infineon.com (172.23.29.47) To
 KLUSE818.infineon.com (172.28.156.171)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Data transfer to/from hardware TPM devices is not always fully reliable.
The existing driver code contains already many checks to detect
corrupted data (e.g. unexpected register values, CRC failures, etc.) and
usually returns EIO in such cases. This series adds automatic retries to
the command/response transmission in tpm_tis_send/tpm_tis_recv, so that
occasional communication errors do not cause the command execution to
fail and the perceived reliability of the TPM device is increased.

v3:
* Rename tpm_tis_recv* functions
* Other small cleanups that were suggested in comments
v2:
* Remove Change-Ids accidentially left in commit messages

Alexander Steffen (4):
  tpm_tis: Explicitly check for error code
  tpm_tis: Move CRC check to generic send routine
  tpm_tis: Use responseRetry to recover from data transfer errors
  tpm_tis: Resend command to recover from data transfer errors

 drivers/char/tpm/tpm_tis_core.c | 69 ++++++++++++++++++++++++---------
 drivers/char/tpm/tpm_tis_core.h |  1 +
 2 files changed, 52 insertions(+), 18 deletions(-)

-- 
2.25.1

