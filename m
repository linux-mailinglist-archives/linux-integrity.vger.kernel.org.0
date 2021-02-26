Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619AF325B2B
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Feb 2021 02:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhBZBKo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Feb 2021 20:10:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:45422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230417AbhBZBKn (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Feb 2021 20:10:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB5EF64EC3;
        Fri, 26 Feb 2021 01:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614301803;
        bh=L7ImJxzjWsfgSl60dccdeBC8yjckHARx8dKvUAFlaoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h60wIl5m5zU/1wUR8pCB39VeBUvXCILb6uuB1Wap+o695kC3dLR4FN5EsEaOMO83D
         KHcRSz3qvY93Lnb10oS6oO128bam7OCMpRgc7BodnBH/+vuL+QytB8P3J/QxAeKvLG
         6uJ5FeAqIvM9p9O5ydP5y7BMKnz9PWd/3TxwPXVOhFMBfbBLTHK1cGggBLPKF/IyTE
         t6mUFgNRDR40LF8WmaNQ0kMdJaCPICsnJTkY/fGac9jO6sgJe8f4DOU+klduGznL+I
         EoJjE1Eiqxys3rrgb/Ih2bt+S2yiPkPd4e9/+BOMUAjIwWVvsGCdf/hfFGb9YI988A
         jEw8knGNIusJQ==
Date:   Fri, 26 Feb 2021 03:09:44 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Patrick Uiterwijk <patrick@puiterwijk.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, linux-integrity@vger.kernel.org,
        pbrobinson@gmail.com, stefanb@linux.ibm.com, kgold@linux.ibm.com
Subject: Re: [PATCH 1/3] tpm: Add support for reading a TPM NV Index
Message-ID: <YDhKWAuY+gbLJ4rG@kernel.org>
References: <20210225203229.363302-1-patrick@puiterwijk.org>
 <20210225203229.363302-2-patrick@puiterwijk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225203229.363302-2-patrick@puiterwijk.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 25, 2021 at 09:32:27PM +0100, Patrick Uiterwijk wrote:
> Add support to read contents from a TPM2 Non-Volatile Index location,
> allowing the kernel to retrieve contents and attributes of NV indexes.
> 
> Signed-off-by: Patrick Uiterwijk <patrick@puiterwijk.org>

How many call sites?

/Jarkko
