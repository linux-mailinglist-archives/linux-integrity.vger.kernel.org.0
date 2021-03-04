Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2376E32D6F9
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Mar 2021 16:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbhCDPow (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Mar 2021 10:44:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:47076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235425AbhCDPov (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Mar 2021 10:44:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24A3164F1C;
        Thu,  4 Mar 2021 15:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614872650;
        bh=6jLPxNDL64P/mRJ73kPiuZhN1FqB4cBzR2lOz4w2S0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CaIujOtvvcJqCchgWRxGH83rlO494rVAJP/mFeqXfJM4+dcyKx710abuEFqVvKpIg
         w9f2sd8VQYRkmSSMQUheQBqMRNrUUNP9bXbiTxoeOvjYrbr+zGeyFIdaDB/9Bi3F9g
         ixfaKFBKNjqvCWuWkB2PTmft2q06G6+89Jk0z4Nr8oAnE+ZvvCgh7WOp57+lEWIDcr
         StH+Gv2orhq5vE5lAOtiHLv6k7pnZ7essdsHN1nBlxaZa+/As0ZHmf+MtxaSCdZ896
         Ctk5il4HTJ8H9Zs0B1y72EJUr6pKE9jcUVXdOqTtUESpdn0urq2dGi0NYvWsJ3wnT/
         RjAFZjtTeTi2Q==
Date:   Thu, 4 Mar 2021 17:43:49 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Markus Wamser <Markus.Wamser@mixed-mode.de>,
        Luke Hinds <lhinds@redhat.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v9 0/4] Introduce TEE based Trusted Keys support
Message-ID: <YEEANW+khw3nJtcQ@kernel.org>
References: <20210301131127.793707-1-sumit.garg@linaro.org>
 <CAFA6WYO4HHhtymaUzmkuaCZybTAWBQ=4K9Dez1pe1kqo3AJhuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYO4HHhtymaUzmkuaCZybTAWBQ=4K9Dez1pe1kqo3AJhuA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 04, 2021 at 03:30:18PM +0530, Sumit Garg wrote:
> Hi Jarkko,
> 
> On Mon, 1 Mar 2021 at 18:41, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Add support for TEE based trusted keys where TEE provides the functionality
> > to seal and unseal trusted keys using hardware unique key. Also, this is
> > an alternative in case platform doesn't possess a TPM device.
> >
> > This patch-set has been tested with OP-TEE based early TA which is already
> > merged in upstream [1].
> >
> > [1] https://github.com/OP-TEE/optee_os/commit/f86ab8e7e0de869dfa25ca05a37ee070d7e5b86b
> >
> > Changes in v9:
> > 1. Rebased to latest tpmdd/master.
> > 2. Defined pr_fmt() and removed redundant tags.
> > 3. Patch #2: incorporated misc. comments.
> > 4. Patch #3: incorporated doc changes from Elaine and misc. comments
> >    from Randy.
> > 5. Patch #4: reverted to separate maintainer entry as per request from
> >    Jarkko.
> > 6. Added Jarkko's Tested-by: tag on patch #2.
> 
> It looks like we don't have any further comments on this patch-set. So
> would you be able to pick up this patch-set?

I'm cool with that - I can pick this for 5.13.

/Jarkko
