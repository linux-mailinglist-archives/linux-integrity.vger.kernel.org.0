Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17A53D8B98
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Jul 2021 12:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhG1KTN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Jul 2021 06:19:13 -0400
Received: from mail-eopbgr70137.outbound.protection.outlook.com ([40.107.7.137]:35488
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229574AbhG1KTM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Jul 2021 06:19:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJizV81gu46hJDpA6dh2+R7mIbqmIwgz8T8NZnseGut1IQbLd8ZGkPrb/kfd75U2P3IfX1gxxIfzM5xXiUuOuM9ejOT72YPKeo3jiNm0elCbp5xxMv7LWVicY/XS1AXO9vX/TlUgYlTd8z4nZ/u7cFN5ONt9ciW4y4yAM5v41XnrW8okxpKJ+e01YXYZeJZM5UKeDNcrElBMN/4ITl6OcrywGK4SGPV9EpzediaVanZCZYi5Np09ticzthCNVENBqdTdVkkJ+g60URgFrz9xLtby1JdZj3oWQLzuLqg2E3BjlLbR2n70SrXrySEnS62J14Gzgtz58r5mQzlPNRN3xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KavUuUpMDfTK6i0pbYnUzZSUm2I/VTy6Aih9rEGSqU=;
 b=WjJ88SwCyS+imosXOj67BMzH78b92ZZseJMIM2o0gyr9ScyqieXxPFAMmwG6kcYdlSPZnSlN1bcusGOXAl/n8Jj1vqL8Zit7mzKWC/h/Gwvo0IcPwWMCsHGTL9heKhgBcF1QvxnOwYAqdN6jal7BCec8+mdST5CAae54ICJKKvddtPDhC3f8ffgAz8/lwuxX4wAeDdxJ90+RQgFazNeoxnWB7yzI7l9OLsOvshWcL8UciCBMH5kO1X45wC/YADCUaIkJzsS5qqTcHyG3g+jZh94dMr+9i+xeboBPkMVvFnU4Yzh3p4hun1dQc3lEcGAx3XTg8HGXd+we6NPj0xN0Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KavUuUpMDfTK6i0pbYnUzZSUm2I/VTy6Aih9rEGSqU=;
 b=08Vj3iUwj1mfTf2Y3MFL8rtuS10FXMT2IzGDhSGnMg/Avhqv4q3pSIAuL/m+cxMTlFTGon3uZw7XcVgPBYIgA7tLUtFJRlSamd6A0IgBdXuQGP0V4HTuBXDYu3yo5zy/ewrroLCYeAMqg2+5kZmbgpLuR4mxM4a/TVlPcbnMAQg=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM9PR09MB4563.eurprd09.prod.outlook.com
 (2603:10a6:20b:2d5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 28 Jul
 2021 10:19:08 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4352.031; Wed, 28 Jul 2021
 10:19:08 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     Igor Zhbanov <i.zhbanov@omp.ru>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
CC:     Igor Zhbanov <izh1979@gmail.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH 1/1] NAX LSM: Add initial support support
Thread-Topic: [PATCH 1/1] NAX LSM: Add initial support support
Thread-Index: AQHXg5n/AqeKwEHmDUiYDh8DD+AiWg==
Date:   Wed, 28 Jul 2021 10:19:08 +0000
Message-ID: <d97d7fdb-1676-9670-6cf5-2427f780ec6f@viveris.fr>
References: <db1c1de0-3672-4bae-ef45-c554379f36f4@omp.ru>
In-Reply-To: <db1c1de0-3672-4bae-ef45-c554379f36f4@omp.ru>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: omp.ru; dkim=none (message not signed)
 header.d=none;omp.ru; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25ac4844-8176-4bc6-67e4-08d951b122bf
x-ms-traffictypediagnostic: AM9PR09MB4563:
x-microsoft-antispam-prvs: <AM9PR09MB456321702DA2CB6E8F6C792894EA9@AM9PR09MB4563.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hKi7MhKAYfnh4GFSxF2YAZ9AkazaCg9GFM+tiykIHksk0abExTt1qLEKKFn6NSJDGRT5YvaOT+4P//lJKwkhhtSqQv6xAH9NaHZdJyH+tbbnR1LZqeZ1/uVypVpHj7e1RjqeeS5981YdMn43k9DBilB5o7h7cBRMbLIwBot9syuK8Y+kTI1D6pQ6naMJ+WtqXLo5nDnx8pb6EcSGr095pvY9tVrmnBI+hjLdzLtDYUzbau1AZ74fK7xUJpVrP3FITKlDAMjV27Phga3bd0LJ5rMCrJUGq8Yn+/+y4ZZ4IGcLgwOA+lw6kNU+5PQ2icfJe8Ij9HJKM2EX47AXVS0h5amiFzj+4qzEhIrmz4DeDxxED5HRCPu0uqnqr2huSNtM1/p2D+4By9shChlzmuE3hSvtJti72xaYezmJQApjQvdKZh59iB2qJPrWcu0Z1RS8hA13MkwNOBwGu65pWcpv7LOaZtw8c05I6Jp7iIWeVqlyaLFFBHCOUcB2pKjvYj9ZonDMUiP0v6heUURTlWRVwMHw90ujtXq3p0J+f+gA0XyEJPQXL4yeCCEEZWp13pFRcs6taa4Hdwc1KdIbLRVfGl8w/7IXI/FnWl8d2RvxeceJjiENxuCZT9gJdY46+td5MSZ6m4z5k3rYYXyl/5FgvujkRX3oZChYJ9gv0B8WTR6ePgsKZMBez/2FJvnG4FEXeWm1P0oJlQccJF8mkyxQ2PRby9goIonngnF1TC9O56FkNFOtU7D9/o1IlHro+guFcLSDgCHBvICoqxaCQMrK/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(39830400003)(346002)(136003)(83380400001)(110136005)(54906003)(186003)(8936002)(76116006)(31686004)(91956017)(478600001)(66446008)(64756008)(316002)(66556008)(2906002)(66476007)(6486002)(8676002)(66946007)(38070700005)(6512007)(26005)(122000001)(2616005)(71200400001)(6506007)(4326008)(31696002)(36756003)(38100700002)(53546011)(30864003)(86362001)(5660300002)(2004002)(45980500001)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?11u+qn9rf5evMSqVLuxdKuqu90wAh95vGqIj2cvSx5v6Udn1kcpBka+S?=
 =?Windows-1252?Q?Um49VOIXmpLSrhq3N7fbv0fKUO9dszQq/HqlSQILmBbRcLPXz5//LGIn?=
 =?Windows-1252?Q?Oawc45jafQrdJsHY1jHez6Zt6A2iUFawucd92fRorxq/YcsmbTTu+5Df?=
 =?Windows-1252?Q?5y7ytf6Tos2DbmhaFk6FVPQm9fVfnAHSGbIIceFMyidMuQ/PZ4Jyaivy?=
 =?Windows-1252?Q?RdYqJLJ+ze3p540cyRVxdatII6jqDEzRDGtN+ATp7OXq4dhi9uP5nFwF?=
 =?Windows-1252?Q?93KExIrZhNooReQ2AQui1m11QIO0yixsHYxt2DO0Oiv9O0xeawNK/rGq?=
 =?Windows-1252?Q?9HINyAEypGlcdGbliX1ZpWVCo53vevYGi7fWaigxS4UZbK9lAkI+RdDY?=
 =?Windows-1252?Q?GezzmD9Bk5eHu7f/w/mRm+2tvDwcrHMrPgDf087dzJuwZSmGN+EUZwwG?=
 =?Windows-1252?Q?BOcUPX8nnNXoZ3PN5KK1Fkc5xzACTgPtLnNPFfNgZtMPah6Xf1dVksNZ?=
 =?Windows-1252?Q?nKlMi/HzKKATeOVH39l0Chho2SrV27pQItpux7KHHYVkrj1D/3pVH6Sd?=
 =?Windows-1252?Q?cCnvT7M/eszdIqH8FroBbZZoJwONqhqgRo5RaEAt990p5PWD/oXND/Wv?=
 =?Windows-1252?Q?hUuJfpcPD7aYpZOKMYC7goV/0/0IRgZwpmgvtIIYW6XyaSCq7ZOKFqgb?=
 =?Windows-1252?Q?byNi+onFu6dbTvyG9xrbt/JvbGAi3tn/6hy1A91GpmeTBjnWmwC96mlL?=
 =?Windows-1252?Q?SB1yQpHfZivKTzaR08fn4CQh0opaZGzHeCexbKuK1jGW4jTtmTnOj/Fp?=
 =?Windows-1252?Q?q44cdJsjOs9+rN5ibeuG7rKx1qqHgg6YO9fPfU7QG5UQ8PanSNBnhAIR?=
 =?Windows-1252?Q?ALopDB4fvNXTcpkREXVGi60E04x+ANjrrohYlpsXH8+g/geCHcfJve7O?=
 =?Windows-1252?Q?t7B0cTSj1ybK4vFuocig689DMKFHhtTVOUhYXsqrhzIelEgw2C3jpj5K?=
 =?Windows-1252?Q?nwKohff17hcJNJtrsfcs3XpdqVxNECFWB6DLai2wEqYiFHMqQXKP0eeH?=
 =?Windows-1252?Q?g+BaUIK7xRXWErAkQRKIFW9MaRoujH82s6Mt5TYm7S3GH/DtabJwkLN9?=
 =?Windows-1252?Q?de4rR/dPHNXDyNSwSz1CVZ2F5ZTvRAdGbQSng1SrRFirkQEmBHvxbuyX?=
 =?Windows-1252?Q?1KhwfocWkKlFp1MiztMrZmAgNEwTZauWMVM7usJnrYuH0QRekpVcXW4a?=
 =?Windows-1252?Q?f8iLiQrdsW5xwu1qZ9QJ0/DMWzuVIktVgqBqbTqJsvmROMGkBJ7GMRfU?=
 =?Windows-1252?Q?58/m3SYbB3dIvwhQqQplGKWyrhacEK0mKVqNHFO/I7xsvTYF6FhiDL5h?=
 =?Windows-1252?Q?S9quUQJlXi/j/s3e+ntFzeM30/MYUusMtTQMoTxB11Z/5AUC5EYrCjbk?=
 =?Windows-1252?Q?VxMCv5H8TWwhpg/+tg3/8g=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <E000697FEB6DCA42AE4F53966C48070A@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ac4844-8176-4bc6-67e4-08d951b122bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2021 10:19:08.1947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R5W+hr2nrGzqpxSGeCkKA/+mw28AfUZmYGtM6J2XAWIelKnIZ2gtbKYefgj4o5uxhfdyJaJiMZz2C7ISOqRKqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR09MB4563
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Igor,

first, a disclaimer: this is the first time I review a kernel patch, so eve=
rything I say
must a taken with a grain of salt (a handful, really).

On 7/7/21 3:03 AM, Igor Zhbanov wrote:
> NAX (No Anonymous Execution) is a Linux Security Module that extends DAC
> by making impossible to make anonymous and modified pages executable for
> privileged processes.
>=20
> The module intercepts anonymous executable pages created with mmap() and
> mprotect() system calls.
>=20
> Depending on the settings, the module can block and log violating system
> calls or log and kill the violating process.
>=20

From what I see, there is also a log-only mode (MODE_PERMISSIVE) that users=
 may
use to try this patch before deploying it. You could probably express that.

Something like "This module will log violations, and it can also block the =
action or kill the offending process,
depending on the enabled settings." maybe?

> Signed-off-by: Igor Zhbanov <i.zhbanov@omp.ru>
> ---
>  Documentation/admin-guide/LSM/NAX.rst   |  48 ++++
>  Documentation/admin-guide/LSM/index.rst |   1 +
>  security/Kconfig                        |  11 +-
>  security/Makefile                       |   2 +
>  security/nax/Kconfig                    |  71 +++++
>  security/nax/Makefile                   |   4 +
>  security/nax/nax-lsm.c                  | 344 ++++++++++++++++++++++++
>  7 files changed, 476 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/admin-guide/LSM/NAX.rst
>  create mode 100644 security/nax/Kconfig
>  create mode 100644 security/nax/Makefile
>  create mode 100644 security/nax/nax-lsm.c
>=20
> diff --git a/Documentation/admin-guide/LSM/NAX.rst b/Documentation/admin-=
guide/LSM/NAX.rst
> new file mode 100644
> index 000000000000..b742f881f3d7
> --- /dev/null
> +++ b/Documentation/admin-guide/LSM/NAX.rst
> @@ -0,0 +1,48 @@
> +=3D=3D=3D=3D=3D=3D=3D
> +NAX LSM
> +=3D=3D=3D=3D=3D=3D=3D
> +
> +:Author: Igor Zhbanov
> +
> +NAX (No Anonymous Execution) is a Linux Security Module that extends DAC
> +by making impossible to make anonymous and modified pages executable for
> +privileged processes. The module intercepts anonymous executable pages
> +created with mmap() and mprotect() system calls.
> +
> +To select it at boot time, specify ``security=3Dnax`` (though this will
> +disable any other LSM).
> +
> +The privileged process is a process for which any of the following is tr=
ue:
> +
> +- ``uid   =3D=3D 0``
> +- ``euid  =3D=3D 0``
> +- ``suid  =3D=3D 0``
> +- ``fsuid =3D=3D 0``
> +- ``cap_effective`` has any capability except of ``kernel.nax.allowed_ca=
ps``
> +- ``cap_permitted`` has any capability except of ``kernel.nax.allowed_ca=
ps``
> +

Maybe "except those explicitly allowed in" or "except for the ones allowed =
in"?

> +The following sysctl parameters are available:
> +
> +* ``kernel.nax.allowed_caps``:
> +
> + Hexadecimal number representing allowed capabilities set for the privil=
eged
> + processes.
> +

Maybe "representing the set of capabilities a non-root process can possess =
without being considered "privileged" by NAX"?

> +* ``kernel.nax.enforcing``:
> +
> + - 0: Only log errors (when enabled by ``kernel.nax.quiet``)
> + - 1: Forbid unsafe pages mappings (default)
> +
> +* ``kernel.nax.locked``:
> +
> + - 0: Changing of the module's sysctl parameters is allowed
> + - 1: Further changing of the module's sysctl parameters is forbidden
> +
> + Setting this parameter to ``1`` after initial setup during the system b=
oot
> + will prevent the module disabling at the later time.
> +
> +* ``kernel.nax.quiet``:
> +
> + - 0: Log violations (default)
> + - 1: Be quiet
> + - 2: Kill the violating process and log

"quiet" probably not the right word to express that fact that it controls t=
he NAX execution mode.
Something like "mode" or "level" would probably be clearer.
But while reading the patch below I believe this doc is simply a little out=
 of date, because quiet can
only take two values: 0 or 1 (otherwise it would be redundant with the 'enf=
orcing' sysctl).
So you should consider updating this document.

> diff --git a/Documentation/admin-guide/LSM/index.rst b/Documentation/admi=
n-guide/LSM/index.rst
> index a6ba95fbaa9f..e9df7fc9a461 100644
> --- a/Documentation/admin-guide/LSM/index.rst
> +++ b/Documentation/admin-guide/LSM/index.rst
> @@ -42,6 +42,7 @@ subdirectories.
> =20
>     apparmor
>     LoadPin
> +   NAX
>     SELinux
>     Smack
>     tomoyo
> diff --git a/security/Kconfig b/security/Kconfig
> index 0ced7fd33e4d..771419647ae1 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -239,6 +239,7 @@ source "security/yama/Kconfig"
>  source "security/safesetid/Kconfig"
>  source "security/lockdown/Kconfig"
>  source "security/landlock/Kconfig"
> +source "security/nax/Kconfig"
> =20
>  source "security/integrity/Kconfig"
> =20
> @@ -278,11 +279,11 @@ endchoice
> =20
>  config LSM
>  	string "Ordered list of enabled LSMs"
> -	default "landlock,lockdown,yama,loadpin,safesetid,integrity,smack,selin=
ux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
> -	default "landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,se=
linux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
> -	default "landlock,lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf"=
 if DEFAULT_SECURITY_TOMOYO
> -	default "landlock,lockdown,yama,loadpin,safesetid,integrity,bpf" if DEF=
AULT_SECURITY_DAC
> -	default "landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,sma=
ck,tomoyo,apparmor,bpf"
> +	default "nax,landlock,lockdown,yama,loadpin,safesetid,integrity,smack,s=
elinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
> +	default "nax,landlock,lockdown,yama,loadpin,safesetid,integrity,apparmo=
r,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
> +	default "nax,landlock,lockdown,yama,loadpin,safesetid,integrity,tomoyo,=
bpf" if DEFAULT_SECURITY_TOMOYO
> +	default "nax,landlock,lockdown,yama,loadpin,safesetid,integrity,bpf" if=
 DEFAULT_SECURITY_DAC
> +	default "nax,landlock,lockdown,yama,loadpin,safesetid,integrity,selinux=
,smack,tomoyo,apparmor,bpf"

I don't know the policy with regard to new LSMs, but enabling this one by d=
efault is maybe a bit violent?
That said, considering the default mode is SECURITY_NAX_MODE_LOG, this woul=
d just log kernel messages and
not break existing systems, so this shouldn't be a problem.

>  	help
>  	  A comma-separated list of LSMs, in initialization order.
>  	  Any LSMs left off this list will be ignored. This can be
> diff --git a/security/Makefile b/security/Makefile
> index 47e432900e24..5c261bbf4659 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -14,6 +14,7 @@ subdir-$(CONFIG_SECURITY_SAFESETID)    +=3D safesetid
>  subdir-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+=3D lockdown
>  subdir-$(CONFIG_BPF_LSM)		+=3D bpf
>  subdir-$(CONFIG_SECURITY_LANDLOCK)	+=3D landlock
> +subdir-$(CONFIG_SECURITY_NAX)		+=3D nax
> =20
>  # always enable default capabilities
>  obj-y					+=3D commoncap.o
> @@ -34,6 +35,7 @@ obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+=3D lockdown/
>  obj-$(CONFIG_CGROUPS)			+=3D device_cgroup.o
>  obj-$(CONFIG_BPF_LSM)			+=3D bpf/
>  obj-$(CONFIG_SECURITY_LANDLOCK)		+=3D landlock/
> +obj-$(CONFIG_SECURITY_NAX)		+=3D nax/
> =20
>  # Object integrity file lists
>  subdir-$(CONFIG_INTEGRITY)		+=3D integrity
> diff --git a/security/nax/Kconfig b/security/nax/Kconfig
> new file mode 100644
> index 000000000000..60ef0964f00a
> --- /dev/null
> +++ b/security/nax/Kconfig
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config SECURITY_NAX
> +	bool "NAX support"
> +	depends on SECURITY
> +	default n
> +	help
> +	  This selects NAX (No Anonymous Execution), which extends DAC
> +	  support with additional system-wide security settings beyond
> +	  regular Linux discretionary access controls. Currently available
> +	  is restriction to make anonymous and modified pages executable
> +	  to privileged processes. Like capabilities, this security module
> +	  stacks with other LSMs. Further information can be found in
> +	  Documentation/admin-guide/LSM/NAX.rst.
> +
> +	  If you are unsure how to answer this question, answer N.
> +
> +config SECURITY_NAX_LOCKED
> +	bool "Lock NAX settings"
> +	depends on SECURITY_NAX
> +	help
> +	  If selected, it will not be possible to change enforcing and quiet
> +	  settings via sysctl or the kernel command line. If not selected,
> +	  it can be enabled at boot with the kernel parameter "nax_locked=3D1"
> +	  or "kernel.nax_locked=3D1" sysctl (if the settings are not locked).
> +
> +config SECURITY_NAX_QUIET
> +	bool "Silence NAX messages"
> +	depends on SECURITY_NAX
> +	help
> +	  If selected, NAX will not print violations. If not selected, it can
> +	  be enabled at boot with the kernel parameter "nax_quiet=3D1" or
> +	  "kernel.nax_quiet=3D1" sysctl (if the settings are not locked).
> +

You probably should document the boot option in the kernel-parameters.txt f=
ile.

> +choice
> +	prompt "NAX violation action mode"
> +	default SECURITY_NAX_MODE_LOG
> +	depends on SECURITY_NAX
> +	help
> +	  Select the NAX violation action mode.
> +
> +	  In the default permissive mode the violations are only logged
> +	  (if logging is not suppressed). In the enforcing mode the violations
> +	  are prohibited. And in the kill mode the process is terminated.
> +
> +	  The value can be changed at boot with the kernel parameter
> +	  "nax_mode" (0, 1, 2) or "kernel.nax_mode=3D" (0, 1, 2) sysctl (if the
> +	  settings are not locked).
> +
> +	config SECURITY_NAX_MODE_LOG
> +		bool "Permissive mode"
> +		help
> +		  In this mode violations are only logged (if logging is not
> +		  suppressed).
> +	config SECURITY_NAX_MODE_ENFORCING
> +		bool "Enforcing mode"
> +		help
> +		  In this mode violations are prohibited and logged (if
> +		  logging is not suppressed).
> +	config SECURITY_NAX_MODE_KILL
> +		bool "Kill mode"
> +		help
> +		  In this mode the voilating process is terminated. The event

"violating"

> +		  is logged (if logging is not suppressed).
> +endchoice
> +
> +config SECURITY_NAX_MODE
> +        int
> +        depends on SECURITY_NAX
> +        default 0 if SECURITY_NAX_MODE_LOG
> +        default 1 if SECURITY_NAX_MODE_ENFORCING
> +        default 2 if SECURITY_NAX_MODE_KILL
> diff --git a/security/nax/Makefile b/security/nax/Makefile
> new file mode 100644
> index 000000000000..9c3372210c77
> --- /dev/null
> +++ b/security/nax/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_SECURITY_NAX) :=3D nax.o
> +
> +nax-y :=3D nax-lsm.o
> diff --git a/security/nax/nax-lsm.c b/security/nax/nax-lsm.c
> new file mode 100644
> index 000000000000..ef99d9b36a9d
> --- /dev/null
> +++ b/security/nax/nax-lsm.c
> @@ -0,0 +1,344 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2016-2021 Open Mobile Platform LLC.
> + *
> + * Written by: Igor Zhbanov <i.zhbanov@omp.ru, izh1979@gmail.com>
> + *
> + * NAX (No Anonymous Execution) Linux Security Module
> + * This module prevents execution of the code in anonymous or modified p=
ages.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2, as
> + * published by the Free Software Foundation. */


Per checkpatch:
WARNING: Block comments use a trailing */ on a separate line
#328: FILE: security/nax/nax-lsm.c:48:
+	 * or it has any unsafe capability (even in a user namespace) */

Checkpatch also complains about a few places where you could use tabs inste=
ad
of spaces, or add a space, and so on.

As a general rule, running 'scripts/checkpatch.pl' prior to sending the pat=
ch is
considered a good practice (see 'Documentation/process/submitting-patches.r=
st').

> +
> +#define pr_fmt(fmt) "NAX: " fmt
> +
> +#include <linux/capability.h>
> +#include <linux/cred.h>
> +#include <linux/ctype.h>
> +#include <linux/lsm_hooks.h>
> +#include <linux/mman.h>
> +#include <linux/sched.h>
> +#include <linux/securebits.h>
> +#include <linux/security.h>
> +#include <linux/sysctl.h>
> +#include <linux/uidgid.h>
> +
> +#define NAX_MODE_PERMISSIVE 0 /* Log only             */
> +#define NAX_MODE_ENFORCING  1 /* Enforce and log      */
> +#define NAX_MODE_KILL       2 /* Kill process and log */
> +
> +static int mode   =3D CONFIG_SECURITY_NAX_MODE,
> +	   quiet  =3D IS_ENABLED(CONFIG_SECURITY_NAX_QUIET),
> +	   locked =3D IS_ENABLED(CONFIG_SECURITY_NAX_LOCKED);
> +
> +#define ALLOWED_CAPS_HEX_LEN (_KERNEL_CAPABILITY_U32S * 8)
> +
> +static char allowed_caps_hex[ALLOWED_CAPS_HEX_LEN + 1];
> +static kernel_cap_t allowed_caps =3D CAP_EMPTY_SET;
> +
> +static int
> +is_privileged_process(void)
> +{
> +	const struct cred *cred;
> +	kuid_t root_uid;
> +
> +	cred =3D current_cred();
> +	root_uid =3D make_kuid(cred->user_ns, 0);
> +	/* We count a process as privileged if it any of its IDs is zero
> +	 * or it has any unsafe capability (even in a user namespace) */
> +	if ((!issecure(SECURE_NOROOT) && (uid_eq(cred->uid,   root_uid) ||
> +					  uid_eq(cred->euid,  root_uid) ||
> +					  uid_eq(cred->suid,  root_uid) ||
> +					  uid_eq(cred->fsuid, root_uid))) ||
> +	    (!cap_issubset(cred->cap_effective, allowed_caps)) ||
> +	    (!cap_issubset(cred->cap_permitted, allowed_caps)))
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static void
> +log_warn(const char *reason)
> +{
> +	if (quiet)
> +		return;
> +
> +	pr_warn_ratelimited("%s: pid=3D%d, uid=3D%u, comm=3D\"%s\"\n",
> +		            reason, current->pid,
> +		            from_kuid(&init_user_ns, current_cred()->uid),
> +	                              current->comm);

Have you considered writing to the audit log instead of the kernel messages=
 directly?
(not saying that this is necessarily better, but is there a reasoning to pr=
efer one or
the other here? Audit logs are often consumed by automated tools and it may=
 be more pratical
for people to detect and treat violations if the messages were pushed to th=
e audit log
- but conversely, that requires defining and maintaining a stable log forma=
t for consumers)

> +}
> +
> +static void
> +kill_current_task(void)
> +{
> +	pr_warn("Killing pid=3D%d, uid=3D%u, comm=3D\"%s\"\n",
> +		current->pid, from_kuid(&init_user_ns, current_cred()->uid),
> +		current->comm);

The same question applies here.

> +	force_sig(SIGKILL);
> +}
> +
> +static int
> +nax_mmap_file(struct file *file, unsigned long reqprot,
> +	      unsigned long prot, unsigned long flags)
> +{
> +	int ret =3D 0;
> +
> +	if (mode =3D=3D NAX_MODE_PERMISSIVE && quiet)
> +		return 0; /* Skip further checks in this case */
> +
> +	if (!(prot & PROT_EXEC)) /* Not executable memory */
> +		return 0;
> +
> +	if (!is_privileged_process())
> +		return 0; /* Not privileged processes can do anything */
> +
> +	if (!file) { /* Anonymous executable memory */
> +		log_warn("MMAP_ANON_EXEC");
> +		ret =3D -EACCES;
> +	} else if (prot & PROT_WRITE) { /* Mapping file RWX */
> +		log_warn("MMAP_FILE_WRITE_EXEC");
> +		ret =3D -EACCES;
> +	}
> +
> +	if (mode =3D=3D NAX_MODE_KILL)
> +		kill_current_task();
> +
> +	return (mode !=3D NAX_MODE_PERMISSIVE) ? ret : 0;
> +}
> +
> +static int
> +nax_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
> +		  unsigned long prot)
> +{
> +	if (mode =3D=3D NAX_MODE_PERMISSIVE && quiet)
> +		return 0; /* Skip further checks in this case */
> +
> +	if (!(prot & PROT_EXEC)) /* Not executable memory */
> +		return 0;
> +
> +	if (!is_privileged_process())
> +		return 0; /* Not privileged processes can do anything */
> +
> +	if (!(vma->vm_flags & VM_EXEC)) {
> +		int ret =3D 0;
> +
> +		if (vma->vm_start >=3D vma->vm_mm->start_brk &&
> +		    vma->vm_end   <=3D vma->vm_mm->brk) {
> +			log_warn("MPROTECT_EXEC_HEAP");
> +			ret =3D -EACCES;
> +		} else if (!vma->vm_file &&
> +			   ((vma->vm_start <=3D vma->vm_mm->start_stack &&
> +			     vma->vm_end   >=3D vma->vm_mm->start_stack) ||
> +			    vma_is_stack_for_current(vma))) {
> +			log_warn("MPROTECT_EXEC_STACK");
> +			ret =3D -EACCES;
> +		} else if (vma->vm_file && vma->anon_vma) {
> +			/* We are making executable a file mapping that has
> +			 * had some COW done. Since pages might have been
> +			 * written, check ability to execute the possibly
> +			 * modified content. This typically should only
> +			 * occur for text relocations. */
> +			log_warn("MPROTECT_EXEC_MODIFIED");
> +			ret =3D -EACCES;
> +		}
> +
> +		if (ret) {
> +			if (mode =3D=3D NAX_MODE_KILL)
> +				kill_current_task();
> +
> +			return (mode !=3D NAX_MODE_PERMISSIVE) ? ret : 0;
> +		}
> +	}
> +
> +	return nax_mmap_file(vma->vm_file, reqprot, prot,
> +			     vma->vm_flags & VM_SHARED);

Considering many checks in nax_mmap_file were already done in this function=
,
wouldn't it be simpler to write the rest the function too (and you could di=
stinguish
MRPOTECT_ANON_EXEC and MMAP_ANON_EXEC that way). What do you think of somet=
hing like:

> -
> -		if (ret) {
> -			if (mode =3D=3D NAX_MODE_KILL)
> -				kill_current_task();
> -
> -			return (mode !=3D NAX_MODE_PERMISSIVE) ? ret : 0;
> -		}
> -	}
> -
> -	return nax_mmap_file(vma->vm_file, reqprot, prot,
> -			     vma->vm_flags & VM_SHARED);
> +	} else {
> +		if (!vma->vm_file) { /* Anonymous executable memory */
> +			log_warn("MRPOTECT_ANON_EXEC");
> +			ret =3D -EACCES;
> +		} else if (prot & PROT_WRITE) { /* remapping the file as RWX */
> +			log_warn("MPROTECT_FILE_WRITE_EXEC");
> +			ret =3D -EACCES;
> +		}
> +	}
> +
> +	if (ret && mode =3D=3D NAX_MODE_KILL)
> +		kill_current_task();
> +
> +	return (mode !=3D NAX_MODE_PERMISSIVE) ? ret : 0;


> +}
> +
> +static struct security_hook_list nax_hooks[] __lsm_ro_after_init =3D {
> +	LSM_HOOK_INIT(mmap_file, nax_mmap_file),
> +	LSM_HOOK_INIT(file_mprotect, nax_file_mprotect),
> +};
> +
> +#ifdef CONFIG_SYSCTL
> +
> +static int
> +nax_dointvec_minmax(struct ctl_table *table, int write,
> +		    void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	if (write && (!capable(CAP_SYS_ADMIN) || locked))
> +		return -EPERM;
> +
> +	return proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> +}
> +
> +static int
> +nax_dostring(struct ctl_table *table, int write, void *buffer,
> +             size_t *lenp, loff_t *ppos)
> +{
> +	if (write) {
> +		int error;
> +		char *buf =3D (char *)buffer;
> +		size_t len =3D *lenp, i;
> +		kernel_cap_t caps =3D CAP_EMPTY_SET;

The kernel style guide mandates that all variables are only defined at the =
beggining of the
function, and not at the beggining of any block like C89.

> +
> +		if (!capable(CAP_SYS_ADMIN) || locked)
> +			return -EPERM;
> +
> +		/* Do not allow trailing garbage or excessive length */
> +		if (len =3D=3D ALLOWED_CAPS_HEX_LEN + 1) {
> +			if (buf[--len] !=3D '\n')
> +				return -EINVAL> +		} else if (len > ALLOWED_CAPS_HEX_LEN || len <=3D=
 0)
> +			return -EINVAL;
> +
> +		if ((error =3D proc_dostring(table, write, buffer, lenp, ppos)))
> +			return error;
> +

Nit: considering that allowed_caps_hex is only used in this function, and t=
hat it represents a small amount of
stack space, couldn't you define it directly in the function?

> +		len =3D strlen(allowed_caps_hex);
> +		for (i =3D 0; i < len; i++)
> +			if (!isxdigit(allowed_caps_hex[i]))
> +				return -EINVAL;> +
> +		for (i =3D 0; i < _KERNEL_CAPABILITY_U32S; i++) {
> +			unsigned long l;
> +
> +			if (kstrtoul(allowed_caps_hex +
> +			             (len >=3D 8 ? len - 8 : 0), 16, &l))
> +				return -EINVAL;
> +
> +			caps.cap[i] =3D l;
> +			if (len < 8)
> +				break;
> +
> +			len -=3D 8;
> +			allowed_caps_hex[len] =3D '\0';
> +		}
> +
> +		allowed_caps =3D cap_intersect(caps, CAP_FULL_SET);

This operation doesn't look atomic to me, and I think other operations coul=
dn run while this
write is ongoing.
While users will probably not write to this often (and a proper system woul=
d be locked anyway,
otherwise the attacker would just have to write to the NAX "mode" sysctl to=
 disable it and carry
on his attack), it could break programs (deny the action of kill the proces=
s) that perform a
mmap() or a mprotect() and read garbage in allowed_caps because a write to =
the structure was
running concurrently.

You should maybe consider a way to ensure either the update is atomic or th=
e update is in a
critical section.

> +		return 0;
> +	} else {
> +		unsigned i;
> +
> +		CAP_FOR_EACH_U32(i)
> +			snprintf(allowed_caps_hex + i * 8, 9, "%08x",
> +			         allowed_caps.cap[CAP_LAST_U32 - i]);
> +
> +		return proc_dostring(table, write, buffer, lenp, ppos);
> +	}
> +}
> +
> +struct ctl_path nax_sysctl_path[] =3D {
> +	{ .procname =3D "kernel" },
> +	{ .procname =3D "nax"    },
> +	{ }
> +};
> +
> +static int max_mode =3D NAX_MODE_KILL;
> +
> +static struct ctl_table nax_sysctl_table[] =3D {
> +	{
> +		.procname     =3D "allowed_caps",
> +		.data         =3D allowed_caps_hex,
> +		.maxlen       =3D ALLOWED_CAPS_HEX_LEN + 1,
> +		.mode         =3D 0644,
> +		.proc_handler =3D nax_dostring,
> +	}, {
> +		.procname     =3D "locked",
> +		.data         =3D &locked,
> +		.maxlen       =3D sizeof(int),
> +		.mode         =3D 0644,
> +		.proc_handler =3D nax_dointvec_minmax,
> +		.extra1       =3D SYSCTL_ZERO,
> +		.extra2       =3D SYSCTL_ONE,
> +	}, {
> +		.procname     =3D "mode",
> +		.data         =3D &mode,
> +		.maxlen       =3D sizeof(int),
> +		.mode         =3D 0644,
> +		.proc_handler =3D nax_dointvec_minmax,
> +		.extra1       =3D SYSCTL_ZERO,
> +		.extra2       =3D &max_mode,
> +	}, {
> +		.procname     =3D "quiet",
> +		.data         =3D &quiet,
> +		.maxlen       =3D sizeof(int),
> +		.mode         =3D 0644,
> +		.proc_handler =3D nax_dointvec_minmax,
> +		.extra1       =3D SYSCTL_ZERO,
> +		.extra2       =3D SYSCTL_ONE,
> +	},
> +	{ }
> +};
> +
> +static void __init
> +nax_init_sysctl(void)
> +{
> +	if (!register_sysctl_paths(nax_sysctl_path, nax_sysctl_table))
> +		panic("NAX: sysctl registration failed.\n");
> +}
> +
> +#else /* !CONFIG_SYSCTL */
> +
> +static inline void
> +nax_init_sysctl(void)
> +{
> +
> +}
> +
> +#endif /* !CONFIG_SYSCTL */
> +
> +static int __init setup_mode(char *str)
> +{
> +	unsigned long val;
> +
> +	if (!locked && !kstrtoul(str, 0, &val)) {
> +		if (val > max_mode){
> +			pr_err("Invalid 'nax_mode' parameter value (%s)\n",
> +			       str);
> +			val =3D max_mode;
> +		}
> +
> +		mode =3D val;
> +	}
> +
> +	return 1;
> +}
> +__setup("nax_mode=3D", setup_mode);
> +
> +static int __init setup_quiet(char *str)
> +{
> +	unsigned long val;
> +
> +	if (!locked && !kstrtoul(str, 0, &val))
> +		quiet =3D val ? 1 : 0;

The order of the kernel parameters will have an impact on NAX behavior.

nax_mode=3D1 nax_locked=3D1 and nax_locked=3D1 nax_mode=3D1 will end up wit=
h the same behavior.
in the first case the mode is enforced, in the second case it isn't (well u=
nless you changed
 the kernel configuration from the default) and it can't be enabled later e=
ither.

Is that desired?

> +
> +	return 1;
> +}
> +__setup("nax_quiet=3D", setup_quiet);
> +
> +static int __init setup_locked(char *str)
> +{
> +	unsigned long val;
> +
> +	if (!locked && !kstrtoul(str, 0, &val))
> +		locked =3D val ? 1 : 0;
> +
> +	return 1;
> +}
> +__setup("nax_locked=3D", setup_locked);
> +
> +static __init int
> +nax_init(void)
> +{
> +	pr_info("Starting.\n");
> +	security_add_hooks(nax_hooks, ARRAY_SIZE(nax_hooks), "nax");
> +	nax_init_sysctl();
> +
> +	return 0;
> +}
> +
> +DEFINE_LSM(nax) =3D {
> +	.name =3D "nax",
> +	.init =3D nax_init,
> +};
>=20

Review aside, this patch is certainly interesting for providing a simple wa=
y to block anonymous excutable mappins,
so thanks for the submission.
I have to wonder: wouldn't it be interesting to add an option to enable NAX=
 for all processes on the system,
as you mentioned in the cover letter?

Have a nice day,
Simon
