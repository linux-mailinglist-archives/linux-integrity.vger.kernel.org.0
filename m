Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E34446AE02
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2019 19:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfGPRwl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jul 2019 13:52:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:51094 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728366AbfGPRwk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jul 2019 13:52:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 65944AC67;
        Tue, 16 Jul 2019 17:52:39 +0000 (UTC)
Date:   Tue, 16 Jul 2019 19:52:38 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Nayna Jain <nayna@linux.ibm.com>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        George Wilson <gcwilson@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v3] tpm: tpm_ibm_vtpm: Fix unallocated banks
Message-ID: <20190716195238.79271980@kitsune.suse.cz>
In-Reply-To: <20190711211357.77bl2ixfnplmumcl@linux.intel.com>
References: <1562861615-11391-1-git-send-email-nayna@linux.ibm.com>
        <20190711202824.dfhzxcqtk5ouud5n@linux.intel.com>
        <20190711211357.77bl2ixfnplmumcl@linux.intel.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 12 Jul 2019 00:13:57 +0300
Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:

> On Thu, Jul 11, 2019 at 11:28:24PM +0300, Jarkko Sakkinen wrote:
> > On Thu, Jul 11, 2019 at 12:13:35PM -0400, Nayna Jain wrote:  
> > > The nr_allocated_banks and allocated banks are initialized as part of
> > > tpm_chip_register. Currently, this is done as part of auto startup
> > > function. However, some drivers, like the ibm vtpm driver, do not run
> > > auto startup during initialization. This results in uninitialized memory
> > > issue and causes a kernel panic during boot.
> > > 
> > > This patch moves the pcr allocation outside the auto startup function
> > > into tpm_chip_register. This ensures that allocated banks are initialized
> > > in any case.
> > > 
> > > Fixes: 879b589210a9 ("tpm: retrieve digest size of unknown algorithms with
> > > PCR read")
> > > Reported-by: Michal Suchanek <msuchanek@suse.de>
> > > Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> > > Tested-by: Michal Suchánek <msuchanek@suse.de>  
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>  
> 
> Thanks a lot! It is applied now.

Fixes the issue for me.

Thanks

Michal
