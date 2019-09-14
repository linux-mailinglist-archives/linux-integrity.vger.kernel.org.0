Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE57B2B46
	for <lists+linux-integrity@lfdr.de>; Sat, 14 Sep 2019 14:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388208AbfINMyv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 14 Sep 2019 08:54:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:11308 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387462AbfINMyv (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 14 Sep 2019 08:54:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2019 05:54:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="361078920"
Received: from krusocki-mobl.ger.corp.intel.com (HELO localhost) ([10.252.40.34])
  by orsmga005.jf.intel.com with ESMTP; 14 Sep 2019 05:54:45 -0700
Date:   Sat, 14 Sep 2019 13:54:44 +0100
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     David Howells <dhowells@redhat.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add a git and a maintainer entry to keyring
 subsystems
Message-ID: <20190914125444.GC9560@linux.intel.com>
References: <20190910143228.30305-1-jarkko.sakkinen@linux.intel.com>
 <11580.1568387033@warthog.procyon.org.uk>
 <33da71451cbc5836efd61ccf125be89c6e946253.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33da71451cbc5836efd61ccf125be89c6e946253.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Sep 13, 2019 at 10:36:15AM -0700, Joe Perches wrote:
> On Fri, 2019-09-13 at 16:03 +0100, David Howells wrote:
> > Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> > 
> > > Subject: [PATCH] MAINTAINERS: Add a git and a maintainer entry to keyring subsystems
> > 
> > I would recommend splitting the patch in two and putting something like:
> > 
> > 	keys: Add Jarkko Sakkinen as co-maintainer
> > 
> > as the subject of the keyrings maintainership one.
> 
> Why is there utility in micro splitting such a trivial patch?

I kind of get this for the MAINTAINERS file so that the changes can
be agreed/disagreed separately.

/Jarkko
