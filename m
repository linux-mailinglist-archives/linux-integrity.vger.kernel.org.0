Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A50E9672C0
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jul 2019 17:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfGLPsl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Jul 2019 11:48:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:16948 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbfGLPsl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Jul 2019 11:48:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jul 2019 08:48:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,483,1557212400"; 
   d="scan'208";a="318032692"
Received: from yanbeibe-mobl2.ger.corp.intel.com ([10.249.32.118])
  by orsmga004.jf.intel.com with ESMTP; 12 Jul 2019 08:48:37 -0700
Message-ID: <cbe7fec0b3de8835d52cc926c888ea531c749ae4.camel@linux.intel.com>
Subject: Re: [PATCH] tpm_crb - workaround broken ACPI tables
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Safford, David (GE Global Research, US)" <david.safford@ge.com>
Cc:     Matthew Garrett <mjg59@google.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>
Date:   Fri, 12 Jul 2019 18:48:36 +0300
In-Reply-To: <20190712150656.GF27512@ziepe.ca>
References: <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7BC7@ALPMBAPA12.e2k.ad.ge.com>
         <20190711145850.GC25807@ziepe.ca>
         <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7C56@ALPMBAPA12.e2k.ad.ge.com>
         <20190711185027.GG25807@ziepe.ca>
         <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7CFE@ALPMBAPA12.e2k.ad.ge.com>
         <CACdnJutS4-N0GgtYPy9GGJ8dVf48VZGF5AFL2raB55bSPKUpNw@mail.gmail.com>
         <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7E2A@ALPMBAPA12.e2k.ad.ge.com>
         <20190712150656.GF27512@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-07-12 at 12:06 -0300, Jason Gunthorpe wrote:
> I wonder if the CRB in the nvs actually needs to be save/restored in
> AMD's implementation?
> 
> Sounds like the answer is to have TPM CRB somehow detect NVS and
> acquire the resource from it, while somehow sequencing suspend/resume
> properly.

Would be cool if we would be able to get someone from AMD to give
some details just to ensure that we are doing the right thing.

/Jarkko

