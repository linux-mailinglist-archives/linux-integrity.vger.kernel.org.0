Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD18FD1AE3
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Oct 2019 23:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbfJIV2t (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Oct 2019 17:28:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:42170 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729908AbfJIV2s (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Oct 2019 17:28:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 14:28:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,277,1566889200"; 
   d="scan'208";a="184198711"
Received: from thomaske-mobl.ger.corp.intel.com (HELO localhost) ([10.252.3.55])
  by orsmga007.jf.intel.com with ESMTP; 09 Oct 2019 14:28:38 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-stable@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Vadim Sukhomlinov <sukhomlinov@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 0/3] tpm: Fix TPM 1.2 Shutdown sequence to prevent future TPM operations
Date:   Thu, 10 Oct 2019 00:28:28 +0300
Message-Id: <20191009212831.29081-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

commit db4d8cb9c9f2af71c4d087817160d866ed572cc9 upstream

This backport is for v4.14 and v4.19 The backport requires non-racy
behaviour from TPM 1.x sysfs code. Thus, the dependecies for that
are included.

NOTE: 1/3 is only needed for v4.14.

v4:
* There was unnecessary assignment inside TPM_CHIP_FLAG_TPM2 branch (does
  not cause any run-time issue).
v3:
* Fixed the cover letter and the subject prefix. My deepest apologies
  for all the hassle :-(
v2:
* Something happened when merging 3/3 that write lock was taken
  twice. Fixed in this version. Did also sanity check test with
  TPM2:
  echo devices > /sys/power/pm_test && echo mem > /sys/power/state

Cc: linux-integrity@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Vadim Sukhomlinov <sukhomlinov@google.com>
Link: https://lore.kernel.org/stable/20190712152734.GA13940@kroah.com/

Jarkko Sakkinen (2):
  tpm: migrate pubek_show to struct tpm_buf
  tpm: use tpm_try_get_ops() in tpm-sysfs.c.

Vadim Sukhomlinov (1):
  tpm: Fix TPM 1.2 Shutdown sequence to prevent future TPM operations

 drivers/char/tpm/tpm-chip.c  |   9 +-
 drivers/char/tpm/tpm-sysfs.c | 201 +++++++++++++++++++++--------------
 drivers/char/tpm/tpm.h       |  13 ---
 3 files changed, 125 insertions(+), 98 deletions(-)

-- 
2.20.1

