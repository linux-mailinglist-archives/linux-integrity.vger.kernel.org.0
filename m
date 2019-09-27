Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 009D2C0895
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Sep 2019 17:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfI0P2M (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Sep 2019 11:28:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:31713 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727140AbfI0P2M (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Sep 2019 11:28:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2019 08:28:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,555,1559545200"; 
   d="scan'208";a="365193995"
Received: from mdauner2-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.39.118])
  by orsmga005.jf.intel.com with ESMTP; 27 Sep 2019 08:28:07 -0700
Date:   Fri, 27 Sep 2019 18:28:04 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Jones <pjones@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Lyude Paul <lyude@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] efi+tpm: Don't access event->count when it isn't
 mapped.
Message-ID: <20190927152747.GA10545@linux.intel.com>
References: <20190925101622.31457-1-jarkko.sakkinen@linux.intel.com>
 <CAKv+Gu9xLXWj8e70rs6Oy3aT_+qvemMJqtOETQG+7z==Nf_RcQ@mail.gmail.com>
 <20190925145011.GC23867@linux.intel.com>
 <20190925151616.3glkehdrmuwtosn3@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925151616.3glkehdrmuwtosn3@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 25, 2019 at 08:16:16AM -0700, Jerry Snitselaar wrote:
> On Wed Sep 25 19, Jarkko Sakkinen wrote:
> > On Wed, Sep 25, 2019 at 12:25:05PM +0200, Ard Biesheuvel wrote:
> > > On Wed, 25 Sep 2019 at 12:16, Jarkko Sakkinen
> > > <jarkko.sakkinen@linux.intel.com> wrote:
> > > >
> > > > From: Peter Jones <pjones@redhat.com>
> > > >
> > > > Some machines generate a lot of event log entries.  When we're
> > > > iterating over them, the code removes the old mapping and adds a
> > > > new one, so once we cross the page boundary we're unmapping the page
> > > > with the count on it.  Hilarity ensues.
> > > >
> > > > This patch keeps the info from the header in local variables so we don't
> > > > need to access that page again or keep track of if it's mapped.
> > > >
> > > > Fixes: 44038bc514a2 ("tpm: Abstract crypto agile event size calculations")
> > > > Cc: linux-efi@vger.kernel.org
> > > > Cc: linux-integrity@vger.kernel.org
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Peter Jones <pjones@redhat.com>
> > > > Tested-by: Lyude Paul <lyude@redhat.com>
> > > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > Acked-by: Matthew Garrett <mjg59@google.com>
> > > > Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > 
> > > Thanks Jarkko.
> > > 
> > > Shall I take these through the EFI tree?
> > 
> > Would be great, if you could because I already sent one PR with fixes for
> > v5.4-rc1 yesterday.
> > 
> > /Jarkko
> 
> My patch collides with this, so I will submit a v3 that applies on top of
> these once I've run a test with all 3 applied on this t480s.

Great, thanks.

/Jarkko
