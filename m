Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D14D9EEFDD
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2019 23:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387470AbfKDVxv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Nov 2019 16:53:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:47980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387588AbfKDVxu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Nov 2019 16:53:50 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADE0321D81;
        Mon,  4 Nov 2019 21:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904429;
        bh=BQznuFgVQfqp84u8/GPWmIUgThSN1012WBeQa99r7uE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U1yKKV1YC6Gfe2u1DPFZIokSkBsXcVf3lFEhAdwcAgG1EwXAdbRX8O62HtY1pXKHo
         /x4/h8+EeCzzG+eeoKd2R6FYx3P+jwpgSZ/kUYXnkU5fVqqNI+m30q43/mk88epzks
         7GqG2T7wy8zP3TEoN9Z28V+UcIzDvak1KAHO9WZY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matthew Garrett <mjg59@google.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>, Lyude Paul <lyude@redhat.com>,
        Octavian Purdila <octavian.purdila@intel.com>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Scott Talbert <swt@techie.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 42/95] efi/x86: Do not clean dummy variable in kexec path
Date:   Mon,  4 Nov 2019 22:44:40 +0100
Message-Id: <20191104212101.999539577@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212038.056365853@linuxfoundation.org>
References: <20191104212038.056365853@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Dave Young <dyoung@redhat.com>

[ Upstream commit 2ecb7402cfc7f22764e7bbc80790e66eadb20560 ]

kexec reboot fails randomly in UEFI based KVM guest.  The firmware
just resets while calling efi_delete_dummy_variable();  Unfortunately
I don't know how to debug the firmware, it is also possible a potential
problem on real hardware as well although nobody reproduced it.

The intention of the efi_delete_dummy_variable is to trigger garbage collection
when entering virtual mode.  But SetVirtualAddressMap can only run once
for each physical reboot, thus kexec_enter_virtual_mode() is not necessarily
a good place to clean a dummy object.

Drop the efi_delete_dummy_variable so that kexec reboot can work.

Signed-off-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Matthew Garrett <mjg59@google.com>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Octavian Purdila <octavian.purdila@intel.com>
Cc: Peter Jones <pjones@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Scott Talbert <swt@techie.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Link: https://lkml.kernel.org/r/20191002165904.8819-8-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/platform/efi/efi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 9061babfbc83d..335a62e74a2e9 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -893,9 +893,6 @@ static void __init kexec_enter_virtual_mode(void)
 
 	if (efi_enabled(EFI_OLD_MEMMAP) && (__supported_pte_mask & _PAGE_NX))
 		runtime_code_page_mkexec();
-
-	/* clean DUMMY object */
-	efi_delete_dummy_variable();
 #endif
 }
 
-- 
2.20.1



