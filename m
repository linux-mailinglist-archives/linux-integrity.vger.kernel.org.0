Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7671D2D87
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2020 12:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgENKyC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 May 2020 06:54:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:26216 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgENKyC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 May 2020 06:54:02 -0400
IronPort-SDR: BKH5TBhPJVnTMblNw6OHK9vooXd6G6qWof8KSHgmbN742LHkEGCf101o4MjNZdB293JMkK9Y2m
 ncoVv4gMktfA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 03:54:02 -0700
IronPort-SDR: d7Xwa4+QlcoDO5TCeicGMdaj4kDvLVY2XhwpVWpIV7Q8SLhC2YjN1UhK8jQ6e37aOcZZIAjTfr
 gAw92wGkouPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,391,1583222400"; 
   d="scan'208";a="266203020"
Received: from apogrebi-mobl2.ger.corp.intel.com ([10.249.39.119])
  by orsmga006.jf.intel.com with ESMTP; 14 May 2020 03:54:00 -0700
Message-ID: <116341780ff56884d2f03aa9b90a8f9566b91540.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: check event log version before reading final events
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Matthew Garrett <mjg59@google.com>,
        =?ISO-8859-1?Q?Lo=EFc?= Yhuel <loic.yhuel@gmail.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Date:   Thu, 14 May 2020 13:53:59 +0300
In-Reply-To: <CACdnJuv8OyQpO4achWJb2HeB8Jb6Ejq9LsG64659JSay-a9O5A@mail.gmail.com>
References: <20200512040113.277768-1-loic.yhuel@gmail.com>
         <CACdnJuv8OyQpO4achWJb2HeB8Jb6Ejq9LsG64659JSay-a9O5A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-05-12 at 13:08 -0700, Matthew Garrett wrote:
> On Mon, May 11, 2020 at 9:01 PM Loïc Yhuel <loic.yhuel@gmail.com> wrote:
> 
> > We get an event log in the SHA-1 format, which doesn't have a
> > tcg_efi_specid_event_head in the first event, and there is a final events
> > table which doesn't match the crypto agile format.
> 
> This seems like a firmware bug, but we definitely shouldn't fail as a result.
> 
> Reviewed-by: Matthew Garrett <mjg59@google.com>

So it is clear that "pr_warn(FW_BUG ..." would be a sane to have there.

/Jarkko

