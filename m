Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B1337B369
	for <lists+linux-integrity@lfdr.de>; Wed, 12 May 2021 03:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhELBXA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 May 2021 21:23:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229954AbhELBW7 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 May 2021 21:22:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D91A6191D;
        Wed, 12 May 2021 01:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620782512;
        bh=Y80GLNJoGPtq0jASDC6QC2X7eZgo2bdGjTqkSYP0pNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lNqmtuazkC32aJEPueGyekKLzfkwyq9zC8oDaUpYvD4LAwNU/sdkoHuEtsElikULC
         Vpb08vVEstRzUzVvcniPL5UNXeP6d98gf7z5KQmOzOsQetIIvjpTryVUhKQ6LkUqnl
         D76x6uiPYDz/B2oHeI4W4UyiS80MSp1dVbGn3KYaeLCDtOMG5o3IxxUCjyE2Pho18i
         fnjIk6nbelrkhnl2ZoFfMbEV4ARkr7CCBUvoiT7rdV8rN4D3OKQ0K2BGwr4K4gdlxD
         1ENQp96Mr/3yH9vbZn0Sk6iQZ/fIg3DE87HAFgPmFkuiRSwu1Sxiih0tinBGJ549Bu
         F8t6/e4yoSG1Q==
Date:   Wed, 12 May 2021 04:21:50 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] tpm: fix error return code in tpm2_get_cc_attrs_tbl()
Message-ID: <YJstroyoV5KfEh/m@kernel.org>
References: <20210508025444.1977-1-thunder.leizhen@huawei.com>
 <YJhI+lIt4devpAoS@kernel.org>
 <b79b306a-71da-f655-3e68-11f1c9df4115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b79b306a-71da-f655-3e68-11f1c9df4115@huawei.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 12, 2021 at 09:12:26AM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/5/10 4:41, Jarkko Sakkinen wrote:
> > On Sat, May 08, 2021 at 10:54:44AM +0800, Zhen Lei wrote:
> >> Fix to return a negative error code from the error handling
> >> case instead of 0, as done elsewhere in this function.
> >>
> >> Fixes: 58472f5cd4f6("tpm: validate TPM 2.0 commands")
> >> Reported-by: Hulk Robot <hulkci@huawei.com>
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> > 
> > In the commit message:
> > 
> > 1. Instead of writing "a negative error code", write -EFAULT.
> OK, I will change it.
> 
> > 2. Some explanation of the choice.
> Do you mean why I choice error code -EFAULT? There's a similar one above this branch.
> 
>         if (nr_commands > 0xFFFFF) {
>                 rc = -EFAULT;
>                 goto out;
>         }

I mean that the commit message must rationalize whatever the commit does,
and choices made.

/Jarkko
