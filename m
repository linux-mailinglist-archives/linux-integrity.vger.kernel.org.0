Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF8767FE64
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2019 18:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390266AbfHBQPk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Aug 2019 12:15:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58930 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732543AbfHBQPk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Aug 2019 12:15:40 -0400
Received: from 162-237-133-238.lightspeed.rcsntx.sbcglobal.net ([162.237.133.238] helo=elm)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <tyhicks@canonical.com>)
        id 1htaDM-0004rZ-SG; Fri, 02 Aug 2019 16:15:33 +0000
Date:   Fri, 2 Aug 2019 11:15:28 -0500
From:   Tyler Hicks <tyhicks@canonical.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     jarkko.sakkinen@linux.intel.com, jejb@linux.ibm.com,
        zohar@linux.ibm.com, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, crazyt2019+lml@gmail.com,
        nayna@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v2] KEYS: trusted: allow module init if TPM is inactive
 or deactivated
Message-ID: <20190802161527.GC26616@elm>
References: <20190802150733.1972-1-roberto.sassu@huawei.com>
 <20190802153030.GB26616@elm>
 <3222714a-a280-0708-f4c0-5db6d342d8dc@huawei.com>
 <8baf1c39-ad04-5cd6-bc67-341e7411db16@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8baf1c39-ad04-5cd6-bc67-341e7411db16@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2019-08-02 18:11:09, Roberto Sassu wrote:
> On 8/2/2019 5:34 PM, Roberto Sassu wrote:
> > On 8/2/2019 5:30 PM, Tyler Hicks wrote:
> > > On 2019-08-02 17:07:33, Roberto Sassu wrote:
> > > > Commit c78719203fc6 ("KEYS: trusted: allow trusted.ko to
> > > > initialize w/o a
> > > > TPM") allows the trusted module to be loaded even a TPM is not found to
> > >                                                     ^ if
> > > 
> > > > avoid module dependency problems.
> > > > 
> > > > However, trusted module initialization can still fail if the TPM is
> > > > inactive or deactivated. This patch ignores tpm_get_random() errors in
> > > > init_digests() and returns -EFAULT in pcrlock() if the TPM didn't return
> > > > random data.
> > > > 
> > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > > The code changes look correct to me.
> > > 
> > >    Reviewed-by: Tyler Hicks <tyhicks@canonical.com>
> > > 
> > > For whoever takes this patch through their tree, I think that adding the
> > > following Fixes tag would be useful (as well as cc'ing stable):
> > > 
> > >    Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip
> > > structure...")
> > > 
> > > I think it is also worth leaving a short note, in the commit message,
> > > for backporters that commit 782779b60faa ("tpm: Actually fail on TPM
> > > errors during "get random"") should be included with any backports of
> > > this patch.
> > 
> > Right, thanks. I wait for Jarkko's comments and I add both the Fixes tag
> > and the short note in the next version of the patch.
> 
> Uhm, I was thinking that maybe it is not necessary to mention commit
> 782779b60faa. This patch would still return 0 even if that commit is not
> backported (TPM_ERR_DISABLED < TPM_MAX_DIGEST_SIZE).

The commit message for 782779b60faa shows 379 being returned when
attempting to get random:

  [   18.092103] tpm tpm0: A TPM error (379) occurred attempting get random

I don't know enough about TPM chips to know how common that is...

Tyler

> 
> Roberto
> 
> -- 
> HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
> Managing Director: Li Peng, Li Jian, Shi Yanli
