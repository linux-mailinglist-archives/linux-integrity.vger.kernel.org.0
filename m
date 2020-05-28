Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8141E5253
	for <lists+linux-integrity@lfdr.de>; Thu, 28 May 2020 02:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbgE1Ail (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 May 2020 20:38:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:16971 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgE1Aik (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 May 2020 20:38:40 -0400
IronPort-SDR: tD6kUSI7QK4zkxD8SmtZ5e0FthC0Hotl0yXT2s7EZOmvLvqm1ZFHnqXHJTkwhoix2XEMMPYNlE
 IhJ4khb2xvYg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 17:38:40 -0700
IronPort-SDR: lt3h9l7nwiI7Rtuo56tysH85rGxntVviHjuy1z4Y6DEH/IsKuoCDNy7N7875C5yh5mZspt0S2a
 lsthD+CNzHyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,443,1583222400"; 
   d="scan'208";a="302286413"
Received: from ederaloi-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.44.51])
  by fmsmga002.fm.intel.com with ESMTP; 27 May 2020 17:38:37 -0700
Date:   Thu, 28 May 2020 03:38:35 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Alex Guzman <alex@guzman.io>
Subject: Re: [PATCH] tpm2: fix TIS locality timeout problems
Message-ID: <20200528003835.GB4781@linux.intel.com>
References: <1590539114.3576.5.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590539114.3576.5.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, May 26, 2020 at 05:25:14PM -0700, James Bottomley wrote:
> It has been reported that some TIS based TPMs are giving unexpected
> errors when using the O_NONBLOCK path.  The problem is that some TPMs
> don't like it when you get and then relinquish a locality (as the
> tpm_try_get_ops/tpm_put_ops pair does) without sending a command.
> This currently happens all the time in the O_NONBLOCK write path.  We
> can fix this by moving the tpm_try_get_ops further down the code to
> after the O_NONBLOCK determination is made.  This is safe because the
> priv->buffer_mutex still protects the priv state being modified.
> 
> Fixes: d23d12484307 ("tpm: fix invalid locking in NONBLOCKING mode")
> Reported-by: Mario Limonciello <Mario.Limonciello@dell.com>
> Tested-by: Alex Guzman <alex@guzman.io>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Subsystem tag is wrong, function name is missing '()' after and
sometimes there are spaces after ".". Please fix the commit
message and I can look at the code when it is clean.

/Jarkko

