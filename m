Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6774A282F19
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Oct 2020 05:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgJEDt5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 4 Oct 2020 23:49:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:60098 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgJEDt5 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 4 Oct 2020 23:49:57 -0400
IronPort-SDR: vViyWUsueYJCE2UzKna6ga/8jvSl3tL/UHI2mC2Mr1gk5/bagSDEWcBQlL1jayuVNCXe99B5nX
 itD1Vs3iJNOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9764"; a="160633340"
X-IronPort-AV: E=Sophos;i="5.77,337,1596524400"; 
   d="scan'208";a="160633340"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2020 20:49:52 -0700
IronPort-SDR: Edf9XQ/vb3fyfY+x9iuwssEF/5l3ZaqRgclijqt7kfN1ocKb+qAQ0ism3Sl/pZ0uzm/lmkZeTA
 wFmC4Anv0vfw==
X-IronPort-AV: E=Sophos;i="5.77,337,1596524400"; 
   d="scan'208";a="523377383"
Received: from sidorovd-mobl1.ccr.corp.intel.com (HELO localhost) ([10.252.48.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2020 20:49:51 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v2 0/3] A bunch of trusted keys fixes
Date:   Mon,  5 Oct 2020 06:49:45 +0300
Message-Id: <20201005034948.174228-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

v2:
Fix a kernel test bot warning:
https://lore.kernel.org/linux-integrity/202010051152.9kxy43LO-lkp@intel.com/

Jarkko Sakkinen (3):
  KEYS: trusted: Fix incorrect handling of tpm_get_random()
  KEYS: trusted: Reserve TPM for seal and unseal operations
  KEYS: trusted: Fix migratable=1 failing

 drivers/char/tpm/tpm.h                    |  4 -
 include/linux/tpm.h                       | 16 +++-
 security/keys/trusted-keys/trusted_tpm1.c | 94 ++++++++++++++++-------
 security/keys/trusted-keys/trusted_tpm2.c |  6 +-
 4 files changed, 86 insertions(+), 34 deletions(-)

-- 
2.25.1

