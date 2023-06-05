Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00577722DEF
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Jun 2023 19:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjFERx1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Jun 2023 13:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbjFERx0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Jun 2023 13:53:26 -0400
Received: from smtp11.infineon.com (smtp11.infineon.com [IPv6:2a00:18f0:1e00:4::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767F9FA;
        Mon,  5 Jun 2023 10:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1685987606; x=1717523606;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6oSGxo7KhdgY2EaqkGYhnYQNSZWnS+0OjH67GWXxekc=;
  b=HLbW674Wl3ANLB/B2sbifcLvc4s3GoooHaOH9fEzlfhcpC5Dqfaoqnhv
   xoUyGOlNuG18vE3pOHCjpVcfN3RqfblGMTHLQaokRq5J+eUxBovgGJ6Yt
   GRyivMhoM35FSxK74I65DS03mSovjYUWJu+6rtZ4GAFgGEwRhewCFSJXG
   U=;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="17446196"
X-IronPort-AV: E=Sophos;i="6.00,218,1681164000"; 
   d="scan'208";a="17446196"
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 19:53:24 +0200
Received: from KLUSE818.infineon.com (172.28.156.171) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 5 Jun 2023
 19:53:23 +0200
Received: from ISCNPC0VBFBX.infineon.com (10.161.6.196) by
 KLUSE818.infineon.com (172.28.156.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 5 Jun 2023 19:53:23 +0200
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
To:     <jarkko@kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [PATCH 0/4] Recovery from data transfer errors for tpm_tis
Date:   Mon, 5 Jun 2023 19:52:46 +0200
Message-ID: <20230605175250.2055-1-Alexander.Steffen@infineon.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.161.6.196]
X-ClientProxiedBy: MUCSE817.infineon.com (172.23.29.43) To
 KLUSE818.infineon.com (172.28.156.171)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

Alexander Steffen (4):
  tpm_tis: Explicitly check for error code
  tpm_tis: Move CRC check to generic send routine
  tpm_tis: Use responseRetry to recover from data transfer errors
  tpm_tis: Resend command to recover from data transfer errors

 drivers/char/tpm/tpm_tis_core.c | 73 +++++++++++++++++++++++++--------
 drivers/char/tpm/tpm_tis_core.h |  1 +
 2 files changed, 56 insertions(+), 18 deletions(-)

-- 
2.34.1

