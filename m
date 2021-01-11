Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0D12F1B0A
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Jan 2021 17:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732337AbhAKQfv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Jan 2021 11:35:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:42352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbhAKQfv (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Jan 2021 11:35:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCB3320B1F;
        Mon, 11 Jan 2021 16:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610382910;
        bh=JwHzWOn98yP3yzjPMaZT6BMENGep8O1PUosAAXMJ+PQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LjWTOdqglUL1RdtD3rwVIVY38br9kVmLGLXirDWW1EgbAq4d1GdUpUUgPEWivBPE2
         nnO0Nom/TCusPJLUkaV/mH09njqN/xX6cUTBgSjpx3iPeJqpMf7b1wNxxZdM0mdoQy
         FehL8I6bcBffc0xWYD9pECgm/7iofA/JISWVRGSQGDyExFlnHY4fggpaOOm//UQ/Xy
         nKL2GNEeWxfYAVvQlKVKMdcD5RrBqe58NqbrAwMYg7TI83hAHhydx63rh0yoOCccWd
         5yt0G0ygSQQDAyMSozaTDMqMiOXzQECWhY91mhRHR1jgVPDqdnbjlpCiOGKfM147JP
         wB994mNoJ52yg==
Date:   Mon, 11 Jan 2021 18:35:03 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com,
        jejb@linux.ibm.com, dhowells@redhat.com, jens.wiklander@linaro.org,
        corbet@lwn.net, jmorris@namei.org, serge@hallyn.com,
        casey@schaufler-ca.com, janne.karhunen@gmail.com,
        daniel.thompson@linaro.org, Markus.Wamser@mixed-mode.de,
        lhinds@redhat.com, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 2/4] KEYS: trusted: Introduce TEE based Trusted Keys
Message-ID: <X/x+N0fgrzIZTeNi@kernel.org>
References: <1604419306-26105-1-git-send-email-sumit.garg@linaro.org>
 <1604419306-26105-3-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604419306-26105-3-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Nov 03, 2020 at 09:31:44PM +0530, Sumit Garg wrote:
> Add support for TEE based trusted keys where TEE provides the functionality
> to seal and unseal trusted keys using hardware unique key.
> 
> Refer to Documentation/tee.txt for detailed information about TEE.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

I haven't yet got QEMU environment working with aarch64, this produces
just a blank screen:

./output/host/usr/bin/qemu-system-aarch64 -M virt -cpu cortex-a53 -smp 1 -kernel output/images/Image -initrd output/images/rootfs.cpio -serial stdio

My BuildRoot fork for TPM and keyring testing is located over here:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/buildroot-tpmdd.git/

The "ARM version" is at this point in aarch64 branch. Over time I will
define tpmdd-x86_64 and tpmdd-aarch64 boards and everything will be then
in the master branch.

To create identical images you just need to

$ make tpmdd_defconfig && make

Can you check if you see anything obviously wrong? I'm eager to test this
patch set, and in bigger picture I really need to have ready to run
aarch64 environment available.

/Jarkko
