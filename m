Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5EE9309765
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Jan 2021 18:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhA3RyZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 30 Jan 2021 12:54:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:60026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230045AbhA3RyZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 30 Jan 2021 12:54:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E9DA64E05;
        Sat, 30 Jan 2021 17:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612029224;
        bh=iRRM+HJpYQMwLzUB8+x+chQVrDmWtErSPyj328qlQt8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BPtuCB0kGYgXTfr7fp8pOyyts9TaDlbdU312RhLoUvUdE6Pu81uKg4jTEtMsasgA4
         PZ3/lT3SuRauIjPP1L4n/rFLtWj+ly/KFBVv1OQ9hYpUIBZkcVCFT1mUIIJpdYQKVq
         hyGZfrelmDFw5GO3FCNa3CAqZfKD4NVue4o+X2ePuyI+L1DHRkhT6dR5Ayt7cnoWK4
         kEYwk9el/PvvM/gWK+Qx6Lvr7IORRILr/9/RxTUlxKegG+DNEy5RMbfu9RGtrYvc25
         hidevukhux/GkTtM2flJSycKJ6pfpTQdIdUW7PZfRoPOfa2DF4OlRGIYQvfhKHXQdI
         VFLx/ptfAJkSg==
Message-ID: <6dc99fd9ffbc5f405c5f64d0802d1399fc6428e4.camel@kernel.org>
Subject: Re: Migration to trusted keys: sealing user-provided key?
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, kernel@pengutronix.de,
        jlu@pengutronix.de
Date:   Sat, 30 Jan 2021 19:53:39 +0200
In-Reply-To: <74830d4f-5a76-8ba8-aad0-0d79f7c01af9@pengutronix.de>
References: <74830d4f-5a76-8ba8-aad0-0d79f7c01af9@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.38.3 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-01-28 at 18:31 +0100, Ahmad Fatoum wrote:
> Hello,
>=20
> I've been looking into how a migration to using trusted/encrypted keys
> would look like (particularly with dm-crypt).
>=20
> Currently, it seems the the only way is to re-encrypt the partitions
> because trusted/encrypted keys always generate their payloads from
> RNG.
>=20
> If instead there was a key command to initialize a new trusted/encrypted
> key with a user provided value, users could use whatever mechanism they
> used beforehand to get a plaintext key and use that to initialize a new
> trusted/encrypted key. From there on, the key will be like any other
> trusted/encrypted key and not be disclosed again to userspace.
>=20
> What are your thoughts on this? Would an API like
>=20
> =C2=A0 keyctl add trusted dmcrypt-key 'set <content>' # user-supplied con=
tent
>=20
> be acceptable?

Maybe it's the lack of knowledge with dm-crypt, but why this would be
useful? Just want to understand the bottleneck, that's all.

> Cheers,
> Ahmad

/Jarkko=20
