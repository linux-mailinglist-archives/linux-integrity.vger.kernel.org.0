Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2464F62084
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jul 2019 16:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfGHOdJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Jul 2019 10:33:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:12732 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728725AbfGHOdJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Jul 2019 10:33:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2019 07:33:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,466,1557212400"; 
   d="scan'208";a="316734532"
Received: from jsakkine-mobl1.tm.intel.com ([10.237.50.189])
  by orsmga004.jf.intel.com with ESMTP; 08 Jul 2019 07:33:07 -0700
Message-ID: <c72431a1e275d94203a62c99337cca40c20a43c9.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: Fix null pointer dereference on chip register
 error path
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Milan Broz <gmazyland@gmail.com>, linux-integrity@vger.kernel.org,
        James Morris <jmorris@namei.org>
Date:   Mon, 08 Jul 2019 17:33:08 +0300
In-Reply-To: <1324e0d6-74c4-f8a7-ea9f-0a603bf15e93@gmail.com>
References: <20190612084210.13562-1-gmazyland@gmail.com>
         <9df0a432-eb9c-914e-5ddc-2680a6fecebd@gmail.com>
         <a8fc7162019168ab3b9b662fb629855205a6b1ca.camel@linux.intel.com>
         <20190703230125.aynx4ianvqqjt5d7@linux.intel.com>
         <1821f2adb0910e76f039949e96ed78325025a4bd.camel@linux.intel.com>
         <1324e0d6-74c4-f8a7-ea9f-0a603bf15e93@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-07-05 at 23:23 +0200, Milan Broz wrote:
> On 05/07/2019 19:52, Jarkko Sakkinen wrote:
> > So how should we work this one out? Do you want to create v2 or do I
> > create a new patch and put reported-by tag. Both work for me. I just
> > need to know this.
> 
> Please fix you mail filters, the patch was sent more than day ago.
> 
> 
https://lore.kernel.org/linux-integrity/20190704072615.31143-1-gmazyland@gmail.com/T/#u
> 
> Milan

Nothing wrong with my mail filters, it was actually waiting in my inbox.
Just didn't notice it that it was part of the emails I downloaded to my
laptop with fdm on Friday (because in rush to spend weekend). Didn't
have time to go through all of them during that day.

/Jarkko

