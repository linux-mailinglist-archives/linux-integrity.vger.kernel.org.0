Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61CB91E6F1A
	for <lists+linux-integrity@lfdr.de>; Fri, 29 May 2020 00:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436990AbgE1WdY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 May 2020 18:33:24 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:41250 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436867AbgE1WdX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 May 2020 18:33:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id CAFB28EE10F;
        Thu, 28 May 2020 15:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1590705200;
        bh=VTyQq/KBhT0N+ixGd7R8XxmuxZO1qhfTdyYZV+Q0q7Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ADPqEy1pN21jrENbQUjKS1nW9Qr+ZGLB8+zCF6VnqqaK50INeWAI0GwHXD81J+3+E
         EQSx6M8MHAF4Aa5N9q6RhyBfyFpFQVBKvfw4BbeMZ9rN5sjoPT3cZjM9m/Z/4v5ljz
         ieaR2YMFZJCcQ6OpqVp2/Am+LOcp4JuF2HRnpwLc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Yasy8jzLJuaj; Thu, 28 May 2020 15:33:20 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 98C058EE0F8;
        Thu, 28 May 2020 15:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1590705200;
        bh=VTyQq/KBhT0N+ixGd7R8XxmuxZO1qhfTdyYZV+Q0q7Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ADPqEy1pN21jrENbQUjKS1nW9Qr+ZGLB8+zCF6VnqqaK50INeWAI0GwHXD81J+3+E
         EQSx6M8MHAF4Aa5N9q6RhyBfyFpFQVBKvfw4BbeMZ9rN5sjoPT3cZjM9m/Z/4v5ljz
         ieaR2YMFZJCcQ6OpqVp2/Am+LOcp4JuF2HRnpwLc=
Message-ID: <1590705198.3515.11.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: Revert "tpm: fix invalid locking in NONBLOCKING
 mode"
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Alex Guzman <alex@guzman.io>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mario.Limonciello@dell.com, peterhuewe@gmx.de, jgg@ziepe.ca
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-integrity@vger.kernel.org, jeffrin@rajagiritech.edu.in
Date:   Thu, 28 May 2020 15:33:18 -0700
In-Reply-To: <a5e2a176faa272a0edc8737c1ef1bf5b3c278f63.camel@guzman.io>
References: <20200526183213.20720-1-mario.limonciello@dell.com>
         <1590520454.11810.40.camel@HansenPartnership.com>
         <ccf055cbf1a14f28bc95a6b02e29a2f6@AUSX13MPC105.AMER.DELL.COM>
         <d6b4591c49f01f24b0dbfd25c8792a3f506d6cae.camel@linux.intel.com>
         <a5e2a176faa272a0edc8737c1ef1bf5b3c278f63.camel@guzman.io>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-05-27 at 18:10 -0700, Alex Guzman wrote:
> On Wed, 2020-05-27 at 23:15 +0300, Jarkko Sakkinen wrote:
> > On Tue, 2020-05-26 at 19:23 +0000, Mario.Limonciello@dell.com
> > wrote:
> > > Thanks, I don't pretend to understand the nuances of this
> > > particular code, but I was hoping that the request to revert got
> > > some attention since Alex's kernel Bugzilla and message a few
> > > months ago to linux integrity weren't.
> > 
> > Removing linux-kernel from CC since this subsystem internal
> > discussion.
> > 
> > Seeing the whole thing first time today.
> > 
> > Bugzilla is the first thing to ignore when busy. It is good as
> > place holder for bugs, but all discussions should happen only in
> > LKML. There's no official requirement to proactively use Bugzilla
> > for anything.
> > 
> > That said I'm happy that people put stuff there so that it gets
> > logged.
> > 
> > For follow-up's use only LKML if it is important to you. Those will
> > get processed.
> > 
> > As far as this goes, if nothing is heard from me, check that you
> > put me as CC to the original email. Otherwise, I might have missed
> > it (by mistake, not by purpose).
> > 
> > Honestly, I'm not sure what point was this patch when there was
> > time to wait for months without response. Why the passivity for all
> > this time?
> > 
> > /Jarkko
> > 
> 
> It largely went quiet because I didn't raise the issue in the mailing
> list again. I pinged back in February (
> https://lore.kernel.org/linux-integrity/CAJ7-
> PMbujee92N1f9xVF8vtXgS49qpe7qHkeWh1Z0R-Rk-Jkaw@mail.gmail.com/) but
> the conversation died out and I was content to simply use the
> last working kernel version and see if the bug was resolved on its
> own.

I think its just a state of knowledge problem: back in February I
didn't know how unusual EPERM errors are in the TPM so the issue just
flew by as a "this is a curious issue with an O_NONBLOCK path" thing,
but thanks to some key stuff I've been doing I now do.  So this time
your EPERM struck me as "that's impossible surely" which is why I dug
into the code to find out where it was coming from ... and sure enough,
it was impossible: it was an untranslated failure return, but at least
it accidentally told me exactly what the real error was.

So the upshot is you got lucky this time around ...

James

> I raised the issue again on the bugtracker a few days ago, leading to
> this follow up here. :)
