Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BAB2F49DC
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Jan 2021 12:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbhAMLRy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Jan 2021 06:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbhAMLRx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Jan 2021 06:17:53 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AD2C06179F
        for <linux-integrity@vger.kernel.org>; Wed, 13 Jan 2021 03:17:12 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id o19so2221778lfo.1
        for <linux-integrity@vger.kernel.org>; Wed, 13 Jan 2021 03:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TAxh0QRvG+U9nWMtk6yUVRJ8OL/Nsz5USXDEEU+kuLw=;
        b=hjKQy54pj428UdfskrcDqwX2PEoAuGx3i2g7PycDem6NXMGRHHmGGyHmVKwWLb2K3J
         GuCbG2pSWNT9EckrACedFivAg7m266Bek8bObR0AWPoaMYAIxLF4kyEoFgxdxCys/z2O
         1M2sH3NJT6oCtEB49yIGbpWyB9hsme9sBdr9hxRICtZApQMPPnUjWWzc2M1Zd4hFsvgG
         uji2fNoa/rsQcIj+hu18ZBNFHEL92k4D5/8f5dYZvaqKQELkydytmCDEthvAlm+xp2CH
         jawETw48NCp3uaDciJagmM/I2m4mDeIiV0WqM9x++VNbLXd50mJ2oGlO07uAiYEAkZlM
         TxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TAxh0QRvG+U9nWMtk6yUVRJ8OL/Nsz5USXDEEU+kuLw=;
        b=K+RWQHrgKpkGK5MwunXyLFpmLYlDpKWUhGWXdCPs/kfudZzpvWbp16u7xarM46amhO
         yc46dwK73lNpTCghb/OG4jKVwDlGHkJTKqRYBOthXSIfkp2ugmlcbz3xNQ5U3PzdHK8r
         0xrzjbTjGZS8mffLBcOlmjT+NrEpr6xf09lHeQ8jOh5xoRhCrv+zgl18pfCnavDQHBx4
         FRVMKnQTMI5bsMRCZz1PlU5WfY5Wpi73CRHzRnCqfWn+1sUPJWi3rhlhceIktxxN1FRa
         G4+ULHKBJudiKtAV+GljMtKKl8JuUO+yPxRIss+CpSPwP1qz4ZZeM3XKJa2N1vUeCDEL
         gSlw==
X-Gm-Message-State: AOAM530MdMj+ppg+JQdWluoyWRiH4FoF1DqwpM6DJEUwURBgttXUXypW
        nzqjRRkHBlpKJNE+t6iEY7QSSi5dRRaHiDdMe8/eAg==
X-Google-Smtp-Source: ABdhPJweF4+YKogH4cN92gRs6BUwNLlYpSWHBGR0Ptdw8KYpzPSd0hSF3S5iZRq39IC4We8OFJ8+kD0bPFuTv8QjcXc=
X-Received: by 2002:a19:c211:: with SMTP id l17mr671408lfc.194.1610536631374;
 Wed, 13 Jan 2021 03:17:11 -0800 (PST)
MIME-Version: 1.0
References: <1604419306-26105-1-git-send-email-sumit.garg@linaro.org>
 <1604419306-26105-3-git-send-email-sumit.garg@linaro.org> <X/x+N0fgrzIZTeNi@kernel.org>
In-Reply-To: <X/x+N0fgrzIZTeNi@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 13 Jan 2021 16:47:00 +0530
Message-ID: <CAFA6WYOUvWAZtYfR4q8beZFkX-CtdxqwJaRQM+GHNMDfQiEWOA@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] KEYS: trusted: Introduce TEE based Trusted Keys
To:     Jarkko Sakkinen <jarkko@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jarkko,

On Mon, 11 Jan 2021 at 22:05, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Tue, Nov 03, 2020 at 09:31:44PM +0530, Sumit Garg wrote:
> > Add support for TEE based trusted keys where TEE provides the functionality
> > to seal and unseal trusted keys using hardware unique key.
> >
> > Refer to Documentation/tee.txt for detailed information about TEE.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> I haven't yet got QEMU environment working with aarch64, this produces
> just a blank screen:
>
> ./output/host/usr/bin/qemu-system-aarch64 -M virt -cpu cortex-a53 -smp 1 -kernel output/images/Image -initrd output/images/rootfs.cpio -serial stdio
>
> My BuildRoot fork for TPM and keyring testing is located over here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/buildroot-tpmdd.git/
>
> The "ARM version" is at this point in aarch64 branch. Over time I will
> define tpmdd-x86_64 and tpmdd-aarch64 boards and everything will be then
> in the master branch.
>
> To create identical images you just need to
>
> $ make tpmdd_defconfig && make
>
> Can you check if you see anything obviously wrong? I'm eager to test this
> patch set, and in bigger picture I really need to have ready to run
> aarch64 environment available.

I would rather suggest you to follow steps listed here [1] as to test
this feature on Qemu aarch64 we need to build firmwares such as TF-A,
OP-TEE, UEFI etc. which are all integrated into OP-TEE Qemu build
system [2]. And then it would be easier to migrate them to your
buildroot environment as well.

[1] https://lists.trustedfirmware.org/pipermail/op-tee/2020-May/000027.html
[2] https://optee.readthedocs.io/en/latest/building/devices/qemu.html#qemu-v8

-Sumit

>
> /Jarkko
