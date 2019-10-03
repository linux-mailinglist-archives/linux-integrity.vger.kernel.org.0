Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD76CAE8B
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Oct 2019 20:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731033AbfJCSvL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Oct 2019 14:51:11 -0400
Received: from mga02.intel.com ([134.134.136.20]:50362 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbfJCSvL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Oct 2019 14:51:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 11:51:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,253,1566889200"; 
   d="scan'208";a="216913947"
Received: from jvalevi1-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.93.117])
  by fmsmga004.fm.intel.com with ESMTP; 03 Oct 2019 11:51:07 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 0/2] tpm: Detach page allocation from tpm_buf
Date:   Thu,  3 Oct 2019 21:51:01 +0300
Message-Id: <20191003185103.26347-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

As has been seen recently, binding the buffer allocation and tpm_buf
together is sometimes far from optimal. The buffer might come from the
caller namely when tpm_send() is used by another subsystem. In addition we
can stability in call sites w/o rollback (e.g. power events)>

Take allocation out of the tpm_buf framework and make it purely a wrapper
for the data buffer.

Link: https://patchwork.kernel.org/patch/11146585/
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>

Jarkko Sakkinen (2):
  tpm: Use GFP_KERNEL for allocating struct tpm_buf
  tpm: Detach page allocation from tpm_buf

 drivers/char/tpm/tpm-sysfs.c      |  19 ++-
 drivers/char/tpm/tpm.h            |  40 ++---
 drivers/char/tpm/tpm1-cmd.c       | 114 +++++++++----
 drivers/char/tpm/tpm2-cmd.c       | 265 +++++++++++++++++++-----------
 drivers/char/tpm/tpm2-space.c     |  64 +++++---
 drivers/char/tpm/tpm_vtpm_proxy.c |  24 +--
 6 files changed, 333 insertions(+), 193 deletions(-)

-- 
2.20.1

