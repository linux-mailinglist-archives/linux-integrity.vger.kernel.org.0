Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E67991229A5
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Dec 2019 12:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfLQLRM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Dec 2019 06:17:12 -0500
Received: from mga07.intel.com ([134.134.136.100]:23166 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726824AbfLQLRM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Dec 2019 06:17:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 03:17:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,325,1571727600"; 
   d="scan'208";a="205441884"
Received: from pbroex-mobl1.ger.corp.intel.com ([10.251.85.107])
  by orsmga007.jf.intel.com with ESMTP; 17 Dec 2019 03:17:09 -0800
Message-ID: <8e3a747111a60ec4e4b8b0ce5f079eade9750735.camel@linux.intel.com>
Subject: Re: [PATCH] drivers: char: tpm: remove unneeded MODULE_VERSION()
 usage
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Date:   Tue, 17 Dec 2019 13:17:07 +0200
In-Reply-To: <1a68db2aee382a1b0472cf0b81a809bc089e622d.camel@linux.intel.com>
References: <20191216084230.31412-1-info@metux.net>
         <1a68db2aee382a1b0472cf0b81a809bc089e622d.camel@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-12-17 at 13:16 +0200, Jarkko Sakkinen wrote:
> On Mon, 2019-12-16 at 09:42 +0100, Enrico Weigelt, metux IT consult wrote:
> > Remove MODULE_VERSION(), as it isn't needed at all: the only version
> > making sense is the kernel version.
> 
> Take the following line away:
> 
> > See also: https://lkml.org/lkml/2017/11/22/480
> 
> And just before SOB:
> 
> Link: https://lkml.org/lkml/2017/11/22/480
> > Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> 
> You have some extra cruft there. It should be:
> 
> Signed-off-by: Enrico Weigelt <info@metux.net>

Also, the email that you are sending this patch from incorrectly
formatted email address. Please configure your email client to
have just Firstname Lastname as the email.

/Jarkko

