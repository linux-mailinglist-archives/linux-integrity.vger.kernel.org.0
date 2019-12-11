Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A47C11B9C2
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2019 18:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730751AbfLKRMc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Dec 2019 12:12:32 -0500
Received: from mga03.intel.com ([134.134.136.65]:46794 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730158AbfLKRMc (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Dec 2019 12:12:32 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 09:12:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,302,1571727600"; 
   d="scan'208";a="414924854"
Received: from cebrenes-mobl1.amr.corp.intel.com (HELO localhost) ([10.251.85.152])
  by fmsmga006.fm.intel.com with ESMTP; 11 Dec 2019 09:12:23 -0800
Date:   Wed, 11 Dec 2019 19:12:22 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        "Zhao, Shirley" <shirley.zhao@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        'Mauro Carvalho Chehab' <mchehab+samsung@kernel.org>,
        "Zhu, Bing" <bing.zhu@intel.com>,
        "Chen, Luhai" <luhai.chen@intel.com>
Subject: Re: One question about trusted key of keyring in Linux kernel.
Message-ID: <20191211171222.GA4516@linux.intel.com>
References: <A888B25CD99C1141B7C254171A953E8E4909BA3B@shsmsx102.ccr.corp.intel.com>
 <1575260220.4080.17.camel@linux.ibm.com>
 <A888B25CD99C1141B7C254171A953E8E4909D360@shsmsx102.ccr.corp.intel.com>
 <1575267453.4080.26.camel@linux.ibm.com>
 <A888B25CD99C1141B7C254171A953E8E4909E381@shsmsx102.ccr.corp.intel.com>
 <1575269075.4080.31.camel@linux.ibm.com>
 <A888B25CD99C1141B7C254171A953E8E4909E399@shsmsx102.ccr.corp.intel.com>
 <1575312932.24227.13.camel@linux.ibm.com>
 <20191209194715.GD19243@linux.intel.com>
 <1575926334.4557.17.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1575926334.4557.17.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 09, 2019 at 04:18:54PM -0500, Mimi Zohar wrote:
> On Mon, 2019-12-09 at 21:47 +0200, Jarkko Sakkinen wrote:
> > On Mon, Dec 02, 2019 at 10:55:32AM -0800, James Bottomley wrote:
> > > blob but it looks like we need to fix the API.  I suppose the good news
> > > is given this failure that we have the opportunity to rewrite the API
> > > since no-one else can have used it for anything because of this.  The
> > 
> > I did successfully run this test when I wrote it 5 years ago:
> > 
> > https://github.com/jsakkine-intel/tpm2-scripts/blob/master/keyctl-smoke.sh
> 
> Thanks, Jarkko.  Is this test still working or is there a regression?

I will run it and in addition to that I will make a patch out of it.

Any suggestions for the script name (should probably have 'tpm2' in
it at least)?

/Jarkko
