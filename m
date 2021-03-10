Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17B7334C28
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Mar 2021 00:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbhCJXFF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Mar 2021 18:05:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:35130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231368AbhCJXEi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Mar 2021 18:04:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DB6964FAE;
        Wed, 10 Mar 2021 23:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615417478;
        bh=WzmZkaUunjZxXsa1qc4s/xR3aKCgsgPzwcOMV3ukiB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t+tHJaSdx8Yn9NL8OrPfepU/PMDh4p/zPHQOzP4BFGkcIOY3dyuBGUxXJw7QDaOxy
         VeCwVyPIdsQ0lIvrw/JyeIjdozo6oifhlg0MFAd1CUcbKrU6mELRl2b8LcRJGiF9+2
         avbTjiI1zCr/txFUWHPeUYOvqhikvmAWVuuMbanNOJWIMYmZK4ya4MHcqke6y3pKhf
         yTuxCc2pdGwb04gy06wWIVcnBxCDRNv+GAQrQu+P0K+j6+PsDuX0x+Hq77GBmj0H/z
         /kSkjUp+4dolV4AuTHDE7gkZ4nA1RplGJWpgtIBVLLogOnjU8M2DJVHmamaKvVT8g/
         iN912YIhCkwkw==
Date:   Thu, 11 Mar 2021 01:04:13 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Fix bugs related to TPM2 event log
Message-ID: <YElQbZy5Z3qn7SVq@kernel.org>
References: <20210310221916.356716-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210310221916.356716-1-stefanb@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Mar 10, 2021 at 05:19:13PM -0500, Stefan Berger wrote:
> This series of patches fixes a couple of issues related to TPM2
> event logs, such as the disappearance of the TPM2 log on QEMU machines
> running with UEFI (my fault) and a kernel fault due to an integer under-
> flow when reading the TPM 2 log multiple times.
> 
> Regards,
>    Stefan
> 
> v1->v2:
>  - Revised patches 1 & 2
> 
> Stefan Berger (3):
>   tpm: efi: Use local variable for calculating final log size
>   tpm: acpi: Check eventlog signature before using it
>   tpm: vtpm_proxy: Avoid reading host log when using a virtual device
> 
>  drivers/char/tpm/eventlog/acpi.c   | 33 +++++++++++++++++++++++++++++-
>  drivers/char/tpm/eventlog/common.c |  3 +++
>  drivers/char/tpm/eventlog/efi.c    | 29 ++++++++++++++++++--------
>  3 files changed, 56 insertions(+), 9 deletions(-)
> 
> -- 
> 2.29.2
> 
> 

b4 seems like remarkably useful tool:

$ b4 am 20210310221916.356716-1-stefanb@linux.ibm.com
Looking up https://lore.kernel.org/r/20210310221916.356716-1-stefanb%40linux.ibm.com
Grabbing thread from lore.kernel.org/linux-integrity
Analyzing 4 messages in the thread
---
Writing ./v2_20210310_stefanb_fix_bugs_related_to_tpm2_event_log.mbx
  ✓ [PATCH v2 1/3] tpm: efi: Use local variable for calculating final log size
  ✓ [PATCH v2 2/3] tpm: acpi: Check eventlog signature before using it
  ✓ [PATCH v2 3/3] tpm: vtpm_proxy: Avoid reading host log when using a virtual device
  ---
  ✓ Attestation-by: DKIM/ibm.com (From: stefanb@linux.ibm.com)
---
Total patches: 3
---
Cover: ./v2_20210310_stefanb_fix_bugs_related_to_tpm2_event_log.cover
 Link: https://lore.kernel.org/r/20210310221916.356716-1-stefanb@linux.ibm.com
 Base: not found (applies clean to current tree)
       git am ./v2_20210310_stefanb_fix_bugs_related_to_tpm2_event_log.mbx

$ git am -3 v2_20210310_stefanb_fix_bugs_related_to_tpm2_event_log.mbx
Applying: tpm: efi: Use local variable for calculating final log size
Applying: tpm: acpi: Check eventlog signature before using it
Applying: tpm: vtpm_proxy: Avoid reading host log when using a virtual device

I also did run checkpatch.pl, no errors.

/Jarkko
