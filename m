Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E81A29CB6A
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Aug 2019 10:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfHZISP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Aug 2019 04:18:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46021 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfHZISO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Aug 2019 04:18:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id w26so11286583pfq.12;
        Mon, 26 Aug 2019 01:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jW9bYxQJkfLp7wpntwTOmna5SElP56fVw11ZQunJKcU=;
        b=rVUbd+MgVjA21mEQTHpwbKMSZHc2/kO9U5V5cgA37bDYREawnyGZwrtA1p/5p67eTu
         mR1IFCEtmnbHI0An6b/iJVtgU73tWAb0WK6Pg3tk64/TUmfGmrQm2pGCAOqpI7dvpEOh
         q02SWQ3ZbTdagNUJRdSPoDgFm1x3bcdvp5NpBCtKkET/5PF0CPo4gSMdyYkNoSMsJFcP
         NyxyTRI4G7bATv8OcEtBp3nG0Of5kjJXpxpAq8lFdVXu/ka0Ff9lKULbG0wP9eIWcD8f
         ibI0HojOmbB16bpAEBYn7yB6CCvizQjA37BP19FALKHIUOcRJH64WqWteH7CzgyLBNVs
         Lvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jW9bYxQJkfLp7wpntwTOmna5SElP56fVw11ZQunJKcU=;
        b=cni5NqflZvfem8Xc++Bu95ACjXQbY2kqhECdsXfAP4+c3vqK76DzpdedzJgPNK7JDu
         dlIe9ZlXLKAcQinjbKHQCq7bqa2oBA3n80yfvnx5bXVSTdpMn5HIfYxfO4VRv7MIkIhV
         s37sHsYhdT2QoLsAZSvudd1hqfFY5JcYLSKpJg3OWlP+JzbicI72xbx2552F2uJNa8QG
         718DvTNAz1OOkg2ER6nkrblxkkQhezkxWUUizJT/67ZkceM5L+MDJMHCjiLqZvfoogBa
         pfu5bEVWX51dFUNj+TCHgTNIcLmqtslxxQtMN8KK0UQ0a+hLpuFg6WX2l2KmwAqRFDBM
         RS1g==
X-Gm-Message-State: APjAAAWZXlrzRaZs5EaitFFMLH7aAkkSe++A6odKpMmXgtVAHxlcWpdm
        LMvuxt1ZzWSCu7iEua/xsag=
X-Google-Smtp-Source: APXvYqwxdLeOUYG5cZxpQGxAmNPAJfgixOy2fRyJ+WwV1oe/0sRqak7qEwUxR3bq214I8IQIYO6Yuw==
X-Received: by 2002:aa7:8a47:: with SMTP id n7mr2473370pfa.182.1566807493764;
        Mon, 26 Aug 2019 01:18:13 -0700 (PDT)
Received: from localhost.localdomain ([175.203.71.146])
        by smtp.googlemail.com with ESMTPSA id f7sm10407976pfd.43.2019.08.26.01.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 01:18:13 -0700 (PDT)
From:   Seunghun Han <kkamagui@gmail.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     mjg59@srcf.ucam.org, Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER),
        linux-kernel@vger.kernel.org, Seunghun Han <kkamagui@gmail.com>
Subject: [PATCH] x86: tpm: Remove a busy bit of the NVS area for supporting AMD's fTPM
Date:   Mon, 26 Aug 2019 17:17:52 +0900
Message-Id: <20190826081752.57258-1-kkamagui@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

I'm Seunghun Han and work at the Affiliated Institute of ETRI. I got
an AMD system which had a Ryzen Threadripper 1950X and MSI mainboard, and
I had a problem with AMD's fTPM. My machine showed an error message below,
and the fTPM didn't work because of it.

[  5.732084] tpm_crb MSFT0101:00: can't request region for resource
             [mem 0x79b4f000-0x79b4ffff]
[  5.732089] tpm_crb: probe of MSFT0101:00 failed with error -16

When I saw the e820 map and iomem, I found two fTPM regions were in
the ACPI NVS area. The regions are below.

79a39000-79b6afff : ACPI Non-volatile Storage
  79b4b000-79b4bfff : MSFT0101:00
  79b4f000-79b4ffff : MSFT0101:00

After analyzing this issue, I found out that a busy bit was set to
the ACPI NVS area, and the Linux kernel didn't allow the TPM CRB driver
to assign CRB regions in it.

To support AMD's fTPM, I removed the busy bit from the ACPI NVS area like
the reserved area so that AMD's fTPM regions could be assigned in it.

Signed-off-by: Seunghun Han <kkamagui@gmail.com>
---
 arch/x86/kernel/e820.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 7da2bcd2b8eb..0d721df8900e 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1085,11 +1085,12 @@ static bool __init do_mark_busy(enum e820_type type, struct resource *res)
 	case E820_TYPE_RESERVED:
 	case E820_TYPE_PRAM:
 	case E820_TYPE_PMEM:
+	/* AMD's fTPM regions are in the ACPI NVS area */
+	case E820_TYPE_NVS:
 		return false;
 	case E820_TYPE_RESERVED_KERN:
 	case E820_TYPE_RAM:
 	case E820_TYPE_ACPI:
-	case E820_TYPE_NVS:
 	case E820_TYPE_UNUSABLE:
 	default:
 		return true;
-- 
2.21.0

