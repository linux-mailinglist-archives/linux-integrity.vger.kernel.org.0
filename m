Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36F6B7AACB
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jul 2019 16:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfG3OUe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Jul 2019 10:20:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbfG3OUd (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Jul 2019 10:20:33 -0400
Received: from localhost.localdomain (ool-18bba523.dyn.optonline.net [24.187.165.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B570820659;
        Tue, 30 Jul 2019 14:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564496433;
        bh=ie2hvwgefqzxoaolytbyCM3+Zq3DzmACUb0PRQtPPZA=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=qrU/yTCaZG62QOnUSLIfaxT+6U4WBnOfKJjKNvtDNo9aG9N3aubbvkgAIVKa5h7VR
         lyJaf8CL1E6XMofCvPZfg+iVJFHO2S59Y+f1C8s97fskZtQ6J8t3+ZDCkIoyhffkEe
         sBQlqfgmoxdOwhdB8Jt+FRlxdaGC34yAxfZ2RFds=
Message-ID: <1564496416.4189.79.camel@kernel.org>
Subject: Re: [PATCH] ima-evm-utils: Allow EVM verify to determine hash algo
From:   Mimi Zohar <zohar@kernel.org>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Tue, 30 Jul 2019 10:20:16 -0400
In-Reply-To: <20190729061807.3278-1-vt@altlinux.org>
References: <20190729061807.3278-1-vt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-07-29 at 09:18 +0300, Vitaly Chikunov wrote:
> Previously for EVM verify you should specify `--hashalgo' option while
> for IMA ima_verify you didn't.
> 
> Allow EVM verify to determine hash algo from signature.

Vitaly, EVM signatures were originally included with an image, but on
first use were replaced with an EVM hmac.  Only once the EVM portable
and immutable signature support was upstreamed, which is relatively
recently, there was a need to support other hash algorithms.

Thank you for taking the time to really clean up ima-evm-utils.  It's
needed some attention for a while now.

> Also, this makes two previously static functions to become exportable
> and renamed:
> 
>   get_hash_algo_from_sig -> imaevm_hash_algo_from_sig
>   get_hash_algo_by_id    -> imaevm_hash_algo_by_id
> 
> This is needed because EVM hash is calculated (in calc_evm_hash) outside
> of library.
> 
> imaevm_hash_algo_by_id() will now return NULL if algo is not found.
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>

Thanks!

Mimi
