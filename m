Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11A3BE8413
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Oct 2019 10:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731720AbfJ2JRf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Oct 2019 05:17:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:18324 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729951AbfJ2JRe (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Oct 2019 05:17:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 02:17:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="401085901"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.122])
  by fmsmga006.fm.intel.com with ESMTP; 29 Oct 2019 02:17:32 -0700
Date:   Tue, 29 Oct 2019 11:17:31 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] tpm: Add major_version sysfs file
Message-ID: <20191029091731.GC9896@linux.intel.com>
References: <20191025193103.30226-1-jsnitsel@redhat.com>
 <20191028205313.GH8279@linux.intel.com>
 <20191028210507.7i6d6b5olw72shm3@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028210507.7i6d6b5olw72shm3@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Oct 28, 2019 at 02:05:07PM -0700, Jerry Snitselaar wrote:
> On Mon Oct 28 19, Jarkko Sakkinen wrote:
> > On Fri, Oct 25, 2019 at 12:31:03PM -0700, Jerry Snitselaar wrote:
> > > +	return sprintf(buf, "%s\n", chip->flags & TPM_CHIP_FLAG_TPM2
> > > +		       ? "2.0" : "1.2");
> > 
> > This is not right. Should be either "1" or "2".
> > 
> > /Jarkko
> 
> Okay I will fix that up. Do we have a final decision on the file name,
> major_version versus version_major?

Well, I don't see how major_version would make any sense. It is
not as future proof as version_major. Still waiting for Jason's
feedback for this.

/Jarkko
