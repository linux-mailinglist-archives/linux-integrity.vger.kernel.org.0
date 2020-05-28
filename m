Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897291E6357
	for <lists+linux-integrity@lfdr.de>; Thu, 28 May 2020 16:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390838AbgE1OHw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 May 2020 10:07:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:41852 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390658AbgE1OHv (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 May 2020 10:07:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3E5FAAC52;
        Thu, 28 May 2020 14:07:49 +0000 (UTC)
Date:   Thu, 28 May 2020 16:07:47 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     ltp@lists.linux.it, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Petr Cervinka <pcervinka@suse.com>,
        Cyril Hrubis <chrubis@suse.cz>, linux-integrity@vger.kernel.org
Subject: Re: [LTP v2 1/1] ima_tpm.sh: Fix for calculating boot aggregate
Message-ID: <20200528140747.GA8401@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200527071434.28574-1-pvorel@suse.cz>
 <1590601280.16219.1.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1590601280.16219.1.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

thanks a lot for testing!

> On Wed, 2020-05-27 at 09:14 +0200, Petr Vorel wrote:
> > Fixes test for kernel commit: 6f1a1d103b48 ima: ("Switch to
> > ima_hash_algo for boot aggregate") from current linux-integrity tree.

> > Tests was failing, because it expect SHA1 hash, but for TPM 2.0 is
> > now used IMA default hash algorithm (by default default SHA256).
> > This is similar for entries in IMA measurement list so we can reuse
> > already existing code.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > changes v1->v2:
> > * removing global variables from get_algorithm_digest (hopefully it's
> > less ugly)

> > Tested only on VM. Can anybody test it on real HW?

> With just this change, the ima_tpm.sh test is failing.  I assume it is
> failing because it is reading the SHA1 TPM bank, not the SHA256 bank
> to calculate the boot_aggregate hash.
First question: is it correct to take sha256? Because on my test below it's
reading sha1, because that's the content of /sys/kernel/security/ima/ascii_runtime_measurements

I thought just kernel commit: 6f1a1d103b48 ima: ("Switch to ima_hash_algo for
boot aggregate") from current linux-integrity tree is needed, but I tested it on
b59fda449cf0 ("ima: Set again build_ima_appraise variable") (i.e. having all
Robeto's ima patches,  missing just last 2 commits from next-integrity head).
What is needed to get your setup?
We both have CONFIG_IMA_DEFAULT_HASH_SHA256=y and CONFIG_IMA_DEFAULT_HASH="sha256".

> ima_tpm 1 TINFO: timeout per run is 0h 5m 0s
> ima_tpm 1 TINFO: IMA kernel config:
> ima_tpm 1 TINFO: CONFIG_IMA=y
> ima_tpm 1 TINFO: CONFIG_IMA_MEASURE_PCR_IDX=10
> ima_tpm 1 TINFO: CONFIG_IMA_LSM_RULES=y
> ima_tpm 1 TINFO: CONFIG_IMA_NG_TEMPLATE=y
> ima_tpm 1 TINFO: CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
> ima_tpm 1 TINFO: CONFIG_IMA_DEFAULT_HASH_SHA256=y
> ima_tpm 1 TINFO: CONFIG_IMA_DEFAULT_HASH="sha256"
> ima_tpm 1 TINFO: CONFIG_IMA_WRITE_POLICY=y
> ima_tpm 1 TINFO: CONFIG_IMA_READ_POLICY=y
> ima_tpm 1 TINFO: CONFIG_IMA_APPRAISE=y
> ima_tpm 1 TINFO: CONFIG_IMA_ARCH_POLICY=y
> ima_tpm 1 TINFO: CONFIG_IMA_TRUSTED_KEYRING=y
> ima_tpm 1 TINFO: CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
> ima_tpm 1 TINFO: CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
> ima_tpm 1 TINFO: CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
> ima_tpm 1 TINFO: /proc/cmdline: BOOT_IMAGE=/boot/vmlinuz-5.6.0-rc3+.signed root=UUID=119f1a79-c391-4e37-905d-3a503284cadb ro quiet splash ima-policy=tcb
> ima_tpm 1 TINFO: verify boot aggregate
> ima_tpm 1 TINFO: used algorithm: sha256
> ima_tpm 1 TINFO: IMA boot aggregate: 'b2341e4ccea25be7fa750830fb5fdf4bef1c44a4'
> ima_tpm 1 TFAIL: bios boot aggregate does not match IMA boot aggregate (3fd5dc717f886ff7182526efc5edc3abb179a5aac1ab589c8ec888398233ae5b)
> ima_tpm 2 TINFO: verify PCR values
> ima_tpm 2 TINFO: evmctl version: evmctl 1.2
> ima_tpm 2 TCONF: TPM Hardware Support not enabled in kernel or no TPM chip found
> ima_tpm 3 TINFO: AppArmor enabled, this may affect test results
> ima_tpm 3 TINFO: it can be disabled with TST_DISABLE_APPARMOR=1 (requires super/root)
> ima_tpm 3 TINFO: loaded AppArmor profiles: none

> Summary:
> passed   0
> failed   1
> skipped  1
> warnings 0


BTW my results on custom kernel:
ima_tpm 1 TINFO: timeout per run is 0h 5m 0s
ima_tpm 1 TINFO: IMA kernel config:
ima_tpm 1 TINFO: CONFIG_IMA=y
ima_tpm 1 TINFO: CONFIG_IMA_MEASURE_PCR_IDX=10
ima_tpm 1 TINFO: CONFIG_IMA_LSM_RULES=y
ima_tpm 1 TINFO: CONFIG_IMA_NG_TEMPLATE=y
ima_tpm 1 TINFO: CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
ima_tpm 1 TINFO: CONFIG_IMA_DEFAULT_HASH_SHA256=y
ima_tpm 1 TINFO: CONFIG_IMA_DEFAULT_HASH="sha256"
ima_tpm 1 TINFO: CONFIG_IMA_APPRAISE=y
ima_tpm 1 TINFO: CONFIG_IMA_APPRAISE_BOOTPARAM=y
ima_tpm 1 TINFO: CONFIG_IMA_APPRAISE_MODSIG=y
ima_tpm 1 TINFO: CONFIG_IMA_TRUSTED_KEYRING=y
ima_tpm 1 TINFO: CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY=y
ima_tpm 1 TINFO: /proc/cmdline: BOOT_IMAGE=/boot/vmlinuz-5.3.18-20-default root=/dev/mapper/system-root crashkernel=121M,high crashkernel=72M,low isofrom=/dev/disk/by-uuid/3271-1AD6:/openSUSE-Tumbleweed-NET-x86_64-Snapshot20161222-Media.iso isofrom_device=/dev/disk/by-uuid/3271-1AD6 isofrom_system=/openSUSE-Tumbleweed-NET-x86_64-Snapshot20161222-Media.iso loader=syslinux quiet resume=/dev/system/swap splash=silent quiet showopts
ima_tpm 1 TINFO: IMA kernel config:
ima_tpm 1 TINFO: CONFIG_IMA=y
ima_tpm 1 TINFO: CONFIG_IMA_MEASURE_PCR_IDX=10
ima_tpm 1 TINFO: CONFIG_IMA_LSM_RULES=y
ima_tpm 1 TINFO: CONFIG_IMA_NG_TEMPLATE=y
ima_tpm 1 TINFO: CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
ima_tpm 1 TINFO: CONFIG_IMA_DEFAULT_HASH_SHA256=y
ima_tpm 1 TINFO: CONFIG_IMA_DEFAULT_HASH="sha256"
ima_tpm 1 TINFO: CONFIG_IMA_APPRAISE=y
ima_tpm 1 TINFO: CONFIG_IMA_APPRAISE_BOOTPARAM=y
ima_tpm 1 TINFO: CONFIG_IMA_APPRAISE_MODSIG=y
ima_tpm 1 TINFO: CONFIG_IMA_TRUSTED_KEYRING=y
ima_tpm 1 TINFO: CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY=y
ima_tpm 1 TINFO: /proc/cmdline: BOOT_IMAGE=/boot/vmlinuz-5.3.18-20-default root=/dev/mapper/system-root crashkernel=121M,high crashkernel=72M,low isofrom=/dev/disk/by-uuid/3271-1AD6:/openSUSE-Tumbleweed-NET-x86_64-Snapshot20161222-Media.iso isofrom_device=/dev/disk/by-uuid/3271-1AD6 isofrom_system=/openSUSE-Tumbleweed-NET-x86_64-Snapshot20161222-Media.iso loader=syslinux quiet resume=/dev/system/swap splash=silent quiet showopts
ima_tpm 1 TINFO: verify boot aggregate
ima_tpm 1 TINFO: used algorithm: sha1
ima_tpm 1 TINFO: IMA boot aggregate: '1172f0990296510ed39403b4f1de83c82e093aae'
ima_tpm 1 TPASS: bios boot aggregate matches IMA boot aggregate (1172f0990296510ed39403b4f1de83c82e093aae)
ima_tpm 2 TINFO: verify PCR values
ima_tpm 2 TINFO: evmctl version: evmctl 1.2.1
ima_tpm 2 TINFO: new PCRS path, evmctl >= 1.1 required
ima_tpm 2 TINFO: verify PCR (Process Control Register)
ima_tpm 2 TPASS: aggregate PCR value matches real PCR value

Summary:
passed   2
failed   0
skipped  0
warnings 0


> # head -1 /sys/kernel/security/ima/ascii_runtime_measurements

> 10 a3132d2501128ff527171658d40d8deb61e2292b ima-ng
> sha256:3fd5dc717f886ff7182526efc5edc3abb179a5aac1ab589c8ec888398233ae5
> b boot_aggregate

mine:
10 c125a1d3684a9737f20f6c1bc880782fae60fb28 ima-ng sha1:1172f0990296510ed39403b4f1de83c82e093aae boot_aggregate

> The ima-evm-utils next-testing branch has code to calculate the
> boot_aggregate based on multiple banks.
I see, 696bf0b ("ima-evm-utils: calculate the digests for multiple TPM banks")
I wonder whether it's reasonable trying to port that to ima_boot_aggregate.c or
just depend on evmctl. External dependencies are sometimes complicated, but for
IMA I incline to just require evmctl.

> # evmctl ima_boot_aggregate

> sha1:4cf3d105b1a1a41b951cc6431f0801c01fe50b24
> sha256:3fd5dc717f886ff7182526efc5edc3abb179a5aac1ab589c8ec888398233ae5b

Thus obviously evmctl (from next-testing) also gets only sha1
./src/evmctl ima_boot_aggregate
sha1:1172f0990296510ed39403b4f1de83c82e093aae

> There's also a new test to verify the boot_aggregate.

> $ VERBOSE=1 make check TESTS=boog_aggregate.test
BTW I got some errors
...
make  check-TESTS
make[2]: Entering directory '/home/foo/ima-evm-utils/tests'
make[3]: Entering directory '/home/foo/ima-evm-utils/tests'
make[4]: Entering directory '/home/foo/ima-evm-utils/tests'
make[4]: Nothing to be done for 'boog_aggregate.log'.
make[4]: Leaving directory '/home/foo/ima-evm-utils/tests'
fatal: making test-suite.log: failed to create boog_aggregate.trs
fatal: making test-suite.log: failed to create boog_aggregate.log
make[3]: *** [Makefile:516: test-suite.log] Error 1
make[3]: Leaving directory '/home/foo/ima-evm-utils/tests'
make[2]: *** [Makefile:625: check-TESTS] Error 2
make[2]: Leaving directory '/home/foo/ima-evm-utils/tests'
make[1]: *** [Makefile:692: check-am] Error 2
make[1]: Leaving directory '/home/foo/ima-evm-utils/tests'
make: *** [Makefile:514: check-recursive] Error 1

> Both need some review and testing before being released.
Any estimation when code is released?

Kind regards,
Petr
