Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC3663E274
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Nov 2022 22:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiK3VFq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Nov 2022 16:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiK3VFp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Nov 2022 16:05:45 -0500
X-Greylist: delayed 1800 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Nov 2022 13:05:43 PST
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4EDF285676;
        Wed, 30 Nov 2022 13:05:43 -0800 (PST)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 2AUKMMDE013659;
        Wed, 30 Nov 2022 14:22:22 -0600
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 2AUKMKYG013658;
        Wed, 30 Nov 2022 14:22:20 -0600
Date:   Wed, 30 Nov 2022 14:22:20 -0600
From:   "Dr. Greg" <greg@enjellic.com>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
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
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>, casey@schaufler-ca.com
Subject: Re: [PATCH v5 03/11] tpm: Allow PCR 23 to be restricted to kernel-only use
Message-ID: <20221130202220.GA13122@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20221111231636.3748636-1-evgreen@chromium.org> <20221111151451.v5.3.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid> <8ae56656a461d7b957b93778d716c6161070383a.camel@linux.ibm.com> <Y4ORZT2t/KhL5jfn@kernel.org> <53e3d7f9cc50e1fe9cf67e7889c6b5498580e5d9.camel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53e3d7f9cc50e1fe9cf67e7889c6b5498580e5d9.camel@linux.ibm.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Wed, 30 Nov 2022 14:22:22 -0600 (CST)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Nov 27, 2022 at 11:41:26AM -0500, James Bottomley wrote:

Good afternoon, I hope the week is going well for everyone.

> On Sun, 2022-11-27 at 18:33 +0200, Jarkko Sakkinen wrote:
> > On Mon, Nov 14, 2022 at 12:11:20PM -0500, James Bottomley wrote:
> > > On Fri, 2022-11-11 at 15:16 -0800, Evan Green wrote:
> > > > Introduce a new Kconfig, TCG_TPM_RESTRICT_PCR, which if enabled
> > > > restricts usermode's ability to extend or reset PCR 23.
> > > 
> > > Could I re ask the question here that I asked of Matthew's patch
> > > set:
> > > 
> > > https://lore.kernel.org/all/b0c4980c8fad14115daa3040979c52f07f7fbe2c.camel@linux.ibm.com/
> > > 
> > > Which was could we use an NVRAM index in the TPM instead of a PCR???
> > > The reason for asking was that PCRs are rather precious and might
> > > get more so now that Lennart has some grand scheme for using more
> > > of them in his unified boot project.?? Matthew promised to play with
> > > the idea but never got back to the patch set to say whether he
> > > investigated this or not.
> > 
> > Even for PCR case it would be better to have it configurable through
> > kernel command-line, including a disabled state, which would the
> > default.
> > 
> > This would be backwards compatible, and if designed properly, could
> > more easily extended for NV index later on.
> 
> Um how?  The observation is in the above referenced email is that PCR23
> is reserved in the TCG literature for application usage.  If any
> application is actually using PCR23 based on that spec then revoking
> access to user space will cause it to break.  This is an ABI change
> which is not backwards compatible.  You can call it a distro problem if
> it's command line configurable, but the default would be what most
> distros take, so it's rather throwing them under the bus if there is an
> application using it.
> 
> Of course, if no application is actually using PCR23, then it's
> probably OK to use it in the kernel and make it invisible to user
> space, but no evidence about this has actually been presented.

If there isn't, there will be in in the next week or so, if we can
stay on schedule.  Otherwise, I fear that Casey Schaufler, who I
believe is holding his breath, may turn irretrievably blue.... :-)

The Trust Orchestration System, Quixote, that we are releasing for
Linux uses PCR23 to generate an attestation of the functional state
value for an internally modeled security domain.

TSEM, the LSM based kernel component in all of this, supports the
ability to implement multiple 'domains', nee namespaces, each of which
can have a security modeling function attached to it.  Each internally
modeled domain has to have the ability to independently attest the
functional value of the security model implemented for the
domain/namespace.

We have found, and I believe others will find that, particularly the
resettable registers, are too precious to be constrained from general
usage.  We actually just finished lifting the PCR23 extension
functionality out of the TSEM driver and into userspace because having
it in the kernel was too constraining.

With respect to making the behavior a command-line option.  We've
slogged through 2+ years of conversations with sizable players who
have indicated that if the 'distys' don't implement something, it
isn't a relevant Linux technology, so a command-line option poses a
barrier to innovation.

> James

Have a good day.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
