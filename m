Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8B9750880
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Jul 2023 14:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjGLMja (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Jul 2023 08:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbjGLMj3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Jul 2023 08:39:29 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7141718
        for <linux-integrity@vger.kernel.org>; Wed, 12 Jul 2023 05:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1689165566;
        bh=T6VYKVVfdvano9tjQIzE080BQEj4ZRWAzPeP9tElmhY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=nOluD2tjGFa+bExvfZOwLud99ykHUhRE00PF+K2HOPFyA9Nx8NwYhHs851k3QFzId
         Qr51LbARimQvjkIbBrxlMqraHbR4X+s2kwUvrL2aywcsceNYnXmCSAAyHyN8gk4cRC
         7Ri8SM13HjnNfaKsq7kop8n0kO64dq4gkjLQNvQQznOCDSOoWsGl64+JeL36tDwWJ4
         T/6ZJJyNMW6g4ocrK8geUxAVuxukNNEA50KSQc8D/RL9BoNqUeDnajp7AmikFNZf7p
         eVDTWOGCn27X8+Vr0CbAW5rvwCjvqag6rAJJGZXGbbR0dImlQPixbmdq60ol4QNPE5
         mHhnQvaLpkBig==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R1HPB11XDz4wxR;
        Wed, 12 Jul 2023 22:39:26 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     eajames@linux.ibm.com, jgg@ziepe.ca, yangyingliang@huawei.com,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de
Subject: Re: [PATCH v2 1/2] powerpc/tpm: Create linux,sml-base/size as big
 endian
In-Reply-To: <ec564375084b6edd7b7d77eb341f451e798fb50d.camel@kernel.org>
References: <20230615123703.4028156-1-mpe@ellerman.id.au>
 <4d378d53225fc8b8cdc99dde900388d2eefaad4e.camel@kernel.org>
 <0fb26243-0d63-118b-2737-05391ba0c69a@linux.ibm.com>
 <ec564375084b6edd7b7d77eb341f451e798fb50d.camel@kernel.org>
Date:   Wed, 12 Jul 2023 22:39:25 +1000
Message-ID: <87r0pde22q.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Jarkko Sakkinen <jarkko@kernel.org> writes:
> On Tue, 2023-07-11 at 08:47 -0400, Stefan Berger wrote:
>> On 7/10/23 17:23, Jarkko Sakkinen wrote:
>> > On Thu, 2023-06-15 at 22:37 +1000, Michael Ellerman wrote:
>> > > There's code in prom_instantiate_sml() to do a "SML handover" (Stored
>> > > Measurement Log) from OF to Linux, before Linux shuts down Open
>> > > Firmware.
>> > >=20
>> > > This involves creating a buffer to hold the SML, and creating two de=
vice
>> > > tree properties to record its base address and size. The kernel then
>> > > later reads those properties from the device tree to find the SML.
>> > >=20
>> > > When the code was initially added in commit 4a727429abec ("PPC64: Add
>> > > support for instantiating SML from Open Firmware") the powerpc kernel
>> > > was always built big endian, so the properties were created big endi=
an
>> > > by default.
>> > >=20
>> > > However since then little endian support was added to powerpc, and n=
ow
>> > > the code lacks conversions to big endian when creating the propertie=
s.
>> > >=20
>> > > This means on little endian kernels the device tree properties are
>> > > little endian, which is contrary to the device tree spec, and in
>> > > contrast to all other device tree properties.
>> > >=20
>> > > To cope with that a workaround was added in tpm_read_log_of() to skip
>> > > the endian conversion if the properties were created via the SML
>> > > handover.
>> > >=20
>> > > A better solution is to encode the properties as big endian as they
>> > > should be, and remove the workaround.
>> > >=20
>> > > Typically changing the encoding of a property like this would present
>> > > problems for kexec. However the SML is not propagated across kexec, =
so
>> > > changing the encoding of the properties is a non-issue.
>> > >=20
>> > > Fixes: e46e22f12b19 ("tpm: enhance read_log_of() to support Physical=
 TPM event log")
>> > > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> > > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>> > > ---
>> > >   arch/powerpc/kernel/prom_init.c |  8 ++++++--
>> > >   drivers/char/tpm/eventlog/of.c  | 23 ++++-------------------
>> > >   2 files changed, 10 insertions(+), 21 deletions(-)
>> >=20
>> > Split into two patches (producer and consumer).
>>=20
>> I think this wouldn't be right since it would break the system when only=
 one patch is applied since it would be reading the fields in the wrong end=
ianess.
>
> I think it would help if the commit message would better explain
> what is going on. It is somewhat difficult to decipher, if you
> don't have deep knowledge of the powerpc architecture.

I mean, it's already 8 paragraphs =C2=AF\_(=E3=83=84)_/=C2=AF

But I'm happy to expand it. I just don't really know what extra detail
is needed to make it clearer.

cheers
