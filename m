Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BD467D2F6
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jan 2023 18:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjAZRXt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Jan 2023 12:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjAZRXs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Jan 2023 12:23:48 -0500
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF513EF9F;
        Thu, 26 Jan 2023 09:23:47 -0800 (PST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 30QHJRSd028306;
        Thu, 26 Jan 2023 11:19:27 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 30QHJPDN028305;
        Thu, 26 Jan 2023 11:19:25 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 26 Jan 2023 11:19:25 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org,
        sudhakar@linux.ibm.com, bgray@linux.ibm.com, erichte@linux.ibm.com,
        gregkh@linuxfoundation.org, nayna@linux.ibm.com,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        gjoyce@linux.ibm.com, joel@jms.id.au, ruscur@russell.cc,
        gcwilson@linux.ibm.com
Subject: Re: [PATCH v4 02/24] powerpc/pseries: Fix alignment of PLPKS structures and buffers
Message-ID: <20230126171925.GN25951@gate.crashing.org>
References: <20230120074306.1326298-1-ajd@linux.ibm.com> <20230120074306.1326298-3-ajd@linux.ibm.com> <87pmb2pxpa.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmb2pxpa.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 26, 2023 at 12:09:53AM +1100, Michael Ellerman wrote:
> Andrew Donnellan <ajd@linux.ibm.com> writes:
> > A number of structures and buffers passed to PKS hcalls have alignment
> > requirements, which could on occasion cause problems:
> >
> > - Authorisation structures must be 16-byte aligned and must not cross a
> >   page boundary
> >
> > - Label structures must not cross page boundaries
> >
> > - Password output buffers must not cross page boundaries
> >
> > Round up the allocations of these structures/buffers to the next power of
> > 2 to make sure this happens.
> 
> It's not the *next* power of 2, it's the *nearest* power of 2, including
> the initial value if it's already a power of 2.

It's not the nearest either, the nearest power of two to 65 is 64.  You
could say "but, round up" to which I would say "round?"  :-P

"Adjust the allocation size to be the smallest power of two greater than
or equal to the given size."

"Pad to a power of two" in shorthand.  "Padded to a power of two if
necessary" if you want to emphasise it can be a no-op.


Segher
