Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776AF2D0661
	for <lists+linux-integrity@lfdr.de>; Sun,  6 Dec 2020 18:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgLFRlZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 6 Dec 2020 12:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgLFRlZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 6 Dec 2020 12:41:25 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4DAC0613D0;
        Sun,  6 Dec 2020 09:40:45 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id CC4AF128007B;
        Sun,  6 Dec 2020 09:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1607276442;
        bh=8ec02T50RHRQ5Id0GXk/fQcLTcNSvBQgNzgeqC9+Bjw=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=rAHcsq13Cn4UZfD5NHBqiEJmFBnNOXkPC5aD87Bus2ENurTDMRYfgDlB1X+xgbCwD
         4jXNZtN2+tyFJdQf0jOiqd6uPPQ8tMgqa05uBkXdE6m2u5kMo10VgrX61rQwL5Vf/3
         sIr4/D+7gQhe89zB1q9PEMHmYbRrM8L5VtABSbzA=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4ygq4P4DqnvF; Sun,  6 Dec 2020 09:40:42 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D3CC3128003D;
        Sun,  6 Dec 2020 09:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1607276442;
        bh=8ec02T50RHRQ5Id0GXk/fQcLTcNSvBQgNzgeqC9+Bjw=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=rAHcsq13Cn4UZfD5NHBqiEJmFBnNOXkPC5aD87Bus2ENurTDMRYfgDlB1X+xgbCwD
         4jXNZtN2+tyFJdQf0jOiqd6uPPQ8tMgqa05uBkXdE6m2u5kMo10VgrX61rQwL5Vf/3
         sIr4/D+7gQhe89zB1q9PEMHmYbRrM8L5VtABSbzA=
Message-ID: <7fe2d70b5daca57d9cd50d3877376e420658ed71.camel@HansenPartnership.com>
Subject: Re: [PATCH v3 1/4] irq: export kstat_irqs
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kernel test robot <lkp@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Matthew Garrett <mjg59@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com
Date:   Sun, 06 Dec 2020 09:40:40 -0800
In-Reply-To: <87360i99ck.fsf@nanos.tec.linutronix.de>
References: <20201205014340.148235-1-jsnitsel@redhat.com>
         <20201205014340.148235-2-jsnitsel@redhat.com>
         <20201205103954.GA17088@kernel.org>
         <87360i99ck.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2020-12-06 at 17:40 +0100, Thomas Gleixner wrote:
> On Sat, Dec 05 2020 at 12:39, Jarkko Sakkinen wrote:
> > On Fri, Dec 04, 2020 at 06:43:37PM -0700, Jerry Snitselaar wrote:
> > > To try and detect potential interrupt storms that
> > > have been occurring with tpm_tis devices it was suggested
> > > to use kstat_irqs() to get the number of interrupts.
> > > Since tpm_tis can be built as a module it needs kstat_irqs
> > > exported.
> > 
> > I think you should also have a paragraph explicitly stating that
> > i915_pmu.c contains a duplicate of kstat_irqs() because it is not
> > exported as of today. It adds a lot more weight to this given that
> > there is already existing mainline usage (kind of).
> 
> It's abusage and just the fact that it exists is not an argument by
> itself.

What we want is a count of the interrupts to see if we're having an
interrupt storm from the TPM device (some seem to be wired to fire the
interrupt even when there's no event to warrant it).  Since
kstat_irqs_user() does the correct RCU locking, should we be using that
instead?

James


