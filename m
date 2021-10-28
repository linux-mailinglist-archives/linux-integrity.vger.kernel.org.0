Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876D343DB68
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Oct 2021 08:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhJ1Gqs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 Oct 2021 02:46:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhJ1Gqr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Oct 2021 02:46:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B10460E78;
        Thu, 28 Oct 2021 06:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635403460;
        bh=geD3maJA+CmqQf7ZyHEi1b6Ffhauz6VMzyXmNZBGEcg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FpoUVqeaRGaH0YEJYkKDuxFssNzBexQqsNX+5WyEjQLsa02acsv1jKGOVszllAi2G
         shVZSjYH24rCL/HS26xgbuXbeeGy8cMJ8MH1aBlM94CINkaRn9u+4Q57+aL/wFWuXo
         KdnbNV4niYB1iSyyql6GQz+fqhLLI1g8wTW1weRxlxGXqWijEzITcQOdkj2lEctsV8
         U1AzwM6BsPvlND3jaKW75Bd+t3yZ402iwmV4rTi13pBqzidxbISQDxOQ2S8yIN9G4s
         /aSMBODrPI0/YWO4tomFhun4n3U7n7eQNv9JQn4k7++Nf7qek/FfBMp52hG9x/G7Zd
         fcQPt96OZQ9JQ==
Date:   Thu, 28 Oct 2021 09:44:18 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 1/2] crypto: use SM3 instead of SM3_256
Message-ID: <YXpGwl/AAqLKye37@iki.fi>
References: <20211026075626.61975-1-tianjia.zhang@linux.alibaba.com>
 <20211026075626.61975-2-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026075626.61975-2-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 26, 2021 at 03:56:25PM +0800, Tianjia Zhang wrote:
> According to https://tools.ietf.org/id/draft-oscca-cfrg-sm3-01.html,
> SM3 always produces a 256-bit hash value and there are no plans for
> other length development, so there is no ambiguity in the name of sm3.
> 
> Suggested-by: James Bottomley <jejb@linux.ibm.com>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

The commit message does not contain a description of what kind of code
change you're doing.

/Jarkko
