Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6960750866
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Jul 2023 14:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjGLMfD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Jul 2023 08:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjGLMfB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Jul 2023 08:35:01 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF9610EF
        for <linux-integrity@vger.kernel.org>; Wed, 12 Jul 2023 05:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1689165294;
        bh=l35p0TcEUmDUj/vXsObL62vUHe1+adoudEDWvF7VoK8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hvmfEYYloo9+IRmXyrs4Arl/1kGU/paHNLUvie0T/nS6bRdMeeoB4WC7r+jeOIev9
         IayCUcVlviVodp3t3DV7/StkH94zI7nQDkG2FwVHeewYTleMnXbbkGBxGTdrRYROij
         LzBUNSxJTqRxFR1Ha25q55R5S6VKLCC19BLMcDRI3kpJLtqbm8511rPSMs+c6Ir3oI
         IS3gGq8K1J0acwa4JjPmQ0YMOcxVcgMAU3MjD1/gR2OBjfTngZjAjE1jHJeqnQZ8YD
         OQjJCotWDyb08kBL6MMPltKIlGmU0b1drzbQy6fyJJgUw6mjn920EQnDJz29ybLOS+
         L/xWDipukI61Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R1HHx21V2z4wxW;
        Wed, 12 Jul 2023 22:34:53 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Cc:     eajames@linux.ibm.com, jgg@ziepe.ca, yangyingliang@huawei.com,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de
Subject: Re: [PATCH v2 1/2] powerpc/tpm: Create linux,sml-base/size as big
 endian
In-Reply-To: <0fb26243-0d63-118b-2737-05391ba0c69a@linux.ibm.com>
References: <20230615123703.4028156-1-mpe@ellerman.id.au>
 <4d378d53225fc8b8cdc99dde900388d2eefaad4e.camel@kernel.org>
 <0fb26243-0d63-118b-2737-05391ba0c69a@linux.ibm.com>
Date:   Wed, 12 Jul 2023 22:34:47 +1000
Message-ID: <87ttu9e2ag.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Stefan Berger <stefanb@linux.ibm.com> writes:
> On 7/10/23 17:23, Jarkko Sakkinen wrote:
>> On Thu, 2023-06-15 at 22:37 +1000, Michael Ellerman wrote:
>>> There's code in prom_instantiate_sml() to do a "SML handover" (Stored
>>> Measurement Log) from OF to Linux, before Linux shuts down Open
>>> Firmware.
>>>
>>> This involves creating a buffer to hold the SML, and creating two device
>>> tree properties to record its base address and size. The kernel then
>>> later reads those properties from the device tree to find the SML.
>>>
>>> When the code was initially added in commit 4a727429abec ("PPC64: Add
>>> support for instantiating SML from Open Firmware") the powerpc kernel
>>> was always built big endian, so the properties were created big endian
>>> by default.
>>>
>>> However since then little endian support was added to powerpc, and now
>>> the code lacks conversions to big endian when creating the properties.
>>>
>>> This means on little endian kernels the device tree properties are
>>> little endian, which is contrary to the device tree spec, and in
>>> contrast to all other device tree properties.
>>>
>>> To cope with that a workaround was added in tpm_read_log_of() to skip
>>> the endian conversion if the properties were created via the SML
>>> handover.
>>>
>>> A better solution is to encode the properties as big endian as they
>>> should be, and remove the workaround.
>>>
>>> Typically changing the encoding of a property like this would present
>>> problems for kexec. However the SML is not propagated across kexec, so
>>> changing the encoding of the properties is a non-issue.
>>>
>>> Fixes: e46e22f12b19 ("tpm: enhance read_log_of() to support Physical TPM event log")
>>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>>> ---
>>>   arch/powerpc/kernel/prom_init.c |  8 ++++++--
>>>   drivers/char/tpm/eventlog/of.c  | 23 ++++-------------------
>>>   2 files changed, 10 insertions(+), 21 deletions(-)
>> 
>> Split into two patches (producer and consumer).
>
> I think this wouldn't be right since it would break the system when
> only one patch is applied since it would be reading the fields in the
> wrong endianess.

Yes that's right.

Typically we would split the patch by subsystem, but in this case it
will just create a known-broken point in the git history, which helps no
one.

cheers
