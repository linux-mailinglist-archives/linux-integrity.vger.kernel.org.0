Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49DF9111CCD
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Dec 2019 23:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbfLCWrj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Dec 2019 17:47:39 -0500
Received: from mail.rosalinux.ru ([195.19.76.54]:36134 "EHLO mail.rosalinux.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728910AbfLCWrf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Dec 2019 17:47:35 -0500
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Dec 2019 17:47:34 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id A954ED505A982;
        Wed,  4 Dec 2019 01:41:32 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id KfbY5ihBT_x5; Wed,  4 Dec 2019 01:41:32 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id EBC85D47BB998;
        Wed,  4 Dec 2019 01:41:31 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru EBC85D47BB998
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
        s=A1AAD92A-9767-11E6-A27F-AC75C9F78EF4; t=1575412892;
        bh=AM3gmah5YTXbwngjs5wa16BFX4Q+UrwLS4Z/5wT42SU=;
        h=To:From:Message-ID:Date:MIME-Version;
        b=FoAKeCwPUy0gGzs68pyihosu/8XNCPLnykY+XmueVJhOxeI1/8OBHwEDK0oVJ2O8V
         a300MxsYpymB0ABZVfVKNXcVToqafxf5hCQ4pNCsvpWz9F25jyDM8oQLD5IsUarVDd
         iBRX0/r3UmGUIVSD6oD52DdyD6jm7vuXYbt3s2LiLsNvGJs6naRytzkFlEqRtaU8Vg
         2VOCHvLpPYem640tzgnUIeDUbZcPhgt3qSUMbKvZRUEneBKfdgo6KaFIWE0MMVu4E8
         eTNm8eFHZQOhCfflWnExUpMPktlhKh66dSfo0iCrgku733L3GbAXgGQNVuWULYAEkN
         0ukgldlnMECCQ==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GUpLsFdyLnpc; Wed,  4 Dec 2019 01:41:31 +0300 (MSK)
Received: from [192.168.1.173] (broadband-90-154-70-11.ip.moscow.rt.ru [90.154.70.11])
        by mail.rosalinux.ru (Postfix) with ESMTPSA id B2ADBD3C4649E;
        Wed,  4 Dec 2019 01:41:31 +0300 (MSK)
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
From:   Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
Subject: [PATCH] ima-evm-utils: Fix compatibility with LibreSSL
Message-ID: <85a96cad-dc04-a617-abfa-fb9427412e52@rosalinux.ru>
Date:   Wed, 4 Dec 2019 01:41:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: ru-RU
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From 4ae52f3cfb459c59e2e48f0d30c20c3763c8a0e7 Mon Sep 17 00:00:00 2001
From: Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
Date: Wed, 4 Dec 2019 01:07:50 +0300
Subject: [PATCH] ima-evm-utils: Fix compatibility with LibreSSL

LibreSSL in most cases can be used as a drop-in replacement of OpenSSL.
Commit 07d799cb6c37 "ima-evm-utils: Preload OpenSSL engine via '--engine'=
 option"
added OpenSSL-specific functions: "engines" were removed from LibreSSL lo=
ng ago.
Instead of requiring to attach GOST support via an external library ("eng=
ine"),
LibreSSL has build-in implementation of GOST.

Commit ebbfc41ad6ba "ima-evm-utils: try to load digest by its alias" is a=
lso not OK
for LibreSSL because LibreSSL uses different digest names:
md_gost12_256 -> streebog256
md_gost12_512 -> streebog512

Example how it works when linked with LibreSSL:
$ libressl dgst -streebog256 testfile
streebog256(a)=3D 04123f539a213e97c802cc229d474c6aa32a825a360b2a933a949fd=
925208d9ce1bb
$ evmctl -v ima_hash -a streebog256 testfile
hash(streebog256): 04123f539a213e97c802cc229d474c6aa32a825a360b2a933a949f=
d925208d9ce1bb
$ evmctl -v ima_hash -a md_gost12_256 testfile
EVP_get_digestbyname(md_gost12_256) failed

TODO: it would be nice to map
md_gost12_256 <-> streebog256
md_gost12_512 <-> streebog512
in evmctl CLI arguements to make the same commands work on systems both
where evmctl is linked with LibreSSL and with OpenSSL.

Fixes: 07d799cb6c37 ("ima-evm-utils: Preload OpenSSL engine via '--engine=
' option")
Fixes: ebbfc41ad6ba ("ima-evm-utils: try to load digest by its alias")
Signed-off-by: Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
---
=C2=A0README=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 2 +-
=C2=A0src/evmctl.c=C2=A0=C2=A0=C2=A0 | 15 ++++++++++++++-
=C2=A0src/libimaevm.c |=C2=A0 2 ++
=C2=A03 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 3603ae8..f843bbe 100644
--- a/README
+++ b/README
@@ -58,7 +58,7 @@ OPTIONS
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --smack=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 use extra SMACK xattrs for EVM
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --m32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 force EVM hmac/signature for 32 bit target system
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --m64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 force EVM hmac/signature for 64 bit target system
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --engine e=C2=A0=C2=A0=C2=A0=C2=A0 preloa=
d OpenSSL engine e (such as: gost)
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --engine e=C2=A0=C2=A0=C2=A0=C2=A0 preloa=
d OpenSSL engine e (such as: gost) (not valid for LibreSSL)
=C2=A0=C2=A0 -v=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 increase verbosity level
=C2=A0=C2=A0 -h, --help=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=
isplay this help and exit
=C2=A0
diff --git a/src/evmctl.c b/src/evmctl.c
index 3d2a10b..f6507c1 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -62,7 +62,10 @@
=C2=A0#include <openssl/hmac.h>
=C2=A0#include <openssl/err.h>
=C2=A0#include <openssl/rsa.h>
+/* LibreSSL removed engines */
+#ifndef LIBRESSL_VERSION_NUMBER
=C2=A0#include <openssl/engine.h>
+#endif
=C2=A0
=C2=A0#ifndef XATTR_APPAARMOR_SUFFIX
=C2=A0#define XATTR_APPARMOR_SUFFIX "apparmor"
@@ -1849,7 +1852,9 @@ static void usage(void)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 --selinux=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use custom Selinux label f=
or EVM\n"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 --caps=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use custom =
Capabilities for EVM(unspecified: from FS, empty: do not use)\n"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 --list=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 measurement=
 list verification\n"
+#ifndef LIBRESSL_VERSION_NUMBER /* LibreSSL removed engines */
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 --engine e=C2=A0=C2=A0=C2=A0=C2=A0 preload OpenSSL engine e (such =
as: gost)\n"
+#endif
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0 -v=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 increase verbosity level\n"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0 -h, --help=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 display this help and exit\n"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "\n");
@@ -1902,7 +1907,9 @@ static struct option opts[] =3D {
=C2=A0=C2=A0=C2=A0=C2=A0 {"selinux", 1, 0, 136},
=C2=A0=C2=A0=C2=A0=C2=A0 {"caps", 2, 0, 137},
=C2=A0=C2=A0=C2=A0=C2=A0 {"list", 0, 0, 138},
+#ifndef LIBRESSL_VERSION_NUMBER
=C2=A0=C2=A0=C2=A0=C2=A0 {"engine", 1, 0, 139},
+#endif
=C2=A0=C2=A0=C2=A0=C2=A0 {"xattr-user", 0, 0, 140},
=C2=A0=C2=A0=C2=A0=C2=A0 {}
=C2=A0
@@ -1947,7 +1954,9 @@ static char *get_password(void)
=C2=A0int main(int argc, char *argv[])
=C2=A0{
=C2=A0=C2=A0=C2=A0=C2=A0 int err =3D 0, c, lind;
+#ifndef LIBRESSL_VERSION_NUMBER
=C2=A0=C2=A0=C2=A0=C2=A0 ENGINE *eng =3D NULL;
+#endif
=C2=A0
=C2=A0#if !(OPENSSL_VERSION_NUMBER < 0x10100000)
=C2=A0=C2=A0=C2=A0=C2=A0 OPENSSL_init_crypto(
@@ -2065,7 +2074,8 @@ int main(int argc, char *argv[])
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 138:
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
measurement_list =3D 1;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
break;
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 139: /* --engine e */
+#ifndef LIBRESSL_VERSION_NUMBER
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 139: /* --engine e, only=
 in OpenSSL, not in LibreSSL */
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
eng =3D ENGINE_by_id(optarg);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (!eng) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 log_err("engine %s isn't available\n", optarg);
@@ -2078,6 +2088,7 @@ int main(int argc, char *argv[])
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
}
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
ENGINE_set_default(eng, ENGINE_METHOD_ALL);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
break;
+#endif
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 140: /* --xattr-use=
r */
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
xattr_ima =3D "user.ima";
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
xattr_evm =3D "user.evm";
@@ -2108,6 +2119,7 @@ int main(int argc, char *argv[])
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
=C2=A0=C2=A0=C2=A0=C2=A0 }
=C2=A0
+#ifndef LIBRESSL_VERSION_NUMBER
=C2=A0=C2=A0=C2=A0=C2=A0 if (eng) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ENGINE_finish(eng);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ENGINE_free(eng);
@@ -2115,6 +2127,7 @@ int main(int argc, char *argv[])
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ENGINE_cleanup();
=C2=A0#endif
=C2=A0=C2=A0=C2=A0=C2=A0 }
+#endif
=C2=A0=C2=A0=C2=A0=C2=A0 ERR_free_strings();
=C2=A0=C2=A0=C2=A0=C2=A0 EVP_cleanup();
=C2=A0=C2=A0=C2=A0=C2=A0 BIO_free(NULL);
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 7c17bf4..050ea78 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -71,8 +71,10 @@ static const char *const pkey_hash_algo[PKEY_HASH__LAS=
T] =3D {
=C2=A0=C2=A0=C2=A0=C2=A0 [PKEY_HASH_SHA384]=C2=A0=C2=A0=C2=A0 =3D "sha384=
",
=C2=A0=C2=A0=C2=A0=C2=A0 [PKEY_HASH_SHA512]=C2=A0=C2=A0=C2=A0 =3D "sha512=
",
=C2=A0=C2=A0=C2=A0=C2=A0 [PKEY_HASH_SHA224]=C2=A0=C2=A0=C2=A0 =3D "sha224=
",
+#ifndef LIBRESSL_VERSION_NUMBER
=C2=A0=C2=A0=C2=A0=C2=A0 [PKEY_HASH_STREEBOG_256] =3D "md_gost12_256",
=C2=A0=C2=A0=C2=A0=C2=A0 [PKEY_HASH_STREEBOG_512] =3D "md_gost12_512",
+#endif
=C2=A0};
=C2=A0
=C2=A0/* Names that are primary for the kernel. */
--=20
2.20.1

P.S. Patch is against commit 3eab1f93 "ima-evm-utils: Release version 1.2=
.1", I did not find newer git.

