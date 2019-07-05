Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C91256052E
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jul 2019 13:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfGELRH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Jul 2019 07:17:07 -0400
Received: from mga06.intel.com ([134.134.136.31]:51990 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbfGELRG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Jul 2019 07:17:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2019 04:17:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,454,1557212400"; 
   d="scan'208";a="339808382"
Received: from jsakkine-mobl1.tm.intel.com ([10.237.50.189])
  by orsmga005.jf.intel.com with ESMTP; 05 Jul 2019 04:16:59 -0700
Message-ID: <a976eae5b9ace7a03eb18e5f7a1e9ff0059559ca.camel@linux.intel.com>
Subject: Re: [PATCH] Revert "tpm: pass an array of tpm_extend_digest
 structures to tpm_pcr_extend()"
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Michal Suchanek <msuchanek@suse.de>,
        linux-integrity@vger.kernel.org
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Bottomley <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Armijn Hemel <armijn@tjaldur.nl>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Date:   Fri, 05 Jul 2019 14:16:58 +0300
In-Reply-To: <1562240882.6165.78.camel@linux.ibm.com>
References: <20190701131505.17759-1-msuchanek@suse.de>
         <8e4cc105b748c5395132b4d3d29d0d9b30a8720c.camel@linux.intel.com>
         <cf2ea579-41c2-42da-2df3-0b1f12e1c639@huawei.com>
         <1562240882.6165.78.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-07-04 at 07:48 -0400, Mimi Zohar wrote:
> On Thu, 2019-07-04 at 13:28 +0200, Roberto Sassu wrote:
> > On 7/4/2019 12:03 PM, Jarkko Sakkinen wrote:
> > > On Mon, 2019-07-01 at 15:15 +0200, Michal Suchanek wrote:
> > > > This reverts commit 0b6cf6b97b7ef1fa3c7fefab0cac897a1c4a3400 to avoid
> > > > following crash:
> > > 
> > > Thank you. I think this the right choice for the moment. I fixed
> > > a trivial checkpatch.pl error and added the mandatory tags. Can
> > > you check quickly v2 (just posted)?
> > > 
> > > I already made it available in my master and next.
> > 
> > Could you please wait few days? I would prefer to fix this issue instead
> > of reverting the whole patch.
> 
> Nayna posted a patch late yesterday titled "tpm: fixes uninitialized
> allocated banks for IBM vtpm driver", which addresses this bug.

With some minor changes it should be fine.

/Jarkko

