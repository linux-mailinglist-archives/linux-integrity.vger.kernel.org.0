Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A6D2D2980
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Dec 2020 12:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgLHLEp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Dec 2020 06:04:45 -0500
Received: from mga06.intel.com ([134.134.136.31]:2768 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbgLHLEp (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Dec 2020 06:04:45 -0500
IronPort-SDR: fhbSyMtQlu1Y4CFWGzbp8ihVBaAorgx+1XeUs0QQJq6h1m8b0d31wGWYvBD+SuloKGO3R06Wko
 LqYDYbkF8N0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="235470333"
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="235470333"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 03:02:58 -0800
IronPort-SDR: OwnlAoD1jMb2C6zsC/VIy7K4ffyxWMukxRJJiNfzvUcw3y971r1WH4Uj0QK0hFSqJiKNsmYkQ0
 8dx86s6PfjEA==
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="541980390"
Received: from lrohns-mobl1.ger.corp.intel.com (HELO linux.intel.com) ([10.252.33.185])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 03:02:53 -0800
Date:   Tue, 8 Dec 2020 13:02:49 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     kernel test robot <lkp@intel.com>, linux-integrity@vger.kernel.org,
        kbuild-all@lists.01.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>,
        jarkko@kernel.org
Subject: Re: [PATCH v14 4/5] security: keys: trusted: use ASN.1 TPM2 key
 format for the blobs
Message-ID: <20201208110249.GB18099@linux.intel.com>
References: <20201129222004.4428-5-James.Bottomley@HansenPartnership.com>
 <202011301002.yYRCOdq5-lkp@intel.com>
 <5e94c7199c675bbfa7112f8b79fcb91f8d2d4fe7.camel@HansenPartnership.com>
 <20201204044908.GD84413@linux.intel.com>
 <20201204045021.GE84413@linux.intel.com>
 <4b73d100255adefbeb6929481e218ef39592bcc8.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b73d100255adefbeb6929481e218ef39592bcc8.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 07, 2020 at 08:23:53AM -0800, James Bottomley wrote:
> On Fri, 2020-12-04 at 06:50 +0200, Jarkko Sakkinen wrote:
> > On Fri, Dec 04, 2020 at 06:49:15AM +0200, Jarkko Sakkinen wrote:
> > > On Mon, Nov 30, 2020 at 11:58:43AM -0800, James Bottomley wrote:
> > > > On Mon, 2020-11-30 at 10:10 +0800, kernel test robot wrote:
> > > > [...]
> > > > >  > 331		if (payload->blob_len < 0)
> > > > >    332			return payload->blob_len;
> > > > 
> > > > OK, I can rework this to use the signed version of blob len as
> > > > below.
> > > > 
> > > > James
> > > 
> > > Do you have the patches in a git branch somewhere with this fixed?
> > > 
> > > I can take from there and apply.
> > 
> > CC my korg address. Sorry for the latency, I have this LKML migration
> > going on (MAINTAINERS is already updated). Sometimes forgot to check
> > this inbox.
> 
> I'm preparing a v15 but this is basically the only code change.
> 
> James

Please actually do. It's always nice to have a lore reference to the
exact version that was merged.

/Jarkko
