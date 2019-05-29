Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A71EA2DFF0
	for <lists+linux-integrity@lfdr.de>; Wed, 29 May 2019 16:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfE2OjN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 May 2019 10:39:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:40996 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfE2OjN (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 May 2019 10:39:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 May 2019 07:39:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,527,1549958400"; 
   d="scan'208";a="179598110"
Received: from ehallina-mobl.ger.corp.intel.com (HELO localhost) ([10.252.1.77])
  by fmsmga002.fm.intel.com with ESMTP; 29 May 2019 07:39:08 -0700
Date:   Wed, 29 May 2019 17:39:07 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Laura Abbott <labbott@redhat.com>
Cc:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Phil Baker <baker1tex@gmail.com>,
        Craig Robson <craig@zhatt.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH v3] tpm: Actually fail on TPM errors during "get random"
Message-ID: <20190529143907.GA7984@linux.intel.com>
References: <20190401190607.GA23795@beast>
 <20190401234625.GA29016@linux.intel.com>
 <20190402164057.GA4544@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DAE2759@hasmsx108.ger.corp.intel.com>
 <20190403175207.GC13396@linux.intel.com>
 <bfcb58ef-98b3-a663-c249-3940ec9a39d3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfcb58ef-98b3-a663-c249-3940ec9a39d3@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, May 28, 2019 at 03:02:49PM -0400, Laura Abbott wrote:
> > Great, I'll add it. Thank you. Just want to be explicit with these
> > things as I consider them as if I was asking a signature from someone
> > :-)
> > 
> > /Jarkko
> > 
> Was this intended to go in for 5.2? I still don't see it in the tree.

Was intended but I failed to notice that I should start to send PRs
to Linus instead of security tree and was waiting for security tree
to be rebased. I'll include to the next PR.

/Jarkko
