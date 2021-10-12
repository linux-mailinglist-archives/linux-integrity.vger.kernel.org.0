Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B9942A827
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Oct 2021 17:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbhJLPYC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Oct 2021 11:24:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229633AbhJLPYB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Oct 2021 11:24:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E13A60E97;
        Tue, 12 Oct 2021 15:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634052120;
        bh=7kLs+anK8k4vNTJePwcFay1rHFEUNiKPKTkIEwb7lwg=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=Lh/U8KEpnd0AV4fQ2vdTWljX2AdZEDVW+cizGOOUT3kljayrHoKbQNSQY5U0rtFQ0
         EVlWZirNeLCQNlTVHGqzBygB3+VrjFQ2aAozexudpy+UIysKF2cEA2Y+nqg4syafOZ
         vdhRPoXJ37fmo2FtHGD2ChP3tzIoO3TFEYOTSeqVre1o0Kf9J45LdOf6UwntHu/CzK
         9ELsfgEd6iPBuGBR+WKqVmoy6MSHcDWe2qPK7pr/8w0Jx+iU+yHuKmjG65R3v6PB6J
         0nKuoNUZSbluZxxUDX1uihmCchN4jku4K0uu0MYbYItJyl8M2w9FUNr7j2b2SOQtDy
         7zStw67Xf4C2Q==
Message-ID: <c6c2337ed83c237f70716cb4c62794d1d3da31f2.camel@kernel.org>
Subject: Re: [PATCH 2/2] tpm: use SM3 instead of SM3_256
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        James Bottomley <jejb@linux.ibm.com>,
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
Date:   Tue, 12 Oct 2021 18:21:57 +0300
In-Reply-To: <20211009130828.101396-3-tianjia.zhang@linux.alibaba.com>
References: <20211009130828.101396-1-tianjia.zhang@linux.alibaba.com>
         <20211009130828.101396-3-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2021-10-09 at 21:08 +0800, Tianjia Zhang wrote:
> According to https://tools.ietf.org/id/draft-oscca-cfrg-sm3-01.html,
> SM3 always produces a 256-bit hash value and there are no plans for
> other length development, so there is no ambiguity in the name of sm3.
>=20
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

This is not enough to make any changes because the commit message
does not describe what goes wrong if we keep it as it was.

/Jarkko

