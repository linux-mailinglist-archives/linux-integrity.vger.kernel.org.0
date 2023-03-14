Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121E56B92A1
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Mar 2023 13:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjCNMGH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Mar 2023 08:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjCNMFx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Mar 2023 08:05:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3079FE4B;
        Tue, 14 Mar 2023 05:05:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1F8B61755;
        Tue, 14 Mar 2023 12:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3E9C4339B;
        Tue, 14 Mar 2023 12:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678795465;
        bh=HrESUByicZY6tKB+bQV1ycPzUQEMp7f5+Cr/Z8QKMsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U5waYEKyWiaG0ZABQ72PXJWMpljOYq9tKwFpPxY01DK4lhLA/M4S4V+RHLXt1w0jE
         ZXcjtWqnyTuTr5/s9Diz/ukrnFdT5OzP4cdgbhxcCd/6gSJNHPYfgDsrWu8CwUpKUN
         JujyX2FSnj/mKM9GKQCQbV00WnxyTGLbaj4QqApw=
Date:   Tue, 14 Mar 2023 13:04:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Mirsad Goran Todorovac <mirsad.goran.todorovac@alu.hr>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Frederick Lawler <fred@cloudflare.com>
Subject: Re: [PATCH v1 0/2] Add destructor hook to LSM modules
Message-ID: <ZBBixqnSCfjWZvyn@kroah.com>
References: <20230310192614.GA528@domac.alu.hr>
 <CAHC9VhSzppHevG_Td+hKU4KRSDgV_NYf2RSeKA06PR-rD+dJLw@mail.gmail.com>
 <c1c1cbcc-10b6-de3f-81e8-78e6b173d46f@alu.unizg.hr>
 <CAHC9VhRFQtqTZku==BkW0uz1oZgG63j15GoQD1iexW4aPoAPcA@mail.gmail.com>
 <ZA7tyrscjwavzY3a@smile.fi.intel.com>
 <CAHC9VhTMoCAFhaa36Bq7_jiKGiaeMbYTuWv7tTQP1OHpY0EUsg@mail.gmail.com>
 <ZBBU9diKqetWQztO@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZBBU9diKqetWQztO@smile.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 14, 2023 at 01:05:25PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 13, 2023 at 04:27:42PM -0400, Paul Moore wrote:
> > On Mon, Mar 13, 2023 at 5:33 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Sat, Mar 11, 2023 at 09:59:17AM -0500, Paul Moore wrote:
> > > > On Fri, Mar 10, 2023 at 5:53 PM Mirsad Goran Todorovac
> > > > <mirsad.todorovac@alu.unizg.hr> wrote:
> 
> ...
> 
> > > > With that out of the way, I wanted to make a quick comment on the
> > > > patch itself.  Currently LSMs do not support unloading, or dynamic
> > > > loading for that matter.  There are several reasons for this, but
> > > > perhaps the most important is that in order to help meet the security
> > > > goals for several of the LSMs they need to be present in the kernel
> > > > from the very beginning and remain until the very end.  Adding a
> > > > proper "release" method to a LSM is going to be far more complicated
> > > > than what you've done with this patchset, involving a lot of
> > > > discussion both for the LSM layer itself and all of the currently
> > > > supported LSMs, and ultimately I don't believe it is something we will
> > > > want to support.
> > > >
> > > > I appreciate your desire to help, and I want to thank you for your
> > > > patch and the effort behind it, but I don't believe the kobject memory
> > > > leak you saw at kernel shutdown was a real issue (it was only "leaked"
> > > > because the system was shutting down) and I'm not sure the current
> > > > behavior is something we want to change in the near future.
> > >
> > > Currently the security module so secure that even adds an unneeded noise to
> > > the debugging output.
> > >
> > > At very least it would be nice to add a stub and put a big comment
> > > (on your taste) explaining why we do not do anything there.
> > >
> > > Agree?
> > 
> > No.
> 
> Are you sure? I'm proposing to add a stub which is no-op, but with a comment
> inside explaining why. In such case we:
> 
> 1) shut the kobject infra up;

Please do not do anything just to "shut up" the kobject code, that
warning is in there on purpose, fix the problem properly and do not try
to work around it as that is totally wrong.

greg k-h
