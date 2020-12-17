Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABBA2DD96E
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Dec 2020 20:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbgLQThA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Dec 2020 14:37:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:41964 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728189AbgLQTg7 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Dec 2020 14:36:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9CD5CAC7F;
        Thu, 17 Dec 2020 19:36:17 +0000 (UTC)
Date:   Thu, 17 Dec 2020 20:36:15 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     ltp@lists.linux.it, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v5 3/4] ima_tpm.sh: Fix calculating boot aggregate
Message-ID: <20201217193615.GA491754@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20201214221946.6340-1-pvorel@suse.cz>
 <20201214221946.6340-4-pvorel@suse.cz>
 <25e41786777f814455780915dfe1bc2c769dc99c.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25e41786777f814455780915dfe1bc2c769dc99c.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

TL;DR: thank you for comments, I update commit message.
Details below.

> Hi Petr,

> On Mon, 2020-12-14 at 23:19 +0100, Petr Vorel wrote:
> > for TPM 2.0 or kernel >= v5.8-rc1:
> > 6f1a1d103b48 ima: ("Switch to ima_hash_algo for boot aggregate")

> > Test still fails with newer TPM 2.0 on kernel < v5.8-rc1.

> The above commit was backported in stable.  Do you know if the failing
> systems backported the above patch?
SLES kernel got it.

> I've recently asked for commit
> 20c59ce010f8 ("ima: extend boot_aggregate with kernel measurements")
> also be backported.
I see, it got backported to v5.4 (LTS).

FYI shell API doesn't have yet support for hint for commits to backport
(my TODO: #700 [1]). Once it's implemented, I'll add 20c59ce010f8 as this tag.

[1] https://github.com/linux-test-project/ltp/issues/700

> > Test was failing, because it expect SHA1 (we ignore MD5) hash, but for TPM 2.0
> > is now used IMA default hash algorithm (by default default SHA256).
> > This is similar for entries in IMA measurement list so we can reuse
> > already existing code.

> > Reading other algorithms than SHA1 or support TPM 2.0 requires evmctl
> > >= 1.3.1 (1.3 would also work for test1, but will be required for test2).

> > Although recent evmctl is recommended, to support older kernels and TPMs
> > which support only SHA1, get boot aggregate with old our legacy
> > ima_boot_aggregate.c.

> ^ the LTP legacy ima_boot_aggregate.c still works, without the evmctl
> dependency.
Yes, I meant in my description this LTP legacy ima_boot_aggregate.c.
Test does not require evmctl for SHA1 hash.

So maybe:
Although recent evmctl is recommended, for older kernels and TPMs
which support only SHA1 is still used the legacy ima_boot_aggregate.c
(no evmctl update required).

> > Also fixed cases:
> > * testing with no TPM device:
> > * TPM TPM 2.0 devices which does not export event log
> > (/sys/kernel/security/tpm0/binary_bios_measurements).

> ^ firmware which does not export the TPM 2.0 binary event log
+1

> > Also fixed test without TPM device (when IMA TPM-bypass is tested)
> > as some TPM 2.0 devices does not export event log
> > (/sys/kernel/security/tpm0/binary_bios_measurements).

> This looks like a duplicate of above.  Maybe just add another bullet
> *
> detecting IMA TPM-bypass mode
+1

> > This does not require evmctl at all.

> I assume this comment refers to TPM 2.0 calculating the
> "boot_aggregate" based on the existing PCR values, as opposed to TPM
> 1.2 which first walks the TPM event log, calculating the PCRs.
No, that's meant for IMA TPM-bypass (test1). Because we only check zero.
Both TPM 1.2 and TPM 2.0 require evmctl for reading PCR-10 (test2).
So just a note for * detecting IMA TPM-bypass mode.

> > Also try best to detect TPM major version (1, 2 or none - assume
> > TPM-bypass). This fixes testing with TPM 2.0 device which does not
> > export event log (/sys/kernel/security/tpm0/binary_bios_measurements):
> > not wrongly assuming TPM-bypass when kernel didn't export other TPM
> > 2.0 files we check in get_tpm_version() but bios boot aggregate is
> > correct (i.e. not 0x00s). In that case evmctl ima_boot_aggregate can get
> > boot aggregate even without TPM event log.

> > Co-developed-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> Thanks, Petr!
Thanks a lot for patient review and info.

Kind regards,
Petr

> Mimi
