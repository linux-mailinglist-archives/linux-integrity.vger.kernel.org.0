Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAE62F57C3
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Jan 2021 04:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbhANCGV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Jan 2021 21:06:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:42588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729109AbhANCGT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Jan 2021 21:06:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0C9223442;
        Thu, 14 Jan 2021 02:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610589938;
        bh=NNgK5BZvTtLVTBZUqJP4R8eSarXLcVpD1VeEm8Vu678=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uEbV8/lm9F6iat9HimlHsiyPyU7AtTod+Gg+fJNZtrdkgZzZFz+9JsAWD2RYgolAy
         zd23Qdv8WM3G/NHSLsEIu07x7B8V0NS0KLE2Cq6nAhkI1a2G7lDOnpvCG7UfwpERtY
         YSAfuut5osfYLOXLZjDF6T/hbMCAB1kUSspXmMpxzmH0DDX0fSf55dZKV3bBFkThsY
         AAUY/7Mz8S1jU4JIZahoaTywyTn/kTlM1YPf+vCrPm59ZUvORuNPcy/OlzXnc7K8at
         qj3qmvqCUzX0XG7wNxM+Csrb3WyJBgHr4QRrdYADo3S7lpxoyTGZPyjinLwkQsZEkz
         LINZx0hO334Bg==
Date:   Thu, 14 Jan 2021 04:05:31 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Markus Wamser <Markus.Wamser@mixed-mode.de>,
        Luke Hinds <lhinds@redhat.com>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 2/4] KEYS: trusted: Introduce TEE based Trusted Keys
Message-ID: <X/+m6+m2/snYj9Vc@kernel.org>
References: <1604419306-26105-1-git-send-email-sumit.garg@linaro.org>
 <1604419306-26105-3-git-send-email-sumit.garg@linaro.org>
 <X/x+N0fgrzIZTeNi@kernel.org>
 <CAFA6WYOUvWAZtYfR4q8beZFkX-CtdxqwJaRQM+GHNMDfQiEWOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYOUvWAZtYfR4q8beZFkX-CtdxqwJaRQM+GHNMDfQiEWOA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 13, 2021 at 04:47:00PM +0530, Sumit Garg wrote:
> Hi Jarkko,
> 
> On Mon, 11 Jan 2021 at 22:05, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Tue, Nov 03, 2020 at 09:31:44PM +0530, Sumit Garg wrote:
> > > Add support for TEE based trusted keys where TEE provides the functionality
> > > to seal and unseal trusted keys using hardware unique key.
> > >
> > > Refer to Documentation/tee.txt for detailed information about TEE.
> > >
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >
> > I haven't yet got QEMU environment working with aarch64, this produces
> > just a blank screen:
> >
> > ./output/host/usr/bin/qemu-system-aarch64 -M virt -cpu cortex-a53 -smp 1 -kernel output/images/Image -initrd output/images/rootfs.cpio -serial stdio
> >
> > My BuildRoot fork for TPM and keyring testing is located over here:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/buildroot-tpmdd.git/
> >
> > The "ARM version" is at this point in aarch64 branch. Over time I will
> > define tpmdd-x86_64 and tpmdd-aarch64 boards and everything will be then
> > in the master branch.
> >
> > To create identical images you just need to
> >
> > $ make tpmdd_defconfig && make
> >
> > Can you check if you see anything obviously wrong? I'm eager to test this
> > patch set, and in bigger picture I really need to have ready to run
> > aarch64 environment available.
> 
> I would rather suggest you to follow steps listed here [1] as to test
> this feature on Qemu aarch64 we need to build firmwares such as TF-A,
> OP-TEE, UEFI etc. which are all integrated into OP-TEE Qemu build
> system [2]. And then it would be easier to migrate them to your
> buildroot environment as well.
> 
> [1] https://lists.trustedfirmware.org/pipermail/op-tee/2020-May/000027.html
> [2] https://optee.readthedocs.io/en/latest/building/devices/qemu.html#qemu-v8
> 
> -Sumit

Can you provide 'keyctl_change'? Otherwise, the steps are easy to follow.

After I've successfully tested 2/4, I'd suggest that you roll out one more
version and CC the documentation patch to Elaine and Mini, and clearly
remark in the commit message that TEE is a standard, with a link to the
specification.

/Jarkko
