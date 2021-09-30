Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D7841DF17
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Sep 2021 18:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350903AbhI3QdY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Sep 2021 12:33:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351616AbhI3QdP (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Sep 2021 12:33:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4717A61250;
        Thu, 30 Sep 2021 16:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633019492;
        bh=TH2rxojCyDCNDEdPBbGoIxnqTdUxBuNAaBEP2LRF2s0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QWAMp7+mZBlr7mVQG/kNYUXTaKnOADxIA5i7B9FKop7Xi2YV/lBYcjMfnNEZH2ShK
         CXNUmfdmRW1vUgCKuiDJddogN3bw6BIjA4SNiICk8UghbXs6dbSc/zfDqp4bMLY//5
         lkVuc4oFRvc/DhpNmMi3UXdQ/xS4u02IT1QvO67gzdTJOkdCVAHB3aScm7YEJBxeiK
         9I5clQD7OYANQ82wgshAgnlaLW0O8Ayb+coDsiLP12g3LaW0EqvwwFUhD+cjKtw7eh
         LEX8NxQ3mCr4iNSMKkv+RNzcmpJsyPBSystgr2l1CH4ohrL4axQMLZhvcF2zMwTVxi
         QQ24SRoCN0xtw==
Message-ID: <2890f582d78ea1d486ddbc97b90b90123819cb9c.camel@kernel.org>
Subject: Re: [PATCH v6] tpm: Add Upgrade/Reduced mode support for TPM2
 modules
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Borys Movchan <borysmn@axis.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     kernel@axis.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 30 Sep 2021 19:31:30 +0300
In-Reply-To: <59f8d5a835ff0f02c9efe0ecff0abbe1b4f08111.camel@kernel.org>
References: <20210930160241.9691-1-borysmn@axis.com>
         <59f8d5a835ff0f02c9efe0ecff0abbe1b4f08111.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-09-30 at 19:28 +0300, Jarkko Sakkinen wrote:
> static inline bool tpm_is_firmware_upgrade(void)
> {
> 	return chip->flags & TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE;
> }

Ugh, here's refined and fixed version:

static inline bool tpm_in_firmware_mode(struct tpm_chip *chip)
{
	return chip->flags & TPM_CHIP_FLAG_FIRMWARE_MODE;
}

/Jarkko

