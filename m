Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D3F45B558
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Nov 2021 08:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbhKXHbm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Nov 2021 02:31:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:46160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241030AbhKXHbk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Nov 2021 02:31:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29F9860ED4;
        Wed, 24 Nov 2021 07:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637738911;
        bh=TuyCi7tqH6iBK/3UakV9Txqfj69lLCntcYcOKw8v/jc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XbeFy9zqhkJsg17CupDshssIcBQnm6PZR57DnOp6Z23Gabz7VpGR/o6J5ppvq8kpC
         nP+p/qMWZ/benS7/2CO5aN8nrOUZ5MtCagCg1Xzs/SVk9pFUqiwW+9dPQPzFhkoFDI
         nL3zOAvjaoeGtxfzNIY+1g8FvMm5qeIENmwMqH4lMj6PXJxUjhmyrNfF8ME0702Tt5
         EcOX3CTDFE15l7fh5/glMGGryuBBZWr4v+VbaI20zvdV8gB+PXxZeYrwUKkE8R6mYF
         LbDUgcL9JDp8o62i4HgAoFuOmdKE+4wSCNo473yqfYkHpIX99OeJdqWIa8U8rCZ8Vy
         WLBjiewzqo3GA==
Message-ID: <7a9a638e3c769d37ce2951717f6cae1220fc3995.camel@kernel.org>
Subject: Re: [PATCH 1/2] selftests: tpm: Probe for available PCR bank
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, linux-kernel@vger.kernel.org
Date:   Wed, 24 Nov 2021 09:28:29 +0200
In-Reply-To: <20211122191752.1308953-2-stefanb@linux.ibm.com>
References: <20211122191752.1308953-1-stefanb@linux.ibm.com>
         <20211122191752.1308953-2-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-11-22 at 14:17 -0500, Stefan Berger wrote:
> Probe for an available PCR bank to accommodate devices that do not have a
> SHA-1 PCR bank or whose SHA-1 bank is deactivated.
>=20
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

1. I don't understand what the patch does by reading this description.
2. linux-kselftest missing.

/Jarkko
