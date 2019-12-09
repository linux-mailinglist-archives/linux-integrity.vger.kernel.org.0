Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0011E11776A
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Dec 2019 21:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfLIUby (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Dec 2019 15:31:54 -0500
Received: from mga14.intel.com ([192.55.52.115]:54463 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbfLIUby (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Dec 2019 15:31:54 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 12:25:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,296,1571727600"; 
   d="scan'208";a="215208124"
Received: from nshalmon-mobl.ger.corp.intel.com (HELO localhost) ([10.252.8.146])
  by orsmga006.jf.intel.com with ESMTP; 09 Dec 2019 12:25:54 -0800
Date:   Mon, 9 Dec 2019 22:25:52 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Will Deacon <will@kernel.org>
Cc:     Jeffrin Jose <jeffrin@rajagiritech.edu.in>, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca
Subject: Re: [PROBLEM]:  WARNING: lock held when returning to user space!
 (5.4.1 #16 Tainted: G )
Message-ID: <20191209202552.GK19243@linux.intel.com>
References: <20191207173420.GA5280@debian>
 <20191209103432.GC3306@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209103432.GC3306@willie-the-truck>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 09, 2019 at 10:34:32AM +0000, Will Deacon wrote:
> Hi,
> 
> [expanding cc list]
> 
> On Sat, Dec 07, 2019 at 11:04:20PM +0530, Jeffrin Jose wrote:
> > i got the following  output related from typical dmesg output from 5.4.1 kernel
> 
> Was this during boot or during some other operation?
> 
> > ================================================
> > WARNING: lock held when returning to user space!
> > 5.4.1 #16 Tainted: G            E    
> > ------------------------------------------------
> > tpm2-abrmd/691 is leaving the kernel with locks still held!
> > 2 locks held by tpm2-abrmd/691:
> >  #0: ffff8881ee784ba8 (&chip->ops_sem){.+.+}, at: tpm_try_get_ops+0x2b/0xc0 [tpm]
> >  #1: ffff8881ee784d88 (&chip->tpm_mutex){+.+.}, at: tpm_try_get_ops+0x57/0xc0 [tpm]
> 
> Can you reproduce this failure on v5.5-rc1?

Does this appear after variable amount of time or detemitically always
at certain point of time (e.g. when the daemon starts or perhaps always
when doing a certain operations with TSS)?

Do we have possibility to get the user code path that gets executed when
this happens?

/Jarkko
