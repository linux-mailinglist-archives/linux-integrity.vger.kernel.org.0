Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5AAE321B
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Oct 2019 14:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439309AbfJXMSw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Oct 2019 08:18:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:42110 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbfJXMSw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Oct 2019 08:18:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E1D47B186;
        Thu, 24 Oct 2019 12:18:50 +0000 (UTC)
Date:   Thu, 24 Oct 2019 14:18:48 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Nayna <nayna@linux.vnet.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        ltp@lists.linux.it,
        Piotr =?iso-8859-2?Q?Kr=F3l?= <piotr.krol@3mdeb.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [LTP] [PATCH] ima: skip verifying TPM 2.0 PCR values
Message-ID: <20191024121848.GA5908@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1558041162.3971.2.camel@linux.ibm.com>
 <fccc3abd-f3ce-fdb1-55d7-c18ce116446c@linux.vnet.ibm.com>
 <20190517150456.GA11796@dell5510>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517150456.GA11796@dell5510>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi all,

I wonder what to do with this patch "ima: skip verifying TPM 2.0 PCR values" [1].
Is it a correct way to differentiate between TPM 1.2 and TPM 2.0?
Or something else should be applied?

How is the work on TPM 2.0 Linux sysfs interface?
But even it's done in near future, we'd still need some way for older kernels.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/patch/1100733/
