Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A63960CBF
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jul 2019 22:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfGEUr5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Jul 2019 16:47:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727983AbfGEUr5 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Jul 2019 16:47:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A3BE216E3;
        Fri,  5 Jul 2019 20:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562359676;
        bh=K7he3rQq49BWkAT4cEC8Z1CZZtq44KtExCY3OnjReBc=;
        h=From:To:Cc:Subject:Date:From;
        b=yXP9LZw3GDXY4+pZb14RV1l6/SKpaLXq2EFuqpgQm5ZH5NcimfHu3P8TiXzqQvtjQ
         kbo+ipZjmWWULJBZVCA9dOWV0IkAfJqzXjxi4vB0TKbR+wSoz7n/O9zF/ylRYTQjQ2
         XYIsEC0f8eJDfp1aN7KgMDZDEW6mCrZy7Cz2kacw=
From:   Sasha Levin <sashal@kernel.org>
To:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com, tee-dev@lists.linaro.org,
        ilias.apalodimas@linaro.org, sumit.garg@linaro.org,
        rdunlap@infradead.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v8 0/2] fTPM: firmware TPM running in TEE
Date:   Fri,  5 Jul 2019 16:47:44 -0400
Message-Id: <20190705204746.27543-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Changes from v7:

 - Address Jarkko's comments.

Sasha Levin (2):
  fTPM: firmware TPM running in TEE
  fTPM: add documentation for ftpm driver

 Documentation/security/tpm/index.rst        |   1 +
 Documentation/security/tpm/tpm_ftpm_tee.rst |  27 ++
 drivers/char/tpm/Kconfig                    |   5 +
 drivers/char/tpm/Makefile                   |   1 +
 drivers/char/tpm/tpm_ftpm_tee.c             | 350 ++++++++++++++++++++
 drivers/char/tpm/tpm_ftpm_tee.h             |  40 +++
 6 files changed, 424 insertions(+)
 create mode 100644 Documentation/security/tpm/tpm_ftpm_tee.rst
 create mode 100644 drivers/char/tpm/tpm_ftpm_tee.c
 create mode 100644 drivers/char/tpm/tpm_ftpm_tee.h

-- 
2.20.1

