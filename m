Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9940716963
	for <lists+linux-integrity@lfdr.de>; Tue,  7 May 2019 19:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfEGRkW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 May 2019 13:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbfEGRkW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 May 2019 13:40:22 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1F94205C9;
        Tue,  7 May 2019 17:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557250822;
        bh=B7xuS+MeONWbjBVsnApHHBG5Z9A/6DoQrJhZdwwwcv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eEUAnM28KJ0goBJyq3TXivl4F3BvbHxfLjWdGtxc84MGwBn0buh/1hbVEK68ShrR4
         TraYZ0TXDs70U6a5TYrdlVWX9NlUKdDJiIS+bd7N8rn6qNCAqEPIXUvy8JBaSgHDP4
         ghs3iJweOwSl/NGjSoucgORRmjjxtcbCyc7RJQ2o=
Date:   Tue, 7 May 2019 13:40:20 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com
Subject: Re: [PATCH v3 0/2] ftpm: a firmware based TPM driver
Message-ID: <20190507174020.GH1747@sasha-vm>
References: <20190415155636.32748-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190415155636.32748-1-sashal@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Apr 15, 2019 at 11:56:34AM -0400, Sasha Levin wrote:
>From: "Sasha Levin (Microsoft)" <sashal@kernel.org>
>
>Changes since v2:
>
> - Drop the devicetree bindings patch (we don't add any new ones).
> - More code cleanups based on Jason Gunthorpe's review.
>
>Sasha Levin (2):
>  ftpm: firmware TPM running in TEE
>  ftpm: add documentation for ftpm driver

Ping? Does anyone have any objections to this?

--
Thanks,
Sasha
