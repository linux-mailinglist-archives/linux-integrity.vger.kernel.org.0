Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6D9A58D1
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Sep 2019 16:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730885AbfIBOIG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Sep 2019 10:08:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:35393 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbfIBOIG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Sep 2019 10:08:06 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 07:08:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,459,1559545200"; 
   d="scan'208";a="183317979"
Received: from doblerbe-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.53.100])
  by fmsmga007.fm.intel.com with ESMTP; 02 Sep 2019 07:08:02 -0700
Date:   Mon, 2 Sep 2019 17:08:00 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND][PATCH v2-resend] MAINTAINERS: fix style in KEYS-TRUSTED
 entry
Message-ID: <20190902140800.oonp4yr5673fpyd5@linux.intel.com>
References: <20190825170015.3199-1-lukas.bulwahn@gmail.com>
 <20190826054024.fjx3robu464ndvi7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826054024.fjx3robu464ndvi7@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Aug 26, 2019 at 08:40:24AM +0300, Jarkko Sakkinen wrote:
> On Sun, Aug 25, 2019 at 07:00:15PM +0200, Lukas Bulwahn wrote:
> > Mimi Zohar used spaces instead of a tab when adding Jarkko Sakkinen as
> > further maintainer to the KEYS-TRUSTED section entry.
> > 
> > In fact, ./scripts/checkpatch.pl -f MAINTAINERS complains:
> > 
> >   WARNING: MAINTAINERS entries use one tab after TYPE:
> >   #8581: FILE: MAINTAINERS:8581:
> >   +M:      Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> > The issue was detected when writing a script that parses MAINTAINERS.
> > 
> > Fixes: 34bccd61b139 ("MAINTAINERS: add Jarkko as maintainer for trusted keys")
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> 
> Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Including to my v5.4 PR.

/Jarkko
