Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7055282E7B
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Oct 2020 02:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgJEA1Y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 4 Oct 2020 20:27:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:58374 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgJEA1Y (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 4 Oct 2020 20:27:24 -0400
IronPort-SDR: bAGDZXVkFFJRbH+pQiVrIwwqcRseoIHpqgFHAtQ2l2J4gOl2Fy9U7FRwqmu8xi9k9N0p0uHYuz
 JSPgeMgRjjEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9764"; a="151097787"
X-IronPort-AV: E=Sophos;i="5.77,337,1596524400"; 
   d="scan'208";a="151097787"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2020 17:27:20 -0700
IronPort-SDR: 0D5UqvfRUKuekCx5jP3JkZhpDuFetOI6XydQ+SyN8XKYt8aNQXHQW5Puq99IV0ZCD/kfHr9Ssf
 s3K4J2j1aQ0w==
X-IronPort-AV: E=Sophos;i="5.77,337,1596524400"; 
   d="scan'208";a="522562429"
Received: from avahldie-mobl.amr.corp.intel.com (HELO localhost) ([10.249.32.74])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2020 17:27:18 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 0/3] A bunch of trusted keys fixes
Date:   Mon,  5 Oct 2020 03:26:56 +0300
Message-Id: <20201005002659.81588-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

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

