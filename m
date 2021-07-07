Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED2E73BF141
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 23:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhGGVNg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Jul 2021 17:13:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230185AbhGGVNg (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Jul 2021 17:13:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3030760FDA;
        Wed,  7 Jul 2021 21:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625692255;
        bh=apft+N2z0gQk1aKOkEXYaAF8CejXYPgOhH49Lyojk5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZGJdMN4NLan6RpEdshJ9XUW4pwsMoqZYzLbrSOgJEiRS4JKUv31k3FDQ64eLApqF9
         rTKKiwivAawZYfl8qTvHHQ0Q8V6cf/TtFe6H0EXsdxkpGAjxnBtA86k/wnev2uDb8w
         N5eFX2qYDaEVdOWmbajCO8OaWTv+HXHxPWGC9jrvNl/4YvvPvHAN8JLJSPqWv4J5sf
         +oBPYiFmszSSWfiwru4i8qr79bSM3sq9AIa2jLlzZVSwWKH8u6I7GeCAWETP6kCgy+
         xrs56AbtKlqotxyqEFvQB9eSS08/XSUchHMqLHmzB0KqZZflF2rE2QFepCeYK4++Pa
         4vaTah6HIyI+A==
Date:   Thu, 8 Jul 2021 00:10:53 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Hao Wu <hao.wu@rubrik.com>
Cc:     Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>, zohar@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, Hamza Attak <hamza@hpe.com>,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        Nayna <nayna@linux.vnet.ibm.com>,
        James.Bottomley@hansenpartnership.com
Subject: Re: [PATCH v2] tpm: fix ATMEL TPM crash caused by too frequent
 queries
Message-ID: <20210707211053.obfqcfq42cqlamns@kernel.org>
References: <20210630042205.30051-1-hao.wu@rubrik.com>
 <20210707043135.33434-1-hao.wu@rubrik.com>
 <20210707092411.onk6ewfmhxj5kf3v@kernel.org>
 <712FD1C1-941C-4ABA-866D-6EA6AFA0FE9F@rubrik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <712FD1C1-941C-4ABA-866D-6EA6AFA0FE9F@rubrik.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jul 07, 2021 at 11:28:35AM -0700, Hao Wu wrote:
> > On Jul 7, 2021, at 2:24 AM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > 
> > On Tue, Jul 06, 2021 at 09:31:35PM -0700, Hao Wu wrote:
> >> Since kernel 4.14, there was a commit (9f3fc7bcddcb)

BTW, please remove this. You have a fixes tag.

> >> fixed the TPM sleep logic from msleep to usleep_range,
> >> so that the TPM sleeps exactly with TPM_TIMEOUT (=5ms) afterward.
> >> Before that fix, msleep(5) actually sleeps for around 15ms.
> > 
> > What is TPM sleep logic?
> It is about the commit metnioned in the description
> `tpm: replace msleep() with usleep_range() in TPM 1.2/2.0 generic drivers`
> https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60475e1c3

What you should do is to explain in simple terms the unwanted behaviour
that you are observing, and also, *when* you observe it. E.g. does this
happen when you use /dev/tpm0, or is it visible already in klog at boot
time. And also: does it occur for anything you put to /dev/tpm0, or is
the bug triggering for some particular TPM commands.

You also need to have information what kind of Atmel chip triggers the
bug. I'd presume that you have access to a machine with such chip?

When you get all that figured out, you should explain how you change
the existing behaviour, and why it makes sense. E.g. if you fixup
timeouts, please just tell how'd you end up choosing the values that
you picked.

E.g. the rationale for that could come from testing and finding the "sweet
spot", or perhaps the reason could be that old values worked, new ones
don't.

Especially in bug fixes the reasoning is *at least* as important as the
the code change itself because I need to know what is going on.

/Jarkko
