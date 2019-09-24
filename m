Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9761BC9A2
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2019 16:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409689AbfIXOCQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Sep 2019 10:02:16 -0400
Received: from mga11.intel.com ([192.55.52.93]:62552 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409677AbfIXOCP (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Sep 2019 10:02:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 07:02:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,544,1559545200"; 
   d="scan'208";a="188474708"
Received: from fbielich-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.54.55])
  by fmsmga008.fm.intel.com with ESMTP; 24 Sep 2019 07:02:13 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-stable@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Vadim Sukhomlinov <sukhomlinov@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/3] tpm: Fix TPM 1.2 Shutdown sequence to prevent future TPM operations
Date:   Tue, 24 Sep 2019 17:01:59 +0300
Message-Id: <20190924140202.11360-1-jarkko.sakkinen@linux.intel.com>
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

Cc: linux-integrity@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Vadim Sukhomlinov <sukhomlinov@google.com>
Link: https://lore.kernel.org/stable/20190712152734.GA13940@kroah.com/

Jarkko Sakkinen (2):
  tpm: migrate pubek_show to struct tpm_buf
  tpm: use tpm_try_get_ops() in tpm-sysfs.c.

Vadim Sukhomlinov (1):
  tpm: Fix TPM 1.2 Shutdown sequence to prevent future TPM operations

 drivers/char/tpm/tpm-chip.c  |   3 +
 drivers/char/tpm/tpm-sysfs.c | 201 +++++++++++++++++++++--------------
 drivers/char/tpm/tpm.h       |  13 ---
 3 files changed, 124 insertions(+), 93 deletions(-)

-- 
2.20.1

