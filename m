Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E78667E242
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Jan 2023 11:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjA0Kwu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Jan 2023 05:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjA0Kws (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Jan 2023 05:52:48 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB165173B;
        Fri, 27 Jan 2023 02:52:46 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P3Dtd620gz4xGq;
        Fri, 27 Jan 2023 21:52:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1674816762;
        bh=QDCzctob2hZHnjNozBUiQhZ3c3ZIA5hUvy/sWV7Il00=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gNVZkfafjj2MpgzETy//HzY37m8ZEoLJYzM81q+qE82zMDjKzSTib1kQlCEWeD74x
         TbA1AJAUzh3UF1b5tIvdicaCY2B8X01OR7xZ+m53Vy0nOtJ3LUefqcxOGiX0TbLzXA
         FpQsTEBfIY6ln8br4aEbGhYCfvHI2Wk46905hzvGFT43HVNg3I805NGwAjRxWwHRl9
         ciLHepcbgn/Ugqz751JfDEzRYwbKTR7RwnvTILKfsIiP/YeV8O7KVE1eCo7xwgRE4m
         oSO3tekfSTlDRy5WvqPzKwaZSDNgEJN4FzrYuWbIZD/efUVviZaorDQh40DV8VzXAt
         Uy3JBixutSBJQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org,
        sudhakar@linux.ibm.com, bgray@linux.ibm.com, erichte@linux.ibm.com,
        gregkh@linuxfoundation.org, nayna@linux.ibm.com,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        gjoyce@linux.ibm.com, joel@jms.id.au, ruscur@russell.cc,
        gcwilson@linux.ibm.com
Subject: Re: [PATCH v4 02/24] powerpc/pseries: Fix alignment of PLPKS
 structures and buffers
In-Reply-To: <20230126171925.GN25951@gate.crashing.org>
References: <20230120074306.1326298-1-ajd@linux.ibm.com>
 <20230120074306.1326298-3-ajd@linux.ibm.com>
 <87pmb2pxpa.fsf@mpe.ellerman.id.au>
 <20230126171925.GN25951@gate.crashing.org>
Date:   Fri, 27 Jan 2023 21:52:31 +1100
Message-ID: <871qngtfkg.fsf@mpe.ellerman.id.au>
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

Segher Boessenkool <segher@kernel.crashing.org> writes:
> On Thu, Jan 26, 2023 at 12:09:53AM +1100, Michael Ellerman wrote:
>> Andrew Donnellan <ajd@linux.ibm.com> writes:
>> > A number of structures and buffers passed to PKS hcalls have alignment
>> > requirements, which could on occasion cause problems:
>> >
>> > - Authorisation structures must be 16-byte aligned and must not cross a
>> >   page boundary
>> >
>> > - Label structures must not cross page boundaries
>> >
>> > - Password output buffers must not cross page boundaries
>> >
>> > Round up the allocations of these structures/buffers to the next power of
>> > 2 to make sure this happens.
>> 
>> It's not the *next* power of 2, it's the *nearest* power of 2, including
>> the initial value if it's already a power of 2.
>
> It's not the nearest either, the nearest power of two to 65 is 64.  You
> could say "but, round up" to which I would say "round?"  :-P

OK you got me there :)

The function name makes it pretty clear that it will round *up* to the
nearest power of 2 but you're right the comment should also make that
clear.

> "Adjust the allocation size to be the smallest power of two greater than
> or equal to the given size."
>
> "Pad to a power of two" in shorthand.  "Padded to a power of two if
> necessary" if you want to emphasise it can be a no-op.

The initial wording implied that it would always over-allocate so yes I
think it's important to make it clear that it doesn't round up if it
doesn't need to.

cheers
