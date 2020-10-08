Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DFF28738B
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Oct 2020 13:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbgJHLpV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Oct 2020 07:45:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:42746 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgJHLpV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Oct 2020 07:45:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 65445AB8F;
        Thu,  8 Oct 2020 11:45:20 +0000 (UTC)
Date:   Thu, 8 Oct 2020 13:45:18 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <20201008114518.GB27671@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200817213506.4474-1-James.Bottomley@HansenPartnership.com>
 <20200817213506.4474-2-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817213506.4474-2-James.Bottomley@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

> Create sysfs per hash groups with 24 PCR files in them one group,
> named pcr-<hash>, for each agile hash of the TPM.  The files are
> plugged in to a PCR read function which is TPM version agnostic, so
> this works also for TPM 1.2 but the hash is only sha1 in that case.

> Note: the macros used to create the hashes emit spurious checkpatch
> warnings.  Do not try to "fix" them as checkpatch recommends, otherwise
> they'll break.

> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>
On both TPM 1.2 and TPM 2.0.
/sys/class/tpm/tpm0/pcr-sha*/* is exporting well on both.
James, thanks for implementing nice API!

BTW are all of these just TPM 1.2 specific?
/sys/class/tpm/tpm0/device/enabled
/sys/class/tpm/tpm0/device/pcrs
/sys/kernel/security/tpm0/binary_bios_measurements

Kind regards,
Petr
