Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183991D2DC8
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2020 13:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgENLDV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 May 2020 07:03:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:19638 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgENLDV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 May 2020 07:03:21 -0400
IronPort-SDR: +YOPAQwkzO1g7f9KRx5ESC/HurtgudFCKTX4uULNSwAw58bZVspZp2weG3EG/Qa+puezP3anm9
 /JsW/PRvNHAQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 04:03:21 -0700
IronPort-SDR: /oYTl4PO55iQ3P9q/8Zc9enssg7XQLtBEBrh5DjF4z6IlVAIue3g1kOkBoFW6h8S6i8jctoGGs
 BrVI3iG6I2hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,391,1583222400"; 
   d="scan'208";a="251627955"
Received: from apogrebi-mobl2.ger.corp.intel.com ([10.249.39.119])
  by orsmga007.jf.intel.com with ESMTP; 14 May 2020 04:03:19 -0700
Message-ID: <a158d1a51710309995af3a2d5faf2641f51d82b5.camel@linux.intel.com>
Subject: Re: Disparity in tpm pcr5 value
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity@vger.kernel.org, Matthew Garrett <mjg59@google.com>
Date:   Thu, 14 May 2020 14:03:19 +0300
In-Reply-To: <20200513175931.xte33asq5nskjflh@cantor>
References: <20200505222731.whnkisag7tlrbcie@cantor>
         <20200513171052.GD25598@linux.intel.com>
         <20200513175931.xte33asq5nskjflh@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-05-13 at 10:59 -0700, Jerry Snitselaar wrote:
> On Wed May 13 20, Jarkko Sakkinen wrote:
> > On Tue, May 05, 2020 at 03:27:31PM -0700, Jerry Snitselaar wrote:
> > > On some systems we've had reports of the value of pcr5 doesn't match the digests in the tpm event log.
> > > It looks like I'm able to reproduce here with 5.7-rc4 on a dell system using this parser:
> > > 
> > > https://github.com/ValdikSS/binary_bios_measurements_parser
> > > 
> > > Any thoughts on where to start digging? Is there another tool I should use to parse this?
> > 
> > ExitBootServices() extends PCR5. My 1st intuition would be to look at
> > final event table handling, which I documented here:
> > 
> > https://www.kernel.org/doc/Documentation/security/tpm/tpm_event_log.rst
> > 
> > It is somewhat quirky how it nees to be managed (had to read that
> > myself to recall how it went).
> > 
> > /Jarkko
> > 
> 
> Yes, my guess is the problem is that when the bios is set to use sha1 it
> does not present a final events log to the os.

Do these relate:

https://patchwork.kernel.org/patch/11542035/

?

/Jarkko

