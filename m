Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA29AEF70
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2019 18:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394149AbfIJQVf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Sep 2019 12:21:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:21091 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394113AbfIJQVf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Sep 2019 12:21:35 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2019 09:21:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="335968855"
Received: from bhobinca-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.53.13])
  by orsmga004.jf.intel.com with ESMTP; 10 Sep 2019 09:21:33 -0700
Date:   Tue, 10 Sep 2019 17:21:32 +0100
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v6 00/12] add integrity and security to TPM2 transactions
Message-ID: <20190910162132.GA11338@linux.intel.com>
References: <1568031408.6613.29.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568031408.6613.29.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 09, 2019 at 01:16:48PM +0100, James Bottomley wrote:
> Link to previous cover letter:
> 
> https://lore.kernel.org/linux-integrity/1540193596.3202.7.camel@HansenPartnership.com/
> 
> This is marked v6 instead of v5 because I did a v5 after feedback on v4
> but didn't get around to posting it and then had to rework the whole of
> the kernel space handling while I was on holiday.  I also added the
> documentation of how the whole thing works and the rationale for doing
> it in tpm-security.rst (patch 11).  The main reason for doing this now
> is so we have something to discuss at Plumbers.
> 
> The new patch set implements the various splits requested, but the main
> changes are that the kernel space is gone and is replaced by a context
> save and restore of the generated null seed.  This is easier to handle
> than a full kernel space given the new threading for TPM spaces, but
> conceptually it is still very like a space.  I've also made whether
> integrity and encryption is turned on a Kconfig option.
> 
> James

So... is there a changelog for the revisions?

/Jarkko
