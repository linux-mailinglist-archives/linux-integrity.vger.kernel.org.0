Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F4B284F77
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Oct 2020 18:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgJFQGM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Oct 2020 12:06:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:9941 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgJFQGM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Oct 2020 12:06:12 -0400
IronPort-SDR: +VHdlPkP5lEMYjlejseNMUXbbpQRw1fYyGwxi8zWsdFL5WJHIWysePHjN9hsesM1hbtTDhnRa5
 e5caJAt80/sw==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="151478600"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="151478600"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 08:53:30 -0700
IronPort-SDR: 23esREes3quhmaB1RNURzlbQedPnL0PAQO0ERuYFStc4mqJUcMFUsmXSGnmB7L9g+GuAXZJcgJ
 oAQ3TNVKEcIg==
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="527413376"
Received: from thijsmet-mobl.ger.corp.intel.com (HELO localhost) ([10.249.34.36])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 08:53:29 -0700
Date:   Tue, 6 Oct 2020 18:53:22 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 0/4] TPM 2.0 fixes in IMA tests
Message-ID: <20201006155322.GA111447@linux.intel.com>
References: <20200929165021.11731-1-pvorel@suse.cz>
 <20200929231118.GA805493@linux.intel.com>
 <20200930055314.GA21664@dell5510>
 <20200930115939.GB7612@linux.intel.com>
 <20201001120125.GE32109@dell5510>
 <20201001183104.GA15664@linux.intel.com>
 <20201006100130.GA14868@dell5510>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006100130.GA14868@dell5510>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 06, 2020 at 12:01:30PM +0200, Petr Vorel wrote:
> Hi Jarkko,
> 
> can rely on /dev/tpm0 and /dev/tpmrm0 for TPM detection?
> i.e.:
> /dev/tpmrm0 => TPM 2.0
> /dev/tpm0 => both TPM 1.2 or 2.0
> none of them => No TPM device

I think that should work as tpmrm0 is unconditionally available for
TPM devices.

Since Linux v5.6 there has been a sysfs file called tpm_version_major
available too.

/Jarkko
