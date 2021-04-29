Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E2C36E510
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Apr 2021 08:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbhD2Gt0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Apr 2021 02:49:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238979AbhD2Gt0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Apr 2021 02:49:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33A8561419;
        Thu, 29 Apr 2021 06:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619678919;
        bh=aeaJUFUhF0YJ7/b9ZoMU0OBjRE51BGOVKWmje1SgVNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JcdDlhxEro66OMN72kpYxyVvQh69BAIu9rq5tPhG3ONjVC0sVyW7pRRwYON4DN3vK
         OEG6N4/bde0nEbVPSud4oEo6cQ6aEgg7v1oLWxVj9w1mLW5nEoGcQZfxemk2ekdVb/
         dkYf2TpoYGJpfHbwansnkf1DCfcwjCCnZb99+cUQ1Ize27wjoMAsGZo/g86j5hu99/
         +7v24GzfQ7piB2dh6TxpHIVjW/tfYCOVRq786qUsibPWEIXD4c+xxES4JHeLWzl4mJ
         rlKGDXml0gNj6/AU58hZ56xj9m13yK0ciXKC6VT+Q/WqnszJd33LL1EVIXSlpw/f8H
         8nRhBZx5nRnSQ==
Date:   Thu, 29 Apr 2021 09:48:36 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "tiantao (H)" <tiantao6@huawei.com>
Cc:     Tian Tao <tiantao6@hisilicon.com>, peterhuewe@gmx.de,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm_crb: Use IOMEM_ERR_PTR when function returns iomem
Message-ID: <YIpWxEqwQwOuDt5q@kernel.org>
References: <1618888245-31604-1-git-send-email-tiantao6@hisilicon.com>
 <YIih6nWshf7XfNTU@kernel.org>
 <9bdc99ef-7407-5ae7-a412-18e695ca8c2d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9bdc99ef-7407-5ae7-a412-18e695ca8c2d@huawei.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 28, 2021 at 04:43:46PM +0800, tiantao (H) wrote:
> 
> 在 2021/4/28 7:44, Jarkko Sakkinen 写道:
> > On Tue, Apr 20, 2021 at 11:10:45AM +0800, Tian Tao wrote:
> > > Function returns 'void __iomem *' so use IOMEM_ERR_PTR for returning
> > > an error.
> > You should also tell why we want to to use IOMEM_ERR_PTR in the
> > description. If it makes sense, then you should know why it makes
> > sense.
> 
> thank for review the code ,I'll send a v2 to update the commit message.
> 
> This is to simplify the code, the definition of IOMEM_ERR_PTR is in
> include/linux/io.h
> 
> #define IOMEM_ERR_PTR(err) (__force void __iomem *)ERR_PTR(err)
> 
> I'll send it to v2 and put the above sentence in the commit messge, what do
> you think?

I don't pre-ack patches.

/Jarkko
