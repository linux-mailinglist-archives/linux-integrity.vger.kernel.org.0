Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B07AEC41FD
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Oct 2019 22:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfJAUv5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Oct 2019 16:51:57 -0400
Received: from mga14.intel.com ([192.55.52.115]:8396 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfJAUv5 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Oct 2019 16:51:57 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 13:51:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="343106358"
Received: from nbaca1-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.37.57])
  by orsmga004.jf.intel.com with ESMTP; 01 Oct 2019 13:51:51 -0700
Date:   Tue, 1 Oct 2019 23:51:50 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Detach page allocation from tpm_buf
Message-ID: <20191001205150.GA26709@linux.intel.com>
References: <20190926172324.3405-1-jarkko.sakkinen@linux.intel.com>
 <20190928075813.nsmu3g7derj2fjmj@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190928075813.nsmu3g7derj2fjmj@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Sep 28, 2019 at 12:58:13AM -0700, Jerry Snitselaar wrote:
> TPM2_CC_GET_RANDOM

Ugh, I somehow sent v1 2nd time also in terms of contents (was fixed in
v2).

I think it would be a great idea to add call to tpm_get_random() to the
chip startup as an additional test.

> Would this work here?
> 
>      	err = total ? total : -EIO;
> out:
> 	kunmap(data_page);
> 	__free_page(data_page);
> 	return err;

I'd guess but I want to keep this commit as dumbed down and mechanical
as possible given the amount of changes.

/Jarkko
