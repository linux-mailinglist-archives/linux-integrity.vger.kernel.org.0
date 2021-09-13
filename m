Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43218409E27
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Sep 2021 22:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243864AbhIMUcc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Sep 2021 16:32:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243788AbhIMUcc (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Sep 2021 16:32:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BC1B6108B;
        Mon, 13 Sep 2021 20:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631565075;
        bh=RPJ5U0dUxyH05Qy2WqNugAgF143GUG387/KfM6hOVeQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Jcv56BwX+tVHQHfFs8YxsC23XjBczKIqJb8hQzuDdDMv8JqhRFhyGYxrhkF+fGpwr
         5OXNq8lHL2RJCbq7Q2BLlPvz1r5wZiY2o6ej3GFhbVxsJVQqOpUC0xdE0Iu0KPYf3k
         vJhkyklcNjQBBrKNS3jZCS4CyaJuj9POfU9Twxk4G6PE1VbyQVwDNOhtwMYh3MhDvl
         DsNJUAAuvW/s7qYPN8tyQa4joaFdKABhelq+Y55FBsXm0SlTXW4MGusxwroGos7716
         qNq/PVumcuCz8Uz+Fv9DvfdSQOqTqQkIoChC6o9JgiBvs0yQ1svS9cITA3DfM1Zwpb
         lfhdpsvsQpvng==
Message-ID: <169a507329c2273f64c1c7ebab0a3530b19e971e.camel@kernel.org>
Subject: Re: [PATCH v2 1/1] tpm/tpm_i2c_infineon: Fix init endian vendor
 check
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Florian Eckert <fe@dev.tdt.de>, peterhuewe@gmx.de, jgg@ziepe.ca,
        Eckert.Florian@googlemail.com
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 13 Sep 2021 23:31:13 +0300
In-Reply-To: <20210913120521.18572-1-fe@dev.tdt.de>
References: <20210913120521.18572-1-fe@dev.tdt.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-09-13 at 14:05 +0200, Florian Eckert wrote:
> On my embedded system I use this tpm infineon chip via i2c bus.
> The system is a MIPS architecture and therefore works in big endian mode.
>=20
> The problem is, that the chip type is not correctly recognized,
> because the vendor ID is wrongly aligned in the memory.
>=20
> By declaring the vendor ID variable as a `__le32` type, the TPM chip is
> then correctly recognized by the driver and feels then responsible.

Please no hyphens just normal single quotes.

You should have always in a commit message some explanation what
the patch does in imperative form, e.g. "Change type of xxx ...
because ...".

I cannot from find a variable named "vendor ID" from
tpm_tis_i2c_init(). Maybe you are referring to the variable,
of which name is "vendor"?

Finally, the commit message lacks explanation what is changed, i.e.
tpm2_tis_i2c_init() in this case.

Did you find the commit ID where this regression was introduceD?

/Jarkko
