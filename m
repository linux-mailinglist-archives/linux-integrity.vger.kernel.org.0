Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8750B219C
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Sep 2019 16:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388468AbfIMOI3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Sep 2019 10:08:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:23440 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388084AbfIMOI2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Sep 2019 10:08:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 07:08:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,501,1559545200"; 
   d="scan'208";a="215387016"
Received: from ltudorx-wtg.ger.corp.intel.com (HELO localhost) ([10.252.37.39])
  by fmsmga002.fm.intel.com with ESMTP; 13 Sep 2019 07:08:24 -0700
Date:   Fri, 13 Sep 2019 15:08:20 +0100
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Petr Vorel <pvorel@suse.cz>
Subject: Re: [PATCH] selftest/trustedkeys: TPM 1.2 trusted keys test
Message-ID: <20190913140820.GC29755@linux.intel.com>
References: <1568157511-5464-1-git-send-email-zohar@linux.ibm.com>
 <1568157876.4991.3.camel@linux.ibm.com>
 <1568203240.5783.8.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1568203240.5783.8.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 11, 2019 at 08:00:40AM -0400, Mimi Zohar wrote:
> On Tue, 2019-09-10 at 19:24 -0400, Mimi Zohar wrote:
> > On Tue, 2019-09-10 at 19:18 -0400, Mimi Zohar wrote:
> > > Create, save and load trusted keys test
> > 
> > Creating trusted keys is failing with the following messages.  Any idea why?
> > 
> > [  147.014653] tpm tpm0: A TPM error (34) occurred attempting to a send a command
> > [  147.014678] trusted_key: srkseal failed (-1)
> > [  147.014687] trusted_key: key_seal failed (-1)
> 
> This is a regression, that needs to be resolved.  The test works on
> kernels prior to 5.1.

It breaks on 5.2?

Can you bisect the failing commit?

/Jarkko
