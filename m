Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA241FFB64
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 20:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgFRS73 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jun 2020 14:59:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:35238 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbgFRS73 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jun 2020 14:59:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2FDF7AB3D;
        Thu, 18 Jun 2020 18:59:27 +0000 (UTC)
Date:   Thu, 18 Jun 2020 20:59:26 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH ima-evm-utils] cmd_ima_bootaggr: Fix for systems without
 TPM 2.0
Message-ID: <20200618185926.GB20597@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200618181007.148765-1-pvorel@suse.cz>
 <1592504434.4615.56.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1592504434.4615.56.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

NOTE: this is for systems with TPM 1.2 (not for system without any TPM).

> On Thu, 2020-06-18 at 20:10 +0200, Petr Vorel wrote:
> > For both kernel with and without CONFIG_IMA=y.

> > NOTE: ima_boot_aggregate was added in dc00c92, without TPM 2.0
> > it just reported:
> > EVP_DigestInit() failed
> > (null):

> > Fixes: 917317a ("ima_evm_utils: emit the per TPM PCR bank
> > "boot_aggregate" values")

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> I don't have a problem with accepting this solution, but I think the
>  real problem is that hash_info.h is not included in the kernel-
> headers package on the system.  One solution would be to include a
> default hash_info.h file in ima-evm-utils and fall back to using it.
Thanks for a quick answer. I'm not sure if this is a best approach.
But I have /usr/include/linux/hash_info.h on all systems
I tested (4.15 from openSUSE and 5.6.13 on Debian).

Kind regards,
Petr
