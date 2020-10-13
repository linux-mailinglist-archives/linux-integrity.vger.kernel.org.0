Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3889528C6B3
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Oct 2020 03:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgJMBRv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Oct 2020 21:17:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:53042 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727950AbgJMBRv (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Oct 2020 21:17:51 -0400
IronPort-SDR: nBJj5QdK410qrLH9Vc+wUXIAYEkfvLo89OHQFtJfjh2Ez9+6KEGucj3UAvPA5GT6qJd8TyN93f
 IsLbz5zAE4Ow==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="153660302"
X-IronPort-AV: E=Sophos;i="5.77,368,1596524400"; 
   d="scan'208";a="153660302"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 18:17:50 -0700
IronPort-SDR: FOeXrfxx7ZIEqucO2iN9f+hVGFLVmtpZkuL+oZ38f2RUt50ZFlAT9UKc+mhrovDMXh60l4Qf6z
 UwKlUV98vWQA==
X-IronPort-AV: E=Sophos;i="5.77,368,1596524400"; 
   d="scan'208";a="530186462"
Received: from lusin-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.53.81])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 18:17:48 -0700
Date:   Tue, 13 Oct 2020 04:17:45 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Borislav Petkov <bp@alien8.de>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v2 0/5] tpm_tis: fix interrupts (again)
Message-ID: <20201013011745.GA41176@linux.intel.com>
Reply-To: equired@linux.intel.com,
          justmentioningitbecauseIthinkthatwouldbeagood@linux.intel.com
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 01, 2020 at 11:09:20AM -0700, James Bottomley wrote:
> The current state of the TIS TPM is that interrupts have been globally
> disabled by various changes.  The problems we got reported the last
> time they were enabled was interrupt storms.  With my own TIS TPM,
> I've found that this is caused because my TPM doesn't do legacy
> cycles, The TIS spec (chapter 6.1 "Locality Usage Per Register")
> requires any TIS TPM without legacy cycles not to act on any write to
> an interrupt register unless the locality is enabled.  This means if
> an interrupt fires after we relinquish the locality, the TPM_EOI in
> the interrupt routine is ineffective meaning the same interrupt
> triggers over and over again.  This problem also means we can have
> trouble setting up interrupts on TIS TPMs because the current init
> code does the setup before the locality is claimed for the first time.
> 
> James

You should consider expanding the audience. Jerry, once you have some
bandwidth (no rush, does not land before rc2), it would be great that if
you could try this. I'm emphasizing this just because of the
intersection. I think it would also make senset to get tested-by from
Nayna.

Speaking of the changelog, I almost never have encounter a patch set
that does not have a changelog in the cover letter. And I'm not able to
interpret the process text in a way that it would ask to scatter
changelogs to the patches, and not put them to the cover letter [*].

Thus, I trust what I see as commodity. Not only that but it also helps a
lot with to see quickly what has changed, especially if the patches are
such that you have to take them in eventually.

In my own patch sets, I've recently started to xref associated lore korg
discussions in the change log entries, when it applies. I started to do
this with the SGX series when I had missed to address a number of Boris'
comments. It has helped a lot with my own tracking and I assume it is
also helpful for reviewers and maintainers to get the context, when they
need it.

The last paragraph is not something I demand. I'm merely just mentioning
it because I think it is a good practice for any patch set.

[*] https://lore.kernel.org/linux-integrity/14edea1f5092c2b8442165756b2ee32e56bed1eb.camel@HansenPartnership.com/

/Jarkko
