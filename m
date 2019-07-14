Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02BFE67F63
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Jul 2019 16:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfGNOim (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 14 Jul 2019 10:38:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:54066 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728146AbfGNOim (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 14 Jul 2019 10:38:42 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jul 2019 07:38:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,490,1557212400"; 
   d="scan'208";a="172004983"
Received: from hgenzken-mobl.ger.corp.intel.com (HELO localhost) ([10.249.35.131])
  by orsmga006.jf.intel.com with ESMTP; 14 Jul 2019 07:38:37 -0700
Date:   Sun, 14 Jul 2019 17:38:36 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Peter Huewe <peterhuewe@gmx.de>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fTPM: fix PTR_ERR() usage
Message-ID: <20190714143836.yfmwkupgg3347i5q@linux.intel.com>
References: <20190712114951.912328-1-arnd@arndb.de>
 <730715760b20d9a76aa93c3ebc39a62045c9ee34.camel@linux.intel.com>
 <20190713151059.GG10104@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190713151059.GG10104@sasha-vm>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Jul 13, 2019 at 11:10:59AM -0400, Sasha Levin wrote:
> > Started also wondering tha tpm_ftpm_tee is a too generic name given that
> > this is for ARM TZ only. Would it make sense to rename it as something
> > like tpm_ftpm_tee_arm? Other proposals are welcome. Just made something
> > up.
> 
> Hm, isn't the _tee part enough?

Not sure, Trusted Execution Environment sounds something that could be
potentially used outside of ARM scope.

/Jarkko
