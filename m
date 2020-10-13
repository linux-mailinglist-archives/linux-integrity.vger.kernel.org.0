Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE8428C5AA
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Oct 2020 02:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgJMA2V (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Oct 2020 20:28:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:50274 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbgJMA2V (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Oct 2020 20:28:21 -0400
IronPort-SDR: /Jl4KGW0h1c0uvkK6YHwkg4u7aN4gLM6/KS4PR4uc/jPlld0JyOUmcTRsi1LQYtRpyMzzaSUOz
 dSogODTG1uPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="163187959"
X-IronPort-AV: E=Sophos;i="5.77,368,1596524400"; 
   d="scan'208";a="163187959"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 17:28:21 -0700
IronPort-SDR: GixC5veKoHSCU1a2uX4kA17UGO34P3QMY9rzZlJ1k40zzDlYwyGNHVR+cH6ks5xfY6lw83LFGm
 3fFTJqetzP0A==
X-IronPort-AV: E=Sophos;i="5.77,368,1596524400"; 
   d="scan'208";a="530175205"
Received: from lusin-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.53.81])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 17:28:19 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v3 0/3] KEYS, trusted: a bunch of bug fixes
Date:   Tue, 13 Oct 2020 03:28:12 +0300
Message-Id: <20201013002815.40256-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch set contains a bunch of disjoint bug fixes.

v3:
* Reordered patches a bit, i.e. trivial fixes in the head and the least
  trivial in the tail.
  <no xref>
* Added the missing "return -ENODEV;" to tpm_transmit_cmd(), when the
  kernel is compiled without TPM support.
  https://lore.kernel.org/linux-integrity/202010110927.zsxMpek2-lkp@intel.com/

v2:
* Fix a kernel test bot warning.
  https://lore.kernel.org/linux-integrity/202010051152.9kxy43LO-lkp@intel.com/

Jarkko Sakkinen (3):
  KEYS: trusted: Fix incorrect handling of tpm_get_random()
  KEYS: trusted: Fix migratable=1 failing
  KEYS: trusted: Reserve TPM for seal and unseal operations

 drivers/char/tpm/tpm.h                    |  4 -
 include/linux/tpm.h                       | 17 +++-
 security/keys/trusted-keys/trusted_tpm1.c | 94 ++++++++++++++++-------
 security/keys/trusted-keys/trusted_tpm2.c |  6 +-
 4 files changed, 87 insertions(+), 34 deletions(-)

-- 
2.25.1

