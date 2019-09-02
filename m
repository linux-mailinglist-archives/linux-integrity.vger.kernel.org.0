Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2380A57B2
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Sep 2019 15:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbfIBNf0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Sep 2019 09:35:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:8380 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730417AbfIBNfZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Sep 2019 09:35:25 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 06:35:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,459,1559545200"; 
   d="scan'208";a="211688788"
Received: from doblerbe-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.53.100])
  by fmsmga002.fm.intel.com with ESMTP; 02 Sep 2019 06:35:21 -0700
Date:   Mon, 2 Sep 2019 16:35:20 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org,
        Alexey Klimov <aklimov@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Remove duplicate code from caps_show() in
 tpm-sysfs.c
Message-ID: <20190902133520.evot6o35vr3bz5vq@linux.intel.com>
References: <20190829143807.30647-1-jarkko.sakkinen@linux.intel.com>
 <20190830160902.iip5jr4yiqcjpz45@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830160902.iip5jr4yiqcjpz45@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Aug 30, 2019 at 09:09:02AM -0700, Jerry Snitselaar wrote:
> On Thu Aug 29 19, Jarkko Sakkinen wrote:
> +	/* TPM 1.1 */
> > +	if (tpm1_getcap(chip, TPM_CAP_VERSION_1_1, &cap,
> > +			"attempting to determine the 1.1 version",
> > +			sizeof(cap.version1))) {
> > +		version = &cap.version1;
:> 
> Actually looking at this again, this seems wrong. The version
> assignment here should be below this if, or in an else block, yes?

Absolutely is in a wrong place.

I sent an updated patch:

https://patchwork.kernel.org/patch/11126741/

/Jarkko
