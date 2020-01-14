Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54F9D13AC0B
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2020 15:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgANORE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Jan 2020 09:17:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:33834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbgANORE (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Jan 2020 09:17:04 -0500
Received: from localhost.localdomain (aaubervilliers-681-1-7-206.w90-88.abo.wanadoo.fr [90.88.129.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20F7D24680;
        Tue, 14 Jan 2020 14:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579011423;
        bh=Vs5vp9Q0pO/rYvjiF2G3gSvq89rNmL0cw1LbNBbTuZk=;
        h=From:To:Cc:Subject:Date:From;
        b=zAfYuw+DRSckBl1J8CDfyssuIGNNADGPIq+IlafAMdRa9CDb5ylpO4WgVUI0AO0in
         2pbR/6QA2Pj1MJkrUn/6keNgeNff43d8N3FWlV6rQ4aUzYoVbaCtyO+I/6lYQF2Mk0
         rq69AeBDAi3s5AA45dz3dOpNSuRUOT61cyjvwzkM=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, jarkko.sakkinen@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, masahisa.kojima@linaro.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca
Subject: [PATCH v2 0/2] synquacer: add TPM support
Date:   Tue, 14 Jan 2020 15:16:45 +0100
Message-Id: <20200114141647.109347-1-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This adds support for driving the TPM on Socionext SynQuacer platforms
using the existing driver for a memory mapped TIS frame.

v2:
- don't use read/write_bytes() to implement read/write16/32 since that uses
  the wrong address

Cc: jarkko.sakkinen@linux.intel.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: masahisa.kojima@linaro.org
Cc: devicetree@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: peterhuewe@gmx.de
Cc: jgg@ziepe.ca

Ard Biesheuvel (2):
  dt-bindings: tpm-tis-mmio: add compatible string for SynQuacer TPM
  tpm: tis: add support for MMIO TPM on SynQuacer

 Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt |  1 +
 drivers/char/tpm/tpm_tis.c                                      | 50 +++++++++++++++++++-
 2 files changed, 49 insertions(+), 2 deletions(-)

-- 
2.20.1

