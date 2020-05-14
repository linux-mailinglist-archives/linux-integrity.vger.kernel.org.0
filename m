Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F21D1D2475
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2020 03:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgENBJR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 May 2020 21:09:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:36826 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgENBJR (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 May 2020 21:09:17 -0400
IronPort-SDR: RC1slc/ec3LpppMX+N9NLRGBTilQqN4p3mctnDBHJMLkf30ThmwE26OWzdV1+n93nBts3SV1AE
 EG3ePw9SG3mA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 18:09:16 -0700
IronPort-SDR: YiIAlxpI4EtN9VTx0Vegwpwfu9sU8tkDAOEDfFqZnoYZRKQuayv5Vc/ogZVPhGmYCmunH+QNzO
 aA8klNpyns3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,389,1583222400"; 
   d="scan'208";a="253346471"
Received: from gliber-mobl1.ger.corp.intel.com ([10.249.38.41])
  by fmsmga008.fm.intel.com with ESMTP; 13 May 2020 18:09:14 -0700
Message-ID: <ab9df4468cc294c67a67ef336019379033e7c90c.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: check event log version before reading final events
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        =?ISO-8859-1?Q?Lo=EFc?= Yhuel <loic.yhuel@gmail.com>
Cc:     linux-integrity@vger.kernel.org, matthewgarrett@google.com,
        javierm@redhat.com
Date:   Thu, 14 May 2020 04:09:13 +0300
In-Reply-To: <CAMj1kXFfLvUXU1A-7jnh3KMy5Qguhq0k9Cw=O0iBmbToowV_8A@mail.gmail.com>
References: <20200512040113.277768-1-loic.yhuel@gmail.com>
         <CAMj1kXFfLvUXU1A-7jnh3KMy5Qguhq0k9Cw=O0iBmbToowV_8A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-05-12 at 08:44 +0200, Ard Biesheuvel wrote:
> Hi Loïc,
> 
> Thanks for the fix.
> 
> On Tue, 12 May 2020 at 06:01, Loïc Yhuel <loic.yhuel@gmail.com> wrote:
> > This fixes the boot issues since 5.3 on several Dell models when the TPM
> > is enabled. Depending on the exact grub binary, booting the kernel would
> > freeze early, or just report an error parsing the final events log.
> > 
> > We get an event log in the SHA-1 format, which doesn't have a
> > tcg_efi_specid_event_head in the first event, and there is a final events
> > table which doesn't match the crypto agile format.
> > __calc_tpm2_event_size reads bad "count" and "efispecid->num_algs", and
> > either fails, or loops long enough for the machine to be appear frozen.
> > 
> > So we now only parse the final events table, which is per the spec always
> > supposed to be in the crypto agile format, when we got a event log in this
> > format.
> > 
> 
> So what functionality do we lose here? Can we still make meaningful
> use of the event log without the final log? I thought one was
> incomplete without the other?


Nope it would be incomplete [*].

So probably would make sense to at least issue a warning in this case.

[*] https://www.kernel.org/doc/Documentation/security/tpm/tpm_event_log.rst

/Jarkko

