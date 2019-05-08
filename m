Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 738EB179A0
	for <lists+linux-integrity@lfdr.de>; Wed,  8 May 2019 14:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfEHMom (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 May 2019 08:44:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:49513 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbfEHMom (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 May 2019 08:44:42 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 05:44:41 -0700
X-ExtLoop1: 1
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.189])
  by orsmga005.jf.intel.com with ESMTP; 08 May 2019 05:44:37 -0700
Date:   Wed, 8 May 2019 15:44:36 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com
Subject: Re: [PATCH v3 0/2] ftpm: a firmware based TPM driver
Message-ID: <20190508124436.GE7642@linux.intel.com>
References: <20190415155636.32748-1-sashal@kernel.org>
 <20190507174020.GH1747@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507174020.GH1747@sasha-vm>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, May 07, 2019 at 01:40:20PM -0400, Sasha Levin wrote:
> On Mon, Apr 15, 2019 at 11:56:34AM -0400, Sasha Levin wrote:
> > From: "Sasha Levin (Microsoft)" <sashal@kernel.org>
> > 
> > Changes since v2:
> > 
> > - Drop the devicetree bindings patch (we don't add any new ones).
> > - More code cleanups based on Jason Gunthorpe's review.
> > 
> > Sasha Levin (2):
> >  ftpm: firmware TPM running in TEE
> >  ftpm: add documentation for ftpm driver
> 
> Ping? Does anyone have any objections to this?

Sorry I've been on vacation week before last week and last week
I was extremely busy because I had been on vacation. This in
my TODO list. Will look into it tomorrow in detail.

Apologies for the delay with this!

/Jarkko
