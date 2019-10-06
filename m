Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5008CCD8C
	for <lists+linux-integrity@lfdr.de>; Sun,  6 Oct 2019 02:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfJFAq0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 5 Oct 2019 20:46:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbfJFAq0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 5 Oct 2019 20:46:26 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20987222C0;
        Sun,  6 Oct 2019 00:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570322785;
        bh=mDMXJWH/nFeJNJwCLSbJe1N6n7x5kCnrUMEyt+durkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=somadfab2V4QHz/ZiMbEFMT0P+UUp3PyP4gF3k6a6e1C7ay80JzefelirS/RG3OoV
         /TXKEfRaxJwYQklwaHiaDbKlRHYsDJXtUIYWX3q1ttspvBrTeLvwL98CzfLIAX5//h
         nDXRRQMxAN+b+8HTvTljrKGE+e7wQJmfDLqVeJck=
Date:   Sat, 5 Oct 2019 20:46:24 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-stable@vger.kernel.org, linux-integrity@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Vadim Sukhomlinov <sukhomlinov@google.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] tpm: Fix TPM 1.2 Shutdown sequence to prevent
 future TPM operations
Message-ID: <20191006004624.GG25255@sasha-vm>
References: <20191003184623.25580-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191003184623.25580-1-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 03, 2019 at 09:46:20PM +0300, Jarkko Sakkinen wrote:
>commit db4d8cb9c9f2af71c4d087817160d866ed572cc9 upstream
>
>This backport is for v4.14 and v4.19 The backport requires non-racy
>behaviour from TPM 1.x sysfs code. Thus, the dependecies for that
>are included.
>
>NOTE: 1/3 is only needed for v4.14.

I've queued these for 4.19 and 4.14, thanks!

-- 
Thanks,
Sasha
