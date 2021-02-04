Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8727230E84B
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Feb 2021 01:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbhBDAGg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 Feb 2021 19:06:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:32792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233288AbhBDAGd (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Feb 2021 19:06:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DDED64E40;
        Thu,  4 Feb 2021 00:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612397152;
        bh=FAOEqJqOki9bCT6WXoW+ukEFUCMr85/l4i4KTBllngQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B/EtOe+Wtnkgu7tZ1fIEmgMOVLesKKLVUioSQah+hpkwFycB8GIqacfK+hzSOP7Pe
         JgkkbO5h0K/S5HvS969GQIOpRhD2AwBLjgSJ4+xMXjl9gpFfj8Fju2g5ndkicSWph5
         B3sBiNDPPJImlpFL9Q5CzDpWPV56GKy6IbpWuvoMD+ya2Aip/n6yocDvr1Z8RfriDP
         Ghe+qckAelI5g+698B973bOpPDAFXee+S2iNQOFz1vPlvBYmMbsSbmQw40LUK5b+Xn
         1l8Jmwq/Y8Q3S+o/PJuJIueY7kPG8bY5Cz3RF93pagOB+08ghwxr96WUeVG8Wic9Au
         jTH63eyVYOyKw==
Date:   Thu, 4 Feb 2021 02:05:46 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jerome Forissier <jerome@forissier.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        op-tee@lists.trustedfirmware.org, Jonathan Corbet <corbet@lwn.net>,
        James Bottomley <jejb@linux.ibm.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Luke Hinds <lhinds@redhat.com>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-integrity@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Yann E. MORIN" <yann.morin.1998@free.fr>
Subject: Re: [PATCH v8 2/4] KEYS: trusted: Introduce TEE based Trusted Keys
Message-ID: <YBs6WsGifYudzzPB@kernel.org>
References: <YAa0ys4YJcZtKdfF@kernel.org>
 <YAeH2pb8szQyjusL@kernel.org>
 <CAFA6WYP5G6NfGk96ePOC+2kpD6B+4hz9nywyUM9Nh=dJDYMiuA@mail.gmail.com>
 <01000177223f74d3-1eef7685-4a19-40d2-ace6-d4cd7f35579d-000000@email.amazonses.com>
 <dc3979e8-6bf0-adb7-164d-d50e805a048f@forissier.org>
 <YAmYu9FxWcLPhBhs@kernel.org>
 <YAmcyKnYCK+Y4IGW@kernel.org>
 <1486cfe8-bc30-1266-12bd-0049f2b64820@forissier.org>
 <YAsVenGkaqb8205f@kernel.org>
 <CAFA6WYPQ+LZyHKZJQb=3euTy8f8TO3HqCADojpZaHXgtzNj+fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYPQ+LZyHKZJQb=3euTy8f8TO3HqCADojpZaHXgtzNj+fw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jan 25, 2021 at 02:47:38PM +0530, Sumit Garg wrote:
> The main reason to guide you towards the OP-TEE build system is that
> you will be able to build all the firmwares (TF-A, OP-TEE, edk2 etc.)
> from source. If you don't need to rebuild those then I have prepared a
> flash firmware binary blob for your testing (attached flash.bin). So
> Qemu cmdline will look like:
> 
> $ qemu-system-aarch64 -nographic -s -machine virt,secure=on -cpu
> cortex-a57 -kernel out/bin/Image -no-acpi -append
> 'console=ttyAMA0,38400 keep_bootcon root=/dev/vda2' -initrd
> out/bin/rootfs.cpio.gz -smp 2 -m 1024 -bios flash.bin -d unimp
> 
> Here you can use "Image" and "rootfs.cpio.gz" from your plain BR builds.
> 
> Give it a try and let me know if this works for you.

Sumit, I can try this again now :-) Thanks Yann for fixing the issue!

https://git.busybox.net/buildroot/commit/?id=b9e7adc152b5811b20724d8c05f0f2117254919c

/Jarkko
