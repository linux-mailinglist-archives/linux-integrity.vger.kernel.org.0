Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8097E27E0A7
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Sep 2020 07:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725440AbgI3FxR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Sep 2020 01:53:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:60658 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgI3FxR (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Sep 2020 01:53:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 63473AC3F;
        Wed, 30 Sep 2020 05:53:16 +0000 (UTC)
Date:   Wed, 30 Sep 2020 07:53:14 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     ltp@lists.linux.it,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 0/4] TPM 2.0 fixes in IMA tests
Message-ID: <20200930055314.GA21664@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200929165021.11731-1-pvorel@suse.cz>
 <20200929231118.GA805493@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929231118.GA805493@linux.intel.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jarkko,

> Hi, is there something specific I should look at in this patch set?

I'm sorry to bother you with LTP specific code. Can you have a quick look if I
didn't overlook anything obvious in reading PCR files (read_pcr_tpm*())?

I'm surprised that it's working on my TPM 2.0 which does not export
/sys/kernel/security/tpm0/binary_bios_measurements (using evmctl).

> /Jarkko

Kind regards,
Petr
