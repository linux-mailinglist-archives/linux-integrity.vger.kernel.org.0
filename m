Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806DD2A97E7
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Nov 2020 15:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgKFOxB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Nov 2020 09:53:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:41134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbgKFOxB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Nov 2020 09:53:01 -0500
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68C9921556;
        Fri,  6 Nov 2020 14:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604674380;
        bh=EFmjPlOdyLT5ZNZK+D5Ee4aaKlYdMVdLhDBsCsU5sfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K/OUy9MS5Am1Y+Darp4BPkNby574zAigogMyhAp4k8pvYpHAxPOYk4gX4KCmd8ecI
         Ns7qUatjY6s1MEBfBIW8TWTkmlIs43PQiO60Kf9f1rcPqRnr45bVNb3AR7jD6Ucwlp
         EqKT0+YVEJPn0xwiDQCx3AXVdCbVYsK1OPdwAWDk=
Date:   Fri, 6 Nov 2020 16:52:52 +0200
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
Subject: Re: [PATCH v8 0/4] Introduce TEE based Trusted Keys support
Message-ID: <20201106145252.GA10434@kernel.org>
References: <1604419306-26105-1-git-send-email-sumit.garg@linaro.org>
 <20201105050736.GA702944@kernel.org>
 <CAFA6WYPetvod-Wov2n_L5TL771j+-kt+_csyWYT-uM=haEKMZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYPetvod-Wov2n_L5TL771j+-kt+_csyWYT-uM=haEKMZQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Nov 06, 2020 at 03:02:41PM +0530, Sumit Garg wrote:
> On Thu, 5 Nov 2020 at 10:37, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Tue, Nov 03, 2020 at 09:31:42PM +0530, Sumit Garg wrote:
> > > Add support for TEE based trusted keys where TEE provides the functionality
> > > to seal and unseal trusted keys using hardware unique key. Also, this is
> > > an alternative in case platform doesn't possess a TPM device.
> > >
> > > This patch-set has been tested with OP-TEE based early TA which is already
> > > merged in upstream [1].
> >
> > Is the new RPI400 computer a platform that can be used for testing
> > patch sets like this? I've been looking for a while something ARM64
> > based with similar convenience as Intel NUC's, and on the surface
> > this new RPI product looks great for kernel testing purposes.
> 
> Here [1] is the list of supported versions of Raspberry Pi in OP-TEE.
> The easiest approach would be to pick up a supported version or else
> do an OP-TEE port for an unsupported one (which should involve minimal
> effort).
> 
> [1] https://optee.readthedocs.io/en/latest/building/devices/rpi3.html#what-versions-of-raspberry-pi-will-work
> 
> -Sumit

If porting is doable, then I'll just order RPI 400, and test with QEMU
up until either I port OP-TEE myself or someone else does it.

For seldom ARM testing, RPI 400 is really convenient device with its
boxed form factor.

/Jarkko
