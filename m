Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71B186244B
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jul 2019 17:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388645AbfGHPZj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Jul 2019 11:25:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:18169 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388641AbfGHPZj (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Jul 2019 11:25:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2019 08:25:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,466,1557212400"; 
   d="scan'208";a="363835132"
Received: from jsakkine-mobl1.tm.intel.com ([10.237.50.189])
  by fmsmga005.fm.intel.com with ESMTP; 08 Jul 2019 08:25:35 -0700
Message-ID: <846cacae8cede764a2e84f628f539d94582fdbe0.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: Document UEFI event log quirks
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     tweek@google.com, matthewgarrett@google.com,
        Jonathan Corbet <corbet@lwn.net>
Date:   Mon, 08 Jul 2019 18:25:38 +0300
In-Reply-To: <ec274596-6bc8-07a0-d09b-1d191646c5cd@infradead.org>
References: <20190703161109.22935-1-jarkko.sakkinen@linux.intel.com>
         <6acf78df-b168-14d3-fea4-9a9d2945e77f@infradead.org>
         <a8ee93721a674434e22d31fd1d10bf9472c1c739.camel@linux.intel.com>
         <ec274596-6bc8-07a0-d09b-1d191646c5cd@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2019-07-07 at 12:33 -0700, Randy Dunlap wrote:
> On 7/5/19 3:15 AM, Jarkko Sakkinen wrote:
> > On Wed, 2019-07-03 at 09:45 -0700, Randy Dunlap wrote:
> > > > +This introduces another problem: nothing guarantees that it is not
> > > > +called before the stub gets to run. Thus, it needs to copy the final
> > > > +events table preboot size to the custom configuration table so that
> > > > +kernel offset it later on.
> 
>      (so that)
>      the kernel can use that final table preboot size as an events table
>      offset later on.
> 
> > > ?  kernel can offset it later on.
> > 
> > EFI stub calculates the total size of the events in the final events
> > table at the time.
> > 
> > Later on, TPM driver uses this offset to copy only the events that
> > were actually generated after ExitBootServices():
> > 
> > /*
> >  * Copy any of the final events log that didn't also end up in the
> >  * main log. Events can be logged in both if events are generated
> >  * between GetEventLog() and ExitBootServices().
> >  */
> > memcpy((void *)log->bios_event_log + log_size,
> >        final_tbl->events + log_tbl->final_events_preboot_size,
> >        efi_tpm_final_log_size);
> > 
> > What would be a better way to describe this?
> 
> Yeah, I think I see what it's doing, how it's using that.
> See above.
> 
> OK?

Your propsal looks legit, thank you. I'll send an update that
tries to address yours and Jordan's feedback.

/Jarkko 

