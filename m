Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B2B6A57A6
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Feb 2023 12:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjB1LVp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 Feb 2023 06:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjB1LVo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Feb 2023 06:21:44 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FECF8A7C
        for <linux-integrity@vger.kernel.org>; Tue, 28 Feb 2023 03:21:39 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PQw1G094mz4wgv;
        Tue, 28 Feb 2023 22:21:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1677583298;
        bh=Qzkz7xSQK7QaLBmpwVbsSJkFMksdw/3aVgUvFCHphao=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ozDOMArDd9j0aGeIoLYJS/iqqbCyf2pKW2MPxKN3Me0bGwHibbwNUCV4FAJBfPS3S
         2V690d/yqr0a0WEg5qsu54QCt+N8FO1tr5CcjFfxkkEh58bSS8+D4O9wlgjkt5GWln
         SGZd56AXrl1q4TcgKDL6AHCGVs5XpvzXlFErvn/fzMYPDhYMSHkAj1AAGWSGFJPVAB
         DUkvRfa6kpdqAAN/qM8+cWm2RmfRWa9BuVWd39fU0g4LClLDVkfoz3MW2dz19A0PgI
         KvLnwWXPconXnRgXfmqEPZMVsZlYD626dKQRgo2jG8LDZKk+t+/954iqX9rbGfoxgB
         DqQP4ttPSCInA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org,
        yangyingliang@huawei.com, eajames@linux.ibm.com, jgg@ziepe.ca,
        peterhuewe@gmx.de
Subject: Re: [PATCH 1/2] powerpc/tpm: Create linux,sml-base/size as big endian
In-Reply-To: <Y/1wm3kmsto5tzeB@kernel.org>
References: <20230224032508.3331281-1-mpe@ellerman.id.au>
 <c2afd163-5f23-acab-fd39-3a5593ed6257@linux.ibm.com>
 <Y/1wm3kmsto5tzeB@kernel.org>
Date:   Tue, 28 Feb 2023 22:21:36 +1100
Message-ID: <87r0uaujb3.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Jarkko Sakkinen <jarkko@kernel.org> writes:
> On Mon, Feb 27, 2023 at 06:08:31PM -0500, Stefan Berger wrote:
>> On 2/23/23 22:25, Michael Ellerman wrote:
>> > There's code in prom_instantiate_sml() to do a "SML handover" (Stored
>> > Measurement Log) from OF to Linux, before Linux shuts down Open
>> > Firmware.
>> > 
>> > This involves creating a buffer to hold the SML, and creating two device
>> > tree properties to record its base address and size. The kernel then
>> > later reads those properties from the device tree to find the SML.
>> > 
>> > When the code was initially added in commit 4a727429abec ("PPC64: Add
>> > support for instantiating SML from Open Firmware") the powerpc kernel
>> > was always built big endian, so the properties were created big endian
>> > by default.
>> > 
>> > However since then little endian support was added to powerpc, and now
>> > the code lacks conversions to big endian when creating the properties.
>> > 
>> > This means on little endian kernels the device tree properties are
>> > little endian, which is contrary to the device tree spec, and in
>> > contrast to all other device tree properties.
>> > 
>> > To cope with that a workaround was added in tpm_read_log_of() to skip
>> > the endian conversion if the properties were created via the SML
>> > handover.
>> > 
>> > A better solution is to encode the properties as big endian as they
>> > should be, and remove the workaround.
>> > 
>> > Typically changing the encoding of a property like this would present
>> > problems for kexec. However the SML is not propagated across kexec, so
>> > changing the encoding of the properties is a non-issue.
>> > 
>> > Fixes: e46e22f12b19 ("tpm: enhance read_log_of() to support Physical TPM event log")
>> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> 
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>
> 2/2 does not have a fixes tag.

True. Arguably the bug goes back to the introduction of
kexec_file_load() support, although the patch won't backport that far
due to code refactoring. So that would be:

Fixes: a0458284f062 ("powerpc: Add support code for kexec_file_load()")

cheers
