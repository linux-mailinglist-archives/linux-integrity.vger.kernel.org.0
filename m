Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEEA63FD82
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Dec 2022 02:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiLBBLb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Dec 2022 20:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiLBBLa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Dec 2022 20:11:30 -0500
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF267CF785;
        Thu,  1 Dec 2022 17:11:27 -0800 (PST)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 2B21AUHv025989;
        Thu, 1 Dec 2022 19:10:30 -0600
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 2B21ATfW025988;
        Thu, 1 Dec 2022 19:10:29 -0600
Date:   Thu, 1 Dec 2022 19:10:29 -0600
From:   "Dr. Greg" <greg@enjellic.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-integrity@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>, gwendal@chromium.org,
        dianders@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, Kees Cook <keescook@chromium.org>,
        dlunev@google.com, zohar@linux.ibm.com,
        Matthew Garrett <mgarrett@aurora.tech>,
        linux-pm@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v5 03/11] tpm: Allow PCR 23 to be restricted to kernel-only use
Message-ID: <20221202011028.GA25824@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20221111231636.3748636-1-evgreen@chromium.org> <20221111151451.v5.3.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid> <8ae56656a461d7b957b93778d716c6161070383a.camel@linux.ibm.com> <Y4ORZT2t/KhL5jfn@kernel.org> <53e3d7f9cc50e1fe9cf67e7889c6b5498580e5d9.camel@linux.ibm.com> <20221130202220.GA13122@wind.enjellic.com> <5d4b205a-9a6c-aa6a-0c83-17e9861fecf8@schaufler-ca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d4b205a-9a6c-aa6a-0c83-17e9861fecf8@schaufler-ca.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 01 Dec 2022 19:10:30 -0600 (CST)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Nov 30, 2022 at 01:34:28PM -0800, Casey Schaufler wrote:

Good evening to everyone.

> On 11/30/2022 12:22 PM, Dr. Greg wrote:
> > On Sun, Nov 27, 2022 at 11:41:26AM -0500, James Bottomley wrote:
> >> Of course, if no application is actually using PCR23, then it's
> >> probably OK to use it in the kernel and make it invisible to user
> >> space, but no evidence about this has actually been presented.
> >
> > If there isn't, there will be in in the next week or so, if we can
> > stay on schedule.  Otherwise, I fear that Casey Schaufler, who I
> > believe is holding his breath, may turn irretrievably blue.... :-)
>
> Sorry to disappoint, but my supply of apoplexy is firmly rooted
> elsewhere for the time being. :-( Also, you overestimate my interest
> in things TPM related.

I was being too clever by half, my comment had nothing to do with your
interest, or lack thereof about TPM's.... :-)

I had replied to one of the threads where LSM stacking and IMA
integration issues were being discussed and I commented that TSEM may
contribute to those conversations.  You had replied back and said that
sending teasers was unfair, I was suggesting with my comment that you
were holding your breath waiting for the release of TSEM.... :-)

On a related note to this thread, a major component of Quixote/TSEM is
the notion of raising the question and opportunity for shaping what
TPM's should be when they grow up, given the limited resources they
bring to the table, let alone the notion that they are about
retrospective rather than prospective trust.

> I am very interested to see TSEM. I have heard nothing of it to
> date.

Hardly anyone has, small team, very focused, working in a deep dive
for the last couple of years to bring this forward.

Hopefully it will prove of interest and utility, I don't believe there
is a reference in the literature to an equivalent approach.

Have a good evening.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
