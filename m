Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED64513A40E
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2020 10:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgANJqD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Jan 2020 04:46:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:41244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgANJqD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Jan 2020 04:46:03 -0500
Received: from dogfood.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5FCE24670;
        Tue, 14 Jan 2020 09:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578995162;
        bh=oXoVf5FYzK2l54ZMTKBmt/diqvZDokYRd/mYU7Iuj7w=;
        h=From:To:Cc:Subject:Date:From;
        b=ofFAsr0yMlwqOasIzmRJEYHG7eCD55Tw4XqWV8py/NHRxsNvvsm9h+vw/whb8uWXZ
         6LhHsk/1b5w3U50AnfJon2zQ7Jyt2wPN4kOL/cG/Zp7TOb3w8YUjBw6r0CpUS/O3kn
         t7N/DVvu3lAy41/P2bAc+9c+6VSwH5DisAhMffX4=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     jarkko.sakkinen@linux.intel.com
Cc:     linux-arm-kernel@lists.infradead.org, masahisa.kojima@linaro.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 0/2] synquacer: add TPM support
Date:   Tue, 14 Jan 2020 10:45:03 +0100
Message-Id: <20200114094505.11855-1-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This adds support for driving the TPM on Socionext SynQuacer platforms
using the existing driver for a memory mapped TIS frame.

Ard Biesheuvel (2):
  dt-bindings: tpm-tis-mmio: add compatible string for SynQuacer TPM
  tpm: tis: add support for MMIO TPM on SynQuacer

 Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt |  1 +
 drivers/char/tpm/tpm_tis.c                                      | 31 ++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

-- 
2.20.1

