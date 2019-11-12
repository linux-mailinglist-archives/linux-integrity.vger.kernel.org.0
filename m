Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C545F99F7
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2019 20:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKLTnM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Nov 2019 14:43:12 -0500
Received: from mga12.intel.com ([192.55.52.136]:20488 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbfKLTnM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Nov 2019 14:43:12 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2019 11:43:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,297,1569308400"; 
   d="scan'208";a="378989807"
Received: from joshbuck-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.20.68])
  by orsmga005.jf.intel.com with ESMTP; 12 Nov 2019 11:43:09 -0800
Date:   Tue, 12 Nov 2019 21:43:08 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Christian Bundy <christianbundy@fraction.io>,
        linux-integrity@vger.kernel.org
Subject: Re: PROBLEM: TPM bug causes suspend to turn off device
Message-ID: <20191112194249.GA8240@linux.intel.com>
References: <a60dadce-3650-44ce-8785-2f737ab9b993@www.fastmail.com>
 <20191110072611.2k6tjt4geiq2rqol@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191110072611.2k6tjt4geiq2rqol@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Nov 10, 2019 at 12:26:11AM -0700, Jerry Snitselaar wrote:
> Jarkko, should there be tpm_chip_start/tpm_chip_stop calls around
> the tpm1_getcap calls in tpm1_get_timeouts?

Lookup tpm_chip_register().

/Jarkko
