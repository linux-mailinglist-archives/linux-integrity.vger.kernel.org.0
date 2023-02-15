Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94279697B0C
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Feb 2023 12:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbjBOLq6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Feb 2023 06:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbjBOLqy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Feb 2023 06:46:54 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998C113535;
        Wed, 15 Feb 2023 03:46:49 -0800 (PST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by gandalf.ozlabs.org (Postfix) with ESMTP id 4PGxBH56hqz4x7w;
        Wed, 15 Feb 2023 22:46:47 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PGxBG64dGz4x5W;
        Wed, 15 Feb 2023 22:46:46 +1100 (AEDT)
From:   Michael Ellerman <michaele@au1.ibm.com>
To:     Andrew Donnellan <ajd@linux.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     ruscur@russell.cc, bgray@linux.ibm.com, nayna@linux.ibm.com,
        gcwilson@linux.ibm.com, gjoyce@linux.ibm.com, brking@linux.ibm.com,
        sudhakar@linux.ibm.com, erichte@linux.ibm.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        zohar@linux.ibm.com, joel@jms.id.au, npiggin@gmail.com
Subject: Re: [PATCH v6 24/26] powerpc/pseries: Implement secvars for dynamic
 secure boot
In-Reply-To: <22172b58cd5353324d14b733aeac51e365597070.camel@linux.ibm.com>
References: <20230210080401.345462-1-ajd@linux.ibm.com>
 <20230210080401.345462-25-ajd@linux.ibm.com>
 <f35e9ba1-5fdb-4cfa-5b41-cc55307dcd45@linux.ibm.com>
 <87pmadvm0n.fsf@mpe.ellerman.id.au>
 <22172b58cd5353324d14b733aeac51e365597070.camel@linux.ibm.com>
Date:   Wed, 15 Feb 2023 22:46:42 +1100
Message-ID: <87zg9f5exp.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Andrew Donnellan <ajd@linux.ibm.com> writes:
> On Mon, 2023-02-13 at 22:32 +1100, Michael Ellerman wrote:
>> > > +       memcpy(&flags, data, sizeof(flags));
>> > 
>> > conversion from bytestream to integer: I think in this case it
>> > would be better to use
>> > 
>> > flags = cpu_to_be64p((__u64*)data);
>> > 
>> > so that the flags always in hypervisor/big endian format
>> 
>> I don't think it's correct to byte swap the flags here. They must be
>> in big endian format, but that's up to the caller.
>
> That was what I initially thought, until I went and tested it properly
> and found it was indeed broken (at least in our qemu environment, this
> is slightly tricky for me to test right now on real hardware with real
> PowerVM) depending on kernel endianness.
>
> - Userspace writes the flags into the buffer in BE order
>
> - The first 8 bytes of the buffer are memcpy()ed, in BE order, into
> flags (a u64)
>
> - plpar_hcall9() is called with flags as an argument, loaded into r9
>
> - r9 is moved to r8 before jumping into the hypervisor
>
> On a BE system, this works fine. On an LE system, this results in the
> bytes in the flags variable being loaded into the register in LE order,
> so the conversion is necessary.

Ah yep of course. So although the flags are written by userspace as part
of the data as a stream of bytes, they're passed to the HV via a
register.

I've had this patch in next for a few days and don't want to rebase it.
So can you send a follow-up patch to fix the flags endianess, with a
nice changelog and comment :)

cheers
