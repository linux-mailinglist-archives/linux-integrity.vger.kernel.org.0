Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE85D22C6
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Oct 2019 10:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733089AbfJJI20 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Oct 2019 04:28:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbfJJI20 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Oct 2019 04:28:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E39982190F;
        Thu, 10 Oct 2019 08:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570696105;
        bh=L5is3Avng3rknWFuaXu0mMsht9z+QsEW6JsvwMdFvA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BfBBTPYw33qgR9u4E5Mc7HStrgmcfJEHHXzSTD9gWbhGpoOpzRIl6av3RrVBsyLvh
         M2IdxTjDr75uEBGOb173VkhYPFsbAnfjqMFgkSVUNX4+qKlMBJxh3/6QbidG0qdyIC
         qlrRpxRf8KI8WZJQb9aoLhTi6sf0DUCR6+fvlNGc=
Date:   Thu, 10 Oct 2019 10:28:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-stable@vger.kernel.org, linux-integrity@vger.kernel.org,
        Vadim Sukhomlinov <sukhomlinov@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] tpm: Fix TPM 1.2 Shutdown sequence to prevent
 future TPM operations
Message-ID: <20191010082822.GD326087@kroah.com>
References: <20191009212831.29081-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009212831.29081-1-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 10, 2019 at 12:28:28AM +0300, Jarkko Sakkinen wrote:
> commit db4d8cb9c9f2af71c4d087817160d866ed572cc9 upstream
> 
> This backport is for v4.14 and v4.19 The backport requires non-racy
> behaviour from TPM 1.x sysfs code. Thus, the dependecies for that
> are included.
> 
> NOTE: 1/3 is only needed for v4.14.

How can a 0/X have a git commit id?

:)

greg k-h
