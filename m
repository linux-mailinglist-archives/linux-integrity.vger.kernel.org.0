Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F158B35B7
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2019 09:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfIPHf5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Sep 2019 03:35:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:7660 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfIPHf5 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Sep 2019 03:35:57 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 00:35:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,510,1559545200"; 
   d="scan'208";a="386119868"
Received: from sshkruni-mobl.ccr.corp.intel.com (HELO localhost) ([10.249.38.138])
  by fmsmga005.fm.intel.com with ESMTP; 16 Sep 2019 00:35:54 -0700
Date:   Mon, 16 Sep 2019 10:35:52 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Petr Vorel <pvorel@suse.cz>
Subject: Re: [PATCH] selftest/trustedkeys: TPM 1.2 trusted keys test
Message-ID: <20190916073552.GD4859@linux.intel.com>
References: <1568157511-5464-1-git-send-email-zohar@linux.ibm.com>
 <1568157876.4991.3.camel@linux.ibm.com>
 <1568203240.5783.8.camel@linux.ibm.com>
 <20190913140820.GC29755@linux.intel.com>
 <1568580742.5055.0.camel@linux.ibm.com>
 <1568604471.4975.8.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1568604471.4975.8.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Sep 15, 2019 at 11:27:51PM -0400, Mimi Zohar wrote:
> On Sun, 2019-09-15 at 16:52 -0400, Mimi Zohar wrote:
> > On Fri, 2019-09-13 at 15:08 +0100, Jarkko Sakkinen wrote:
> > > On Wed, Sep 11, 2019 at 08:00:40AM -0400, Mimi Zohar wrote:
> > > > On Tue, 2019-09-10 at 19:24 -0400, Mimi Zohar wrote:
> > > > > On Tue, 2019-09-10 at 19:18 -0400, Mimi Zohar wrote:
> > > > > > Create, save and load trusted keys test
> > > > > 
> > > > > Creating trusted keys is failing with the following messages.  Any idea why?
> > > > > 
> > > > > [  147.014653] tpm tpm0: A TPM error (34) occurred attempting to a send a command
> > > > > [  147.014678] trusted_key: srkseal failed (-1)
> > > > > [  147.014687] trusted_key: key_seal failed (-1)
> > > > 
> > > > This is a regression, that needs to be resolved.  The test works on
> > > > kernels prior to 5.1.
> > > 
> > > It breaks on 5.2?
> > 
> > No, the regression is in 5.1.
> > 
> > > 
> > > Can you bisect the failing commit?
> > 
> > git bisect start -- drivers/char/tpm/
> > git bisect bad
> > git bisect good v5.0 
> > 
> > # first bad commit: [412eb585587a1dc43c9622db79de9663b6c4c238] tpm:
> > use tpm_buf in tpm_transmit_cmd() as the IO parameter
> 
> In tpm_send(), setting buf.data directly to cmd, instead of calling
> tpm_buf_init() fixes the problem.

I see. Obviously memcpy() does not tpm_buf length. The implementation is
kind of clunky but the point is to move building the tpm_buf to the
caller (which is soon possible thanks to Sumit's patches).

I sent a fix candidate.

/Jarkko
