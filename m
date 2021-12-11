Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CD4471487
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Dec 2021 16:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhLKPkT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 11 Dec 2021 10:40:19 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:55672 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbhLKPkT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Dec 2021 10:40:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 18BA5CE0958
        for <linux-integrity@vger.kernel.org>; Sat, 11 Dec 2021 15:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6361C004DD;
        Sat, 11 Dec 2021 15:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639237216;
        bh=9tSLpF8bZNHxC3ZfoaciEtdjyj5Qhpt0cXdoL2mlEG8=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=mvsxZYOfOhC+9yqMA1pOw4zqxK+5fd5TSimwFblD7gGde/Xy+tXxLbm0IkEZz3Wb4
         fyVuELPd9swVrnwk2D2yqoCcUwouK+/kwkeDW5fva+svcfclytvCVUNAe6urVEi5Qo
         nyE1hnERX2Fe1zV8/WIdOEYEvFNdvJO+QXNbR2tddYLiT8cyWFxdxwdEpxWY4ty3E+
         88xucI3CnQLBvC0xdsWxvzG5aGzWI1IMDrGwmm6XDVQqk408pH5/iCNQRNgeMgVBPc
         DNHN1TZzIkErMTqdzBxrxGsn8arKfOG/NzyWoWyL2SXAI2ClHQXJJyfqbag3Wt/0A0
         +wQ88ZohkvPzg==
Message-ID: <8e7191ed3b4bc409431261608376251b788ec817.camel@kernel.org>
Subject: Re: [PATCH] Instantiate key with user-provided decrypted data.
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Yael Tiomkin <yaelt@google.com>, linux-integrity@vger.kernel.org
Date:   Sat, 11 Dec 2021 17:40:12 +0200
In-Reply-To: <20211210150018.2075133-1-yaelt@google.com>
References: <20211210150018.2075133-1-yaelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-12-10 at 10:00 -0500, Yael Tiomkin wrote:
> The encrypted.c class supports instantiation of encrypted keys with
> either an already-encrypted key material, or by generating new key
> material based on random numbers. To support encryption of
> user-provided decrypted data, this patch defines a new datablob
> format: [<format>] <master-key name> <decrypted data length>
> <decrypted data>.
>=20
> Signed-off-by: Yael Tiomkin <yaelt@google.com>

Nit: rather write "Define a new datablob...".

Why do we want this?

/Jarkko
