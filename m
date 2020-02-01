Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50BB914F91A
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Feb 2020 18:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgBARKI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 1 Feb 2020 12:10:08 -0500
Received: from mga01.intel.com ([192.55.52.88]:55171 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgBARKI (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 1 Feb 2020 12:10:08 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2020 09:10:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,390,1574150400"; 
   d="scan'208";a="218924370"
Received: from mtaylo3-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.87.188])
  by orsmga007.jf.intel.com with ESMTP; 01 Feb 2020 09:10:05 -0800
Date:   Sat, 1 Feb 2020 19:10:04 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        "james.bottomley@hansenpartnership.com" 
        <james.bottomley@hansenpartnership.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: Re: [PATCH 1/8] tpm: initialize crypto_id of allocated_banks to
 HASH_ALGO__LAST
Message-ID: <20200201171004.GC14875@linux.intel.com>
References: <20200127170443.21538-1-roberto.sassu@huawei.com>
 <20200127170443.21538-2-roberto.sassu@huawei.com>
 <50afe1f50297b02af52621b6738ffff0c24f1bdf.camel@linux.intel.com>
 <8c15cf66708a4d38916b8ca39f26b5f6@huawei.com>
 <1580477590.6104.61.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1580477590.6104.61.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jan 31, 2020 at 08:33:10AM -0500, Mimi Zohar wrote:
> On Thu, 2020-01-30 at 16:11 +0000, Roberto Sassu wrote:
> > > -----Original Message-----
> > > From: Jarkko Sakkinen [mailto:jarkko.sakkinen@linux.intel.com]
> > > Sent: Thursday, January 30, 2020 9:48 AM
> > > To: Roberto Sassu <roberto.sassu@huawei.com>; zohar@linux.ibm.com;
> > > james.bottomley@hansenpartnership.com; linux-integrity@vger.kernel.org
> > > Cc: linux-security-module@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
> > > Subject: Re: [PATCH 1/8] tpm: initialize crypto_id of allocated_banks to
> > > HASH_ALGO__LAST
> > > 
> > > On Mon, 2020-01-27 at 18:04 +0100, Roberto Sassu wrote:
> > > > chip->allocated_banks contains the list of TPM algorithm IDs of allocated
> > > > PCR banks. It also contains the corresponding ID of the crypto subsystem,
> > > > so that users of the TPM driver can calculate a digest for a PCR extend
> > > > operation.
> > > >
> > > > However, if there is no mapping between TPM algorithm ID and crypto ID,
> > > the
> > > > crypto_id field in chip->allocated_banks remains set to zero (the array is
> > > > allocated and initialized with kcalloc() in tpm2_get_pcr_allocation()).
> > > > Zero should not be used as value for unknown mappings, as it is a valid
> > > > crypto ID (HASH_ALGO_MD4).
> > > >
> > > > This patch initializes crypto_id to HASH_ALGO__LAST.
> > > >
> > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>---
> > > 
> > > Remarks:
> > > 
> > > * After the subsystem tag, short summary starts with a capital lettter.
> > > * Missing fixes tag and cc tag to stable.
> > > * A struct called allocated_banks does not exist.
> > > * Please prefer using an imperative sentence when describing the action
> > >   to take e.g. "Thus, initialize crypto_id to HASH_ALGO__LAST".
> > 
> > Thanks. I will fix these issues in the next version of the patch set.
> 
> Jarkko, I realize this is a TPM patch, but this patch set is dependent
> on it.  When this patch is ready, could you create a topic branch,
> which both of us could merge?

WFM.

/Jarkko
