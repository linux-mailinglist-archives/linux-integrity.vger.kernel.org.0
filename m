Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673202DCDAF
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Dec 2020 09:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgLQIdv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Dec 2020 03:33:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:52284 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgLQIdv (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Dec 2020 03:33:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A05DFAC7B;
        Thu, 17 Dec 2020 08:33:09 +0000 (UTC)
Date:   Thu, 17 Dec 2020 09:33:08 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     ltp@lists.linux.it, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v5 0/4] TPM 2.0 fixes in IMA tests
Message-ID: <X9sXxGacmaPYN8hp@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20201214221946.6340-1-pvorel@suse.cz>
 <aec8d4d757c674b3fdb4caaf3d89317d230b91e7.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aec8d4d757c674b3fdb4caaf3d89317d230b91e7.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> Hi Petr,

> On Mon, 2020-12-14 at 23:19 +0100, Petr Vorel wrote:
> > The only problem which bothers me is failure on ima_policy=tcb:

> > evmctl ima_measurement /sys/kernel/security/integrity/ima/binary_runtime_measurements -vv
> > ...
> > sha256: PCRAgg  10: c19866f10132282d4cf20ca45f50078db843f95dc8d1ea8819d0e240cdf3b21c
> > sha256: TPM PCR-10: df913daa0437a2365f710f6d93a4f2d37146414425d9aaa60740dc635d187158
> > sha256: PCRAgg 10 does not match TPM PCR-10
> > Failed to match per TPM bank or SHA1 padded TPM digest(s) (count 1446)
> > errno: No such file or directory (2)

> > Thus test get failure for the fist run without --ignore-violations
> > ...
> > ima_tpm 1 TINFO: using command: evmctl ima_boot_aggregate -v
> > Using tss2-rc-decode to read PCRs.
> > ima_tpm 1 TINFO: IMA boot aggregate: '0756853d9378ff6473966e20610a8d1cb97e4dc613cb87adf5e870c8eb93fd0f'
> > ima_tpm 1 TPASS: bios boot aggregate matches IMA boot aggregate
> > ima_tpm 2 TINFO: verify PCR values
> > ima_tpm 2 TINFO: real PCR-10: '6d8aec6291c0c19efdee50e20899939135be073cd4d6e9063e53386f54f9487d'
> > ima_tpm 2 TFAIL: evmctl failed, trying with --ignore-violations
> > ima_tpm 2 TINFO: aggregate PCR-10: '6d8aec6291c0c19efdee50e20899939135be073cd4d6e9063e53386f54f9487d'
> > ima_tpm 2 TPASS: aggregate PCR value matches real PCR value
> > ima_tpm 3 TINFO: AppArmor enabled, this may affect test results
> > ima_tpm 3 TINFO: it can be disabled with TST_DISABLE_APPARMOR=1 (requires super/root)
> > ima_tpm 3 TINFO: loaded AppArmor profiles: none

> > Summary:
> > passed   2
> > failed   1
> > skipped  0
> > warnings 0

> > IMHO unless this is specific for this particular TPM we should skip test
> > if ima_policy=tcb.

> No, I don't think so.  Violations are a result of a file being opened
> for read and write at the same time.  Opening a file for write, when it
> is already open for read, results in a Time of Measure/Time of Use
> (ToMToU) violation.  Opening a file for read, when it is already open
> for write, results in an open_writer violation.  One of the more common
> reasons for these violations are log files.

> With the builtin TCB measurement policy enabled on the boot command
> line, files are measured from the beginning, before a custom policy is
> loaded.  Normally a custom policy is loaded after an LSM policy has
> been loaded, allowing IMA policy rules to be defined in terms of LSM
> labels.

> Verifying the IMA measurement list against the TPM PCRs is an important
> test.  Ignoring violations doesn't make sense either.   Perhaps if a
> custom policy has not been loaded, emit an informational message and
> skip the test without "--ignore-violations".

Thanks for an explanation. Agree, you're right. It's most likely wrong setup
(there were some temporary files in /tmp and even postfix pid file in /var/run/),
I need to properly setup dracut-ima. It'd be then good to document this, but I'd
do it as separate effort.

So, can I merge the patchset with your ack/review-by?

Kind regards,
Petr

> thanks,

> Mimi

