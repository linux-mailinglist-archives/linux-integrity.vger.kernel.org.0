Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60137AC966
	for <lists+linux-integrity@lfdr.de>; Sat,  7 Sep 2019 23:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfIGVVt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 7 Sep 2019 17:21:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:8834 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbfIGVVt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 7 Sep 2019 17:21:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2019 14:21:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,478,1559545200"; 
   d="scan'208";a="195779075"
Received: from dpotapen-mobl1.ger.corp.intel.com ([10.252.53.110])
  by orsmga002.jf.intel.com with ESMTP; 07 Sep 2019 14:21:46 -0700
Message-ID: <5403fb1ecdee5c2443c8389ffd7b25e800340565.camel@linux.intel.com>
Subject: Re: [PATCH] tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for
 interrupts
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-stable@vger.kernel.org
Date:   Sun, 08 Sep 2019 00:21:46 +0300
In-Reply-To: <b19179168421eb511856f0ec5fd328d97f06a68c.camel@pengutronix.de>
References: <20190830000906.2369009-1-stefanb@linux.vnet.ibm.com>
         <b19179168421eb511856f0ec5fd328d97f06a68c.camel@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-09-06 at 14:37 +0200, Jan Lübbe wrote:
> This is due to the SPI accesses performed by tis_int_handler (which
> will sleep). Switching to devm_request_threaded_irq fixes this and
> leads to a successful IRQ probe.

Aah, right through tpm_tis_read32/write32(). This is definitely a new
regression. Thanks for reporting this! This was completely missed when
the support for other than TCG MMIO was implemented for the TIS driver.

This should have a patch of it own with your reported-by unless you
care to send bug fix for it.

> But: It seems that the IRQ is not acked correctly, as the interrupt
> line stays low. I suspect this is because the tpm_chip_stop from
> http://git.infradead.org/users/jjs/linux-tpmdd.git/commitdiff/9b558deab2c5d7dc23d5f7a4064892ede482ad32
> happens before the threaded handler runs. I'm currently unable to
> verify that though, as my build machine's disk just died. :/

I cannot recall all the nyances related to interrupt probing but with a
quick look I wonder why it does not utilize int_queue. Then
tpm_chip_stop() could be done synchronously.

> Regards,
> Jan

/Jarkko

