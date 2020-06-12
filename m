Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5401F7A72
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jun 2020 17:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgFLPL5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Jun 2020 11:11:57 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2304 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726286AbgFLPL4 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Jun 2020 11:11:56 -0400
Received: from lhreml705-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 6750ADA06B09320AA0F5;
        Fri, 12 Jun 2020 16:11:54 +0100 (IST)
Received: from fraeml704-chm.china.huawei.com (10.206.15.53) by
 lhreml705-chm.china.huawei.com (10.201.108.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 12 Jun 2020 16:11:54 +0100
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 12 Jun 2020 17:11:53 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1913.007;
 Fri, 12 Jun 2020 17:11:53 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Maurizio Drocco <maurizio.drocco@ibm.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>
CC:     "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: [PATCH] extend IMA boot_aggregate with kernel measurements
Thread-Topic: [PATCH] extend IMA boot_aggregate with kernel measurements
Thread-Index: AQHWQCo8nqt7HKCznkGnNWX+y9c+NajT/1SAgADtAgCAACbgMA==
Date:   Fri, 12 Jun 2020 15:11:53 +0000
Message-ID: <380af929b2d2440a9dc35ba0b374247d@huawei.com>
References: <1591921795.11061.12.camel@linux.ibm.com>
 <20200612143812.1609-1-maurizio.drocco@ibm.com>
In-Reply-To: <20200612143812.1609-1-maurizio.drocco@ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.220.96.108]
Content-Type: multipart/mixed;
        boundary="_002_380af929b2d2440a9dc35ba0b374247dhuaweicom_"
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--_002_380af929b2d2440a9dc35ba0b374247dhuaweicom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> From: linux-integrity-owner@vger.kernel.org [mailto:linux-integrity-
> owner@vger.kernel.org] On Behalf Of Maurizio Drocco
> Sent: Friday, June 12, 2020 4:38 PM
> IMA is not considering TPM registers 8-9 when calculating the boot
> aggregate. When registers 8-9 are used to store measurements of the
> kernel and its command line (e.g., grub2 bootloader with tpm module
> enabled), IMA should include them in the boot aggregate.
>=20
> Signed-off-by: Maurizio Drocco <maurizio.drocco@ibm.com>
> ---
>  security/integrity/ima/ima.h        |  2 +-
>  security/integrity/ima/ima_crypto.c | 15 ++++++++++++++-
>  2 files changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index df93ac258e01..9d94080bdad8 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -30,7 +30,7 @@
>=20
>  enum ima_show_type { IMA_SHOW_BINARY,
> IMA_SHOW_BINARY_NO_FIELD_LEN,
>  		     IMA_SHOW_BINARY_OLD_STRING_FMT,
> IMA_SHOW_ASCII };
> -enum tpm_pcrs { TPM_PCR0 =3D 0, TPM_PCR8 =3D 8 };
> +enum tpm_pcrs { TPM_PCR0 =3D 0, TPM_PCR8 =3D 8, TPM_PCR10 =3D 10 };
>=20
>  /* digest size for IMA, fits SHA1 or MD5 */
>  #define IMA_DIGEST_SIZE		SHA1_DIGEST_SIZE
> diff --git a/security/integrity/ima/ima_crypto.c
> b/security/integrity/ima/ima_crypto.c
> index 220b14920c37..64f5e3151e18 100644
> --- a/security/integrity/ima/ima_crypto.c
> +++ b/security/integrity/ima/ima_crypto.c
> @@ -809,7 +809,7 @@ static void ima_pcrread(u32 idx, struct tpm_digest *d=
)
>  static int ima_calc_boot_aggregate_tfm(char *digest, u16 alg_id,
>  				       struct crypto_shash *tfm)
>  {
> -	struct tpm_digest d =3D { .alg_id =3D alg_id, .digest =3D {0} };
> +	struct tpm_digest d =3D { .alg_id =3D alg_id, .digest =3D {0} }, d0 =3D=
 d;
>  	int rc;
>  	u32 i;
>  	SHASH_DESC_ON_STACK(shash, tfm);
> @@ -830,6 +830,19 @@ static int ima_calc_boot_aggregate_tfm(char
> *digest, u16 alg_id,
>  		rc =3D crypto_shash_update(shash, d.digest,
>  					 crypto_shash_digestsize(tfm));
>  	}
> +	/*
> +	 * extend cumulative sha1 over tpm registers 8-9, which contain

Hi Maurizio

with recent patches, boot_aggregate can be calculated from non-SHA1
PCR banks. I would replace with:

Extend cumulative digest over ...

Given that with this patch boot_aggregate is calculated differently,
shouldn't we call it boot_aggregate_v2 and enable it with a new
option?

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

> +	 * measurement for the kernel command line (reg. 8) and image
> (reg. 9)
> +	 * in a typical PCR allocation.
> +	 */
> +	for (i =3D TPM_PCR8; i < TPM_PCR10; i++) {
> +		ima_pcrread(i, &d);
> +		/* if not zero, accumulate with current aggregate */
> +		if (memcmp(d.digest, d0.digest,
> +			   crypto_shash_digestsize(tfm)) !=3D 0)
> +			rc =3D crypto_shash_update(shash, d.digest,
> +
> crypto_shash_digestsize(tfm));
> +	}
>  	if (!rc)
>  		crypto_shash_final(shash, digest);
>  	return rc;
> --
> 2.17.1


--_002_380af929b2d2440a9dc35ba0b374247dhuaweicom_
Content-Type: message/rfc822
Content-Disposition: attachment;
	creation-date="Fri, 12 Jun 2020 15:11:53 GMT";
	modification-date="Fri, 12 Jun 2020 15:11:53 GMT"

Received: from fraeml709-chm.china.huawei.com (10.206.15.37) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5
 via Mailbox Transport; Thu, 28 May 2020 09:33:39 +0200
Received: from fraeml703-chm.china.huawei.com (10.206.15.52) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Thu, 28 May 2020 09:33:39 +0200
Received: from fraeml703-chm.china.huawei.com (10.206.15.52) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 28 May 2020 09:33:38 +0200
Received: from DGGEMS412-HUB.china.huawei.com (10.3.19.212) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA_P256) id
 15.1.1913.5 via Frontend Transport; Thu, 28 May 2020 09:33:38 +0200
Received: from hulknmm (10.175.113.134) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 28 May
 2020 15:33:32 +0800
From: pmail_patchwork <patchwork@huawei.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
CC: pmail_hulkcommits <hulkcommits@huawei.com>, pmail_hulkcommits
	<hulkcommits@huawei.com>
Subject: re: [PATCH 9/9] ima: Don't remove security.ima if file must not be
 appraised
Thread-Topic: [PATCH 9/9] ima: Don't remove security.ima if file must not be
 appraised
Thread-Index: AQHWNMJOo5mVCMbjDE6NnqkX1hFZvg==
Date: Thu, 28 May 2020 08:03:43 +0000
Message-ID: <20200528080343.54677.49365@hulknmm>
References: <20200528065732.22351-4-roberto.sassu@huawei.com>
In-Reply-To: <20200528065732.22351-4-roberto.sassu@huawei.com>
Content-Language: en-US
X-MS-Exchange-Organization-AuthMechanism: 06
X-MS-Exchange-Organization-AuthSource: DGGEMS412-HUB.china.huawei.com
X-MS-Has-Attach:
X-MS-Exchange-Organization-Network-Message-Id: f8904490-833d-4cc6-2086-08d802d9700c
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
x-ms-exchange-organization-originalserveripaddress: 10.3.19.212
x-ms-exchange-organization-originalclientipaddress: 10.175.113.134
Content-Type: text/plain; charset="utf-8"
Content-ID: <0235E133B9F18A49A545EE45BB2C6001@huawei.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0

VG90YWw6IDAgd2FybmluZ3MsIDAgZXJyb3JzLCAzIGl0ZW1zIGNoZWNrZWQNCg0KQWxsIDMgdGVz
dCBpdGVtcyBTVUNDRVNTLg0KDQpMaW5rOiBodHRwOi8vcGF0Y2h3b3JrLmh1YXdlaS5jb20vcGF0
Y2gvNTI4OTAvDQoNCi0tLQ0KSHVsayBSb2JvdA0K

--_002_380af929b2d2440a9dc35ba0b374247dhuaweicom_--
