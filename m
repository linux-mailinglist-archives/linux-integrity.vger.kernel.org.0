Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20B825748D
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Jun 2019 00:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfFZWuk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jun 2019 18:50:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:27478 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfFZWuk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jun 2019 18:50:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 15:50:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,421,1557212400"; 
   d="scan'208";a="170209986"
Received: from mwsinger-mobl3.ger.corp.intel.com ([10.252.48.211])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Jun 2019 15:50:37 -0700
Message-ID: <2595b4f6ce49cc3d413c75f86a63ad9d26f0f1fd.camel@linux.intel.com>
Subject: [GIT PULL] tpmdd updates for Linux v5.3
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, jmorris@namei.org,
        mjg59@google.com
Date:   Thu, 27 Jun 2019 01:50:47 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

My v5.3 PR contains two critical bug fixes and support for obtaining TPM
events triggered by ExitBootServices(). For the latter I have to give a
quite verbose explanation not least because I had to revisit all the
details myself to remember what was going on in Matthew's patches.

The preboot software stack maintains an event log that gets entries
every time something gets hashed to any of the PCR registers. What gets
hashed could be a component to be run or perhaps log of some actions
taken just to give couple of coarse examples. In general, anything
relevant for the boot process that the preboot software does gets hashed
and a log entry with a specific event type [1].

The main application for this is remote attestation and the reason why
it is useful is nicely put in the very first section of [1]:

"Attestation is used to provide information about the platform’s state
to a challenger. However, PCR contents are difficult to interpret;
therefore, attestation is typically more useful when the PCR contents
are accompanied by a measurement log. While not trusted on their own,
the measurement log contains a richer set of information than do the PCR
contents. The PCR contents are used to provide the validation of the
measurement log."

Because EFI_TCG2_PROTOCOL.GetEventLog() is not available after calling
ExitBootServices(), Linux EFI stub copies the event log to a custom
configuration table. Unfortunately, ExitBootServices() also generates
events and obviously these events do not get copied to that table.
Luckily firmware does this for us by providing a configuration table
identified by EFI_TCG2_FINAL_EVENTS_TABLE_GUID.

This PR essentially contains necessary changes to provide the full
event log for the use the user space that is concatenated from these
two partial event logs [2].

[1] 
https://trustedcomputinggroup.org/resource/pc-client-specific-platform-firmware-profile-specification/
[2] The final concatenation is done in drivers/char/tpm/eventlog/efi.c

/Jarkko

The following changes since commit c88e40e07cd967dcdf37321a63ab6e8b0d881100:

  Merge tag 'mfd-fixes-5.2-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd (2019-06-25 03:41:03
+0800)

are available in the Git repository at:

  git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20190625

for you to fetch changes up to 166a2809d65b282272c474835ec22c882a39ca1b:

  tpm: Don't duplicate events from the final event log in the TCG2 log (2019-06-
24 23:57:50 +0300)

----------------------------------------------------------------
tpmdd updates for Linux v5.3

----------------------------------------------------------------
Kees Cook (1):
      tpm: Actually fail on TPM errors during "get random"

Matthew Garrett (6):
      tpm: Abstract crypto agile event size calculations
      tpm: Reserve the TPM final events table
      tpm: Append the final event log to the TPM event log
      efi: Attempt to get the TCG2 event log in the boot stub
      Abstract out support for locating an EFI config table
      tpm: Don't duplicate events from the final event log in the TCG2 log

Vadim Sukhomlinov (1):
      tpm: Fix TPM 1.2 Shutdown sequence to prevent future TPM operations

 drivers/char/tpm/eventlog/efi.c                |  59 ++++++++--
 drivers/char/tpm/eventlog/tpm2.c               |  47 +-------
 drivers/char/tpm/tpm-chip.c                    |   6 +-
 drivers/char/tpm/tpm1-cmd.c                    |   7 +-
 drivers/char/tpm/tpm2-cmd.c                    |   7 +-
 drivers/firmware/efi/efi.c                     |   2 +
 drivers/firmware/efi/libstub/efi-stub-helper.c |  15 +++
 drivers/firmware/efi/libstub/efistub.h         |   2 +
 drivers/firmware/efi/libstub/fdt.c             |  27 ++---
 drivers/firmware/efi/libstub/tpm.c             |  80 ++++++++++---
 drivers/firmware/efi/tpm.c                     |  63 +++++++++-
 include/linux/efi.h                            |  10 ++
 include/linux/tpm_eventlog.h                   | 152 +++++++++++++++++++++++++
 13 files changed, 378 insertions(+), 99 deletions(-)

