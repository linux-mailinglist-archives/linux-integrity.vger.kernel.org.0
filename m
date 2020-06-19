Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB46D200605
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jun 2020 12:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732225AbgFSKHl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Jun 2020 06:07:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:53236 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732048AbgFSKHl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Jun 2020 06:07:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9AE8FB048;
        Fri, 19 Jun 2020 10:07:38 +0000 (UTC)
Date:   Fri, 19 Jun 2020 12:07:37 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Bruno Meneguele <bmeneg@redhat.com>, ltp@lists.linux.it,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Petr Cervinka <pcervinka@suse.com>,
        Cyril Hrubis <chrubis@suse.cz>,
        linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>,
        Maurizio Drocco <maurizio.drocco@ibm.com>
Subject: Re: [LTP v2 1/1] ima_tpm.sh: Fix for calculating boot aggregate
Message-ID: <20200619100737.GB18704@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200527071434.28574-1-pvorel@suse.cz>
 <1590601280.16219.1.camel@linux.ibm.com>
 <20200528140747.GA8401@dell5510>
 <1590679145.4457.39.camel@linux.ibm.com>
 <20200528160527.GA27243@dell5510>
 <20200615194134.GF129694@glitch>
 <1592252491.11061.181.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1592252491.11061.181.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi all,

> On Mon, 2020-06-15 at 16:41 -0300, Bruno Meneguele wrote:
> > On Thu, May 28, 2020 at 06:05:27PM +0200, Petr Vorel wrote:
> > > Hi Mimi,
...
> > > To sum that: my patch is required for any system without physical TPM with with
> > > kernel with b59fda449cf0 + it also works for TPM 1.2 (regardless kernel
> > > version), because TPM 1.2 supports sha1 only boot aggregate.

> > > But testing on kernel with b59fda449cf0 with TPM 2.0 is not only broken with
> > > this patch, but also on current version in master, right? As you have
> > > sha256:3fd5dc717f886ff7182526efc5edc3abb179a5aac1ab589c8ec888398233ae5 anyway.
> > > So this patch would help at least testing on VM without vTPM.


> > If we consider to delay this change until we have the ima-evm-utils
> > released with the ima_boot_aggregate + make this test dependent on
> > both ima-evm-utils and tsspcrread, would it be worth to SKIP the test in
> > case a TPM2.0 sha256 bank is detected instead of FAIL? Thus we could
> > have the test fixed for TPM1.2 && no-TPM cases until we get the full
> > support for multiple banks?
+1

> As long as we're dealing with the "boot_aggregate", Maurizio just
> posted a kernel patch for including PCR 8 & 9 in the boot_aggregate.
>  The existing IMA LTP "boot_aggregate" test is going to need to
> support this change.
I'm not sure if I did something wrong, but it looks to me that 'evmctl
ima_boot_aggregate' does not provide backward compatibility with TPM 1.2.
Or am I wrong?

And given the fact that new evmctl is not released, I'd adapt the test just for
TPM 1.2 && no-TPM as Bruno suggested (TCONF if
/sys/class/tpm/tpm0/tpm_version_major presented and not 1, print info about TPM
2.0 not yet supported otherwise).

BTW what is the correct way for systems with more TPM (is there any? It looks
it's possible [1]). Which of them is used? Should I loop over
/sys/class/tpm/tpm*/tpm_version_major or just use
/sys/class/tpm/tpm0/tpm_version_major?

Kind regards,
Petr

[1] https://letstrust.de/archives/29-New-fun-fact!.html
