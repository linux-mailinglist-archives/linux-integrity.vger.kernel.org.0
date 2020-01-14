Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0756A13AC12
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2020 15:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgANORH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Jan 2020 09:17:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:33922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbgANORG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Jan 2020 09:17:06 -0500
Received: from localhost.localdomain (aaubervilliers-681-1-7-206.w90-88.abo.wanadoo.fr [90.88.129.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B84424689;
        Tue, 14 Jan 2020 14:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579011425;
        bh=q26RMnhv4e6vnyl7On3dw2ZS7Ofbxt7I4hTv9fYgiXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A94Kv+FoH+qqPpiPSMm1lXCHjuH7DksvFWPXDH3mvBvxh8jbUn0C4UZ/hK58kJKRU
         gbYNtafpJMfiWdsxLHYQ5vONategLeQZB0BUI8pvdqdfBXz06rbNkH1BKvmjtpkZof
         ryTwyh2PAuBcDDd7YHn6b/HZc7KTWAIUOhn5vCcc=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, jarkko.sakkinen@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, masahisa.kojima@linaro.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: tpm-tis-mmio: add compatible string for SynQuacer TPM
Date:   Tue, 14 Jan 2020 15:16:46 +0100
Message-Id: <20200114141647.109347-2-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200114141647.109347-1-ardb@kernel.org>
References: <20200114141647.109347-1-ardb@kernel.org>
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

