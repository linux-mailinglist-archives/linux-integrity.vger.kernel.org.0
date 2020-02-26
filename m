Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 716CF16FB50
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Feb 2020 10:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgBZJvx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Feb 2020 04:51:53 -0500
Received: from mail.rosalinux.ru ([195.19.76.54]:59352 "EHLO mail.rosalinux.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgBZJvx (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Feb 2020 04:51:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id 73CADD54B071E;
        Wed, 26 Feb 2020 12:51:49 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qjE7aMT_3kkK; Wed, 26 Feb 2020 12:51:34 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id 15090D54B0713;
        Wed, 26 Feb 2020 12:51:34 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 15090D54B0713
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
        s=A1AAD92A-9767-11E6-A27F-AC75C9F78EF4; t=1582710694;
        bh=tq2x11ZCwB8BaUhf3qnS8GeRWynl/Kh2mm2TyF/f4AY=;
        h=To:From:Message-ID:Date:MIME-Version;
        b=Ue3F0JYx/2cTHR1m0RGX+K53V74ZYesj+jFkrWjpEBeT9wjm9mcSofKlJcLFbv5tV
         b/TmSEHHpGRJXDyRKYsnHtOpW3voUzKhwn7VhfQu2chAyagxFznQPMnMB1z91+R8eZ
         Y++WFZw1zngrX+OuruLgLBXEYurWFH35MW6lFud15WcUGEZgVsj4NdEAl2EUJ6ti1L
         f9AaMnOMLuCU3M5OWHB24xC4TupJMUsmyQEuYFtV1CoorBnLNyVw6ijyHQVqeGKOIa
         aK4yIyGTwvbSm6eso3WTj1IWkrGTmdSyrTVSx3rJoYS6UIfH10okiyFoc163nGHKAa
         JRhly4cGOvMuA==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8VyMeXTgARMF; Wed, 26 Feb 2020 12:51:34 +0300 (MSK)
Received: from [192.168.1.173] (broadband-90-154-70-246.ip.moscow.rt.ru [90.154.70.246])
        by mail.rosalinux.ru (Postfix) with ESMTPSA id DF9FCD54B0710;
        Wed, 26 Feb 2020 12:51:33 +0300 (MSK)
Subject: Re: [PATCH] ima-evm-utils: Fix compatibility with LibreSSL
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <63ba8482-0085-f2d3-dbb9-70bb81990f07@rosalinux.ru>
 <1582638298.10443.196.camel@linux.ibm.com>
From:   Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
Message-ID: <fac0bebb-22ce-77f9-bac9-7ca5f76d1ca1@rosalinux.ru>
Date:   Wed, 26 Feb 2020 12:51:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1582638298.10443.196.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: ru-RU
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Mimi, thanks for feedback.
25.02.2020 16:44, Mimi Zohar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Sun, 2020-02-16 at 14:10 +0300, Mikhail Novosyolov wrote:
>> LibreSSL in most cases can be used as a drop-in replacement of OpenSSL=
.
>> Commit 07d799cb6c37 "ima-evm-utils: Preload OpenSSL engine via '--engi=
ne' option"
>> added OpenSSL-specific functions: "engines" were removed from LibreSSL=
 long ago.
>> Instead of requiring to attach GOST support via an external library ("=
engine"),
>> LibreSSL has build-in implementation of GOST.
>
> OpenSSL had a builtin support for GOST, which was dropped.=C2=A0 From t=
he
> OpenSSL news "Changes between 1.0.2h and 1.1.0":
>
>=C2=A0=C2=A0=C2=A0=C2=A0 The GOST engine was out of date and therefore i=
t has been removed. An up
>=C2=A0=C2=A0=C2=A0=C2=A0 to date GOST engine is now being maintained in =
an external repository.
>=C2=A0=C2=A0=C2=A0=C2=A0 See:=C2=A0=C2=A0=C2=A0=C2=A0 https://wiki.opens=
sl.org/index.php/Binaries=C2=A0=C2=A0=C2=A0 .=C2=A0 Libssl still retains
>=C2=A0=C2=A0=C2=A0=C2=A0 support for GOST ciphersuites (these are only a=
ctivated if a GOST engine
>=C2=A0=C2=A0=C2=A0=C2=A0 is present).
>
> Please update the patch description to reflect the reason for OpenSSL
> dropping GOST builtin support, while LibreSSL continues to build it
> in.
The reasons why OpenSSL decided to do it are out of my scope, I can just =
write that OpenSSL had GOST, then dropped it, then gost-engine appeared a=
s an OpenSSL plugin and that LibreSSL has GOST built in and dropped engin=
es API after forking from OpenSSL. Will it be OK?
>
>> Commit ebbfc41ad6ba "ima-evm-utils: try to load digest by its alias" i=
s also not OK
>> for LibreSSL because LibreSSL uses different digest names:
>> md_gost12_256 -> streebog256
>> md_gost12_512 -> streebog512
>>
>> Example how it works when linked with LibreSSL:
>> $ libressl dgst -streebog256 testfile
>> streebog256(a)=3D 04123f539a213e97c802cc229d474c6aa32a825a360b2a933a94=
9fd925208d9ce1bb
>> $ evmctl -v ima_hash -a streebog256 testfile
>> hash(streebog256): 04123f539a213e97c802cc229d474c6aa32a825a360b2a933a9=
49fd925208d9ce1bb
>> $ evmctl -v ima_hash -a md_gost12_256 testfile
>> EVP_get_digestbyname(md_gost12_256) failed
>
> Removing "engine support" is one logical change.=C2=A0 This sounds like=
 it
> is a separate issue and should be addressed in its own patch.
LibreSSL removed engine API completely, but seems to keep the API to cont=
inue working as a drop in replacement of OpenSSL. There are no engines in=
 LibreSSL, printing information about them in --help and trying to load t=
hem does not make sense and will confuse users. The main purpose of this =
patch is not to fix=C2=A0 _buildability_ with LibreSSL, but to fix logica=
l mistakes which appear when using LibreSSL.
>>
>> TODO: it would be nice to map
>> md_gost12_256 <-> streebog256
>> md_gost12_512 <-> streebog512
>> in evmctl CLI arguements to make the same commands work on systems bot=
h
>> where evmctl is linked with LibreSSL and with OpenSSL.
>>
>> Fixes: 07d799cb6c37 ("ima-evm-utils: Preload OpenSSL engine via '--eng=
ine' option")
>> Fixes: ebbfc41ad6ba ("ima-evm-utils: try to load digest by its alias")
>> Signed-off-by: Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
>> ---
>>=C2=A0 README=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 2 +-
>>=C2=A0 src/evmctl.c=C2=A0=C2=A0=C2=A0 | 15 ++++++++++++++-
>>=C2=A0 src/libimaevm.c |=C2=A0 2 ++
>>=C2=A0 3 files changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/README b/README
>> index 3603ae8..f843bbe 100644
>> --- a/README
>> +++ b/README
>> @@ -58,7 +58,7 @@ OPTIONS
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --smack=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 use extra SMACK xattrs for EVM
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --m32=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 force EVM hmac/signature for 32 bit target=
 system
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --m64=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 force EVM hmac/signature for 64 bit target=
 system
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --engine e=C2=A0=C2=A0=C2=A0=C2=A0 pre=
load OpenSSL engine e (such as: gost)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --engine e=C2=A0=C2=A0=C2=A0=C2=A0 pre=
load OpenSSL engine e (such as: gost) (not valid for LibreSSL)
>>=C2=A0=C2=A0=C2=A0 -v=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 increase verbosity level
>>=C2=A0=C2=A0=C2=A0 -h, --help=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 display this help and exit
>> =C2=A0
>> diff --git a/src/evmctl.c b/src/evmctl.c
>> index 3d2a10b..f6507c1 100644
>> --- a/src/evmctl.c
>> +++ b/src/evmctl.c
>> @@ -62,7 +62,10 @@
>>=C2=A0 #include <openssl/hmac.h>
>>=C2=A0 #include <openssl/err.h>
>>=C2=A0 #include <openssl/rsa.h>
>> +/* LibreSSL removed engines */
>> +#ifndef LIBRESSL_VERSION_NUMBER
>>=C2=A0 #include <openssl/engine.h>
>> +#endif
>
> According to the LibreSSL wiki, both OpenSSL and LibreSSL may be
> installed on the same system in separate directories.=C2=A0 Instead of
> using LIBRESSL_VERSION_NUMBER, consider defining an autotools option.

LibreSSL can be used either as a drop in replacement of OpenSSL or can be=
 installed to a separate prefix.

What do you suggest to do with an autotools option? To define a prefix wh=
ere libssl/libcrypto is, e.g. /usr or /opt/libressl? It may be useful. Bu=
t, in my experience of building curl and other programs with LibreSSL fro=
m a custom prefix, any heaurestics in configure.ac cause much more troubl=
es than profit, I had to hack curl's configure.ac to stop it from picking=
 OpenSSL.

Right now the only line which detect libcrypto is "PKG_CHECK_MODULES(LIBC=
RYPTO, [libcrypto >=3D 0.9.8 ])". If we make an autotools option, we will=
 have to somehow handle situation when headers and/or pkgconfig files are=
 not in the prefix, like curl does (https://github.com/curl/curl/blob/mas=
ter/configure.ac#L1642). Let's avoid such a bicycle. I had to hack it to =
build curl with libressl, and many people on the Internet complain that i=
t works incorrectly in case of cross-compilation. The same problems will =
occure in ima-evm-utils.

Right now I build ima-evm-utils like this:
export LIBCRYPTO_CFLAGS=3D"$(pkg-config --cflags-only-I --libs-only-L lib=
ressl-libcrypto)"
...where libressl-libcrypto is a not upstream name of the *.pc file, I re=
named it from libcrypto.pc to libressl-libcrypto.pc. It works perfectly. =
There is no need in inventing a bicycle in configure.ac, I am pretty sure=
.

LIBRESSL_VERSION_NUMBER is defined in LibreSSL only and so to my mind is =
a good method of build-time detection of which library is being used. Man=
y software uses it, see https://codesearch.debian.net/search?q=3DLIBRESSL=
_VERSION_NUMBER&literal=3D1

Even if we make an autotools option which sets a prefix for Open/LibreSSL=
, I think it is better to continue using LIBRESSL_VERSION_NUMBER in #ifde=
f's because otherwise there will be a lot of confusion when ima-evm-utils=
 is built against a custom ssl library in a custom prefix but when the bu=
ilder does not manually define that it is libressl.

If I misunderstood your idea about an autotools option, please correct me=
.
> thanks,
>
> Mimi
>
>> =C2=A0
>>=C2=A0 #ifndef XATTR_APPAARMOR_SUFFIX
>>=C2=A0 #define XATTR_APPARMOR_SUFFIX "apparmor"
>> @@ -1849,7 +1852,9 @@ static void usage(void)
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 --selinux=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use custom Selinu=
x label for EVM\n"
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 --caps=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 us=
e custom Capabilities for EVM(unspecified: from FS, empty: do not use)\n"
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 --list=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 me=
asurement list verification\n"
>> +#ifndef LIBRESSL_VERSION_NUMBER /* LibreSSL removed engines */
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 --engine e=C2=A0=C2=A0=C2=A0=C2=A0 preload OpenSSL engine=
 e (such as: gost)\n"
>> +#endif
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0 -v=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 increase verbosity level\n"
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0 -h, --he=
lp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 display this help and =
exit\n"
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "\n");
>> @@ -1902,7 +1907,9 @@ static struct option opts[] =3D {
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {"selinux", 1, 0, 136},
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {"caps", 2, 0, 137},
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {"list", 0, 0, 138},
>> +#ifndef LIBRESSL_VERSION_NUMBER
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {"engine", 1, 0, 139},
>> +#endif
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {"xattr-user", 0, 0, 140},
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {}
>> =C2=A0
>> @@ -1947,7 +1954,9 @@ static char *get_password(void)
>>=C2=A0 int main(int argc, char *argv[])
>>=C2=A0 {
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err =3D 0, c, lind;
>> +#ifndef LIBRESSL_VERSION_NUMBER
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ENGINE *eng =3D NULL;
>> +#endif
>> =C2=A0
>>=C2=A0 #if !(OPENSSL_VERSION_NUMBER < 0x10100000)
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OPENSSL_init_crypto(
>> @@ -2065,7 +2074,8 @@ int main(int argc, char *argv[])
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 138:
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 measurement_list =3D 1;
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 break;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 139: /* --engine e */
>> +#ifndef LIBRESSL_VERSION_NUMBER
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 139: /* --engine e, o=
nly in OpenSSL, not in LibreSSL */
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 eng =3D ENGINE_by_id(optarg);
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (!eng) {
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_err("engine %s isn't available\n", opt=
arg);
>> @@ -2078,6 +2088,7 @@ int main(int argc, char *argv[])
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ENGINE_set_default(eng, ENGINE_METHOD_ALL);
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 break;
>> +#endif
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 140: /* --x=
attr-user */
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 xattr_ima =3D "user.ima";
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 xattr_evm =3D "user.evm";
>> @@ -2108,6 +2119,7 @@ int main(int argc, char *argv[])
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0
>> +#ifndef LIBRESSL_VERSION_NUMBER
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (eng) {
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ENGINE_finish(en=
g);
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ENGINE_free(eng)=
;
>> @@ -2115,6 +2127,7 @@ int main(int argc, char *argv[])
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ENGINE_cleanup()=
;
>>=C2=A0 #endif
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +#endif
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ERR_free_strings();
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EVP_cleanup();
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIO_free(NULL);
>> diff --git a/src/libimaevm.c b/src/libimaevm.c
>> index 7c17bf4..050ea78 100644
>> --- a/src/libimaevm.c
>> +++ b/src/libimaevm.c
>> @@ -71,8 +71,10 @@ static const char *const pkey_hash_algo[PKEY_HASH__=
LAST] =3D {
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [PKEY_HASH_SHA384]=C2=A0=C2=A0=C2=A0 =3D=
 "sha384",
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [PKEY_HASH_SHA512]=C2=A0=C2=A0=C2=A0 =3D=
 "sha512",
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [PKEY_HASH_SHA224]=C2=A0=C2=A0=C2=A0 =3D=
 "sha224",
>> +#ifndef LIBRESSL_VERSION_NUMBER
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [PKEY_HASH_STREEBOG_256] =3D "md_gost12_=
256",
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [PKEY_HASH_STREEBOG_512] =3D "md_gost12_=
512",
>> +#endif
>>=C2=A0 };
>> =C2=A0
>>=C2=A0 /* Names that are primary for the kernel. */
>

