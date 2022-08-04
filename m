Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3FD5897CD
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Aug 2022 08:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiHDGgF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Aug 2022 02:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiHDGgE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Aug 2022 02:36:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9E33AB31;
        Wed,  3 Aug 2022 23:36:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B26B460EF5;
        Thu,  4 Aug 2022 06:36:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8464C433C1;
        Thu,  4 Aug 2022 06:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659594960;
        bh=XWdk58I8HuYnLJ5GXb3J4tqaVKN0JX8nir8rtpOl2Fo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CEhJyC6z6ebWqBBC413s3sNPrZsBsb37Oys6ZXEAHfJd9TB2CiwSGDuxGEvUzTIV3
         AfvDu6tNH/+f5qoikGDlpGkzuyJdz06dkd/ewDvVZ0hDf4xmXhhQ67qjJa2b+PUo9n
         rlXch47Y9YndESG7X6Y0/NexXldDq0rltxhHQTr/puO9Iewf5GhEUvh/Fgcp4OUT2S
         /sn/xzKJ67oyI8KMEm6p5rA3O6/op3KsxByUSI8aUqZar318uSpZvfRqmRSsmXCZ/d
         HgG6+H/RBtqRZpPveTlf12AZVEZQ+R8GRBWx62FtolwovDmVUaK5NcHM77NNspqKHG
         9pKZP1OIcxqxQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] tpmdd updates for v5.20
In-Reply-To: <20220803210228.158993-1-jarkko@kernel.org> (Jarkko Sakkinen's
        message of "Thu, 4 Aug 2022 00:02:28 +0300")
References: <20220803210228.158993-1-jarkko@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Thu, 04 Aug 2022 09:35:51 +0300
Message-ID: <87pmhgikhk.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Jarkko Sakkinen <jarkko@kernel.org> writes:

> Contains mostly TPM and also few keyring fixes.
>
> BR, Jarkko
>
> The following changes since commit 200e340f2196d7fd427a5810d06e893b932f145a:
>
>   Merge tag 'pull-work.dcache' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2022-08-03 11:43:12 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.20
>
> for you to fetch changes up to 863ed94c589fcd1984f4e3080f069d30508044bb:
>
>   tpm: Add check for Failure mode for TPM2 modules (2022-08-03 23:56:20 +0300)
>
> ----------------------------------------------------------------
> tpmdd updates for Linux v5.20
>
> ----------------------------------------------------------------
> Alexander Steffen (3):
>       dt-bindings: trivial-devices: Add Infineon SLB9673 TPM
>       tpm: Add tpm_tis_verify_crc to the tpm_tis_phy_ops protocol layer
>       tpm: Add tpm_tis_i2c backend for tpm_tis_core
>
> Elvira Khabirova (1):
>       pkcs7: support EC-RDSA/streebog in SignerInfo
>
> Huacai Chen (1):
>       tpm: eventlog: Fix section mismatch for DEBUG_SECTION_MISMATCH
>
> M...rten Lindahl (1):
>       tpm: Add check for Failure mode for TPM2 modules

Some encoding problems in the name? At least my Gnus didn't show them correctly.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
