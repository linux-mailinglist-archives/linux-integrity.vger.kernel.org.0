Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA79F2E9FB2
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Jan 2021 22:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbhADV6U (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Jan 2021 16:58:20 -0500
Received: from mga12.intel.com ([192.55.52.136]:57536 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbhADV6U (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Jan 2021 16:58:20 -0500
IronPort-SDR: PilyWOUSSM+B9FkcLzd52TPYif0uUCtWC4TmR9k3yFydCbrW9WhxPhDJLB3XMLfdINe+iGPcVo
 zh+Z9723Qf+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="156208356"
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="156208356"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 13:56:33 -0800
IronPort-SDR: xgtStRMq4Hk5kfpIb3tEnrCXjZevCH+TLLEFDvLN34DVrDG6D2y//DLulRHM6aaRXrem8sU5av
 UxOTEv3h8eZQ==
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="378589911"
Received: from smestry-mobl1.gar.corp.intel.com (HELO linux.intel.com) ([10.252.62.64])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 13:56:25 -0800
Date:   Mon, 4 Jan 2021 23:56:24 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Ken Goldman <kgold@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v14 3/5] security: keys: trusted: fix TPM2 authorizations
Message-ID: <X/OPCHbAn8YjfQn8@linux.intel.com>
References: <20201129222004.4428-1-James.Bottomley@HansenPartnership.com>
 <20201129222004.4428-4-James.Bottomley@HansenPartnership.com>
 <dfd33d3d-8e1c-8acf-a3aa-3b62659d5d68@linux.ibm.com>
 <aa82e85e1a5055367517b1f0c0f00206f51353cb.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa82e85e1a5055367517b1f0c0f00206f51353cb.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 23, 2020 at 11:58:17AM -0800, James Bottomley wrote:
> On Tue, 2020-12-22 at 18:01 -0500, Ken Goldman wrote:
> > On 11/29/2020 5:20 PM, James Bottomley wrote:
> > > Note this is both and enhancement and a potential bug fix.  The TPM
> > > 2.0 spec requires us to strip leading zeros, meaning empyty
> > > authorization is a zero length HMAC whereas we're currently passing
> > > in 20 bytes of zeros.  A lot of TPMs simply accept this as OK, but
> > > the Microsoft TPM emulator rejects it with TPM_RC_BAD_AUTH, so this
> > > patch makes the Microsoft TPM emulator work with trusted keys.
> > 
> > 1 - To be precise, it strips trailing zeros, but 20 bytes of zero
> > results in an empty buffer either way.
> > 
> > "
> > Part 1 19.6.4.3	Authorization Size Convention
> > 
> > Trailing octets of zero are to be removed from any string before it
> > is used as an authValue.
> > "
> > 
> > 
> > 2 - If you have a test case for the MS simulator, post it and I'll
> > give it a try.
> > 
> > I did a quick test, power cycle to set platform auth to empty, than
> > create primary with a parent password 20 bytes of zero, and the
> > SW TPM accepted it.
> > 
> > This was a password session, not an HMAC session.
> 
> I reported it to Microsoft as soon as I found the problem, so, since
> this patch set has been languishing for years, I'd hope it would be
> fixed by now.  It is still, however, possible there still exist TPM
> implementations based on the unfixed Microsoft reference platform.
> 
> James

One year :-) A bit over but by all practical means... [*]

BTW, can you use my kernel org address for v15? 

[*] https://lore.kernel.org/linux-integrity/1575781600.14069.8.camel@HansenPartnership.com/

/Jarkko
