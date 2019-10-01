Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E95FC34F0
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Oct 2019 14:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732272AbfJAM4C (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Oct 2019 08:56:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:38880 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731291AbfJAM4C (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Oct 2019 08:56:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 07CD2AC18
        for <linux-integrity@vger.kernel.org>; Tue,  1 Oct 2019 12:56:01 +0000 (UTC)
Date:   Tue, 1 Oct 2019 14:56:00 +0200
From:   Matthias Gerstner <mgerstner@suse.de>
To:     linux-integrity@vger.kernel.org
Subject: bluez: NULL pointer dereference in bluetooth-meshd
 org.bluez.mesh.Network1.Join
Message-ID: <20191001125600.GD9771@f195.suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

in the context of a review of the bluetooth-meshd D-Bus service [1] I
noticed a segmentation fault due to NULL pointer dereference. It can be
triggered in bluez version 5.51 via the following D-Bus call:

$ dbus-send --system --type=3Dmethod_call --print-reply \
  --dest=3Dorg.bluez.mesh /org/bluez/mesh org.bluez.mesh.Network1.Join \
  objpath:/org/gnome/DisplayManager \
  array:byte:1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16

After the D-Bus timeout the bluetooth-meshd will crash with the
following backtrace:

    node_init_cb (node=3D0x0, agent=3D0x0) at mesh/mesh.c:359
    359                     reply =3D dbus_error(join_pending->msg, MESH_ER=
ROR_FAILED,
    (gdb) bt
        user_data=3D0x5555555be170) at mesh/node.c:1760
        dbus=3D<optimized out>) at ell/dbus.c:216
        user_data=3D0x5555555a6e00) at ell/dbus.c:279
        user_data=3D0x5555555a7ef0) at ell/io.c:126
        at ell/main.c:642
        at mesh/main.c:205

The reason is probably that the `join_pending` data structure has
already been freed in a different function.

[1]: https://bugzilla.suse.com/show_bug.cgi?id=3D1151518

Cheers

Matthias

--=20
Matthias Gerstner <matthias.gerstner@suse.de>
Dipl.-Wirtsch.-Inf. (FH), Security Engineer
https://www.suse.com/security
Phone: +49 911 740 53 290
GPG Key ID: 0x14C405C971923553

SUSE Software Solutions Germany GmbH
HRB 247165, AG M=FCnchen
Gesch=E4ftsf=FChrer: Felix Imend=F6rffer

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE82oG1A8ab1eESZdjFMQFyXGSNVMFAl2TTOAACgkQFMQFyXGS
NVOBIhAAwGSejEqpFF5duyDyl5tfIVwI+BTUdCCtvWACyCVnflyNKx3o1gxuhgpC
xsTBwECY9+uqnOOg0wTAfI0YY9yEzhBkMQ9VGkGtfko0doWCi0I949EAO+XDMS0X
i289ijQqW4XzP9tB7ub3QpCx69Xts5vGAoy5D/eIbCWj70lDzkmhjMy5nssSIejL
5AO0H1JQPdjn+p2WZsXeU1C7iTt9IlHX4NnpgyEwOdXugS8PeUq8HgmPzB+g0MqI
bUTuObegkPkfPjPgAIKojAUArY0be6PVtKlXdfV9ddH8l7zhBHhG4F+Ig/mFDlgf
GFosMCF2pc16qpZ1hWKC+y5phtao3M9wKeZmUSzOas3jiaaxRvL2gR6SnO8MmQl5
XCvoBgOvhujdhK25MjVKBzkEMKCzvX6jalXETFjBPpmww9zxRiTSiuJm6yFOQVgv
iHGbs+qD5QzFXTN1r9jRkdVTsEccL5oQvvx1PBwgKcSS5FQ40Mk0x/jF1mg8nkK6
fWicnqScmFM+Iv1eOUeKHZaW/L8u64vG2/bifWQoYZlU5/hwSt9OCngbebp9XLgR
BL+00XKafEScvZMKVqeChPryIXCI1z7hbXqlUU5D60XnWbawZiw2/Drd8ot1vMxL
DJJ+zieB1h+K0ByoSnMcjfmEYibai+tDrRzydDp5ThE25u30Cqc=
=PpEm
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
