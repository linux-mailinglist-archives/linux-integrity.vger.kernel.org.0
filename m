Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D171D41F0
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2020 02:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgEOAD0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 May 2020 20:03:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:17796 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbgEOAD0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 May 2020 20:03:26 -0400
IronPort-SDR: g/0Sb2OIhduRYzLkFPrXOhvrbY3ujtNR8RJfYR/Xh4U1kCyXZl2cvs+fSCCisw2Dy097Gy7ynF
 FvRyeryR4hSw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 17:03:25 -0700
IronPort-SDR: IMU8mvYF/BX3FJs5oOTyEUMla3XtzozhJcao0jL/7xZKH3ZpBvjZISrte25WPNwTCkEYZJTpJj
 m13mDz2d9sZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,392,1583222400"; 
   d="scan'208";a="266422263"
Received: from ashadrin-mobl1.ccr.corp.intel.com ([10.249.38.112])
  by orsmga006.jf.intel.com with ESMTP; 14 May 2020 17:03:23 -0700
Message-ID: <7dadd27c89860c03d6c2eb0922838ef3e29e8f9b.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: check event log version before reading final events
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        =?ISO-8859-1?Q?Lo=EFc?= Yhuel <loic.yhuel@gmail.com>
Cc:     Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Date:   Fri, 15 May 2020 03:03:10 +0300
In-Reply-To: <CAMj1kXEUTdmudiB5aKeDAkYhv5jbwzBQ4cOrxK8VOt8O8Xjk=Q@mail.gmail.com>
References: <20200512040113.277768-1-loic.yhuel@gmail.com>
         <CACdnJuv8OyQpO4achWJb2HeB8Jb6Ejq9LsG64659JSay-a9O5A@mail.gmail.com>
         <116341780ff56884d2f03aa9b90a8f9566b91540.camel@linux.intel.com>
         <CANMwUkir2WTA7-J--Y_QFz8ZX5dHNTtLru19FHYew1uyxyKYNA@mail.gmail.com>
         <CAMj1kXEUTdmudiB5aKeDAkYhv5jbwzBQ4cOrxK8VOt8O8Xjk=Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-05-14 at 13:31 +0200, Ard Biesheuvel wrote:
> On Thu, 14 May 2020 at 13:28, Loïc Yhuel <loic.yhuel@gmail.com> wrote:
> > Le jeu. 14 mai 2020 à 12:54, Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com> a écrit :
> > > So it is clear that "pr_warn(FW_BUG ..." would be a sane to have there.
> > So only to tell the UEFI might have logged events the kernel can't read ?
> > There is no warning if the table is missing, which would have the same result.
> > 
> > I can try to dump it, perhaps it is using the SHA-1 log format.
> > If so, would a patch to support this non-standard behavior be accepted ?
> 
> That is why I was asking the question: what exact condition should we
> warn about? And at which point?

Always when final table is missing there should be some sort of notification
because the event log is incomplete.

I.e. it misses PCR5 extends from GetEventLog().

No additional info, just a note that we don't have the tail. I'm fine with
info level message too.

/Jarkko

