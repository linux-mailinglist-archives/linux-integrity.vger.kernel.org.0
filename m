Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E5F6A7793
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Mar 2023 00:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCAXJ6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Mar 2023 18:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCAXJ5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Mar 2023 18:09:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632D1126F9
        for <linux-integrity@vger.kernel.org>; Wed,  1 Mar 2023 15:09:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAE86614B5
        for <linux-integrity@vger.kernel.org>; Wed,  1 Mar 2023 23:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04918C433EF;
        Wed,  1 Mar 2023 23:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677712195;
        bh=6xF2bS9+IFQDCx6Cz15lcI9nmFQE54LHi90Yyw/kHvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P5D5QOYgEyKNQZ9f6ppESpNkKgS5MnyG2PjBtyyalUY+ZBeKlty4L6Mzd+TMR+F95
         t4nvGP5IdizIJhOERO/0RHxbulT3yM+w+JWQF9Y65P7a4N83w6Wp80Ux45qlgS/fCd
         0XZxCl7Wm9idMSzdwiVBjElevlBebEMNfKO5JmDK2Oe7ppXS7brxo6jSLIZpLZwrDm
         en8+StcvKLIcX1ze3lzYJsUEe/olilY7rrMXdqqa+kpPzJpTOFhUo7s/1odVnPiupH
         9hUKym8mFaOgl2TB44HiLLvQ9jWyISJwad3DQpxHAOqrpYfVkheHb6ejgJTcdBdz0l
         LMScX42SKYdkQ==
Date:   Thu, 2 Mar 2023 01:09:53 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org,
        yangyingliang@huawei.com, eajames@linux.ibm.com, jgg@ziepe.ca,
        peterhuewe@gmx.de
Subject: Re: [PATCH 1/2] powerpc/tpm: Create linux,sml-base/size as big endian
Message-ID: <Y//bQe1Zd32bLy+J@kernel.org>
References: <20230224032508.3331281-1-mpe@ellerman.id.au>
 <c2afd163-5f23-acab-fd39-3a5593ed6257@linux.ibm.com>
 <Y/1wm3kmsto5tzeB@kernel.org>
 <87r0uaujb3.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0uaujb3.fsf@mpe.ellerman.id.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 28, 2023 at 10:21:36PM +1100, Michael Ellerman wrote:
> Jarkko Sakkinen <jarkko@kernel.org> writes:
> > On Mon, Feb 27, 2023 at 06:08:31PM -0500, Stefan Berger wrote:
> >> On 2/23/23 22:25, Michael Ellerman wrote:
> >> > There's code in prom_instantiate_sml() to do a "SML handover" (Stored
> >> > Measurement Log) from OF to Linux, before Linux shuts down Open
> >> > Firmware.
> >> > 
> >> > This involves creating a buffer to hold the SML, and creating two device
> >> > tree properties to record its base address and size. The kernel then
> >> > later reads those properties from the device tree to find the SML.
> >> > 
> >> > When the code was initially added in commit 4a727429abec ("PPC64: Add
> >> > support for instantiating SML from Open Firmware") the powerpc kernel
> >> > was always built big endian, so the properties were created big endian
> >> > by default.
> >> > 
> >> > However since then little endian support was added to powerpc, and now
> >> > the code lacks conversions to big endian when creating the properties.
> >> > 
> >> > This means on little endian kernels the device tree properties are
> >> > little endian, which is contrary to the device tree spec, and in
> >> > contrast to all other device tree properties.
> >> > 
> >> > To cope with that a workaround was added in tpm_read_log_of() to skip
> >> > the endian conversion if the properties were created via the SML
> >> > handover.
> >> > 
> >> > A better solution is to encode the properties as big endian as they
> >> > should be, and remove the workaround.
> >> > 
> >> > Typically changing the encoding of a property like this would present
> >> > problems for kexec. However the SML is not propagated across kexec, so
> >> > changing the encoding of the properties is a non-issue.
> >> > 
> >> > Fixes: e46e22f12b19 ("tpm: enhance read_log_of() to support Physical TPM event log")
> >> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> >> 
> >> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> >
> > 2/2 does not have a fixes tag.
> 
> True. Arguably the bug goes back to the introduction of
> kexec_file_load() support, although the patch won't backport that far
> due to code refactoring. So that would be:
> 
> Fixes: a0458284f062 ("powerpc: Add support code for kexec_file_load()")

Hmm... IMHO, it would still make sense to document this.

BR, Jarkko
