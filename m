Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63003CD9A5
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Oct 2019 01:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfJFXcd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 6 Oct 2019 19:32:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:22013 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfJFXcd (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 6 Oct 2019 19:32:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Oct 2019 16:32:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,265,1566889200"; 
   d="scan'208";a="276626306"
Received: from mwebb1-mobl.ger.corp.intel.com (HELO localhost) ([10.251.93.103])
  by orsmga001.jf.intel.com with ESMTP; 06 Oct 2019 16:32:27 -0700
Date:   Mon, 7 Oct 2019 02:32:21 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] tpm: Detach page allocation from tpm_buf
Message-ID: <20191006233221.GA15594@linux.intel.com>
References: <20191003185103.26347-1-jarkko.sakkinen@linux.intel.com>
 <20191003185103.26347-3-jarkko.sakkinen@linux.intel.com>
 <1570207062.3563.17.camel@HansenPartnership.com>
 <1570210647.5046.78.camel@linux.ibm.com>
 <1570210902.3563.19.camel@HansenPartnership.com>
 <20191004182434.tjwtfjzvamomybhr@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004182434.tjwtfjzvamomybhr@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Oct 04, 2019 at 11:24:34AM -0700, Jerry Snitselaar wrote:
> On Fri Oct 04 19, James Bottomley wrote:
> > On Fri, 2019-10-04 at 13:37 -0400, Mimi Zohar wrote:
> > > On Fri, 2019-10-04 at 09:37 -0700, James Bottomley wrote:
> > > > On Thu, 2019-10-03 at 21:51 +0300, Jarkko Sakkinen wrote:
> > > > > As has been seen recently, binding the buffer allocation and
> > > > > tpm_buf
> > > > > together is sometimes far from optimal.
> > > >
> > > > Can you elaborate on this a bit more?  I must have missed the
> > > > discussion.
> > > 
> > > Refer to e13cd21ffd50 ("tpm: Wrap the buffer from the caller to
> > > tpm_buf in tpm_send()") for the details.
> > 
> > Yes, I get that, but to my mind that calls for moving the
> > tpm_init/destroy_buf into the callers of tpm_send (which, for the most
> > part, already exist), which means there's no need to separate the buf
> > and data lifetimes.
> > 
> > James
> > 
> 
> Sumit has been working on a patchset that does this.  His patchset
> converts both the asymmetric keys and trusted keys code to using the
> tpm_buf manipulation functions.

And it is also in a shape that it can soon be merged (within
few iterations at most).

/Jarkko
