Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF68604BD
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jul 2019 12:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbfGEKwC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Jul 2019 06:52:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:49132 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727825AbfGEKwC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Jul 2019 06:52:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2E458AD8A;
        Fri,  5 Jul 2019 10:52:01 +0000 (UTC)
Date:   Fri, 5 Jul 2019 12:51:58 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH] tpm: fixes uninitialized allocated banks for IBM vtpm
 driver
Message-ID: <20190705125158.72f79929@naga>
In-Reply-To: <f315356e7c00378c8785bd20d5869c9046ece2f2.camel@linux.intel.com>
References: <1562211121-2188-1-git-send-email-nayna@linux.ibm.com>
        <f315356e7c00378c8785bd20d5869c9046ece2f2.camel@linux.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 05 Jul 2019 13:42:18 +0300
Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:

> On Wed, 2019-07-03 at 23:32 -0400, Nayna Jain wrote:
> > The nr_allocated_banks and allocated banks are initialized as part of
> > tpm_chip_register. Currently, this is done as part of auto startup
> > function. However, some drivers, like the ibm vtpm driver, do not run
> > auto startup during initialization. This results in uninitialized memory
> > issue and causes a kernel panic during boot.
> > 
> > This patch moves the pcr allocation outside the auto startup function
> > into tpm_chip_register. This ensures that allocated banks are initialized
> > in any case.
> > 
> > Fixes: 879b589210a9 ("tpm: retrieve digest size of unknown algorithms with
> > PCR read")
> > Signed-off-by: Nayna Jain <nayna@linux.ibm.com>  
> 
> Please add
> 
> Reported-by: Michal Suchanek <msuchanek@suse.de>
> 
> It is missing. Michal is there a chance you could try this out once
> Nayna send a new version?

Should be easy to test. Without the patch the machine crashes on boot
so it is quite obvious case. I have a few VMs with the vTPM available.

Thanks

Michal
