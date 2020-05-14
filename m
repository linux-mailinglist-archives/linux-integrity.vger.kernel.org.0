Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8741D2D84
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2020 12:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgENKv4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 May 2020 06:51:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:23270 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbgENKv4 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 May 2020 06:51:56 -0400
IronPort-SDR: tefQ+fuE/yM/C0NNxBEbpuXQqERNCz0lwggjminhOS8x6ic0q6BErv2goSbGmhK8rXsV3MhVJy
 jZ4IdA9uakVw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 03:51:55 -0700
IronPort-SDR: 46gXR2FOU1CoYboCW4wd1pF2D2k8gL53ixan8bWkgETCODT1YK9wVtHmz6WXGaeemSCYbludmZ
 CbO8F9kw3+Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,391,1583222400"; 
   d="scan'208";a="266202646"
Received: from apogrebi-mobl2.ger.corp.intel.com ([10.249.39.119])
  by orsmga006.jf.intel.com with ESMTP; 14 May 2020 03:51:53 -0700
Message-ID: <aa633c59f845817f7ada8089f29638bdfdb016a3.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: check event log version before reading final events
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        =?ISO-8859-1?Q?Lo=EFc?= Yhuel <loic.yhuel@gmail.com>
Cc:     linux-integrity@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>, javierm@redhat.com
Date:   Thu, 14 May 2020 13:51:53 +0300
In-Reply-To: <CAMj1kXFPt4eSDCC61paWhyfOaEeWUgUQSnczwZJ7Eny8t7ow5g@mail.gmail.com>
References: <20200512040113.277768-1-loic.yhuel@gmail.com>
         <CAMj1kXFfLvUXU1A-7jnh3KMy5Qguhq0k9Cw=O0iBmbToowV_8A@mail.gmail.com>
         <CANMwUkg+2O2nK8z38HZw6z0NdLUPwj40m4DPKmn1sf9oDqG7Pw@mail.gmail.com>
         <CAMj1kXFPt4eSDCC61paWhyfOaEeWUgUQSnczwZJ7Eny8t7ow5g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-05-12 at 14:30 +0200, Ard Biesheuvel wrote:
> On Tue, 12 May 2020 at 13:40, Loïc Yhuel <loic.yhuel@gmail.com> wrote:
> > Le mar. 12 mai 2020 à 08:45, Ard Biesheuvel <ardb@kernel.org> a écrit :
> > > So what functionality do we lose here? Can we still make meaningful
> > > use of the event log without the final log? I thought one was
> > > incomplete without the other?
> > The char driver (drivers/char/tpm/eventlog/efi.c), already ignores
> > efi.tpm_final_log
> > if the event log version isn't EFI_TCG2_EVENT_LOG_FORMAT_TCG_2.
> > So there currently no code making use of the final log contents on
> > those machines,
> > besides the two cases I patched which only try to determine its size.
> > 
> 
> Ah ok, thanks for clarifying. If we never consume it anyway, then I
> agree this is the correct fix.

I think issuing a warning would not be a bad idea given the incompleteness
of the even log.

/Jarkko

