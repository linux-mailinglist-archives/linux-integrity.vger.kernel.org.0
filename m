Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA37B403F
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2019 20:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390314AbfIPSXh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Sep 2019 14:23:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:12162 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390312AbfIPSXg (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Sep 2019 14:23:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 11:23:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,513,1559545200"; 
   d="scan'208";a="180523040"
Received: from mnichels-mobl.amr.corp.intel.com (HELO localhost) ([10.252.53.200])
  by orsmga008.jf.intel.com with ESMTP; 16 Sep 2019 11:23:33 -0700
Date:   Mon, 16 Sep 2019 21:23:32 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Joe Perches <joe@perches.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add a git and a maintainer entry to keyring
 subsystems
Message-ID: <20190916182332.GC16093@linux.intel.com>
References: <33da71451cbc5836efd61ccf125be89c6e946253.camel@perches.com>
 <20190910143228.30305-1-jarkko.sakkinen@linux.intel.com>
 <11580.1568387033@warthog.procyon.org.uk>
 <32692.1568623971@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32692.1568623971@warthog.procyon.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 16, 2019 at 09:52:51AM +0100, David Howells wrote:
> Joe Perches <joe@perches.com> wrote:
> 
> > > I would recommend splitting the patch in two and putting something like:
> > > 
> > > 	keys: Add Jarkko Sakkinen as co-maintainer
> > > 
> > > as the subject of the keyrings maintainership one.
> > 
> > Why is there utility in micro splitting such a trivial patch?
> 
> Because the keyrings maintainership piece is addressing a major procedural
> concern on Linus's part - and I think it needs to go in its own patch with the
> subject I suggested.

I'll send separate patches tomorrow.

/Jarkko
