Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0401A29D294
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Oct 2020 22:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgJ1Vda (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Oct 2020 17:33:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24677 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725933AbgJ1VdM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Oct 2020 17:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603920790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BV09UFtgQqcVbF3UBVq1cKpCO5++n1kls3gye8c9cWY=;
        b=LjBIj9J+8+KV7zQ61eME8VXxOQk2o7Gg6V3rNKWxnKFrX7KJiEd7F8u7pu4dAv3WlicUUo
        cBRQ0kI+PZJXgOaGLqq7dzfeE1vLZ7V9/QqonBEZJZa0Mij7XEP5MsNlJSyZlp/SmnHaNQ
        6Gtoc2HAyRw9gw/W+5E5gku3AaIRErI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-yaAh-QeWN4yNacaBGbHOuA-1; Wed, 28 Oct 2020 17:17:21 -0400
X-MC-Unique: yaAh-QeWN4yNacaBGbHOuA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E32D101EBEA;
        Wed, 28 Oct 2020 21:17:20 +0000 (UTC)
Received: from localhost (ovpn-116-23.gru2.redhat.com [10.97.116.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B03F460BF1;
        Wed, 28 Oct 2020 21:17:19 +0000 (UTC)
Date:   Wed, 28 Oct 2020 18:17:18 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        Wartan Hachaturow <wart@debian.org>
Subject: Re: ima-evm-utils: version 1.3.2 released
Message-ID: <20201028211718.GD16738@glitch>
References: <a0c4d8b6e8523ab245feb43492bf7f209d558c0e.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <a0c4d8b6e8523ab245feb43492bf7f209d558c0e.camel@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bmeneg@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PHCdUe6m4AxPMzOu"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--PHCdUe6m4AxPMzOu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2020 at 02:21:22PM -0400, Mimi Zohar wrote:
> The ima-evm-utils v1.3.2 release adds docker based travis support for
> testing different distro releases.  Please refer to the NEWS file for a
> short summary and the git history for details.
>=20
> thanks,
>=20
> Mimi
>=20

It's now updated in Fedora Rawhide and requested for Fedora 33 (should
take a week or so to effectively land stable repo).

Thanks Mimi!

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--PHCdUe6m4AxPMzOu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl+Z394ACgkQYdRkFR+R
okP9LQgAv6R7JzErXY3m4OdjlQQnPW6Lm0giSHdut5pMMNSkQ0WmT2gC33m3DCHN
6g9ekQuX2UZItPzh3IynrJ8M7sA+oh8lXWIyGkQIBcMYrUb/8VGGFL8LMy7HaFZ6
Pn8ptmZYNihzX+b8NJhvnUUJL/bMvxlsdW7DgmCPUf6Qja6eZ5ZlabuvSUeO47j1
zjSSDOzU6DZb4y+5Xoc6Vp0rDLGhG8OnqPc71Tmyq3iza/ke2USIWqn+6IByTU8P
QHT516SRcuZEvOAyB4sKrsJ2hj/1k8dDN+aDkrFT5CFfFzR3v3QfLKPZu8zgOgar
CjUpUo/rnEWxcXLITKnVSGaodF/DSg==
=NsAi
-----END PGP SIGNATURE-----

--PHCdUe6m4AxPMzOu--

