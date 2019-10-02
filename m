Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6852CC8F39
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Oct 2019 19:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbfJBRDS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Oct 2019 13:03:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:32221 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728484AbfJBRDR (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Oct 2019 13:03:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2019 10:03:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,249,1566889200"; 
   d="scan'208";a="343386945"
Received: from wkadry-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.81.190])
  by orsmga004.jf.intel.com with ESMTP; 02 Oct 2019 10:03:11 -0700
Date:   Wed, 2 Oct 2019 20:03:10 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2,RESEND] tpm: Detach page allocation from tpm_buf
Message-ID: <20191002170253.GA9634@linux.intel.com>
References: <20191002104530.7679-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002104530.7679-1-jarkko.sakkinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Oct 02, 2019 at 01:45:30PM +0300, Jarkko Sakkinen wrote:
> As has been seen recently, binding the buffer allocation and tpm_buf
> together is sometimes far from optimal. The buffer might come from the
> caller namely when tpm_send() is used by another subsystem. In addition we
> can stability in call sites w/o rollback (e.g. power events)>
> 
> Take allocation out of the tpm_buf framework and make it purely a wrapper
> for the data buffer.

OK, so the reason that the fix for the CC was not included, was that
it was in my staging area. I had not amended it :-/

/Jarkko
