Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F50040EBE1
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Sep 2021 22:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239722AbhIPUzd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Sep 2021 16:55:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20830 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233853AbhIPUzc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Sep 2021 16:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631825651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PSNtvF8iu8B2xMJOk4HIWzsuw5719K924p8/5PsMv4I=;
        b=b5Gy3F3WFP+FIA9E/PxLHoBb82fcQyVmm3t2SdDA5uZfT7PQngbhe68q6OduIf/nkECcqS
        fK5lim/PLt6bO1VvbA8Jq1VM+Ahj78LGoDMzs8TwBLtlPNxZCVHSh2rdQ2/LhqQF9l15ZV
        fbvcdocZ/3tPTc9jZHYsoMQIfdBcLCg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305--SIZQpxYO9yTXa0XqrziUg-1; Thu, 16 Sep 2021 16:54:07 -0400
X-MC-Unique: -SIZQpxYO9yTXa0XqrziUg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61DB6801E72;
        Thu, 16 Sep 2021 20:54:06 +0000 (UTC)
Received: from localhost (unknown [10.22.16.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8C335D9CA;
        Thu, 16 Sep 2021 20:54:05 +0000 (UTC)
Date:   Thu, 16 Sep 2021 17:54:04 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Simon.THOBY@viveris.fr, kgold@linux.ibm.com,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v7 ima-evm-utils 1/2] set default hash algorithm in
 configuration time
Message-ID: <YUOu7JjfFmi0OLAE@glitch>
References: <20210910184701.386163-1-bmeneg@redhat.com>
 <20210910184701.386163-2-bmeneg@redhat.com>
 <0a8960c73cd7836949e891ac8efdf516907669cb.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NBrbHmRnePpEbT0N"
Content-Disposition: inline
In-Reply-To: <0a8960c73cd7836949e891ac8efdf516907669cb.camel@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--NBrbHmRnePpEbT0N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 14, 2021 at 11:24:22AM -0400, Mimi Zohar wrote:
> On Fri, 2021-09-10 at 15:47 -0300, Bruno Meneguele wrote:
> > The default hash algorithm for evmctl is today hardcoded in the libimae=
vm.c
> > file. To facilitate package maintainers across different distributions =
to
> > set their own default hash algorithm this, patch adds the
> > --with-default-hash=3D<algo> option to the configuration script.
> >=20
> > The chosen algorithm will then be checked by its available in the kerne=
l,
> > otherwise IMA won't be able to verify files hashed by the user. For tha=
t,
> > the kernel header hash_info.h used as the source of supported hashes. In
> > case the hash_info.h header is not present, the configuration script wa=
rns
> > about it, but uses whatever the user specified in the option.
> >=20
> > Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
>=20
> Thanks, Bruno.  This patch set is now queued in the next-testing
> branch.
>=20
> Mimi
>=20

Thanks Mimi.

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--NBrbHmRnePpEbT0N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAmFDruwACgkQYdRkFR+R
okPIvQf+JcEe+DUjrzTNCmNTUZf7wDhMupb5RouEnxhAjwsATv/lD3fa+HykBbTv
z4ydxlm1tlufRacoKj5ciTe0buk0Xp3kDvzYfgo2lkmIauGK40DgN9ZEppysJIw2
1NjpBgwoSuADzTodj7mIe+XMHPPMPEP2HovDQHWOXDDa2JKClwOs6yHusaL88K0t
UR0bdUAMq3DvREmCtpRwXYshBKszTgqJQOFhYGbeSxkiby+0X6nExGqKF//RYvEI
K/s4+XOR3SU12AV1qZOCRDTil6FJLwEQqsO8XZvjY0g/k+W3zPdcZWUpDMjdXqci
3+sdW0wW+EtGLgmXii5d9LL3V1tlGQ==
=x4b9
-----END PGP SIGNATURE-----

--NBrbHmRnePpEbT0N--

