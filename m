Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A363660CC4
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jul 2019 22:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbfGEUsF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Jul 2019 16:48:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728000AbfGEUsA (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Jul 2019 16:48:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE7CE2184C;
        Fri,  5 Jul 2019 20:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562359679;
        bh=WPjrPAJc8jUDE0PFgMh7HVyr5P4sYGHdpbEYbdaExJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=be5FRRugD8ZAe/sXSDQJ64XGyzD+iWFYVCmlZyFDCwu7uNhxLDCk7crmkEuy8cRWa
         aqEi3XNzehDBFmd1cszzMH1BJDpKniM3NLzRE4aBhLCWryX7oNXkqIDio/K4t2hSem
         sAwWaq3XM45RkNqI1vELXYhaWylD52Oky9TDH7OQ=
From:   Sasha Levin <sashal@kernel.org>
To:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com, tee-dev@lists.linaro.org,
        ilias.apalodimas@linaro.org, sumit.garg@linaro.org,
        rdunlap@infradead.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v8 2/2] fTPM: add documentation for ftpm driver
Date:   Fri,  5 Jul 2019 16:47:46 -0400
Message-Id: <20190705204746.27543-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705204746.27543-1-sashal@kernel.org>
References: <20190705204746.27543-1-sashal@kernel.org>
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
 Documentation/security/tpm/tpm_ftpm_tee.rst | 27 +++++++++++++++++++++
 2 files changed, 28 insertions(+)
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
index 000000000000..8c2bae16e3d9
--- /dev/null
+++ b/Documentation/security/tpm/tpm_ftpm_tee.rst
@@ -0,0 +1,27 @@
+=============================================
+Firmware TPM Driver
+=============================================
+
+This document describes the firmware Trusted Platform Module (fTPM)
+device driver.
+
+Introduction
+============
+
+This driver is a shim for firmware implemented in ARM's TrustZone
+environment. The driver allows programs to interact with the TPM in the same
+way they would interact with a hardware TPM.
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
+userspace which will enable userspace to communicate with the firmware TPM
+through this device.
-- 
2.20.1

