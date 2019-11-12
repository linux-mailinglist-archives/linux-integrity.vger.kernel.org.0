Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47289F9A64
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2019 21:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfKLURU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Nov 2019 15:17:20 -0500
Received: from mga12.intel.com ([192.55.52.136]:23123 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfKLURU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Nov 2019 15:17:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2019 12:17:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,297,1569308400"; 
   d="scan'208";a="378999660"
Received: from joshbuck-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.20.68])
  by orsmga005.jf.intel.com with ESMTP; 12 Nov 2019 12:17:17 -0800
Date:   Tue, 12 Nov 2019 22:17:16 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: question about setting TPM_CHIP_FLAG_IRQ in tpm_tis_core_init
Message-ID: <20191112201716.GA12340@linux.intel.com>
References: <20191112033637.kxotlhm6mtr5irvd@cantor>
 <6d6f0899-8ba0-d6cf-ef3b-317ca698b687@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d6f0899-8ba0-d6cf-ef3b-317ca698b687@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Nov 12, 2019 at 08:28:57AM -0500, Stefan Berger wrote:
> I set this flag for the TIS because it wasn't set anywhere else.
> tpm_tis_send() wouldn't set the flag but go via the path:
> 
> if (!(chip->flags & TPM_CHIP_FLAG_IRQ) || priv->irq_tested)
> 
>         return tpm_tis_send_main(chip, buf, len);

Wondering why this isn't just "if (priv->irq_tested)"? Isn't that the
whole point. The tail is the test part e.g. should be executed when
IRQ testing is done.

/Jarkko
