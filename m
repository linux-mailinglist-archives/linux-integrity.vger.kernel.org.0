Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682422D9CFF
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Dec 2020 17:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440230AbgLNQzd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Dec 2020 11:55:33 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:41066 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729493AbgLNQzd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Dec 2020 11:55:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DEE47128098D;
        Mon, 14 Dec 2020 08:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1607964892;
        bh=UHUbxU8MjLcolafOQDhasLysUHkdYUG7xy2k16O+1GY=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=IUYAI0PlYVLiS73KVZZk1m6bdkXkr7KN9YDFdABNmq/ehJl7I48hhE6x7snZBqHQj
         Ys30nvM/s2v5usbAJuI3IfN/H9QBwq7ZQLPXUlvvOJR2gUNGy3KBmGSIuEdEn8TMMB
         1m8gQuwCSwtYVXeZ88OF97M+S7Qk4F2AC/f3oRPU=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EGkgHWQ1zIzl; Mon, 14 Dec 2020 08:54:52 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 51C9F128098B;
        Mon, 14 Dec 2020 08:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1607964892;
        bh=UHUbxU8MjLcolafOQDhasLysUHkdYUG7xy2k16O+1GY=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=IUYAI0PlYVLiS73KVZZk1m6bdkXkr7KN9YDFdABNmq/ehJl7I48hhE6x7snZBqHQj
         Ys30nvM/s2v5usbAJuI3IfN/H9QBwq7ZQLPXUlvvOJR2gUNGy3KBmGSIuEdEn8TMMB
         1m8gQuwCSwtYVXeZ88OF97M+S7Qk4F2AC/f3oRPU=
Message-ID: <80f02e5b510d6d11bf8e85be79a6db923c9037d1.camel@HansenPartnership.com>
Subject: Re: [PATCH v2] tpm: ignore failed selftest in probe
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@iki.fi>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        enric.balletbo@collabora.com, kernel@collabora.com,
        dafna3@gmail.com, Andrey Pronin <apronin@chromium.org>
Date:   Mon, 14 Dec 2020 08:54:51 -0800
In-Reply-To: <eea2618c-f22c-1e68-7502-dcbc2ae7c494@collabora.com>
References: <20201207135710.17321-1-dafna.hirschfeld@collabora.com>
         <20201208173451.GA57585@kapsi.fi>
         <ca37d350-d79c-41ad-f221-55d8851437bc@collabora.com>
         <20201211175745.GA34718@kernel.org>
         <eea2618c-f22c-1e68-7502-dcbc2ae7c494@collabora.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-12-14 at 10:50 +0100, Dafna Hirschfeld wrote:
> Am 11.12.20 um 18:57 schrieb Jarkko Sakkinen:
[...]
> > But how does this patch deal with TPM2?
> 
> It doesn't, I was not sure if there is need to keep consistent
> behavior between 1.2 and 2. I can send next version with the same
> behavior for TPM 2.

This comes up a lot, so let me give my view that this really has to be
our requirement going forward.  TPM 1.2 is pretty much a dead device
and, thanks to being sha1 only, it's definitely not used to provide
security in any serious devices anymore.  So effectively any patch
which is TPM 1.2 only is either because there's a problem in a legacy
system which was fixed in 2.0 or because for some reason the patch
producer is working on a legacy system, but it also needs to be
provided for TPM 2.0.

On this patch, I've got a TPM 2.0 which I can trigger into failure mode
on demand (just not get it back again without a power cycle).  Since it
does correctly respond TPM_RC_FAILURE to every command, it could be
attached with no command restriction.  The problem is that TPM 2 is an
agile device so we need to probe some of its characteristics on attach,
which we can't if it's in a failed state.  So if we're going to attach
a failed TPM 2, we're going to have to make assumptions about the
probed values.  What do we use as the assumptions for things like
number of PCRS (24 woud be reasonable) and hashes and banks (sha1 and
sha256), attribute table?  The problem here is we only probe this at
attach, so if the TPM somehow unfails, all of the assumptions are
likely to be wrong and we're going to get issues ... this last bit
argues that we should restrict the command list to make sure we don't
send it a command with incorrect assumptions.

James



