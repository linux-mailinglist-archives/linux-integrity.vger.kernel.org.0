Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA1081701D1
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Feb 2020 16:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgBZPDC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Feb 2020 10:03:02 -0500
Received: from mga02.intel.com ([134.134.136.20]:23955 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgBZPDC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Feb 2020 10:03:02 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 07:03:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,488,1574150400"; 
   d="scan'208";a="238058625"
Received: from avgorshk-mobl.ccr.corp.intel.com (HELO localhost) ([10.252.15.208])
  by orsmga003.jf.intel.com with ESMTP; 26 Feb 2020 07:02:57 -0800
Date:   Wed, 26 Feb 2020 17:02:55 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, aik@ozlabs.ru,
        david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org,
        nayna@linux.vnet.ibm.com, gcwilson@linux.ibm.com, jgg@ziepe.ca
Subject: Re: [PATCH v2 3/4] tpm: Implement tpm2_init to call when
 TPM_OPS_AUTO_STARTUP is not set
Message-ID: <20200226150255.GB3407@linux.intel.com>
References: <20200213202329.898607-1-stefanb@linux.vnet.ibm.com>
 <20200213202329.898607-4-stefanb@linux.vnet.ibm.com>
 <20200225170015.GE15662@linux.intel.com>
 <3813980a-6c5e-c99f-7b37-b20b72eb6a8a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3813980a-6c5e-c99f-7b37-b20b72eb6a8a@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 25, 2020 at 01:20:39PM -0500, Stefan Berger wrote:
> On 2/25/20 12:00 PM, Jarkko Sakkinen wrote:
> > On Thu, Feb 13, 2020 at 03:23:28PM -0500, Stefan Berger wrote:
> > > From: Stefan Berger <stefanb@linux.ibm.com>
> > > 
> > > Implement tpm2_init() that gets the TPM 2 timeouts and command durations
> > > and command code attributes. This function is to be called in case the
> > > TPM_OPS_AUTO_STARTUP flag is not set and therefore tpm2_auto_startup()
> > > is not called.
> > > 
> > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > The commit makes zero effort trying to explain what the heck tpm_init()
> > is and when it should be used and why the function name tpm2_init().
> 
> Are you saying the explanation of when to use tpm2_init above is not enough?
> 'bviously we are trying to cover the case of using the TPM 2 by a driver
> that doesn't use the TPM_OPS_AUTO_STARTUP flag and therefore the TPM 2
> timeouts and command durations and command code attributes are not set as
> they would be if tpm2_auto_startup() was to be called and tpm2_init() is the
> alternative to call. I didn't like tpm2_init() either... any suggestions for
> a better name?

I'm not getting what this commit is trying to do in the first place.

/Jarkko
