Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE22C8F41
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Oct 2019 19:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbfJBRDx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Oct 2019 13:03:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42563 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbfJBRDw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Oct 2019 13:03:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id n14so20500988wrw.9
        for <linux-integrity@vger.kernel.org>; Wed, 02 Oct 2019 10:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4PokOnzm+oPBOfuUNXGxhTnYV86Xe9IUth6ohOE2Moc=;
        b=lbaRKl9Sw32KcoJuKhy42btRwwnIf5qJkXgklbtMtdTbbKv9pfLbW8DQBaa9xY5ueH
         mmbRwytKylLFYjmSQZTewjfV8VsUpRx3BTL+xqyuRXVafUDmdiCQwyN3rSl8WcqN95Iz
         kEt0DMUYERZOm/UNlapCkAufqsyg+s2LwOVIiBtgDyHRALMfem6bQFzj6rvW6bTNTQrK
         chCtI4XLB6lJZAuPsb8nnelrEJPjBDa4btRcSPvvNoI6U7StdRMeAEiqS9g0cTY+LkUb
         vRoX7QmBpMW4QJw0JDclENNx4D1okrRBxnYuJyl2qTuwqd9bB+ET/kBayqgR2YuoLRPM
         AdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4PokOnzm+oPBOfuUNXGxhTnYV86Xe9IUth6ohOE2Moc=;
        b=qzc5BWLKoaj/hLZBTFfipY1b1ecuwCjS8N/zunDVgRakreWT+fnVqLw4rhnX0VhSgb
         v/7ikt8/mP1YRw6Ym72Itb2izK8nMwPExvFdWcE4PhEEmxzi6k4MaSI3MDgXZMTTDM8W
         QXPs/bvwHmfLHCD6PIlf7b64lSmUMF8DRNe2tzRfoyNWprcmohcPyMXNmTaCppFdIjUn
         I4nOxfHu3S1pWziXi903sZukMj9Cks7+U1/gKSaFYYO3o7C28b87WcJ1TTy1HEy5GHlz
         vNBrlpiqGPhB/SmuT+L+3MFfHMyWFFarBnzs2rvGHl0rYttmaqW6U/aPIOO4QAkGXI4v
         fpjQ==
X-Gm-Message-State: APjAAAVHT8HBivtT72HwPlknjfSlyEJgue2jUpHY+FqlgczwusTG46vq
        iMH8ufJlHZfLqccirdhpux7yiw==
X-Google-Smtp-Source: APXvYqw9MCV1O+7Aq+XDMSajGWDzKNaYl4/YugE0KOmsVoSAQ8Gzis+ttdbZXeFqTIP6ndQafnLeAQ==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr3787044wrm.114.1570035830342;
        Wed, 02 Oct 2019 10:03:50 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:f145:3252:fc29:76c9])
        by smtp.gmail.com with ESMTPSA id f18sm7085459wmh.43.2019.10.02.10.03.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 10:03:49 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Dave Young <dyoung@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Lyude Paul <lyude@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Octavian Purdila <octavian.purdila@intel.com>,
        Peter Jones <pjones@redhat.com>, Scott Talbert <swt@techie.net>
Subject: [PATCH 1/7] efi: cper: Fix endianness of PCIe class code
Date:   Wed,  2 Oct 2019 18:58:58 +0200
Message-Id: <20191002165904.8819-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191002165904.8819-1-ard.biesheuvel@linaro.org>
References: <20191002165904.8819-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Lukas Wunner <lukas@wunner.de>

The CPER parser assumes that the class code is big endian, but at least
on this edk2-derived Intel Purley platform it's little endian:

    efi: EFI v2.50 by EDK II BIOS ID:PLYDCRB1.86B.0119.R05.1701181843
    DMI: Intel Corporation PURLEY/PURLEY, BIOS PLYDCRB1.86B.0119.R05.1701181843 01/18/2017

    {1}[Hardware Error]:   device_id: 0000:5d:00.0
    {1}[Hardware Error]:   slot: 0
    {1}[Hardware Error]:   secondary_bus: 0x5e
    {1}[Hardware Error]:   vendor_id: 0x8086, device_id: 0x2030
    {1}[Hardware Error]:   class_code: 000406
                                       ^^^^^^ (should be 060400)

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/cper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index addf0749dd8b..b1af0de2e100 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -381,7 +381,7 @@ static void cper_print_pcie(const char *pfx, const struct cper_sec_pcie *pcie,
 		printk("%s""vendor_id: 0x%04x, device_id: 0x%04x\n", pfx,
 		       pcie->device_id.vendor_id, pcie->device_id.device_id);
 		p = pcie->device_id.class_code;
-		printk("%s""class_code: %02x%02x%02x\n", pfx, p[0], p[1], p[2]);
+		printk("%s""class_code: %02x%02x%02x\n", pfx, p[2], p[1], p[0]);
 	}
 	if (pcie->validation_bits & CPER_PCIE_VALID_SERIAL_NUMBER)
 		printk("%s""serial number: 0x%04x, 0x%04x\n", pfx,
-- 
2.20.1

