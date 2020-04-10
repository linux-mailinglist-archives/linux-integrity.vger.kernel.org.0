Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD671A4B7D
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Apr 2020 23:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDJVIU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Apr 2020 17:08:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:30617 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgDJVIU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Apr 2020 17:08:20 -0400
IronPort-SDR: NZiRY5zPBYw4fuNKLkrjySWtyGjWvHQXB0eaAazAHUIuFGZlceMfW9DUgQnTQNqD+tukvD7iZ5
 rzGAZKHdOq5Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2020 14:08:19 -0700
IronPort-SDR: AvzLOgaoRjhdRSbFzby5vp117Pqyw6L6WtxcOL2jdNl7EciYlwxNwobTmNoyVAeiV58llw0aJL
 AbZKhDjsqwzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,368,1580803200"; 
   d="scan'208";a="261787298"
Received: from sartorig-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.43.100])
  by orsmga008.jf.intel.com with ESMTP; 10 Apr 2020 14:08:14 -0700
Date:   Sat, 11 Apr 2020 00:08:13 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm_tis_core: Disable broken IRQ handling code
Message-ID: <20200410210813.GA74881@linux.intel.com>
References: <20200409211044.21625-1-hdegoede@redhat.com>
 <20200410163826.GM11886@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410163826.GM11886@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Apr 10, 2020 at 01:38:26PM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 09, 2020 at 11:10:44PM +0200, Hans de Goede wrote:
> > Since commit dda8b2af395b ("tpm: Revert "tpm_tis_core: Set
> > TPM_CHIP_FLAG_IRQ before probing for interrupts"") we no longer set
> > the TPM_CHIP_FLAG_IRQ ever.
> 
> This all used to work..

Yes, up until T490 issues.

/Jarkko
