Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD7245FD97
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2019 21:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfGDT7Q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Jul 2019 15:59:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50461 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfGDT7P (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Jul 2019 15:59:15 -0400
Received: from 162-237-133-238.lightspeed.rcsntx.sbcglobal.net ([162.237.133.238] helo=elm)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <tyhicks@canonical.com>)
        id 1hj7sn-00065o-5y; Thu, 04 Jul 2019 19:59:05 +0000
Date:   Thu, 4 Jul 2019 14:58:58 -0500
From:   Tyler Hicks <tyhicks@canonical.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Michal Suchanek <msuchanek@suse.de>,
        linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Bottomley <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Armijn Hemel <armijn@tjaldur.nl>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [PATCH] Revert "tpm: pass an array of tpm_extend_digest
 structures to tpm_pcr_extend()"
Message-ID: <20190704195857.GB6105@elm>
References: <20190701131505.17759-1-msuchanek@suse.de>
 <8e4cc105b748c5395132b4d3d29d0d9b30a8720c.camel@linux.intel.com>
 <cf2ea579-41c2-42da-2df3-0b1f12e1c639@huawei.com>
 <1562240882.6165.78.camel@linux.ibm.com>
 <1562255201.6165.143.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1562255201.6165.143.camel@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hey Mimi!

On 2019-07-04 11:46:41, Mimi Zohar wrote:
> Hi Jarkko,
> 
> On Thu, 2019-07-04 at 07:48 -0400, Mimi Zohar wrote:
> > On Thu, 2019-07-04 at 13:28 +0200, Roberto Sassu wrote:
> > > On 7/4/2019 12:03 PM, Jarkko Sakkinen wrote:
> > > > On Mon, 2019-07-01 at 15:15 +0200, Michal Suchanek wrote:
> > > >> This reverts commit 0b6cf6b97b7ef1fa3c7fefab0cac897a1c4a3400 to avoid
> > > >> following crash:
> > > > 
> > > > Thank you. I think this the right choice for the moment. I fixed
> > > > a trivial checkpatch.pl error and added the mandatory tags. Can
> > > > you check quickly v2 (just posted)?
> > > > 
> > > > I already made it available in my master and next.
> > > 
> > > Could you please wait few days? I would prefer to fix this issue instead
> > > of reverting the whole patch.
> > 
> > Nayna posted a patch late yesterday titled "tpm: fixes uninitialized
> > allocated banks for IBM vtpm driver", which addresses this bug.
> 
> Now with my review, and with Sachin Sant's and Michal Suchánek
> testing, instead of reverting this patch could you pick up Nayna's
> patch instead?

It looks to me like the revert would also fix a bug that is keeping the
eCryptfs module from loading when the TPM is in an "inactive" state:

  https://bugzilla.kernel.org/show_bug.cgi?id=203953

I just noticed that it was recently discussed here, too:

  https://lore.kernel.org/linux-integrity/1562244125.6165.95.camel@linux.ibm.com/T/#t

I believe that the revert would fix it because the call to
init_digests()/tpm_get_random() would no longer be in the path of
loading ecryptfs.ko (which depends on encrypted-keys.ko, which depends
on trusted.ko).

If the revert isn't used, we'll need a different fix for bug 203953. It
should be an easy fix but I don't want it to be forgotten.

Tyler

> 
> thanks!
> 
> Mimi
> 
