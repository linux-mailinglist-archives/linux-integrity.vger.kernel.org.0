Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90F8DE83F8
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Oct 2019 10:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbfJ2JOW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Oct 2019 05:14:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:42281 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730552AbfJ2JOW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Oct 2019 05:14:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 02:14:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="399721579"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.122])
  by fmsmga005.fm.intel.com with ESMTP; 29 Oct 2019 02:14:20 -0700
Date:   Tue, 29 Oct 2019 11:14:19 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: Add major_version sysfs file
Message-ID: <20191029091419.GA9896@linux.intel.com>
References: <20191025142847.14931-1-jsnitsel@redhat.com>
 <20191027153541.GA5222@linux.intel.com>
 <20191027230046.GJ23952@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191027230046.GJ23952@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Oct 27, 2019 at 08:00:46PM -0300, Jason Gunthorpe wrote:
> On Sun, Oct 27, 2019 at 05:35:41PM +0200, Jarkko Sakkinen wrote:
> > On Fri, Oct 25, 2019 at 07:28:47AM -0700, Jerry Snitselaar wrote:
> > > Easily determining what TCG version a tpm device implements
> > > has been a pain point for userspace for a long time, so
> > > add a sysfs file to report the tcg version of a tpm device.
> > > 
> > > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Cc: Peter Huewe <peterhuewe@gmx.de>
> > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > Cc: linux-integrity@vger.kernel.org
> > > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > 
> > Please use version_major (e.g. if there is ever version_minor
> > they order nicely alphabetically).
> 
> That is not the convention in sysfs

What is wrong with that name?

/Jarkko
