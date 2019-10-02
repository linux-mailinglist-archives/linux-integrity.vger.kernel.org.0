Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E71F8C8F40
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Oct 2019 19:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbfJBRDw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Oct 2019 13:03:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35581 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728484AbfJBRDv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Oct 2019 13:03:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id v8so20559709wrt.2
        for <linux-integrity@vger.kernel.org>; Wed, 02 Oct 2019 10:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BYYfVQIfFtpOzEISpfYA8mada12Gi+by+EuvgLlTqFs=;
        b=I3ma6LtMenHnUmcpuK5EauyVCCDOO/mq1nFzq1/qCLqwWVUQzOv19WX3l2eYhKYNbo
         iK7BapnntZY0k2eht5rZTc8xCP68vdLvhPmnsnIpo7+Nk1MjynmDQfAATc8OeJdI2RlG
         ZamUbSthr2YnREgTluCf2qL8/bPhBlJFvIcQ3PhvURk9/QdLREqYsH5SKTklYmAGH/jE
         C+CareO8YOz6+t1LNuY61w/s7oCdSMGyZULGQ7QvQEhOdxasIWBS2982WtZWX1oh5Gmf
         8GUaOZuI9tUzhp0E7XD3+Ib2DJJ714TsqCjFgZ5Ah5k/WwfX7XOBEP3kcWEkvRhKfL94
         W/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BYYfVQIfFtpOzEISpfYA8mada12Gi+by+EuvgLlTqFs=;
        b=lJld4qGgehjGKwu90gtFi2VvmOdHmT0vVYjQNAM/t5RTuxJTrnLwxV65Gx80dvnHEV
         3CapzEe8ZsO7+tWzGdJ1secrwENDgPncZjERIRydhzlCKhXjFWh1FuwfJelcWnIn1Cso
         h8IRsuC3amliIQ0XDDXV2CqgkvmaRcozO1wQlErtMJMzGijbvzHIb4ttA708T1GjP2ia
         BUQ1RhdhZwxpKXyM37QxlUECGssxTmiYxnYQ8Tpamnq6H1gLcGi7KeSWMriFN1tFE33i
         lhHVlBD9lF3bBIxVMEGzkbWhyC+X8jDDbldbQ6r8x5heBeNQ6OyDsQsxbrFPuJSTWYWX
         7HuQ==
X-Gm-Message-State: APjAAAU4B2SMczvwuO9PzAnHOv3YvkLjTmpPAesNUv5Sn+suG/JRyiTu
        hP5lky2mR7lVVykD4Btx5VR38w==
X-Google-Smtp-Source: APXvYqzXLD7bD20WEf4fYahS92VBaU8Nfz7zJCiUjw+YXBjU6Eadhx+AVtevlqIIL2bsBkVfwA9OPg==
X-Received: by 2002:adf:e348:: with SMTP id n8mr3213078wrj.299.1570035828925;
        Wed, 02 Oct 2019 10:03:48 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:f145:3252:fc29:76c9])
        by smtp.gmail.com with ESMTPSA id f18sm7085459wmh.43.2019.10.02.10.03.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 10:03:48 -0700 (PDT)
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
Subject: [GIT PULL 0/7] EFI fixes for v5.4
Date:   Wed,  2 Oct 2019 18:58:57 +0200
Message-Id: <20191002165904.8819-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent

for you to fetch changes up to d45bb93ac68495a8c53126742b4d2223101cfb7f:

  efi/x86: do not clean dummy variable in kexec path (2019-10-02 18:44:23 +0200)

----------------------------------------------------------------
A couple of EFI fixes for v5.4:
- a cosmetic fix for the byte order of PCI class codes in CPER error reports
- bail early instead of pointlessly iterating over all EFI variables looking
  for the one containing a supplementary ACPI SSDT table if we never specified
  a variable name to begin with
- some fixes for TPM event log parsing
- fix kexec hangs on OVMF/x86 caused by attempts to delete a dummy variable
  which shouldn't even exist at that point.

----------------------------------------------------------------
Ard Biesheuvel (1):
      efivar/ssdt: don't iterate over EFI vars if no SSDT override was specified

Ben Dooks (1):
      efi: make unexported efi_rci2_sysfs_init static

Dave Young (1):
      efi/x86: do not clean dummy variable in kexec path

Jerry Snitselaar (1):
      efi/tpm: only set efi_tpm_final_log_size after successful event log parsing

Lukas Wunner (1):
      efi: cper: Fix endianness of PCIe class code

Peter Jones (2):
      efi/tpm: Don't access event->count when it isn't mapped.
      efi/tpm: don't traverse an event log with no events

 arch/x86/platform/efi/efi.c       |  3 ---
 drivers/firmware/efi/cper.c       |  2 +-
 drivers/firmware/efi/efi.c        |  3 +++
 drivers/firmware/efi/rci2-table.c |  2 +-
 drivers/firmware/efi/tpm.c        | 24 ++++++++++++++++++------
 include/linux/tpm_eventlog.h      | 16 ++++++++++++----
 6 files changed, 35 insertions(+), 15 deletions(-)
