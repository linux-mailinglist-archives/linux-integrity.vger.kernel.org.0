Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A7E43AA23
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Oct 2021 04:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbhJZCSH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 Oct 2021 22:18:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230216AbhJZCSH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Oct 2021 22:18:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F104261078;
        Tue, 26 Oct 2021 02:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635214544;
        bh=5jx/mGELsgCeUy/kfkFouShF25qOwFhjUg01K1BXYDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iNVt/ZN3wOs4DfycjkclUeMI1yGljFf1nmusRxbBU5rpTWZMxKS3xlUNJe63xcUK0
         bScbtCjyYnRKs/hu1QEHXxqpigR+nQ5rxQC23ER1V+RGxFRmhhOytVefDgZvkYJxzK
         SCPvWFQ2C+UCmMyQW5z0WsTyCgibQm78mgNVl8Bf+aI4yrOH5PxUxpOfni9gCYVU8d
         u2COlRyhJ2u0KvoFouRw5pk3qwcxjyWsf78Z9fGolzb6V0Uk+Z0SJdJwSSJE3DY7L4
         CbwXuJLo1qY6iuQ5kqqEntZQghxeQKC2y5zzYIlqY0O6dimIKuJlOqhibHr7ZMdl5h
         aQpo2ZeWpspFA==
Date:   Tue, 26 Oct 2021 05:15:41 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm/st33zp24: drop unneeded over-commenting
Message-ID: <YXdkzV+R2VVGuKQc@iki.fi>
References: <20211013092151.11835-1-sohaib.amhmd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013092151.11835-1-sohaib.amhmd@gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Oct 13, 2021 at 11:21:50AM +0200, Sohaib Mohamed wrote:
> Remove parameter descriptions from all static functions.
> Remove the comment altogether that does not tell what the function does.
> 
> Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>

Thanks.
 
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
