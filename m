Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1C3C420C
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Oct 2019 22:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfJAUxf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Oct 2019 16:53:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:7154 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfJAUxf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Oct 2019 16:53:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 13:53:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="275119559"
Received: from nbaca1-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.37.57])
  by orsmga001.jf.intel.com with ESMTP; 01 Oct 2019 13:53:32 -0700
Date:   Tue, 1 Oct 2019 23:53:31 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Klimov <aklimov@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 0/4] tpm: add update_durations class op to allow
 override of chip supplied values
Message-ID: <20191001205331.GB26709@linux.intel.com>
References: <20190902142735.6280-1-jsnitsel@redhat.com>
 <20190928174543.6msskzuyhirtjxwe@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190928174543.6msskzuyhirtjxwe@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Sep 28, 2019 at 10:45:43AM -0700, Jerry Snitselaar wrote:
> On Mon Sep 02 19, Jerry Snitselaar wrote:
> > We've run into a case where a customer has an STM TPM 1.2 chip
> > (version 1.2.8.28), that is getting into an inconsistent state and
> > they end up getting tpm transmit errors.  In really old tpm code this
> > wasn't seen because the code that grabbed the duration values from the
> > chip could fail silently, and would proceed to just use default values
> > and move forward. More recent code though successfully gets the
> > duration values from the chip, and using those values this particular
> > chip version gets into the state seen by the customer.
> > 
> > The idea with this patchset is to provide a facility like the
> > update_timeouts operation to allow the override of chip supplied
> > values.
> > 
> > changes from v3:
> >    * Assign value to version when tpm1_getcap is successful for TPM 1.1 device
> >      not when it fails.
> > 
> > changes from v2:
> >    * Added patch 1/3
> >    * Rework tpm_tis_update_durations to make use of new version structs
> >      and pull tpm1_getcap calls out of loop.
> > 
> > changes from v1:
> >    * Remove unneeded newline
> >    * Formatting cleanups
> >    * Change tpm_tis_update_durations to be a void function, and
> >      use chip->duration_adjusted to track whether adjustment was
> >      made.
> > 
> > Jarkko Sakkinen (1):
> >      tpm: Remove duplicate code from caps_show() in tpm-sysfs.c
> > 
> > Jerry Snitselaar (2):
> >      tpm: provide a way to override the chip returned durations
> >      tpm_tis: override durations for STM tpm with firmware 1.2.8.28
> > 
> > 
> 
> Anyone else have any feedback on this patchset?

Thanks for reminding. I'll put this to my master soonish.

/Jarkko
