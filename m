Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C215F23B434
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Aug 2020 06:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbgHDEfK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Aug 2020 00:35:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:56564 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729149AbgHDEfK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Aug 2020 00:35:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E7C7EAB3D;
        Tue,  4 Aug 2020 04:35:23 +0000 (UTC)
Date:   Tue, 4 Aug 2020 06:35:04 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Lachlan Sneff <t-josne@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, ltp@lists.linux.it,
        nramas@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, tyhicks@linux.microsoft.com,
        yaneurabeya@gmail.com, zhang.jia@linux.alibaba.com
Subject: Re: [PATCH 1/3] IMA: Update key test documentation
Message-ID: <20200804043504.GA76360@x230>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200803184726.2416-1-t-josne@linux.microsoft.com>
 <20200803184726.2416-2-t-josne@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803184726.2416-2-t-josne@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lachlan,

> The current documentation for the existing IMA key test was
> left in by accident by a previous merge. It does not apply
> to the test that is currently included in the LTP.

> Update the documentation for the IMA key test.

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>
Thanks for fixing this, I propose this changes:

Fixes: d2768c84e ("IMA: Add a test to verify measurement of keys")

> ---
>  .../kernel/security/integrity/ima/README.md   | 22 +++++--------------
>  1 file changed, 5 insertions(+), 17 deletions(-)

> diff --git a/testcases/kernel/security/integrity/ima/README.md b/testcases/kernel/security/integrity/ima/README.md
> index d4644ba39..2956ac7fd 100644
> --- a/testcases/kernel/security/integrity/ima/README.md
> +++ b/testcases/kernel/security/integrity/ima/README.md
> @@ -15,27 +15,15 @@ Although a custom policy, loaded via dracut, systemd or manually from user
>  space, may contain equivalent measurement tcb rules, detecting them would
>  require `IMA_READ_POLICY=y` therefore ignore this option.

> -### IMA key import test
> -`ima_keys.sh` requires a x509 public key, by default in `/etc/keys/x509_ima.der`
> -(defined in `CONFIG_IMA_X509_PATH` kernel config option).
> -The key must be signed by the private key you generate. Follow these instructions:
> -https://manpages.ubuntu.com/manpages/disco/man1/evmctl.1.html#generate%20trusted%20keys
> -
> -The test cannot be set-up automatically because the x509 public key must be
> -built into the kernel and loaded onto a trusted keyring
> -(e.g. `.builtin_trusted_keys`, `.secondary_trusted_keyring`).
> -
> -As well as what's required for the IMA tests, the following are also required
> -in the kernel configuration:
> +### IMA key test
> +`ima_keys.sh` requires a readable IMA policy, as well as a loaded policy
> +with `func=KEY_CHECK keyrings=...`, see example in `keycheck.policy`.
> +
> +Mandatory kernel configuration for IMA:
This "Mandatory kernel configuration for IMA:" would be in docs twice. The above
one (CONFIG_INTEGRITY=y, CONFIG_IMA=y) is required for all tests.
Take it that "### IMA key test" is header 3, but ## IMA tests
is header 2 (upper level).

>  ```
>  CONFIG_IMA_READ_POLICY=y
> -CONFIG_IMA_X509_PATH="/etc/keys/x509_ima.der"
> -CONFIG_SYSTEM_TRUSTED_KEYRING=y
> -CONFIG_SYSTEM_TRUSTED_KEYS="/etc/keys/ima-local-ca.pem"
>  ```

> -Test also requires loaded policy with `func=KEY_CHECK`, see example in `keycheck.policy`.
> -
>  ### IMA kexec test

>  `ima_kexec.sh` requires loaded policy which contains `measure func=KEXEC_CMDLINE`,

I also removed "IMA" from EVM tests header.

Kind regards,
Petr

diff --git testcases/kernel/security/integrity/ima/README.md testcases/kernel/security/integrity/ima/README.md
index 2956ac7fd..392e1e868 100644
--- testcases/kernel/security/integrity/ima/README.md
+++ testcases/kernel/security/integrity/ima/README.md
@@ -19,7 +19,8 @@ require `IMA_READ_POLICY=y` therefore ignore this option.
 `ima_keys.sh` requires a readable IMA policy, as well as a loaded policy
 with `func=KEY_CHECK keyrings=...`, see example in `keycheck.policy`.
 
-Mandatory kernel configuration for IMA:
+As well as what's required for the IMA tests, the following are also required
+-in the kernel configuration:
 ```
 CONFIG_IMA_READ_POLICY=y
 ```
@@ -38,7 +39,7 @@ To kexec a different kernel image export `IMA_KEXEC_IMAGE=<pathname>`.
 kernel parameter) which appraises the integrity of all files owned by root and EVM setup.
 Again, for simplicity ignore possibility to load requires rules via custom policy.
 
-Mandatory kernel configuration for IMA & EVM:
+Mandatory kernel configuration for EVM tests:
 ```
 CONFIG_INTEGRITY=y
 CONFIG_INTEGRITY_SIGNATURE=y
@@ -50,7 +51,7 @@ CONFIG_TRUSTED_KEYS=y
 CONFIG_ENCRYPTED_KEYS=y
 ```
 
-Example of installing IMA + EVM on openSUSE:
+Example of preparing environment on for EVM on openSUSE:
 
 * Boot install system with `ima_policy=tcb|appraise_tcb ima_appraise=fix evm=fix` kernel parameters
   (for IMA measurement, IMA appraisal and EVM protection)
