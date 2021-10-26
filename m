Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8FC43AA20
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Oct 2021 04:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbhJZCRA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 Oct 2021 22:17:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230216AbhJZCRA (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Oct 2021 22:17:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D09861057;
        Tue, 26 Oct 2021 02:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635214477;
        bh=qIVqOavI+41kXLEr5nEtj7yZFH6f2ssL6tlpW772TII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DtuK25dpo4jA1U7aJoRVwuoO7CGt+W40QAqOjHBKSzRSAFz7bQdXojzyBOyfIuedb
         dbFSC9JwgWGq5XULlcWNm0qJ8K0rtQcqW+N3PalLyyftrUBlCMooss2/M/5FHjLs2k
         DtFOPudT7ziaa3SlV/Vk9oSINPCZbbZsVHXm1b08RQ5OG6MYGxg2W59A9tt6rlNzWL
         gQpeUNio4aTx2BOy/Fv6k/2ejCx+isKMZNODdMmMgL3XVW+gfVxbjEyE3n0mKWeAF5
         6fR1BqvpwiQA5LV8WBa+4uN2lMogl4nXtexRququBOQ3+VIZmGePR8JpM969X0XCg7
         /fs449JT4+vUQ==
Date:   Tue, 26 Oct 2021 05:14:34 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Chen Jun <chenjun102@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, rui.xiang@huawei.com
Subject: Re: [PATCH v2 1/1] tpm: add request_locality before write
 TPM_INT_ENABLE
Message-ID: <YXdkil68pWPMzL3e@iki.fi>
References: <20211013062556.116504-1-chenjun102@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013062556.116504-1-chenjun102@huawei.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Oct 13, 2021 at 06:25:56AM +0000, Chen Jun wrote:
> Locality is not appropriately requested before writing the int mask.
> Add the missing boilerplate.
> 
> Fixes: e6aef069b6e9 ("tpm_tis: convert to using locality callbacks")
> Signed-off-by: Chen Jun <chenjun102@huawei.com>


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

I'll queue this to v5.16-rc2 pull request (already closed
for rc1).

/Jarkko
