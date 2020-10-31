Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242A42A18C4
	for <lists+linux-integrity@lfdr.de>; Sat, 31 Oct 2020 17:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgJaQpZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 31 Oct 2020 12:45:25 -0400
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21108 "EHLO
        sender4-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbgJaQpZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 31 Oct 2020 12:45:25 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1604162686; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=R7nYTVeEzvQTZ5qpFyS/zj8CC/82t2bxxuqTJVkF2hC1XXOSev/Btb3Os+l0a4vP//IM53iWmewt+gvb+d5JHCnFko7EOCIiAe6t2nRGFbgEkLnAM5zqcLkfgKN8ZspvRJJ9DlFvLcDhcmrgcyjgzGab9s5NXE2zrUZZ36ET/FU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1604162686; h=Cc:Date:From:Message-ID:Subject:To; 
        bh=VO7HKgwp5hY4uW+eur6uI4P4Oa5OD58CYj88tNXXYIY=; 
        b=AzZ4tCq0vh5l87HCdVTEfnigs6RUO1DEQXWKbceTlXVBeBvFaqdYVT5MMi8YzIwxazWYcy610lvG5JshfMgHIg0pIEfy2laNyxpA6GaB+HqmXSWQrBR697eXsntLfYxssrNtH/r+ZrAFMztjUHSaMoLJd1O+BEje8GL++zfQuus=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com> header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1604162686;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=VO7HKgwp5hY4uW+eur6uI4P4Oa5OD58CYj88tNXXYIY=;
        b=NLz3RP872WdHqubvb0135++jffLZGWXG/Wy93X+wp3fAgf3ym6bEq8i75cWwLECO
        qkxRkAOW8amuSXsmh+puN0vx9BVIpN3Nu/NYRgynJ1fZht5HTl7dIqqgQRJA9vK9lf7
        Ng+cHlk/32Fm6bFCXXPYs3mkfvUw2Is3IVeTAKv4=
Received: from sisyou.hme. (c-73-129-147-140.hsd1.md.comcast.net [73.129.147.140]) by mx.zohomail.com
        with SMTPS id 1604162685809562.1268729878734; Sat, 31 Oct 2020 09:44:45 -0700 (PDT)
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        jarkko.sakkinen@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        trenchboot-devel@googlegroups.com
Subject: [RFC PATCH 0/4] Secure Launch early PCR extend support
Date:   Sat, 31 Oct 2020 12:51:18 -0400
Message-Id: <20201031165122.21539-1-dpsmith@apertussolutions.com>
X-Mailer: git-send-email 2.11.0
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This RFC is a break out of the prerequisite TPM functionality for the larger
Secure Launch capability. This TPM/PCR subset is in a separate smaller patch set
being sent as an RFC to get early feedback before the whole Secure Launch patch
set is resubmitted. This patch RFC, if accepted, will be part of the overall
Secure Launch patch set.

TPMs support numerous operations, the majority of which will never be used by
the Secure Launch feature in the compressed kernel. Given that, this RFC does
not seek to implement a TPM driver but merely enough logic for the PCR extend
operation with a reasonable reuse of the mainline TPM driver.

In this RFC is the early_pcr_extend functionality that is built from shared
headers with the mainline TPM driver for common definitions and TPM buffer
functionality. The early_pcr_extend balances the introduction of new logic to
communicate with the TPM without having to introduce unrelated hardware features
not already available under the compressed kernel. The target usage of
early_pcr_extend is to support DRTM capable hardware under Secure Launch.
Historically the authors have not encountered any DRTM capable hardware that
uses any other interface other than the TPM Interface Specification (TIS) FIFO
software interface. To minimize the impact to code size and avoid unnecessary
functionality in the compressed kernel, the early_pcr_extend provides a very
limited implementation of the FIFO interface necessary to set locality and carry
out the extend operation.

For the sake of completeness, a discussion on the proposed refactoring of the
mainline driver FIFO and TPM command handling for reuse in the compressed kernel
needs to be addressed. After reviewing the mainline TPM driver for a second
time, we have arrived at the conclusion that the driver is too entangled with
the mainline kernel functionality which makes refactoring highly impractical.
The following are a few examples of this entanglement. The mainline TPM driver
is built around the tpm_chip structure which uses definitions not available in
the compressed kernel. It is likely that bringing these definitions into the
compressed kernel purely to make the tpm_chip structure available, would be
found to be unacceptable. Therefore it would be necessary to create a compressed
kernel representation which would end up with a majority of tpm_chip structure
being stubbed out since very little of this abstraction is required for the one
TPM command that will be used. Another concern is that the mainline TPM driver
FIFO interface is heavily reliant on timers implemented with mainline kernel
jiffies for interacting with the TPM. The compressed kernel does not have access
to jiffies. In the compressed kernel, jiffies have not been initialized and
timers have not been started. Therefore the use of jiffies would have to be
abstracted out of the mainline TPM driver resulting in a significant refactoring
or borderline rewrite of the driver.

We believe that the approach we are presenting here should be satisfactory. We
feel it is clear that we are not trying to create a new TPM driver. We have
split up the TPM headers to be able to reuse almost all the needed definitions/
structures. In addition, we switched to using the mainline TPM driver's buffer
functions. The remaining code to do the extend is minimal and appropriate for
the compressed kernel environment.

Thank you,
Daniel P. Smith and Ross Philipson

Daniel P. Smith (4):
  tpm: Move TPM TIS definitions out of TIS core header
  tpm: Move core definitions and buffer management out of main TPM
    header
  tpm: Conditionally use static buffer in TPM buffer management
  x86: Add early PCR extend support for Secure Launch

 arch/x86/boot/compressed/Makefile           |   2 +
 arch/x86/boot/compressed/early_pcr_extend.c | 311 ++++++++++++++++++++++++++++
 arch/x86/boot/compressed/early_pcr_extend.h |  92 ++++++++
 drivers/char/tpm/tpm_tis_core.h             |  60 +-----
 drivers/char/tpm/tpm_tis_defs.h             |  81 ++++++++
 include/linux/tpm.h                         | 269 +-----------------------
 include/linux/tpm_buffer.h                  | 135 ++++++++++++
 include/linux/tpm_core.h                    | 185 +++++++++++++++++
 8 files changed, 809 insertions(+), 326 deletions(-)
 create mode 100644 arch/x86/boot/compressed/early_pcr_extend.c
 create mode 100644 arch/x86/boot/compressed/early_pcr_extend.h
 create mode 100644 drivers/char/tpm/tpm_tis_defs.h
 create mode 100644 include/linux/tpm_buffer.h
 create mode 100644 include/linux/tpm_core.h

-- 
2.11.0

