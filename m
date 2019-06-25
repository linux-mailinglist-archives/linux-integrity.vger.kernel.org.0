Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABCA55827
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Jun 2019 21:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfFYTwV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Jun 2019 15:52:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727990AbfFYTwR (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Jun 2019 15:52:17 -0400
Received: from sasha-vm.mshome.net (unknown [167.220.24.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42313208E3;
        Tue, 25 Jun 2019 19:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561492336;
        bh=7pm8JkCLHqEoLrJYY8z/2/wqC8f2TYEabiJDZrXwd5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V4Da/jRQR1Q49DYyxY7sfL/T0+yxQICBc2EP8tJqlozjDuNPv6QA4wiF/vGeluBFe
         3PBHRWAgXLMwn7t4CnL5hBjReEDyvvoypvZ41GQsiBAQhxTV0uD3uR8Ckglm3LtsO3
         rjyxOL/b/Qprljuk829q56aLQIrTBiIsET4TIMJ4=
From:   Sasha Levin <sashal@kernel.org>
To:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com, tee-dev@lists.linaro.org,
        ilias.apalodimas@linaro.org, sumit.garg@linaro.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v6 2/2] fTPM: add documentation for ftpm driver
Date:   Tue, 25 Jun 2019 15:52:09 -0400
Message-Id: <20190625195209.13663-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625195209.13663-1-sashal@kernel.org>
References: <20190625195209.13663-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch adds basic documentation to describe the new fTPM driver.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/security/tpm/index.rst        |  1 +
 Documentation/security/tpm/tpm_ftpm_tee.rst | 31 +++++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 Documentation/security/tpm/tpm_ftpm_tee.rst

diff --git a/Documentation/security/tpm/index.rst b/Documentation/security/tpm/index.rst
index af77a7bbb070..15783668644f 100644
--- a/Documentation/security/tpm/index.rst
+++ b/Documentation/security/tpm/index.rst
@@ -4,4 +4,5 @@ Trusted Platform Module documentation
 
 .. toctree::
 
+   tpm_ftpm_tee
    tpm_vtpm_proxy
diff --git a/Documentation/security/tpm/tpm_ftpm_tee.rst b/Documentation/security/tpm/tpm_ftpm_tee.rst
new file mode 100644
index 000000000000..29c2f8b5ed10
--- /dev/null
+++ b/Documentation/security/tpm/tpm_ftpm_tee.rst
@@ -0,0 +1,31 @@
+=============================================
+Firmware TPM Driver
+=============================================
+
+| Authors:
+| Thirupathaiah Annapureddy <thiruan@microsoft.com>
+| Sasha Levin <sashal@kernel.org>
+
+This document describes the firmware Trusted Platform Module (fTPM)
+device driver.
+
+Introduction
+============
+
+This driver is a shim for a firmware implemented in ARM's TrustZone
+environment. The driver allows programs to interact with the TPM in the same
+way the would interact with a hardware TPM.
+
+Design
+======
+
+The driver acts as a thin layer that passes commands to and from a TPM
+implemented in firmware. The driver itself doesn't contain much logic and is
+used more like a dumb pipe between firmware and kernel/userspace.
+
+The firmware itself is based on the following paper:
+https://www.microsoft.com/en-us/research/wp-content/uploads/2017/06/ftpm1.pdf
+
+When the driver is loaded it will expose ``/dev/tpmX`` character devices to
+userspace which will enable userspace to communicate with the firmware tpm
+through this device.
-- 
2.20.1

