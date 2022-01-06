Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE19A486A56
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Jan 2022 20:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243204AbiAFTKw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Jan 2022 14:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbiAFTKv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Jan 2022 14:10:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5708CC061245;
        Thu,  6 Jan 2022 11:10:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F00FB8216A;
        Thu,  6 Jan 2022 19:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E84AC36AEB;
        Thu,  6 Jan 2022 19:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641496248;
        bh=dJ08G+MJqdgy37E8iW0zvCedqHmZwB/EW5VaXH8w/qY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bgvmzaOTXwwxXsQeqT43AruCcX/MMdiQxWu2QePcsAi4ObAdQjP/37yWInMVKPrNd
         6PDkVM4F24lVbI0KuQ5uk6kO6vYJyNouUnsMdHEK8vlyPBz4PL50r7pO5taYmGHQ3g
         cN987Fyby6e8t9mbx2TqZWfRTnHnze+qOD/E20IYb6DRWXvqNmT/vmaOdETVIbsElb
         MFKVMrIO/0F1kNnWgQuzoP+vaZeuA0+AJirS46SZnvEX+sQqhmfy9WmAbMCuOdQ5CU
         sxaVooPl6v4dnVRT/aMbboSaI8wHTJQQVOTMWm5HBcO8kjhkPHExdvtVI6vOVOooHX
         vDPOt8SLwM8NQ==
Date:   Thu, 6 Jan 2022 21:10:44 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER updates for v5.17
Message-ID: <Ydc+tDVZ7vv1SYm4@iki.fi>
References: <YcvI8Uki51C2aMqe@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcvI8Uki51C2aMqe@iki.fi>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 29, 2021 at 04:33:21AM +0200, Jarkko Sakkinen wrote:
> Hi,
> 
> Other than bug fixes for TPM, includes a patch for asymmetric keys to allow
> to look up and verify with self-signed certificates (keys without so called
> Authority Key Identifier (AKID)) using a new "dn:" prefix in the query.

I'll send updated PR. There was a truncated fixes tag in
"tpm: fix potential NULL pointer access in tpm_del_char_device".

BR,
Jarkko
