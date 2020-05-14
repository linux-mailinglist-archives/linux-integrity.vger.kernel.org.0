Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6228A1D41D5
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2020 01:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgENXp3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 May 2020 19:45:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:15654 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbgENXp3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 May 2020 19:45:29 -0400
IronPort-SDR: 6yRLmhgV/4GgiaDZgg+Ge+0FuzmVqBjJ6ZE2IR4KUrRv/roNh2ZDlEnrt7lI/w9sj/DZ45EU8k
 I3Mq25uqsiqg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 16:45:10 -0700
IronPort-SDR: QJjC5KP/0QZ5t28RoYykDPx+zZ2pXQM3doJrw8eAM17sh9hWU3hzMQAYwM7Qp7dii/cECMTdvc
 tn340YMzDtPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,392,1583222400"; 
   d="scan'208";a="410262700"
Received: from ashadrin-mobl1.ccr.corp.intel.com ([10.249.38.112])
  by orsmga004.jf.intel.com with ESMTP; 14 May 2020 16:45:07 -0700
Message-ID: <7f477bcd992f0927a25f8538663c7bad8efb73c1.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: check event log version before reading final events
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     =?ISO-8859-1?Q?Lo=EFc?= Yhuel <loic.yhuel@gmail.com>,
        linux-integrity@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>, javierm@redhat.com
Date:   Fri, 15 May 2020 02:44:55 +0300
In-Reply-To: <CAMj1kXHX2Hf_QeKF4m-4yfjzcM2=AFV-EzthQvDO1pOsyaSsZw@mail.gmail.com>
References: <20200512040113.277768-1-loic.yhuel@gmail.com>
         <CAMj1kXFfLvUXU1A-7jnh3KMy5Qguhq0k9Cw=O0iBmbToowV_8A@mail.gmail.com>
         <ab9df4468cc294c67a67ef336019379033e7c90c.camel@linux.intel.com>
         <CAMj1kXHX2Hf_QeKF4m-4yfjzcM2=AFV-EzthQvDO1pOsyaSsZw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-05-14 at 10:10 +0200, Ard Biesheuvel wrote:
> On Thu, 14 May 2020 at 03:09, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> > On Tue, 2020-05-12 at 08:44 +0200, Ard Biesheuvel wrote:
> > > Hi Loïc,
> > > 
> > > Thanks for the fix.
> > > 
> > > On Tue, 12 May 2020 at 06:01, Loïc Yhuel <loic.yhuel@gmail.com> wrote:
> > > > This fixes the boot issues since 5.3 on several Dell models when the TPM
> > > > is enabled. Depending on the exact grub binary, booting the kernel would
> > > > freeze early, or just report an error parsing the final events log.
> > > > 
> > > > We get an event log in the SHA-1 format, which doesn't have a
> > > > tcg_efi_specid_event_head in the first event, and there is a final events
> > > > table which doesn't match the crypto agile format.
> > > > __calc_tpm2_event_size reads bad "count" and "efispecid->num_algs", and
> > > > either fails, or loops long enough for the machine to be appear frozen.
> > > > 
> > > > So we now only parse the final events table, which is per the spec always
> > > > supposed to be in the crypto agile format, when we got a event log in this
> > > > format.
> > > > 
> > > 
> > > So what functionality do we lose here? Can we still make meaningful
> > > use of the event log without the final log? I thought one was
> > > incomplete without the other?
> > 
> > Nope it would be incomplete [*].
> > 
> > So probably would make sense to at least issue a warning in this case.
> > 
> > [*] https://www.kernel.org/doc/Documentation/security/tpm/tpm_event_log.rst
> > 
> 
> Right.
> 
> I'll take the current patch as a fix for now.
> 
> I agree it makes sense to add a warning, but I'd like to understand
> better which exact condition we should warn about.
> Currently, tpm_read_log_efi() simply disregards the final log if it is
> not in crypto agile format, but is there any point to exposing
> anything in that case?


IMHO just a brief warning that "tail is missing" would be sufficient,
no other info.

/Jarkko

