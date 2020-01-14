Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFF013A413
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2020 10:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgANJqG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Jan 2020 04:46:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:41362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728998AbgANJqF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Jan 2020 04:46:05 -0500
Received: from dogfood.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E582124673;
        Tue, 14 Jan 2020 09:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578995164;
        bh=q26RMnhv4e6vnyl7On3dw2ZS7Ofbxt7I4hTv9fYgiXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XyydpypudDBcz8etUqufb5GnphOu22iRcWN0zlHbwPz1qgMRTO4QEmBwLSmlUsMHV
         bZ/08I5PIoeMSmQhF2KQBhtfiwa9+uSxaLiBQf3k79JorHQ8QE7jq4xfPsn949mILa
         Qzv+Yg/4y2fJdcgoxzQveBdcZQn63pqLSHcrRt6E=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     jarkko.sakkinen@linux.intel.com
Cc:     linux-arm-kernel@lists.infradead.org, masahisa.kojima@linaro.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 1/2] dt-bindings: tpm-tis-mmio: add compatible string for SynQuacer TPM
Date:   Tue, 14 Jan 2020 10:45:04 +0100
Message-Id: <20200114094505.11855-2-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200114094505.11855-1-ardb@kernel.org>
References: <20200114094505.11855-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add a compatible string for the SynQuacer TPM to the binding for a
TPM exposed via a memory mapped TIS frame. The MMIO window behaves
slightly differently on this hardware, so it requires its own
identifier.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt b/Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
index 7c6304426da1..b604c8688dc8 100644
--- a/Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
+++ b/Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
@@ -12,6 +12,7 @@ Required properties:
 - compatible: should contain a string below for the chip, followed by
               "tcg,tpm-tis-mmio". Valid chip strings are:
 	          * "atmel,at97sc3204"
+		  * "socionext,synquacer-tpm-mmio"
 - reg: The location of the MMIO registers, should be at least 0x5000 bytes
 - interrupts: An optional interrupt indicating command completion.
 
-- 
2.20.1

