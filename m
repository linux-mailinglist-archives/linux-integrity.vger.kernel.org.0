Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBB5154B89
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Feb 2020 20:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgBFTCG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Feb 2020 14:02:06 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36096 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgBFTCG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Feb 2020 14:02:06 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 016IwCqd163636;
        Thu, 6 Feb 2020 19:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=lH/mJ5tGFIX33JIoc+qsJCjWo7qPkQB0LSW8LE0MD1w=;
 b=o/Lt4WJz0UrQ6SM2iCE9ovbFzloijnS/UyCk/WKSNnVsb8dCMB9LvS2ENzXnO4xnBj9d
 2T+kRryRtQGwQJk6cZgWUGuKkzhiwns0Yq+hmB1FFpohI2CZv3mRUGlBDgYklCN2St7h
 KDLeIqc2Ehvo4EW40UnAvO3J1Jdq8r6JWC8OgazhjSNDjWyvsID3dvBLf+bIcTxBqo/x
 e/EkW5P850FLYgvuTkekpWzE5IvxhgZ2cY3h0bd5HXLnPAhlHa6LpzQdc6wfjFlteoq5
 3c5/U9iG0ZI0KS4cPC/K8j38gaxquWTMtl1ZdnQ0iUPNTcLsKBYI6XplXwPM6IcWQqZu +w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=lH/mJ5tGFIX33JIoc+qsJCjWo7qPkQB0LSW8LE0MD1w=;
 b=VTgkMLbl+d+AdGGYxmhhYYlS96GEW457GVncYqIxmjd2042F20+5mS7EDcQXe4EgkddV
 DuVlrJcB4EFazBIkkxJMEvHHwXi12fhDBbOlBF8QZliXydk9QBSY3hftpNyA3Vv3xZHn
 LIExMfFm84RhxGO57tNgfkd8cIEDtNy6CMjRKlNyHDQ5SOl6O5eoHLs93piuawUNhVsJ
 WfawAw3n32wWKIiAx9c4XfGnJJ99NLaaijk2RaL8Tl5xkqnbTtNlyqI22iEg65ungtaC
 NMQZ6pAIkIO8KSEPbVHmiR2puZRp9qzFR1S60J/H+ZzVUFarP1T3OaSA3qwoB5EvpQXt VA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2xykbpkqwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 19:01:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 016IwX4e177134;
        Thu, 6 Feb 2020 19:01:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2y080dv9e9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 19:01:29 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 016J1Svw004501;
        Thu, 6 Feb 2020 19:01:28 GMT
Received: from dhcp-10-65-154-237.vpn.oracle.com (/10.65.154.237)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Feb 2020 11:01:27 -0800
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH 1/2] ima: Implement support for uncompressed module
 appended signatures
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <1581012329.5585.439.camel@linux.ibm.com>
Date:   Thu, 6 Feb 2020 12:01:26 -0700
Cc:     dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, geert@linux-m68k.org,
        gregkh@linuxfoundation.org, nayna@linux.ibm.com,
        tglx@linutronix.de, bauerman@linux.ibm.com, mpe@ellerman.id.au,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <73919AC1-E13A-4B35-B811-B0FFBC7E8644@oracle.com>
References: <20200206164226.24875-1-eric.snowberg@oracle.com>
 <20200206164226.24875-2-eric.snowberg@oracle.com>
 <1581012329.5585.439.camel@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
X-Mailer: Apple Mail (2.3273)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002060138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002060138
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Feb 6, 2020, at 11:05 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> On Thu, 2020-02-06 at 11:42 -0500, Eric Snowberg wrote:
>> Currently IMA can validate compressed modules containing appended
>> signatures.  This adds the ability to also validate uncompressed
>> modules when appraise_type=3Dimasig|modsig.
>>=20
>> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
>=20
> Your patch description in no way matches the code.
>=20

How about if I changed the description to the following:

Currently IMA can only validate compressed modules containing appended
signatures when appraise_type=3Dimasig|modsig.  An uncompressed module =
that=20
is internally signed must still be ima signed. =20

Add the ability to validate the uncompress module by validating it =
against
keys contained within the .builtin_trusted_keys keyring. Now when using =
a
policy such as:

appraise func=3DMODULE_CHECK appraise_type=3Dimasig|modsig

It will load modules containing an appended signature when either =
compressed
or uncompressed.


>> ---
>> security/integrity/digsig.c           | 9 +++++++--
>> security/integrity/ima/ima_appraise.c | 3 +++
>> security/integrity/integrity.h        | 3 ++-
>> 3 files changed, 12 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/security/integrity/digsig.c =
b/security/integrity/digsig.c
>> index ea1aae3d07b3..5e0c4d04ab9d 100644
>> --- a/security/integrity/digsig.c
>> +++ b/security/integrity/digsig.c
>> @@ -15,6 +15,7 @@
>> #include <linux/key-type.h>
>> #include <linux/digsig.h>
>> #include <linux/vmalloc.h>
>> +#include <linux/verification.h>
>> #include <crypto/public_key.h>
>> #include <keys/system_keyring.h>
>>=20
>> @@ -31,6 +32,7 @@ static const char * const =
keyring_name[INTEGRITY_KEYRING_MAX] =3D {
>> 	".ima",
>> #endif
>> 	".platform",
>> +	".builtin_trusted_keys",
>> };
>>=20
>> #ifdef CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
>> @@ -45,8 +47,11 @@ static struct key *integrity_keyring_from_id(const =
unsigned int id)
>> 		return ERR_PTR(-EINVAL);
>>=20
>> 	if (!keyring[id]) {
>> -		keyring[id] =3D
>> -			request_key(&key_type_keyring, keyring_name[id], =
NULL);
>> +		if (id =3D=3D INTEGRITY_KEYRING_KERNEL)
>> +			keyring[id] =3D VERIFY_USE_SECONDARY_KEYRING;
>> +		else
>> +			keyring[id] =3D request_key(&key_type_keyring,
>> +						  keyring_name[id], =
NULL);
>> 		if (IS_ERR(keyring[id])) {
>> 			int err =3D PTR_ERR(keyring[id]);
>> 			pr_err("no %s keyring: %d\n", keyring_name[id], =
err);
>> diff --git a/security/integrity/ima/ima_appraise.c =
b/security/integrity/ima/ima_appraise.c
>> index 300c8d2943c5..4c009c55d620 100644
>> --- a/security/integrity/ima/ima_appraise.c
>> +++ b/security/integrity/ima/ima_appraise.c
>> @@ -294,6 +294,9 @@ static int modsig_verify(enum ima_hooks func, =
const struct modsig *modsig,
>> 	    func =3D=3D KEXEC_KERNEL_CHECK)
>> 		rc =3D =
integrity_modsig_verify(INTEGRITY_KEYRING_PLATFORM,
>> 					     modsig);
>> +	if (rc && func =3D=3D MODULE_CHECK)
>> +		rc =3D integrity_modsig_verify(INTEGRITY_KEYRING_KERNEL, =
modsig);
>> +
>> 	if (rc) {
>> 		*cause =3D "invalid-signature";
>> 		*status =3D INTEGRITY_FAIL;
>> diff --git a/security/integrity/integrity.h =
b/security/integrity/integrity.h
>> index 73fc286834d7..63f0e6bff0e0 100644
>> --- a/security/integrity/integrity.h
>> +++ b/security/integrity/integrity.h
>> @@ -145,7 +145,8 @@ int integrity_kernel_read(struct file *file, =
loff_t offset,
>> #define INTEGRITY_KEYRING_EVM		0
>> #define INTEGRITY_KEYRING_IMA		1
>> #define INTEGRITY_KEYRING_PLATFORM	2
>> -#define INTEGRITY_KEYRING_MAX		3
>> +#define INTEGRITY_KEYRING_KERNEL	3
>> +#define INTEGRITY_KEYRING_MAX		4
>>=20
>> extern struct dentry *integrity_dir;
>>=20
>=20

