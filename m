Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887D1607C56
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Oct 2022 18:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiJUQfp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Oct 2022 12:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiJUQfp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Oct 2022 12:35:45 -0400
X-Greylist: delayed 1798 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Oct 2022 09:35:41 PDT
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E36C203570;
        Fri, 21 Oct 2022 09:35:39 -0700 (PDT)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 29LEroap015522;
        Fri, 21 Oct 2022 09:53:50 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 29LErmuU015521;
        Fri, 21 Oct 2022 09:53:48 -0500
Date:   Fri, 21 Oct 2022 09:53:48 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Micka?l Sala?n <mic@digikod.net>, Petr Vorel <pvorel@suse.cz>,
        Borislav Petkov <bp@suse.de>, Takashi Iwai <tiwai@suse.de>,
        Jonathan McDowell <noodles@fb.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/9] security: Move trivial IMA hooks into LSM
Message-ID: <20221021145348.GA15390@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20221013222702.never.990-kees@kernel.org> <20221013223654.659758-2-keescook@chromium.org> <16e008b3709f3c85dbad1accb9fce8ddad552205.camel@linux.ibm.com> <202210191134.FC646AFC71@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210191134.FC646AFC71@keescook>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Fri, 21 Oct 2022 09:53:50 -0500 (CDT)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Oct 19, 2022 at 11:59:40AM -0700, Kees Cook wrote:

Good morning, I hope the week is ending well for everyone.

> On Wed, Oct 19, 2022 at 10:34:48AM -0400, Mimi Zohar wrote:
> >
> > The only thing trivial about making IMA and EVM LSMs is moving
> > them to LSM hooks.  Although static files may be signed and the
> > signatures distributed with the file data through the normal
> > distribution mechanisms (e.g. RPM), other files cannot be signed
> > remotely (e.g.  configuration files).  For these files, both IMA
> > and EVM may be configured to maintain persistent file state stored
> > as security xattrs in the form of security.ima file hashes or
> > security.evm HMACs.  The LSM flexibility of enabling/disabling IMA
> > or EVM on a per boot basis breaks this usage, potentially
> > preventing subsequent boots.

> I'm not suggesting IMA and EVM don't have specific behaviors that
> need to be correctly integrated into the LSM infrastructure. In
> fact, I spent a lot of time designing that infrastructure to be
> flexible enough to deal with these kinds of things. (e.g. plumbing
> "enablement", etc.) As I mentioned, this was more of trying to
> provide a head-start on the conversion. I don't intend to drive this
> -- please take whatever is useful from this example and use it. :)
> I'm happy to help construct any missing infrastructure needed
> (e.g. LSM_ORDER_LAST, etc).

We are 2-3 weeks out from submitting for review and inclusion in the
kernel, a new LSM, and an associated userspace stack, that will have a
high degree of significance with respect to these conversations.

> Kees Cook

Best wishes for a pleasant fall weekend.

As always,

Dr. Greg
The Quixote Project - Flailing at the Travails of Cybersecurity
