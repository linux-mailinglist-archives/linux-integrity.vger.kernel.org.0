Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA9E67E2BA
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Jan 2023 12:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjA0LJJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Jan 2023 06:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbjA0LJH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Jan 2023 06:09:07 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950A980F9B;
        Fri, 27 Jan 2023 03:09:03 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P3FFR5p05z4xHV;
        Fri, 27 Jan 2023 22:08:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1674817740;
        bh=Y9utl1kOHVvMVILv+GUuqyaSSu0UglfF0XYXjmDGNlo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Lss0HKdluvv5JI2rpIb69PH0xbX1GwXooNuCM9bRM7tTwmfiwMopaz3cHjNvc53Yc
         6PKoVjuxokRqj/c0yq2Nf2PxqkZi+vEvchyBacGOZJMdsQwnTEOTEEnl+bdHtHVaLY
         spGCu4jYruPxPt5SFluIcaUw5KigftfZ1t9ynldKha4s6rFp3QHirPk3pRVZYZcwDi
         b1fbYVZNEpbA76c//EU4p0d5wElXGMHu5zKwz8zP1jAmNr6T/6dbAINrpssgby+vnz
         x1Irji28fWg2yKJ+uvIHHtCEMr/L8+FSR2OIk9Mr5yj34gRv3LCcT4CqggX7UpyKQS
         jXyI/sdcB8eSw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Andrew Donnellan <ajd@linux.ibm.com>,
        David Laight <David.Laight@ACULAB.COM>,
        'Segher Boessenkool' <segher@kernel.crashing.org>
Cc:     "gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>,
        "erichte@linux.ibm.com" <erichte@linux.ibm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "sudhakar@linux.ibm.com" <sudhakar@linux.ibm.com>,
        "ruscur@russell.cc" <ruscur@russell.cc>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "bgray@linux.ibm.com" <bgray@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "gcwilson@linux.ibm.com" <gcwilson@linux.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v4 02/24] powerpc/pseries: Fix alignment of PLPKS
 structures and buffers
In-Reply-To: <2de207dadb936f25db123ae2d02aea91a9841656.camel@linux.ibm.com>
References: <20230120074306.1326298-1-ajd@linux.ibm.com>
 <20230120074306.1326298-3-ajd@linux.ibm.com>
 <87pmb2pxpa.fsf@mpe.ellerman.id.au>
 <20230126171925.GN25951@gate.crashing.org>
 <5118edd7f1f445afa1812d2b9b62dd4f@AcuMS.aculab.com>
 <2de207dadb936f25db123ae2d02aea91a9841656.camel@linux.ibm.com>
Date:   Fri, 27 Jan 2023 22:08:59 +1100
Message-ID: <87y1pos08k.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Andrew Donnellan <ajd@linux.ibm.com> writes:
> On Thu, 2023-01-26 at 17:31 +0000, David Laight wrote:
>> Changing the size to kzalloc() doesn't help.
>> The alignment depends on the allocator and is only required to have
>> a relatively small alignment (ARCH_MINALIGN?) regardless of the size.
>> 
>> IIRC one of the allocators adds a small header to every item.
>> It won't return 16 byte aligned items at all.
>
> I'm relying on the behaviour described in Documentation/core-
> api/memory-allocation.rst:
>
>     The address of a chunk allocated with kmalloc is aligned to at
>     least ARCH_KMALLOC_MINALIGN bytes. For sizes which are a power of
>     two, the alignment is also guaranteed to be at least the respective
>     size.
>
> Is this wrong?

I believe it's correct.

For SLAB and SLUB it boils down to:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/slab_common.c?commit=830b3c68c1fb1e9176028d02ef86f3cf76aa2476#n640

That's where the kmalloc slabs are created (see create_kmalloc_cache())
just below.

If you create your own slab (with kmem_cache_create()) then the
alignment is up to you, so that's why there's no power-of-2 logic in
calculate_alignment().

And SLOB (which we don't use) does something similar:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/slob.c?commit=830b3c68c1fb1e9176028d02ef86f3cf76aa2476#n493

cheers
