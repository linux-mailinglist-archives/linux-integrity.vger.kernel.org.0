Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F65C218934
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Jul 2020 15:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbgGHNf4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jul 2020 09:35:56 -0400
Received: from mga17.intel.com ([192.55.52.151]:55756 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728148AbgGHNf4 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jul 2020 09:35:56 -0400
IronPort-SDR: /x2eGVyQk+OS8cP8oHjhqMki7GQbmD0c8PY1aYldstTftGkcWvoDu3xZmitg0d2ZegEjK5nLaG
 fSbGOLKI0rdw==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="127873211"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="127873211"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 06:35:55 -0700
IronPort-SDR: aJscoD6Xxx8E/ww7mzPXQrwwPFlZ1PdDUbrFrgnVoXTfYBd8mctpotmhti+bHSB7PyudqP2iAw
 VOktHU/rDYTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="457505720"
Received: from alachman-mobl.ger.corp.intel.com (HELO localhost) ([10.252.42.138])
  by orsmga005.jf.intel.com with ESMTP; 08 Jul 2020 06:35:51 -0700
Date:   Wed, 8 Jul 2020 16:35:50 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert commit e918e570415c ("tpm_tis: Remove the HID
 IFX0102")
Message-ID: <20200708133550.GB538949@linux.intel.com>
References: <20200706205342.21333-1-jarkko.sakkinen@linux.intel.com>
 <20200707094140.GB2639362@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707094140.GB2639362@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jul 07, 2020 at 11:41:40AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 06, 2020 at 11:53:42PM +0300, Jarkko Sakkinen wrote:
> > Removing IFX0102 from tpm_tis was not a right move because both tpm_tis
> > and tpm_infineon use the same device ID. Revert the commit and add a
> > remark about a bug caused by commit 93e1b7d42e1e ("[PATCH] tpm: add HID
> > module parameter").
> > 
> > Fixes: e918e570415c ("tpm_tis: Remove the HID IFX0102")
> > Reported-by: Peter Huewe <peterhuewe@gmx.de>
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> As the original was asked to be applied to the stable trees, this one
> should have as well.
> 
> I'll go drop it from the stable queues right now, thanks.
> 
> greg k-h

Ah, apologies for my ignorance.

/Jarkko
