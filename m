Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED409140979
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jan 2020 13:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgAQMHk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Jan 2020 07:07:40 -0500
Received: from mickerik.phytec.de ([195.145.39.210]:53582 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgAQMHk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Jan 2020 07:07:40 -0500
X-Greylist: delayed 911 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Jan 2020 07:07:39 EST
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1579261947; x=1581853947;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RcmzTB1s7Z1SPOcbINkI+pkvC+2emm42UmMi6wVFUzE=;
        b=ZFJ9mD+TMetDavQUGoZuCJ8b2BgDDeLgXITFQQORmkQqE5bvvCIZaE8iq77vxnpd
        kjN/cLk/KZFuIKI3+STmrwJMDvjEa8OT1k2vvdf2EMRzdEQE1MaJCa6WiSqw+QRk
        EvB87O8NRQTJdjzu1TDzkQT/Ktt3Inn/pKNoDt9/4cg=;
X-AuditID: c39127d2-bf5ff70000002a58-6c-5e219ffbda5f
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 6C.8F.10840.BFF912E5; Fri, 17 Jan 2020 12:52:27 +0100 (CET)
Received: from [172.16.20.241] ([172.16.20.241])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2020011712522739-160140 ;
          Fri, 17 Jan 2020 12:52:27 +0100 
Subject: Re: [PATCH v2 1/2] security/keys/secure_key: Adds the secure key
 support based on CAAM.
To:     Udit Agarwal <udit.agarwal@nxp.com>, dhowells@redhat.com,
        zohar@linux.vnet.ibm.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        jarkko.sakkinen@linux.intel.com
Cc:     sahil.malhotra@nxp.com, ruchika.gupta@nxp.com,
        horia.geanta@nxp.com, aymen.sghaier@nxp.com
References: <20180723111432.26830-1-udit.agarwal@nxp.com>
From:   Maik Otto <m.otto@phytec.de>
Message-ID: <ae70f48b-be78-ffb8-8b36-0d278b2e19f6@phytec.de>
Date:   Fri, 17 Jan 2020 12:52:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20180723111432.26830-1-udit.agarwal@nxp.com>
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 17.01.2020 12:52:27,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 17.01.2020 12:52:27
X-TNEFEvaluated: 1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWyRoCBS/f3fMU4g7MrZCxaDy9lsnjX9JvF
        4sP5w0wW31e5WKxbv5jJYuudJjaLE+eOsVt86HnEZrHn4Cs2i7lHdjBanL9wjt1i6s3NjBaf
        VkxiduD1uLY70mPeyUCPB4c2s3j0fE/22PhuB5PH+31X2Tw+b5ILYI/isklJzcksSy3St0vg
        yui9u4e54Nklpor9+86xNjD+62HqYuTgkBAwkdj+2KWLkZNDSGAro8SiaYxdjFxA9hlGie65
        h9lAEsICSRLn/pxmA0mICPxjlPhy/jA7SIJZIE6ie/Y3JohuS4m9l2cyg9hsAkoSD+euBrN5
        BWwkNmxoZQSxWQRUJb4t6mcBsUUFEiXeNbyFqhGUODnzCVicU8BK4snDpWBXSAhcYZRY2NvP
        CpKQEBCSOL34LDPEYjOJeZsfQtnaEssWvmaewCg4C8msWUjKZiEpW8DIvIpRKDczOTu1KDNb
        ryCjsiQ1WS8ldRMjMIoOT1S/tIOxb47HIUYmDsZDjBIczEoivHd7FeOEeFMSK6tSi/Lji0pz
        UosPMUpzsCiJ827gLQkTEkhPLEnNTk0tSC2CyTJxcEo1MPL6BpxwXif0uuyH4fUHsqE+CUJn
        pHQCcpWsbP+cPqwitCrZ8patRMLjQ1VSu1Ztbfz96Vhf2IFmvrXJ7o+WPqxic1PQdZEXPfH2
        5VTF4qRpE/VWu23cPOnLZOP7c+q6P8TVdp9mm6Wh0cyyY6/nicU/tRq5HbJNbnFfmR0s9DfH
        O5rdVjh6rxJLcUaioRZzUXEiAKozaAmQAgAA
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi

I tested both patches in combination with
[RFC,2/2] dm-crypt: Use any key type which is registered from
https://patchwork.kernel.org/patch/10835633/  with bug fix
and=C2=A0 an i.MX6Quad (logged device) with Mainline Kernel 4.19.88

The following tests were successful:
- key generation with CAAM
keyctl add secure kmk-master "new 64" @s
- export and import key blob with same controller
keyctl pipe 332995568 > secure=5Fkey.blob
reboot device
keyctl add secure kmk-master "load `cat secure=5Fkey.blob`" @s
- import keyblob with an other cpu and same keys for secure boot
caam=5Fjr 2102000.jr1: caam op done err: 20000c1a
[ 185.788931] secure=5Fkey: key=5Fblob decap fail (-22)
add=5Fkey: Invalid argument
=3D> failing import was expected: pass
- use key from keyring in dmcrypt with an sd-card
dmsetup create test --table "0 106496 crypt aes-xts-plain64
:64:secure:kmk-master 0 /dev/mmcblk0p3 0"
write,read reboot and read again

Tested-by: Maik Otto<m.otto@phytec.de>

Am 23.07.2018 um 13:14 schrieb Udit Agarwal:
> Secure keys are derieved using CAAM crypto block.
>
> Secure keys derieved are the random number symmetric keys from CAAM.
> Blobs corresponding to the key are formed using CAAM. User space
> will only be able to view the blob of the key.
>
> Signed-off-by: Udit Agarwal <udit.agarwal@nxp.com>
> Reviewed-by: Sahil Malhotra <sahil.malhotra@nxp.com>
> ---
> Changes in v2:
> Changes security/keys/Makefile to compile securekey module
> when CONFIG=5FSECURE=5FKEY is enabled as module.
>
>   Documentation/security/keys/secure-key.rst |  67 +++
>   MAINTAINERS                                |  11 +
>   include/keys/secure-type.h                 |  33 ++
>   security/keys/Kconfig                      |  11 +
>   security/keys/Makefile                     |   5 +
>   security/keys/secure=5Fkey.c                 | 339 ++++++++++++
>   security/keys/securekey=5Fdesc.c             | 608 +++++++++++++++++++++
>   security/keys/securekey=5Fdesc.h             | 141 +++++
>   8 files changed, 1215 insertions(+)
>   create mode 100644 Documentation/security/keys/secure-key.rst
>   create mode 100644 include/keys/secure-type.h
>   create mode 100644 security/keys/secure=5Fkey.c
>   create mode 100644 security/keys/securekey=5Fdesc.c
>   create mode 100644 security/keys/securekey=5Fdesc.h
>
> diff --git a/Documentation/security/keys/secure-key.rst b/Documentation/s=
ecurity/keys/secure-key.rst
> new file mode 100644
> index 000000000000..a33ffd09d7bd
> --- /dev/null
> +++ b/Documentation/security/keys/secure-key.rst
> @@ -0,0 +1,67 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Secure Key
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Secure key is the new type added to kernel key ring service.
> +Secure key is a symmetric type key of minimum length 32 bytes
> +and with maximum possible length to be 128 bytes. It is produced
> +in kernel using the CAAM crypto engine. Userspace can only see
> +the blob for the corresponding key. All the blobs are displayed
> +or loaded in hex ascii.
> +
> +Secure key can be created on platforms which supports CAAM
> +hardware block. Secure key can also be used as a master key to
> +create the encrypted keys along with the existing key types in
> +kernel.
> +
> +Secure key uses CAAM hardware to generate the key and blobify its
> +content for userspace. Generated blobs are tied up with the hardware
> +secret key stored in CAAM, hence the same blob will not be able to
> +de-blobify with the different secret key on another machine.
> +
> +Usage::
> +
> +	keyctl add secure <name> "new <keylen>" <ring>
> +	keyctl load secure <name> "load <hex=5Fblob>" <ring>
> +	keyctl print <key=5Fid>
> +
> +"keyctl add secure" option will create the random data of the
> +specified key len using CAAM and store it as a key in kernel.
> +Key contents will be displayed as blobs to the user in hex ascii.
> +User can input key len from 32 bytes to 128 bytes.
> +
> +"keyctl load secure" option will load the blob contents. In kernel,
> +key will be deirved using input blob and CAAM, along with the secret
> +key stored in CAAM.
> +
> +"keyctl print" will return the hex string of the blob corresponding to
> +key=5Fid. Returned blob will be of key=5Flen + 48 bytes. Extra 48 bytes =
are
> +the header bytes added by the CAAM.
> +
> +Example of secure key usage::
> +
> +1. Create the secure key with name kmk-master of length 32 bytes::
> +
> +	$ keyctl add secure kmk-master "new 32" @u
> +	46001928
> +
> +	$keyctl show
> +	Session Keyring
> +	1030783626 --alswrv      0 65534  keyring: =5Fuid=5Fses.0
> +	 695927745 --alswrv      0 65534   \=5F keyring: =5Fuid.0
> +	  46001928 --als-rv      0     0       \=5F secure: kmk-master
> +
> +2. Print the blob contents for the kmk-master key::
> +
> +	$ keyctl print 46001928
> +	d9743445b640f3d59c1670dddc0bc9c2
> +	34fc9aab7dd05c965e6120025012f029b
> +	07faa4776c4f6ed02899e35a135531e9a
> +	6e5c2b51132f9d5aef28f68738e658296
> +	3fe583177cfe50d2542b659a13039
> +
> +	$ keyctl pipe 46001928 > secure=5Fkey.blob
> +
> +3. Load the blob in the user key ring::
> +
> +	$ keyctl load secure kmk-master "load 'cat secure=5Fkey.blob'" @u
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9fd5e8808208..654be2ee4b0a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7939,6 +7939,17 @@ F:	include/keys/trusted-type.h
>   F:	security/keys/trusted.c
>   F:	security/keys/trusted.h
>  =20
> +KEYS-SECURE
> +M:	Udit Agarwal <udit.agarwal@nxp.com>
> +R:	Sahil Malhotra <sahil.malhotra@nxp.com>
> +L:	linux-security-module@vger.kernel.org
> +L:	keyrings@vger.kernel.org
> +S:	Supported
> +F:	include/keys/secure-type.h
> +F:	security/keys/secure=5Fkey.c
> +F:	security/keys/securekey=5Fdesc.c
> +F:	security/keys/securekey=5Fdesc.h
> +
>   KEYS/KEYRINGS:
>   M:	David Howells <dhowells@redhat.com>
>   L:	keyrings@vger.kernel.org
> diff --git a/include/keys/secure-type.h b/include/keys/secure-type.h
> new file mode 100644
> index 000000000000..5b7a5f144e41
> --- /dev/null
> +++ b/include/keys/secure-type.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2018 NXP.
> + *
> + */
> +
> +#ifndef =5FKEYS=5FSECURE=5FTYPE=5FH
> +#define =5FKEYS=5FSECURE=5FTYPE=5FH
> +
> +#include <linux/key.h>
> +#include <linux/rcupdate.h>
> +
> +/* Minimum key size to be used is 32 bytes and maximum key size fixed
> + * is 128 bytes.
> + * Blob size to be kept is Maximum key size + blob header added by CAAM.
> + */
> +
> +#define MIN=5FKEY=5FSIZE                    32
> +#define MAX=5FKEY=5FSIZE                    128
> +#define BLOB=5FHEADER=5FSIZE		48
> +
> +#define MAX=5FBLOB=5FSIZE                   (MAX=5FKEY=5FSIZE + BLOB=5FH=
EADER=5FSIZE)
> +
> +struct secure=5Fkey=5Fpayload {
> +	struct rcu=5Fhead rcu;
> +	unsigned int key=5Flen;
> +	unsigned int blob=5Flen;
> +	unsigned char key[MAX=5FKEY=5FSIZE + 1];
> +	unsigned char blob[MAX=5FBLOB=5FSIZE];
> +};
> +
> +extern struct key=5Ftype key=5Ftype=5Fsecure;
> +#endif
> diff --git a/security/keys/Kconfig b/security/keys/Kconfig
> index 6462e6654ccf..7eb138b5a54f 100644
> --- a/security/keys/Kconfig
> +++ b/security/keys/Kconfig
> @@ -71,6 +71,17 @@ config TRUSTED=5FKEYS
>  =20
>   	  If you are unsure as to whether this is required, answer N.
>  =20
> +config SECURE=5FKEYS
> +	tristate "SECURE=5FKEYS"
> +	depends on KEYS && CRYPTO=5FDEV=5FFSL=5FCAAM && CRYPTO=5FDEV=5FFSL=5FCA=
AM=5FJR
> +	help
> +	  This option provide support for creating secure-type key and blobs
> +	  in kernel. Secure keys are random number symmetric keys generated
> +	  from CAAM. The CAAM creates the blobs for the random key.
> +	  Userspace will only be able to see the blob.
> +
> +	  If you are unsure as to whether this is required, answer N.
> +
>   config ENCRYPTED=5FKEYS
>   	tristate "ENCRYPTED KEYS"
>   	depends on KEYS
> diff --git a/security/keys/Makefile b/security/keys/Makefile
> index ef1581b337a3..eec1c350e922 100644
> --- a/security/keys/Makefile
> +++ b/security/keys/Makefile
> @@ -28,4 +28,9 @@ obj-$(CONFIG=5FKEY=5FDH=5FOPERATIONS) +=3D dh.o
>   #
>   obj-$(CONFIG=5FBIG=5FKEYS) +=3D big=5Fkey.o
>   obj-$(CONFIG=5FTRUSTED=5FKEYS) +=3D trusted.o
> +CFLAGS=5Fsecure=5Fkey.o +=3D -I$(obj)/../../drivers/crypto/caam/
> +CFLAGS=5Fsecurekey=5Fdesc.o +=3D -I$(obj)/../../drivers/crypto/caam/
> +obj-$(CONFIG=5FSECURE=5FKEYS) +=3D securekey.o
> +securekey-y :=3D securekey=5Fdesc.o \
> +	       secure=5Fkey.o
>   obj-$(CONFIG=5FENCRYPTED=5FKEYS) +=3D encrypted-keys/
> diff --git a/security/keys/secure=5Fkey.c b/security/keys/secure=5Fkey.c
> new file mode 100644
> index 000000000000..ec8ad4394549
> --- /dev/null
> +++ b/security/keys/secure=5Fkey.c
> @@ -0,0 +1,339 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2018 NXP
> + * Secure key is generated using NXP CAAM hardware block. CAAM generates=
 the
> + * random number (used as a key) and creates its blob for the user.
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/parser.h>
> +#include <linux/string.h>
> +#include <linux/key-type.h>
> +#include <linux/rcupdate.h>
> +#include <keys/secure-type.h>
> +#include <linux/completion.h>
> +
> +#include "securekey=5Fdesc.h"
> +
> +static const char hmac=5Falg[] =3D "hmac(sha1)";
> +static const char hash=5Falg[] =3D "sha1";
> +
> +static struct crypto=5Fshash *hashalg;
> +static struct crypto=5Fshash *hmacalg;
> +
> +enum {
> +	error =3D -1,
> +	new=5Fkey,
> +	load=5Fblob,
> +};
> +
> +static const match=5Ftable=5Ft key=5Ftokens =3D {
> +	{new=5Fkey, "new"},
> +	{load=5Fblob, "load"},
> +	{error, NULL}
> +};
> +
> +static struct secure=5Fkey=5Fpayload *secure=5Fpayload=5Falloc(struct ke=
y *key)
> +{
> +	struct secure=5Fkey=5Fpayload *sec=5Fkey =3D NULL;
> +	int ret =3D 0;
> +
> +	ret =3D key=5Fpayload=5Freserve(key, sizeof(*sec=5Fkey));
> +	if (ret < 0)
> +		goto out;
> +
> +	sec=5Fkey =3D kzalloc(sizeof(*sec=5Fkey), GFP=5FKERNEL);
> +	if (!sec=5Fkey)
> +		goto out;
> +
> +out:
> +	return sec=5Fkey;
> +}
> +
> +/*
> + * parse=5Finputdata - parse the keyctl input data and fill in the
> + *		     payload structure for key or its blob.
> + * param[in]: data pointer to the data to be parsed for creating key.
> + * param[in]: p pointer to secure key payload structure to fill parsed d=
ata
> + * On success returns 0, otherwise -EINVAL.
> + */
> +static int parse=5Finputdata(char *data, struct secure=5Fkey=5Fpayload *=
p)
> +{
> +	substring=5Ft args[MAX=5FOPT=5FARGS];
> +	long keylen =3D 0;
> +	int ret =3D -EINVAL;
> +	int key=5Fcmd =3D -EINVAL;
> +	char *c =3D NULL;
> +
> +	c =3D strsep(&data, " \t");
> +	if (!c) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	/* Get the keyctl command i.e. new=5Fkey or load=5Fblob etc */
> +	key=5Fcmd =3D match=5Ftoken(c, key=5Ftokens, args);
> +
> +	switch (key=5Fcmd) {
> +	case new=5Fkey:
> +		/* first argument is key size */
> +		c =3D strsep(&data, " \t");
> +		if (!c) {
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
> +
> +		ret =3D kstrtol(c, 10, &keylen);
> +		if (ret < 0 || keylen < MIN=5FKEY=5FSIZE ||
> +						keylen > MAX=5FKEY=5FSIZE) {
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
> +
> +		p->key=5Flen =3D keylen;
> +		ret =3D new=5Fkey;
> +
> +		break;
> +	case load=5Fblob:
> +		/* first argument is blob data for CAAM*/
> +		c =3D strsep(&data, " \t");
> +		if (!c) {
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
> +
> +		/* Blob=5Flen =3D No of characters in blob/2 */
> +		p->blob=5Flen =3D strlen(c) / 2;
> +		if (p->blob=5Flen > MAX=5FBLOB=5FSIZE) {
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
> +
> +		ret =3D hex2bin(p->blob, c, p->blob=5Flen);
> +		if (ret < 0) {
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
> +		ret =3D load=5Fblob;
> +
> +		break;
> +	case error:
> +		ret =3D -EINVAL;
> +		break;
> +	}
> +
> +out:
> +	return ret;
> +}
> +
> +/*
> + * secure=5Finstantiate - create a new secure type key.
> + * Supports the operation to generate a new key. A random number
> + * is generated from CAAM as key data and the corresponding red blob
> + * is formed and stored as key=5Fblob.
> + * Also supports the operation to load the blob and key is derived using
> + * that blob from CAAM.
> + * On success, return 0. Otherwise return errno.
> + */
> +static int secure=5Finstantiate(struct key *key,
> +		struct key=5Fpreparsed=5Fpayload *prep)
> +{
> +	struct secure=5Fkey=5Fpayload *payload =3D NULL;
> +	size=5Ft datalen =3D prep->datalen;
> +	char *data =3D NULL;
> +	int key=5Fcmd =3D 0;
> +	int ret =3D 0;
> +	enum sk=5Freq=5Ftype sk=5Fop=5Ftype;
> +	struct device *dev =3D NULL;
> +
> +	if (datalen <=3D 0 || datalen > 32767 || !prep->data) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	data =3D kmalloc(datalen + 1, GFP=5FKERNEL);
> +	if (!data) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	memcpy(data, prep->data, datalen);
> +	data[datalen] =3D '\0';
> +
> +	payload =3D secure=5Fpayload=5Falloc(key);
> +	if (!payload) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	/* Allocate caam job ring for operation to be performed from CAAM */
> +	dev =3D caam=5Fjr=5Falloc();
> +	if (!dev) {
> +		pr=5Finfo("caam=5Fjr=5Falloc failed\n");
> +		ret =3D -ENODEV;
> +		goto out;
> +	}
> +
> +	key=5Fcmd =3D parse=5Finputdata(data, payload);
> +	if (key=5Fcmd < 0) {
> +		ret =3D key=5Fcmd;
> +		goto out;
> +	}
> +
> +	switch (key=5Fcmd) {
> +	case load=5Fblob:
> +		/*
> +		 * Red blob decryption to be done for load operation
> +		 * to derive the key.
> +		 */
> +		sk=5Fop=5Ftype =3D sk=5Fred=5Fblob=5Fdec;
> +		ret =3D key=5Fdeblob(payload, sk=5Fop=5Ftype, dev);
> +		if (ret !=3D 0) {
> +			pr=5Finfo("secure=5Fkey: key=5Fblob decap fail (%d)\n", ret);
> +			goto out;
> +		}
> +		break;
> +	case new=5Fkey:
> +		/* Get Random number from caam of the specified length */
> +		sk=5Fop=5Ftype =3D sk=5Fget=5Frandom;
> +		ret =3D caam=5Fget=5Frandom(payload, sk=5Fop=5Ftype, dev);
> +		if (ret !=3D 0) {
> +			pr=5Finfo("secure=5Fkey: get=5Frandom fail (%d)\n", ret);
> +			goto out;
> +		}
> +
> +		/* Generate red blob of key random bytes with CAAM */
> +		sk=5Fop=5Ftype =3D sk=5Fred=5Fblob=5Fenc;
> +		ret =3D key=5Fblob(payload, sk=5Fop=5Ftype, dev);
> +		if (ret !=3D 0) {
> +			pr=5Finfo("secure=5Fkey: key=5Fblob encap fail (%d)\n", ret);
> +			goto out;
> +		}
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +out:
> +	if (data)
> +		kzfree(data);
> +	if (dev)
> +		caam=5Fjr=5Ffree(dev);
> +
> +	if (!ret)
> +		rcu=5Fassign=5Fkeypointer(key, payload);
> +	else
> +		kzfree(payload);
> +
> +	return ret;
> +}
> +
> +/*
> + * secure=5Fread - copy the  blob data to userspace in hex.
> + * param[in]: key pointer to key struct
> + * param[in]: buffer pointer to user data for creating key
> + * param[in]: buflen is the length of the buffer
> + * On success, return to userspace the secure key data size.
> + */
> +static long secure=5Fread(const struct key *key, char =5F=5Fuser *buffer,
> +			 size=5Ft buflen)
> +{
> +	const struct secure=5Fkey=5Fpayload *p =3D NULL;
> +	char *ascii=5Fbuf;
> +	char *bufp;
> +	int i;
> +
> +	p =3D dereference=5Fkey=5Flocked(key);
> +	if (!p)
> +		return -EINVAL;
> +
> +	if (buffer && buflen >=3D 2 * p->blob=5Flen) {
> +		ascii=5Fbuf =3D kmalloc(2 * p->blob=5Flen, GFP=5FKERNEL);
> +		if (!ascii=5Fbuf)
> +			return -ENOMEM;
> +
> +		bufp =3D ascii=5Fbuf;
> +		for (i =3D 0; i < p->blob=5Flen; i++)
> +			bufp =3D hex=5Fbyte=5Fpack(bufp, p->blob[i]);
> +		if (copy=5Fto=5Fuser(buffer, ascii=5Fbuf, 2 * p->blob=5Flen) !=3D 0) {
> +			kzfree(ascii=5Fbuf);
> +			return -EFAULT;
> +		}
> +		kzfree(ascii=5Fbuf);
> +	}
> +	return 2 * p->blob=5Flen;
> +}
> +
> +/*
> + * secure=5Fdestroy - clear and free the key's payload
> + */
> +static void secure=5Fdestroy(struct key *key)
> +{
> +	kzfree(key->payload.data[0]);
> +}
> +
> +struct key=5Ftype key=5Ftype=5Fsecure =3D {
> +	.name =3D "secure",
> +	.instantiate =3D secure=5Finstantiate,
> +	.destroy =3D secure=5Fdestroy,
> +	.read =3D secure=5Fread,
> +};
> +EXPORT=5FSYMBOL=5FGPL(key=5Ftype=5Fsecure);
> +
> +static void secure=5Fshash=5Frelease(void)
> +{
> +	if (hashalg)
> +		crypto=5Ffree=5Fshash(hashalg);
> +	if (hmacalg)
> +		crypto=5Ffree=5Fshash(hmacalg);
> +}
> +
> +static int =5F=5Finit secure=5Fshash=5Falloc(void)
> +{
> +	int ret;
> +
> +	hmacalg =3D crypto=5Falloc=5Fshash(hmac=5Falg, 0, CRYPTO=5FALG=5FASYNC);
> +	if (IS=5FERR(hmacalg)) {
> +		pr=5Finfo("secure=5Fkey: could not allocate crypto %s\n",
> +				hmac=5Falg);
> +		return PTR=5FERR(hmacalg);
> +	}
> +
> +	hashalg =3D crypto=5Falloc=5Fshash(hash=5Falg, 0, CRYPTO=5FALG=5FASYNC);
> +	if (IS=5FERR(hashalg)) {
> +		pr=5Finfo("secure=5Fkey: could not allocate crypto %s\n",
> +				hash=5Falg);
> +		ret =3D PTR=5FERR(hashalg);
> +		goto hashalg=5Ffail;
> +	}
> +
> +	return 0;
> +
> +hashalg=5Ffail:
> +	crypto=5Ffree=5Fshash(hmacalg);
> +	return ret;
> +}
> +
> +static int =5F=5Finit init=5Fsecure=5Fkey(void)
> +{
> +	int ret;
> +
> +	ret =3D secure=5Fshash=5Falloc();
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D register=5Fkey=5Ftype(&key=5Ftype=5Fsecure);
> +	if (ret < 0)
> +		secure=5Fshash=5Frelease();
> +	return ret;
> +}
> +
> +static void =5F=5Fexit cleanup=5Fsecure=5Fkey(void)
> +{
> +	secure=5Fshash=5Frelease();
> +	unregister=5Fkey=5Ftype(&key=5Ftype=5Fsecure);
> +}
> +
> +late=5Finitcall(init=5Fsecure=5Fkey);
> +module=5Fexit(cleanup=5Fsecure=5Fkey);
> +
> +MODULE=5FLICENSE("GPL");
> diff --git a/security/keys/securekey=5Fdesc.c b/security/keys/securekey=
=5Fdesc.c
> new file mode 100644
> index 000000000000..03a57cb93a74
> --- /dev/null
> +++ b/security/keys/securekey=5Fdesc.c
> @@ -0,0 +1,608 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 NXP
> + *
> + */
> +
> +#include <keys/secure-type.h>
> +#include "securekey=5Fdesc.h"
> +
> +/* key modifier for blob encapsulation & decapsulation descriptor */
> +u8 key=5Fmodifier[] =3D "SECURE=5FKEY";
> +u32 key=5Fmodifier=5Flen =3D 10;
> +
> +void caam=5Fsk=5Frng=5Fdesc(struct sk=5Freq *skreq, struct sk=5Fdesc *sk=
desc)
> +{
> +	struct sk=5Ffetch=5Frnd=5Fdata *fetch=5Frnd=5Fdata =3D NULL;
> +	struct random=5Fdesc *rnd=5Fdesc =3D NULL;
> +	size=5Ft len =3D 0;
> +	u32 *desc =3D skreq->hwdesc;
> +
> +	init=5Fjob=5Fdesc(desc, 0);
> +
> +	fetch=5Frnd=5Fdata =3D &skreq->req=5Fu.sk=5Ffetch=5Frnd=5Fdata;
> +	rnd=5Fdesc =3D &skdesc->dma=5Fu.random=5Fdescp;
> +	len =3D fetch=5Frnd=5Fdata->key=5Flen;
> +
> +	/* command 0x82500000 */
> +	append=5Fcmd(desc, CMD=5FOPERATION | OP=5FTYPE=5FCLASS1=5FALG |
> +			OP=5FALG=5FALGSEL=5FRNG);
> +	/* command 0x60340000 | len */
> +	append=5Fcmd(desc, CMD=5FFIFO=5FSTORE | FIFOST=5FTYPE=5FRNGSTORE | len);
> +	append=5Fptr(desc, rnd=5Fdesc->rnd=5Fdata);
> +}
> +
> +void caam=5Fsk=5Fredblob=5Fencap=5Fdesc(struct sk=5Freq *skreq, struct s=
k=5Fdesc *skdesc)
> +{
> +	struct redblob=5Fencap=5Fdesc *red=5Fblob=5Fdesc =3D
> +					&skdesc->dma=5Fu.redblob=5Fencapdesc;
> +	struct sk=5Fred=5Fblob=5Fencap *red=5Fblob=5Freq =3D
> +					&skreq->req=5Fu.sk=5Fred=5Fblob=5Fencap;
> +	u32 *desc =3D skreq->hwdesc;
> +
> +	init=5Fjob=5Fdesc(desc, 0);
> +
> +	/* Load class 2 key with key modifier. */
> +	append=5Fkey=5Fas=5Fimm(desc, key=5Fmodifier, key=5Fmodifier=5Flen,
> +			  key=5Fmodifier=5Flen, CLASS=5F2 | KEY=5FDEST=5FCLASS=5FREG);
> +
> +	/* SEQ IN PTR Command. */
> +	append=5Fseq=5Fin=5Fptr(desc, red=5Fblob=5Fdesc->in=5Fdata, red=5Fblob=
=5Freq->data=5Fsz,
> +			  0);
> +
> +	/* SEQ OUT PTR Command. */
> +	append=5Fseq=5Fout=5Fptr(desc, red=5Fblob=5Fdesc->redblob,
> +			   red=5Fblob=5Freq->redblob=5Fsz, 0);
> +
> +	/* RedBlob encapsulation PROTOCOL Command. */
> +	append=5Foperation(desc, OP=5FTYPE=5FENCAP=5FPROTOCOL | OP=5FPCLID=5FBL=
OB);
> +}
> +
> +/* void caam=5Fsk=5Fredblob=5Fdecap=5Fdesc(struct sk=5Freq *skreq, struc=
t sk=5Fdesc *skdesc)
> + * brief CAAM Descriptor creator from redblob to plaindata.
> + * param[in] skreq Pointer to secure key request structure
> + * param[in] skdesc Pointer to secure key descriptor structure
> + */
> +void caam=5Fsk=5Fredblob=5Fdecap=5Fdesc(struct sk=5Freq *skreq, struct s=
k=5Fdesc *skdesc)
> +{
> +	struct redblob=5Fdecap=5Fdesc *red=5Fblob=5Fdesc =3D
> +					&skdesc->dma=5Fu.redblob=5Fdecapdesc;
> +	struct sk=5Fred=5Fblob=5Fdecap *red=5Fblob=5Freq =3D
> +					&skreq->req=5Fu.sk=5Fred=5Fblob=5Fdecap;
> +	u32 *desc =3D skreq->hwdesc;
> +
> +	init=5Fjob=5Fdesc(desc, 0);
> +
> +	/* Load class 2 key with key modifier. */
> +	append=5Fkey=5Fas=5Fimm(desc, key=5Fmodifier, key=5Fmodifier=5Flen,
> +			  key=5Fmodifier=5Flen, CLASS=5F2 | KEY=5FDEST=5FCLASS=5FREG);
> +
> +	/* SEQ IN PTR Command. */
> +	append=5Fseq=5Fin=5Fptr(desc, red=5Fblob=5Fdesc->redblob,
> +			  red=5Fblob=5Freq->redblob=5Fsz, 0);
> +
> +	/* SEQ OUT PTR Command. */
> +	append=5Fseq=5Fout=5Fptr(desc, red=5Fblob=5Fdesc->out=5Fdata,
> +			   red=5Fblob=5Freq->data=5Fsz, 0);
> +
> +	/* RedBlob decapsulation PROTOCOL Command. */
> +	append=5Foperation(desc, OP=5FTYPE=5FDECAP=5FPROTOCOL | OP=5FPCLID=5FBL=
OB);
> +}
> +
> +/* int caam=5Fsk=5Fget=5Frandom=5Fmap(struct device *dev, struct sk=5Fre=
q *req,
> + *			      struct sk=5Fdesc *skdesc)
> + * brief DMA map the buffer virtual pointers to physical address.
> + * param[in] dev Pointer to job ring device structure
> + * param[in] req Pointer to secure key request structure
> + * param[in] skdesc Pointer to secure key descriptor structure
> + * return 0 on success, error value otherwise.
> + */
> +int caam=5Fsk=5Fget=5Frandom=5Fmap(struct device *dev, struct sk=5Freq *=
req,
> +			   struct sk=5Fdesc *skdesc)
> +{
> +	struct sk=5Ffetch=5Frnd=5Fdata *fetch=5Frnd=5Fdata;
> +	struct random=5Fdesc *rnd=5Fdesc;
> +
> +	fetch=5Frnd=5Fdata =3D &req->req=5Fu.sk=5Ffetch=5Frnd=5Fdata;
> +	rnd=5Fdesc =3D &skdesc->dma=5Fu.random=5Fdescp;
> +
> +	rnd=5Fdesc->rnd=5Fdata =3D dma=5Fmap=5Fsingle(dev, fetch=5Frnd=5Fdata->=
data,
> +				fetch=5Frnd=5Fdata->key=5Flen, DMA=5FFROM=5FDEVICE);
> +
> +	if (dma=5Fmapping=5Ferror(dev, rnd=5Fdesc->rnd=5Fdata)) {
> +		dev=5Ferr(dev, "Unable to map memory\n");
> +		goto sk=5Frandom=5Fmap=5Ffail;
> +	}
> +	return 0;
> +
> +sk=5Frandom=5Fmap=5Ffail:
> +	return -ENOMEM;
> +}
> +
> +/* int caam=5Fsk=5Fredblob=5Fencap=5Fmap(struct device *dev, struct sk=
=5Freq *req,
> + *					struct sk=5Fdesc *skdesc)
> + * brief DMA map the buffer virtual pointers to physical address.
> + * param[in] dev Pointer to job ring device structure
> + * param[in] req Pointer to secure key request structure
> + * param[in] skdesc Pointer to secure key descriptor structure
> + * return 0 on success, error value otherwise.
> + */
> +int caam=5Fsk=5Fredblob=5Fencap=5Fmap(struct device *dev, struct sk=5Fre=
q *req,
> +			      struct sk=5Fdesc *skdesc)
> +{
> +	struct sk=5Fred=5Fblob=5Fencap *red=5Fblob=5Fencap;
> +	struct redblob=5Fencap=5Fdesc *red=5Fblob=5Fdesc;
> +
> +	red=5Fblob=5Fencap =3D &req->req=5Fu.sk=5Fred=5Fblob=5Fencap;
> +	red=5Fblob=5Fdesc =3D &skdesc->dma=5Fu.redblob=5Fencapdesc;
> +
> +	red=5Fblob=5Fdesc->in=5Fdata =3D dma=5Fmap=5Fsingle(dev, red=5Fblob=5Fe=
ncap->data,
> +					red=5Fblob=5Fencap->data=5Fsz, DMA=5FTO=5FDEVICE);
> +	if (dma=5Fmapping=5Ferror(dev, red=5Fblob=5Fdesc->in=5Fdata)) {
> +		dev=5Ferr(dev, "Unable to map memory\n");
> +		goto sk=5Fdata=5Ffail;
> +	}
> +
> +	red=5Fblob=5Fdesc->redblob =3D dma=5Fmap=5Fsingle(dev, red=5Fblob=5Fenc=
ap->redblob,
> +				red=5Fblob=5Fencap->redblob=5Fsz, DMA=5FFROM=5FDEVICE);
> +	if (dma=5Fmapping=5Ferror(dev, red=5Fblob=5Fdesc->redblob)) {
> +		dev=5Ferr(dev, "Unable to map memory\n");
> +		goto sk=5Fredblob=5Ffail;
> +	}
> +
> +	return 0;
> +
> +sk=5Fredblob=5Ffail:
> +	dma=5Funmap=5Fsingle(dev, red=5Fblob=5Fdesc->in=5Fdata, red=5Fblob=5Fen=
cap->data=5Fsz,
> +			 DMA=5FTO=5FDEVICE);
> +sk=5Fdata=5Ffail:
> +	return -ENOMEM;
> +}
> +
> +/* static int caam=5Fsk=5Fredblob=5Fdecap=5Fmap(struct device *dev,
> + *					    struct sk=5Freq *req,
> + *					    struct sk=5Fdesc *skdesc)
> + * brief DMA map the buffer virtual pointers to physical address.
> + * param[in] dev Pointer to job ring device structure
> + * param[in] req Pointer to secure key request structure
> + * param[in] skdesc Pointer to secure key descriptor structure
> + * return 0 on success, error value otherwise.
> + */
> +int caam=5Fsk=5Fredblob=5Fdecap=5Fmap(struct device *dev, struct sk=5Fre=
q *req,
> +			      struct sk=5Fdesc *skdesc)
> +{
> +	struct sk=5Fred=5Fblob=5Fdecap *red=5Fblob=5Fdecap;
> +	struct redblob=5Fdecap=5Fdesc *red=5Fblob=5Fdesc;
> +
> +	red=5Fblob=5Fdecap =3D &req->req=5Fu.sk=5Fred=5Fblob=5Fdecap;
> +	red=5Fblob=5Fdesc =3D &skdesc->dma=5Fu.redblob=5Fdecapdesc;
> +
> +	red=5Fblob=5Fdesc->redblob =3D dma=5Fmap=5Fsingle(dev, red=5Fblob=5Fdec=
ap->redblob,
> +				red=5Fblob=5Fdecap->redblob=5Fsz, DMA=5FTO=5FDEVICE);
> +	if (dma=5Fmapping=5Ferror(dev, red=5Fblob=5Fdesc->redblob)) {
> +		dev=5Ferr(dev, "Unable to map memory\n");
> +		goto sk=5Fredblob=5Ffail;
> +	}
> +
> +	red=5Fblob=5Fdesc->out=5Fdata =3D dma=5Fmap=5Fsingle(dev, red=5Fblob=5F=
decap->data,
> +				red=5Fblob=5Fdecap->data=5Fsz, DMA=5FFROM=5FDEVICE);
> +	if (dma=5Fmapping=5Ferror(dev, red=5Fblob=5Fdesc->out=5Fdata)) {
> +		dev=5Ferr(dev, "Unable to map memory\n");
> +		goto sk=5Fdata=5Ffail;
> +	}
> +
> +	return 0;
> +
> +sk=5Fdata=5Ffail:
> +	dma=5Funmap=5Fsingle(dev, red=5Fblob=5Fdesc->redblob,
> +			 red=5Fblob=5Fdecap->redblob=5Fsz, DMA=5FTO=5FDEVICE);
> +sk=5Fredblob=5Ffail:
> +	return -ENOMEM;
> +}
> +
> +/* @fn void securekey=5Funmap(struct device *dev,
> + *			    struct sk=5Fdesc *skdesc, struct sk=5Freq *req)
> + * @brief DMA unmap the buffer pointers.
> + * @param[in] dev Pointer to job ring device structure
> + * @param[in] skdesc Pointer to secure key descriptor structure
> + * @param[in] req Pointer to secure key request structure
> + */
> +void securekey=5Funmap(struct device *dev,
> +		     struct sk=5Fdesc *skdesc, struct sk=5Freq *req)
> +{
> +
> +	switch (req->type) {
> +	case sk=5Fget=5Frandom:
> +		{
> +			struct sk=5Ffetch=5Frnd=5Fdata *fetch=5Frnd=5Fdata;
> +			struct random=5Fdesc *rnd=5Fdesc;
> +
> +			fetch=5Frnd=5Fdata =3D &req->req=5Fu.sk=5Ffetch=5Frnd=5Fdata;
> +			rnd=5Fdesc =3D &skdesc->dma=5Fu.random=5Fdescp;
> +
> +			/* Unmap Descriptor buffer pointers. */
> +			dma=5Funmap=5Fsingle(dev, rnd=5Fdesc->rnd=5Fdata,
> +					 fetch=5Frnd=5Fdata->key=5Flen,
> +					 DMA=5FFROM=5FDEVICE);
> +			break;
> +		}
> +	case sk=5Fred=5Fblob=5Fenc:
> +		{
> +			struct sk=5Fred=5Fblob=5Fencap *red=5Fblob=5Fencap;
> +			struct redblob=5Fencap=5Fdesc *red=5Fblob=5Fdesc;
> +
> +			red=5Fblob=5Fencap =3D &req->req=5Fu.sk=5Fred=5Fblob=5Fencap;
> +			red=5Fblob=5Fdesc =3D &skdesc->dma=5Fu.redblob=5Fencapdesc;
> +
> +			/* Unmap Descriptor buffer pointers. */
> +			dma=5Funmap=5Fsingle(dev, red=5Fblob=5Fdesc->in=5Fdata,
> +					 red=5Fblob=5Fencap->data=5Fsz,
> +					 DMA=5FTO=5FDEVICE);
> +
> +			dma=5Funmap=5Fsingle(dev, red=5Fblob=5Fdesc->redblob,
> +					 red=5Fblob=5Fencap->redblob=5Fsz,
> +					 DMA=5FFROM=5FDEVICE);
> +
> +			break;
> +		}
> +	case sk=5Fred=5Fblob=5Fdec:
> +		{
> +			struct sk=5Fred=5Fblob=5Fdecap *red=5Fblob=5Fdecap;
> +			struct redblob=5Fdecap=5Fdesc *red=5Fblob=5Fdesc;
> +
> +			red=5Fblob=5Fdecap =3D &req->req=5Fu.sk=5Fred=5Fblob=5Fdecap;
> +			red=5Fblob=5Fdesc =3D &skdesc->dma=5Fu.redblob=5Fdecapdesc;
> +
> +			/* Unmap Descriptor buffer pointers. */
> +			dma=5Funmap=5Fsingle(dev, red=5Fblob=5Fdesc->redblob,
> +					 red=5Fblob=5Fdecap->redblob=5Fsz,
> +					 DMA=5FTO=5FDEVICE);
> +
> +			dma=5Funmap=5Fsingle(dev, red=5Fblob=5Fdesc->out=5Fdata,
> +					 red=5Fblob=5Fdecap->data=5Fsz,
> +					 DMA=5FFROM=5FDEVICE);
> +
> +			break;
> +		}
> +	default:
> +		dev=5Ferr(dev, "Unable to find request type\n");
> +		break;
> +	}
> +	kfree(skdesc);
> +}
> +
> +/*  int caam=5Fsecurekey=5Fdesc=5Finit(struct device *dev, struct sk=5Fr=
eq *req)
> + *  brief CAAM Descriptor creator for secure key operations.
> + *  param[in] dev Pointer to job ring device structure
> + *  param[in] req Pointer to secure key request structure
> + *  return 0 on success, error value otherwise.
> + */
> +int caam=5Fsecurekey=5Fdesc=5Finit(struct device *dev, struct sk=5Freq *=
req)
> +{
> +	struct sk=5Fdesc *skdesc =3D NULL;
> +	int ret =3D 0;
> +
> +	switch (req->type) {
> +	case sk=5Fget=5Frandom:
> +		{
> +			skdesc =3D kmalloc(sizeof(*skdesc), GFP=5FDMA);
> +			if (!skdesc) {
> +				ret =3D -ENOMEM;
> +				goto out;
> +			}
> +			skdesc->req=5Ftype =3D req->type;
> +
> +			if (caam=5Fsk=5Fget=5Frandom=5Fmap(dev, req, skdesc)) {
> +				dev=5Ferr(dev, "caam get=5Frandom map fail\n");
> +				ret =3D -ENOMEM;
> +				goto out;
> +			}
> +			caam=5Fsk=5Frng=5Fdesc(req, skdesc);
> +			break;
> +		}
> +	case sk=5Fred=5Fblob=5Fenc:
> +		{
> +			skdesc =3D kmalloc(sizeof(*skdesc), GFP=5FDMA);
> +			if (!skdesc) {
> +				ret =3D -ENOMEM;
> +				goto out;
> +			}
> +
> +			skdesc->req=5Ftype =3D req->type;
> +
> +			if (caam=5Fsk=5Fredblob=5Fencap=5Fmap(dev, req, skdesc)) {
> +				dev=5Ferr(dev, "caam redblob=5Fencap map fail\n");
> +				ret =3D -ENOMEM;
> +				goto out;
> +			}
> +
> +			/* Descriptor function to create redblob from data. */
> +			caam=5Fsk=5Fredblob=5Fencap=5Fdesc(req, skdesc);
> +			break;
> +		}
> +
> +	case sk=5Fred=5Fblob=5Fdec:
> +		{
> +			skdesc =3D kmalloc(sizeof(*skdesc), GFP=5FDMA);
> +			if (!skdesc) {
> +				ret =3D -ENOMEM;
> +				goto out;
> +			}
> +
> +			skdesc->req=5Ftype =3D req->type;
> +
> +			if (caam=5Fsk=5Fredblob=5Fdecap=5Fmap(dev, req, skdesc)) {
> +				dev=5Ferr(dev, "caam redblob=5Fdecap map fail\n");
> +				ret =3D -ENOMEM;
> +				goto out;
> +			}
> +
> +			/* Descriptor function to decap data from redblob. */
> +			caam=5Fsk=5Fredblob=5Fdecap=5Fdesc(req, skdesc);
> +			break;
> +		}
> +	default:
> +		pr=5Fdebug("Unknown request type\n");
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	req->desc=5Fpointer =3D (void *)skdesc;
> +
> +out:
> +	return ret;
> +}
> +
> +/* static void caam=5Fop=5Fdone (struct device *dev, u32 *desc, u32 ret,
> + *			     void *context)
> + * brief callback function to be called when descriptor executed.
> + * param[in] dev Pointer to device structure
> + * param[in] desc descriptor pointer
> + * param[in] ret return status of Job submitted
> + * param[in] context void pointer
> + */
> +static void caam=5Fop=5Fdone(struct device *dev, u32 *desc, u32 ret,
> +			 void *context)
> +{
> +	struct sk=5Freq *req =3D context;
> +
> +	if (ret) {
> +		dev=5Ferr(dev, "caam op done err: %x\n", ret);
> +		/* print the error source name. */
> +		caam=5Fjr=5Fstrstatus(dev, ret);
> +	}
> +	/* Call securekey=5Funmap function for unmapping the buffer pointers. */
> +	securekey=5Funmap(dev, req->desc=5Fpointer, req);
> +
> +	req->ret =3D ret;
> +	complete(&req->comp);
> +}
> +
> +
> +/*  static int sk=5Fjob=5Fsubmit(struct device *jrdev, struct sk=5Freq *=
req)
> + *  brief Enqueue a Job descriptor to Job ring and wait until SEC return=
s.
> + *  param[in] jrdev Pointer to job ring device structure
> + *  param[in] req Pointer to secure key request structure
> + *  return 0 on success, error value otherwise.
> + */
> +static int sk=5Fjob=5Fsubmit(struct device *jrdev, struct sk=5Freq *req)
> +{
> +	int ret;
> +
> +	init=5Fcompletion(&req->comp);
> +
> +	/* caam=5Fjr=5Fenqueue function for Enqueue a job descriptor */
> +	ret =3D caam=5Fjr=5Fenqueue(jrdev, req->hwdesc, caam=5Fop=5Fdone, req);
> +	if (!ret)
> +		wait=5Ffor=5Fcompletion=5Finterruptible(&req->comp);
> +
> +	ret =3D req->ret;
> +	return ret;
> +}
> +
> +/* caam=5Fget=5Frandom(struct secure=5Fkey=5Fpayload *p,  enum sk=5Freq=
=5Ftype fetch=5Frnd,
> + *		   struct device *dev)
> + * Create the random number of the specified length using CAAM block
> + * param[in]: out pointer to place the random bytes
> + * param[in]: length for the random data bytes.
> + * param[in]: dev Pointer to job ring device structure
> + * If operation is successful return 0, otherwise error.
> + */
> +int caam=5Fget=5Frandom(struct secure=5Fkey=5Fpayload *p,  enum sk=5Freq=
=5Ftype fetch=5Frnd,
> +		    struct device *dev)
> +{
> +	struct sk=5Ffetch=5Frnd=5Fdata *fetch=5Frnd=5Fdata =3D NULL;
> +	struct sk=5Freq *req =3D NULL;
> +	int ret =3D 0;
> +	void *temp =3D NULL;
> +
> +	req =3D kmalloc(sizeof(struct sk=5Freq), GFP=5FDMA);
> +	if (!req) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	req->type =3D fetch=5Frnd;
> +	fetch=5Frnd=5Fdata =3D &(req->req=5Fu.sk=5Ffetch=5Frnd=5Fdata);
> +
> +	/* initialise with key length */
> +	fetch=5Frnd=5Fdata->key=5Flen =3D p->key=5Flen;
> +
> +	temp =3D kmalloc(fetch=5Frnd=5Fdata->key=5Flen, GFP=5FDMA);
> +	if (!temp) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +	fetch=5Frnd=5Fdata->data =3D temp;
> +
> +	ret =3D caam=5Fsecurekey=5Fdesc=5Finit(dev, req);
> +
> +	if (ret) {
> +		pr=5Finfo("caam=5Fsecurekey=5Fdesc=5Finit failed\n");
> +		goto out;
> +	}
> +
> +	ret =3D sk=5Fjob=5Fsubmit(dev, req);
> +	if (!ret) {
> +		/*Copy output to key buffer. */
> +		memcpy(p->key, fetch=5Frnd=5Fdata->data, p->key=5Flen);
> +	} else {
> +		ret =3D -EINVAL;
> +	}
> +
> +out:
> +	if (req)
> +		kfree(req);
> +
> +	if (temp)
> +		kfree(temp);
> +
> +	return ret;
> +}
> +EXPORT=5FSYMBOL(caam=5Fget=5Frandom);
> +
> +/* key=5Fdeblob(struct secure=5Fkey=5Fpayload *p, enum sk=5Freq=5Ftype d=
ecap=5Ftype
> + *		struct device *dev)
> + * Deblobify the blob to get the key data and fill in secure key payload=
 struct
> + * param[in] p pointer to the secure key payload
> + * param[in] decap=5Ftype operation to be done.
> + * param[in] dev dev Pointer to job ring device structure
> + * If operation is successful return 0, otherwise error.
> + */
> +int key=5Fdeblob(struct secure=5Fkey=5Fpayload *p, enum sk=5Freq=5Ftype =
decap=5Ftype,
> +	       struct device *dev)
> +{
> +	unsigned int blob=5Flen;
> +	struct sk=5Fred=5Fblob=5Fdecap *d=5Fblob;
> +	struct sk=5Freq *req =3D NULL;
> +	int total=5Fsz =3D 0, *temp =3D NULL, ret =3D 0;
> +
> +	req =3D kmalloc(sizeof(struct sk=5Freq), GFP=5FDMA);
> +	if (!req) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	d=5Fblob =3D &(req->req=5Fu.sk=5Fred=5Fblob=5Fdecap);
> +	blob=5Flen =3D p->blob=5Flen;
> +	req->type =3D decap=5Ftype;
> +
> +	/*
> +	 * Red blob size is the blob=5Flen filled in payload struct
> +	 * Data=5Fsz i.e. key is the blob=5Flen - blob header size
> +	 */
> +
> +	d=5Fblob->redblob=5Fsz =3D blob=5Flen;
> +	d=5Fblob->data=5Fsz =3D blob=5Flen - (SK=5FBLOB=5FKEY=5FSZ + SK=5FBLOB=
=5FMAC=5FSZ);
> +	total=5Fsz =3D d=5Fblob->data=5Fsz + d=5Fblob->redblob=5Fsz;
> +
> +	temp =3D kmalloc(total=5Fsz, GFP=5FDMA);
> +	if (!temp) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	req->mem=5Fpointer =3D temp;
> +	d=5Fblob->redblob =3D temp;
> +	d=5Fblob->data =3D d=5Fblob->redblob + d=5Fblob->redblob=5Fsz;
> +	memcpy(d=5Fblob->redblob, p->blob, blob=5Flen);
> +
> +	ret =3D caam=5Fsecurekey=5Fdesc=5Finit(dev, req);
> +
> +	if (ret) {
> +		pr=5Finfo("caam=5Fsecurekey=5Fdesc=5Finit: Failed\n");
> +		goto out;
> +	}
> +
> +	ret =3D sk=5Fjob=5Fsubmit(dev, req);
> +	if (!ret) {
> +		/*Copy output to key buffer. */
> +		p->key=5Flen =3D d=5Fblob->data=5Fsz;
> +		memcpy(p->key, d=5Fblob->data, p->key=5Flen);
> +	} else {
> +		ret =3D -EINVAL;
> +	}
> +
> +out:
> +	if (temp)
> +		kfree(temp);
> +	if (req)
> +		kfree(req);
> +	return ret;
> +}
> +EXPORT=5FSYMBOL(key=5Fdeblob);
> +
> +/* key=5Fblob(struct secure=5Fkey=5Fpayload *p, enum sk=5Freq=5Ftype enc=
ap=5Ftype,
> + *		struct device *dev)
> + * To blobify the key data to get the blob. This blob can only be seen by
> + * userspace.
> + * param[in] p pointer to the secure key payload
> + * param[in] decap=5Ftype operation to be done.
> + * param[in] dev dev Pointer to job ring device structure
> + * If operation is successful return 0, otherwise error.
> + */
> +int key=5Fblob(struct secure=5Fkey=5Fpayload *p, enum sk=5Freq=5Ftype en=
cap=5Ftype,
> +	     struct device *dev)
> +{
> +	unsigned int key=5Flen;
> +	struct sk=5Fred=5Fblob=5Fencap *k=5Fblob;
> +	struct sk=5Freq *req =3D NULL;
> +	int total=5Fsz =3D 0, *temp =3D NULL, ret =3D 0;
> +
> +	req =3D kmalloc(sizeof(struct sk=5Freq), GFP=5FDMA);
> +	if (!req) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	key=5Flen =3D p->key=5Flen;
> +
> +	req->type =3D encap=5Ftype;
> +	k=5Fblob =3D &(req->req=5Fu.sk=5Fred=5Fblob=5Fencap);
> +
> +	/*
> +	 * Data=5Fsz i.e. key len and the corresponding blob=5Flen is
> +	 * key=5Flen + BLOB header size.
> +	 */
> +
> +	k=5Fblob->data=5Fsz =3D key=5Flen;
> +	k=5Fblob->redblob=5Fsz =3D key=5Flen + SK=5FBLOB=5FKEY=5FSZ + SK=5FBLOB=
=5FMAC=5FSZ;
> +	total=5Fsz =3D k=5Fblob->data=5Fsz + k=5Fblob->redblob=5Fsz;
> +
> +	temp =3D kmalloc(total=5Fsz, GFP=5FDMA);
> +	if (!temp) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	req->mem=5Fpointer =3D temp;
> +	k=5Fblob->data =3D temp;
> +
> +	k=5Fblob->redblob =3D k=5Fblob->data + k=5Fblob->data=5Fsz;
> +	memcpy(k=5Fblob->data, p->key, key=5Flen);
> +
> +	ret =3D caam=5Fsecurekey=5Fdesc=5Finit(dev, req);
> +
> +	if (ret) {
> +		pr=5Finfo("caam=5Fsecurekey=5Fdesc=5Finit failed\n");
> +		goto out;
> +	}
> +
> +	ret =3D sk=5Fjob=5Fsubmit(dev, req);
> +	if (!ret) {
> +		/*Copy output to key buffer. */
> +		p->blob=5Flen =3D k=5Fblob->redblob=5Fsz;
> +		memcpy(p->blob, k=5Fblob->redblob, p->blob=5Flen);
> +	} else {
> +		ret =3D -EINVAL;
> +	}
> +
> +out:
> +	if (temp)
> +		kfree(req->mem=5Fpointer);
> +	if (req)
> +		kfree(req);
> +	return ret;
> +
> +}
> +EXPORT=5FSYMBOL(key=5Fblob);
> diff --git a/security/keys/securekey=5Fdesc.h b/security/keys/securekey=
=5Fdesc.h
> new file mode 100644
> index 000000000000..0ee26e95b205
> --- /dev/null
> +++ b/security/keys/securekey=5Fdesc.h
> @@ -0,0 +1,141 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright 2018 NXP
> + *
> + */
> +#ifndef =5FSECUREKEY=5FDESC=5FH=5F
> +#define =5FSECUREKEY=5FDESC=5FH=5F
> +
> +#include "compat.h"
> +#include "regs.h"
> +#include "intern.h"
> +#include "desc.h"
> +#include "desc=5Fconstr.h"
> +#include "jr.h"
> +#include "error.h"
> +#include "pdb.h"
> +
> +#define SK=5FBLOB=5FKEY=5FSZ		32	/* Blob key size. */
> +#define SK=5FBLOB=5FMAC=5FSZ		16	/* Blob MAC size. */
> +
> +/*
> + * brief defines different kinds of operations supported by this module.
> + */
> +enum sk=5Freq=5Ftype {
> +	sk=5Fget=5Frandom,
> +	sk=5Fred=5Fblob=5Fenc,
> +	sk=5Fred=5Fblob=5Fdec,
> +};
> +
> +
> +/*
> + * struct random=5Fdes
> + * param[out] rnd=5Fdata output buffer for random data.
> + */
> +struct random=5Fdesc {
> +	dma=5Faddr=5Ft rnd=5Fdata;
> +};
> +
> +/* struct redblob=5Fencap=5Fdesc
> + * details Structure containing dma address for redblob encapsulation.
> + * param[in] in=5Fdata input data to redblob encap descriptor.
> + * param[out] redblob output buffer for redblob.
> + */
> +struct redblob=5Fencap=5Fdesc {
> +	dma=5Faddr=5Ft in=5Fdata;
> +	dma=5Faddr=5Ft redblob;
> +};
> +
> +/* struct redblob=5Fdecap=5Fdesc
> + * details Structure containing dma address for redblob decapsulation.
> + * param[in] redblob input buffer to redblob decap descriptor.
> + * param[out] out=5Fdata output data from redblob decap descriptor.
> + */
> +struct redblob=5Fdecap=5Fdesc {
> +	dma=5Faddr=5Ft redblob;
> +	dma=5Faddr=5Ft out=5Fdata;
> +};
> +
> +/* struct sk=5Fdesc
> + * details Structure for securekey descriptor creation.
> + * param[in] req=5Ftype operation supported.
> + * param[in] dma=5Fu union of struct for supported operation.
> + */
> +struct sk=5Fdesc {
> +	u32 req=5Ftype;
> +	union {
> +		struct redblob=5Fencap=5Fdesc redblob=5Fencapdesc;
> +		struct redblob=5Fdecap=5Fdesc redblob=5Fdecapdesc;
> +		struct random=5Fdesc random=5Fdescp;
> +	} dma=5Fu;
> +};
> +
> +/* struct sk=5Ffetch=5Frnd=5Fdata
> + * decriptor structure containing key length.
> + */
> +struct sk=5Ffetch=5Frnd=5Fdata {
> +	void *data;
> +	size=5Ft key=5Flen;
> +};
> +
> +/* struct sk=5Fred=5Fblob=5Fencap
> + * details Structure containing buffer pointers for redblob encapsulatio=
n.
> + * param[in] data Input data.
> + * param[in] data=5Fsz size of Input data.
> + * param[out] redblob output buffer for redblob.
> + * param[in] redblob=5Fsz size of redblob.
> + */
> +struct sk=5Fred=5Fblob=5Fencap {
> +	void *data;
> +	uint32=5Ft data=5Fsz;
> +	void *redblob;
> +	uint32=5Ft redblob=5Fsz;
> +};
> +
> +/* struct sk=5Fred=5Fblob=5Fdecap
> + * details Structure containing buffer pointers for redblob decapsulatio=
n.
> + * param[in] redblob Input redblob.
> + * param[in] redblob=5Fsz size of redblob.
> + * param[out] data output buffer for data.
> + * param[in] data=5Fsz size of output data.
> + */
> +struct sk=5Fred=5Fblob=5Fdecap {
> +	void *redblob;
> +	uint32=5Ft redblob=5Fsz;
> +	void *data;
> +	uint32=5Ft data=5Fsz;
> +};
> +
> +/* struct sk=5Freq
> + * details Structure for securekey request creation.
> + * param[in] type operation supported.
> + * param[in] req=5Fu union of struct for supported operation.
> + * param[out] ret return status of CAAM operation.
> + * param[in] mem=5Fpointer memory pointer for allocated kernel memory.
> + * param[in] desc=5Fpointer Pointer to securekey descriptor creation str=
ucture.
> + * param[in] comp struct completion object.
> + * param[in] hwdesc contains descriptor instructions.
> + */
> +struct sk=5Freq {
> +	enum sk=5Freq=5Ftype type;
> +	void *arg;
> +	union {
> +		struct sk=5Fred=5Fblob=5Fencap sk=5Fred=5Fblob=5Fencap;
> +		struct sk=5Fred=5Fblob=5Fdecap sk=5Fred=5Fblob=5Fdecap;
> +		struct sk=5Ffetch=5Frnd=5Fdata sk=5Ffetch=5Frnd=5Fdata;
> +	} req=5Fu;
> +	int ret;
> +	void *mem=5Fpointer;
> +	void *desc=5Fpointer;
> +	struct completion comp;
> +	u32 hwdesc[MAX=5FCAAM=5FDESCSIZE];
> +};
> +
> +int caam=5Fget=5Frandom(struct secure=5Fkey=5Fpayload *p,  enum sk=5Freq=
=5Ftype fetch=5Frnd,
> +		    struct device *dev);
> +int key=5Fblob(struct secure=5Fkey=5Fpayload *p, enum sk=5Freq=5Ftype en=
cap=5Ftype,
> +	     struct device *dev);
> +int key=5Fdeblob(struct secure=5Fkey=5Fpayload *p, enum sk=5Freq=5Ftype =
decap=5Ftype,
> +	       struct device *dev);
> +
> +#endif /*=5FSECUREKEY=5FDESC=5FH=5F*/
