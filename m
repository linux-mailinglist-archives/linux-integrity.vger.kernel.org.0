Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56F78801B7
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2019 22:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436973AbfHBUX7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Aug 2019 16:23:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35803 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436954AbfHBUX7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Aug 2019 16:23:59 -0400
Received: from 162-237-133-238.lightspeed.rcsntx.sbcglobal.net ([162.237.133.238] helo=elm)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <tyhicks@canonical.com>)
        id 1hte5d-0006JN-66; Fri, 02 Aug 2019 20:23:49 +0000
Date:   Fri, 2 Aug 2019 15:23:44 -0500
From:   Tyler Hicks <tyhicks@canonical.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>, jejb@linux.ibm.com,
        zohar@linux.ibm.com, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, crazyt2019+lml@gmail.com,
        nayna@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH] KEYS: trusted: allow module init if TPM is inactive or
 deactivated
Message-ID: <20190802202343.GE26616@elm>
References: <20190705163735.11539-1-roberto.sassu@huawei.com>
 <20190711194811.rfsohbfc3a7carpa@linux.intel.com>
 <b4454a78-1f1b-cc75-114a-99926e097b05@huawei.com>
 <20190801163215.mfkagoafkxscesne@linux.intel.com>
 <e50c4cfa-1f0c-6f4d-1910-010a8d874393@huawei.com>
 <20190802142721.GA26616@elm>
 <20190802194226.oiztvme5klkmw6fh@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802194226.oiztvme5klkmw6fh@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2019-08-02 22:42:26, Jarkko Sakkinen wrote:
> On Fri, Aug 02, 2019 at 09:27:22AM -0500, Tyler Hicks wrote:
> > On 2019-08-02 10:21:16, Roberto Sassu wrote:
> > > On 8/1/2019 6:32 PM, Jarkko Sakkinen wrote:
> > > > On Mon, Jul 15, 2019 at 06:44:28PM +0200, Roberto Sassu wrote:
> > > > > According to the bug report at https://bugs.archlinux.org/task/62678,
> > > > > the trusted module is a dependency of the ecryptfs module. We should
> > > > > load the trusted module even if the TPM is inactive or deactivated.
> > > > > 
> > > > > Given that commit 782779b60faa ("tpm: Actually fail on TPM errors during
> > > > > "get random"") changes the return code of tpm_get_random(), the patch
> > > > > should be modified to ignore the -EIO error. I will send a new version.
> > > > 
> > > > Do you have information where this dependency comes from?
> > > 
> > > ecryptfs retrieves the encryption key from encrypted keys (see
> > > ecryptfs_get_encrypted_key()).
> > 
> > That has been there for many years with any problems. It was added
> > in 2011:
> > 
> >  commit 1252cc3b232e582e887623dc5f70979418caaaa2
> >  Author: Roberto Sassu <roberto.sassu@polito.it>
> >  Date:   Mon Jun 27 13:45:45 2011 +0200
> > 
> >      eCryptfs: added support for the encrypted key type
> > 
> > What's recently changed the situation is this patch:
> > 
> >  commit 240730437deb213a58915830884e1a99045624dc
> >  Author: Roberto Sassu <roberto.sassu@huawei.com>
> >  Date:   Wed Feb 6 17:24:51 2019 +0100
> > 
> >      KEYS: trusted: explicitly use tpm_chip structure from tpm_default_chip()
> > 
> > Now eCryptfs has a hard dependency on a TPM chip that's working
> > as expected even if eCryptfs (or the rest of the system) isn't utilizing
> > the TPM. If the TPM behaves unexpectedly, you can't access your files.
> > We need to get this straightened out soon.
> 
> I agree with this conclusion that eCryptfs needs to be fixed, not
> another workaround to trusted.ko.

That wasn't the conclusion that I came to. I prefer Robert's proposed
change to trusted.ko.

How do you propose that this be fixed in eCryptfs?

Removing encrypted_key support from eCryptfs is the only way that I can
see to fix the bug in eCryptfs. That support has been there since 2011.
I'm not sure of the number of users that would be broken by removing
encrypted_key support. I don't think the number is high but I can't say
that confidently.

Roberto, what was your use case when you added encrypted_key support to
eCryptfs back then? Are you aware of any users of eCryptfs +
encrypted_keys?

Jarkko, removing a long-standing feature is potentially more disruptive
to users than adding a workaround to trusted.ko which already requires a
similar workaround. I don't think that I agree with you on the proper
fix here.

Tyler

> 
> /Jarkko
