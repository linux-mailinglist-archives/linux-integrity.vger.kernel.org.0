Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403221FD58F
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jun 2020 21:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgFQTwP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jun 2020 15:52:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59190 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726597AbgFQTwO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jun 2020 15:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592423532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bd/UhXF5PAw+f2+fDN6TaGxb76Zt213SNjoeRalON8Y=;
        b=V/jfxdBeIlAwCiJYnFtUP021Zt0LUVGp0o+IqDMds2MKQlGQ4seys6rcDQ8FLGg5o7UT0n
        kCMLBBBC0JMNr74Rpe7l00u4R4vx6oaH2ogYpgQO9CJdoYHYJpQ36B2xpYMB9ZXnxoQV8d
        gopClFBG4t6HDHEz0wA1RnAz4P+67Z8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-brOrSKgoP_u90wN5XWqslw-1; Wed, 17 Jun 2020 15:52:08 -0400
X-MC-Unique: brOrSKgoP_u90wN5XWqslw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E668E8035CD;
        Wed, 17 Jun 2020 19:52:06 +0000 (UTC)
Received: from localhost (ovpn-116-72.gru2.redhat.com [10.97.116.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DAC119D9E;
        Wed, 17 Jun 2020 19:52:06 +0000 (UTC)
Date:   Wed, 17 Jun 2020 16:52:05 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Petr Cervinka <pcervinka@suse.com>,
        Cyril Hrubis <chrubis@suse.cz>,
        linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>
Subject: Re: [LTP v2 1/1] ima_tpm.sh: Fix for calculating boot aggregate
Message-ID: <20200617195205.GA40831@glitch>
References: <20200527071434.28574-1-pvorel@suse.cz>
 <1590601280.16219.1.camel@linux.ibm.com>
 <20200528140747.GA8401@dell5510>
 <1590679145.4457.39.camel@linux.ibm.com>
 <20200528160527.GA27243@dell5510>
 <20200615194134.GF129694@glitch>
 <20200615200121.GG129694@glitch>
 <1592347211.11061.250.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <1592347211.11061.250.camel@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2020 at 06:40:11PM -0400, Mimi Zohar wrote:
> On Mon, 2020-06-15 at 17:01 -0300, Bruno Meneguele wrote:
> > On Mon, Jun 15, 2020 at 04:41:34PM -0300, Bruno Meneguele wrote:
> > > On Thu, May 28, 2020 at 06:05:27PM +0200, Petr Vorel wrote:
>=20
> > > > > The boot_aggregate.trs and boot_aggregate.log files are being cre=
ated
> > > > > in the tests/ directory. =A0Is that directory read-only?
> > > > Yes, drwxr-xr-x. Testing on fresh clone and issue persists.
> > > >=20
> > >=20
> > > Yes, same thing here.. but didn't really check the reason for that. W=
ill
> > > take a time later to see what's happening.
>=20
> Cloning as root will cause that to happen.
>=20
> $ sudo git clone git://git.code.sf.net/p/linux-ima/ima-evm-utils --branch=
 next-testing
> Cloning into 'ima-evm-utils'...
> remote: Enumerating objects: 1154, done.
> remote: Counting objects: 100% (1154/1154), done.
> remote: Compressing objects: 100% (1052/1052), done.
> remote: Total 1154 (delta 736), reused 182 (delta 96)
> Receiving objects: 100% (1154/1154), 335.12 KiB | 0 bytes/s, done.
> Resolving deltas: 100% (736/736), done.
> Checking connectivity... done.
>=20
> $ ls -lat ima-evm-utils/ | grep tests
> drwxr-xr-x.  2 root root   220 Jun 16 18:28 tests
>=20
> Mimi
>=20

Yes, indeed. But what really happened with both I and Petr was trying to
run the test copying and pasting what you've sent:

$ VERBOSE=3D1 make check TESTS=3Dboog_aggregate.test

the typo in "boog" (vs "boot") was the cause. So I think we can ignore
this issue here :).

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl7qdGUACgkQYdRkFR+R
okOslwgAyxmw5vJJroe8Iyxb/U9Xs3a5FsoQUorNAqNNaxJaGYyA7uS+QD4FiWzn
4ZYAj32AFJcr5YdMQ7zhqxoLaere280klcxb8rLjdAvH9Z6N3hnwHdgvzM2DQbGB
VMwGKSa+WQT/fIJJNCc+qXs3kB9NGRpqTyfMNn2DiQqtUZCp+vn+KwknY/xa+cVR
oriVaBGWWNtrBTPQCD/D9L6l0aJOEsHByQl5hrGHGgG27pfoqYul5ChWBk/SIKBL
TsSlOb16EKsElBP4j/GyHHRz1ZByj66KgzCXwSMaAQXjWFLyVVgP7V52EXD31Vgp
YbCl9R8PFXDqsmXmyN5AjBOfygr6Gw==
=t10N
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--

