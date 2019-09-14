Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E71ADB2B42
	for <lists+linux-integrity@lfdr.de>; Sat, 14 Sep 2019 14:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388371AbfINMxs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 14 Sep 2019 08:53:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:44514 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387462AbfINMxs (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 14 Sep 2019 08:53:48 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2019 05:53:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="361078798"
Received: from krusocki-mobl.ger.corp.intel.com (HELO localhost) ([10.252.40.34])
  by orsmga005.jf.intel.com with ESMTP; 14 Sep 2019 05:53:42 -0700
Date:   Sat, 14 Sep 2019 13:53:41 +0100
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add a git and a maintainer entry to keyring
 subsystems
Message-ID: <20190914125341.GB9560@linux.intel.com>
References: <20190910143228.30305-1-jarkko.sakkinen@linux.intel.com>
 <11580.1568387033@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11580.1568387033@warthog.procyon.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Sep 13, 2019 at 04:03:53PM +0100, David Howells wrote:
> Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> 
> > Subject: [PATCH] MAINTAINERS: Add a git and a maintainer entry to keyring subsystems
> 
> I would recommend splitting the patch in two and putting something like:
> 
> 	keys: Add Jarkko Sakkinen as co-maintainer
> 
> as the subject of the keyrings maintainership one.

Thanks, I'll refine accordingly.

/Jarkko
