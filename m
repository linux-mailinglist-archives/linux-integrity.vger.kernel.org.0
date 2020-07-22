Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821DD229F46
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Jul 2020 20:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgGVScE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Jul 2020 14:32:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgGVScE (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Jul 2020 14:32:04 -0400
Received: from localhost.localdomain (pool-96-246-152-186.nycmny.fios.verizon.net [96.246.152.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0612420714;
        Wed, 22 Jul 2020 18:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595442723;
        bh=Ej7eb6WRvQeFRdUgnRjsIBu5uXweOW5ytKzwLo5Afbk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CbACEJnAveYL+vdtshYbCbyv7U5XmiAol7J6Hp0j1zM33YkK3mSGFLrxW7PUW1SRT
         41DSm1zZIiTx2468OO5N9pd9VpeddV4FMHxsBms9j7NwnKH/oCDWyVgumVYLVPSKxR
         XgiB4TVt9h/FlmvNvqhBpwElXs6b0oglyRbUseHg=
Message-ID: <1595442721.5211.7.camel@kernel.org>
Subject: Re: [PATCH v2] IMA: Add test for kexec cmdline measurement
From:   Mimi Zohar <zohar@kernel.org>
To:     Lachlan Sneff <t-josne@linux.microsoft.com>, pvorel@suse.cz,
        ltp@lists.linux.it
Cc:     nramas@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org
Date:   Wed, 22 Jul 2020 14:32:01 -0400
In-Reply-To: <1595441389.5211.1.camel@linux.ibm.com>
References: <20200722164040.23109-1-t-josne@linux.microsoft.com>
         <1595441389.5211.1.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-07-22 at 14:09 -0400, Mimi Zohar wrote:
> On Wed, 2020-07-22 at 12:40 -0400, Lachlan Sneff wrote:
> > IMA policy can be set to measure the command line passed in the kexec system call.
> > There needs to be a test to validate this kexec command line measurement.
> > 
> > Add a testcase that verifies that the IMA subsystem has correctly
> > measured the cmdline specified during a kexec.
> > 
> > Note that this test does not actually reboot.
> > 
> > Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
> 
> Other than the patch not applying cleanly and leading blanks, 
> 
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Oops, the kexec load is using the '-s' option, similarly the unload
should use it too.  Please change all the "kexec -u" occurences to
"kexec -su".

+    if ! kexec -sl $IMAGE --reuse-cmdline; then
> +        tst_res TCONF "kexec failed: $?"
> +        
> +        local sb_status="$(bootctl status 2>/dev/null | grep 'Secure Boot' \
> +            | tr -d ' ' | sed 's/SecureBoot:*//')"
> +        
> +        if [ "$sb_status" = "enabled" ]; then
> +            tst_res TINFO "secure boot is enabled, the specified kernel image may not be signed"
> +        fi
> +
> +        return
> +    fi
> +
> +    kexec -u
> +
> +    if ! measure "$cmdline"; then
> +        tst_res TFAIL "unable to find a correct entry in the IMA log"
> +        
> +        if [ ! -r $IMA_POLICY ]; then
> +            tst_brk TCONF "cannot read IMA policy (CONFIG_IMA_READ_POLICY=y required) to give contextual information"
> +        fi
> +
> +        if ! grep "measure func=KEXEC_CMDLINE" $IMA_POLICY >/dev/null; then
> +            tst_brk TCONF "The IMA policy does not specify 'measure func=KEXEC_CMDLINE', see IMA test README"
> +        fi
> +
> +        return
> +    fi
> +
> +    cmdline="foo"cmldine
> +    if ! kexec -sl $IMAGE --append=$cmdline; then
> +        tst_brk TCONF "kexec failed: $?"
> +    fi
> +
> +    kexec -u
