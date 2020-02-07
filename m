Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1038A1560C0
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2020 22:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgBGViy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Feb 2020 16:38:54 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53168 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgBGViy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Feb 2020 16:38:54 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 017LcIcq017985;
        Fri, 7 Feb 2020 21:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=2D7uz5QaJA0q+6LKxaLb65KcnuN/MeJW2O8h52/HjzQ=;
 b=cgFOsXwGT0/yxhwF4pXM2EpankNYRy1heRwcrkchtOKS8C2KNp19v2P/zQBLAQe3/CUb
 ObPJuw/LwTn75pWUFIf+QO6N3RcvoaRuRBBvCt603CRRsSPwzaGKy72xcb2Z/zuA/bwF
 joHEKaB0BoV7fe2HA9oZW+7yk4Mkl6C4wN9LYbPbcD/Q74ZfUx4Cl/Tt7Cq/pMmmfpYN
 kQ86V0pcsvU3aCa46WBaKvOge9jxfTYZIsY8nanJwDcWNAkE7gD4/uNvFdIbrWIRF8uM
 UBlGEt9/bHsx8o5ZOSQ8rA8ZPhqUhK3VCoofFozKKC838jWbScnYvNdj36rxwS3rIyPZ Nw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2xykbpjh5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Feb 2020 21:38:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 017LDah6080102;
        Fri, 7 Feb 2020 21:38:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2y0mk44bme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Feb 2020 21:38:17 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 017Lc87F028473;
        Fri, 7 Feb 2020 21:38:08 GMT
Received: from dhcp-10-65-179-106.vpn.oracle.com (/10.65.179.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Feb 2020 13:38:08 -0800
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH 0/2] ima: uncompressed module appraisal support
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <1581101672.5585.628.camel@linux.ibm.com>
Date:   Fri, 7 Feb 2020 14:38:07 -0700
Cc:     Nayna <nayna@linux.vnet.ibm.com>, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com, dhowells@redhat.com,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        nayna@linux.ibm.com, tglx@linutronix.de, bauerman@linux.ibm.com,
        mpe@ellerman.id.au, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C25E5885-F00B-48C0-AEF1-FA3014B2FDA6@oracle.com>
References: <20200206164226.24875-1-eric.snowberg@oracle.com>
 <5c246616-9a3a-3ed2-c1f9-f634cef511c9@linux.vnet.ibm.com>
 <09D68C13-75E2-4BD6-B4E6-F765B175C7FD@oracle.com>
 <1581087096.5585.597.camel@linux.ibm.com>
 <330BDFAC-E778-4E9D-A2D2-DD81B745F6AB@oracle.com>
 <1581097201.5585.613.camel@linux.ibm.com>
 <764C5FC8-DF0C-4B7A-8B5B-FD8B83F31568@oracle.com>
 <1581100125.5585.623.camel@linux.ibm.com>
 <992E95D5-D4B9-4913-A36F-BB47631DFE0A@oracle.com>
 <1581101672.5585.628.camel@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
X-Mailer: Apple Mail (2.3273)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9524 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002070152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9524 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002070153
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Feb 7, 2020, at 11:54 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> On Fri, 2020-02-07 at 11:45 -0700, Eric Snowberg wrote:
>>=20
>>> On Feb 7, 2020, at 11:28 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>>>=20
>>> On Fri, 2020-02-07 at 10:49 -0700, Eric Snowberg wrote:
>>>>=20
>>>>> On Feb 7, 2020, at 10:40 AM, Mimi Zohar <zohar@linux.ibm.com> =
wrote:
>>>>>=20
>>>>>> $ insmod ./foo.ko
>>>>>> insmod: ERROR: could not insert module ./foo.ko: Permission =
denied
>>>>>>=20
>>>>>> last entry from audit log:
>>>>>> type=3DINTEGRITY_DATA msg=3Daudit(1581089373.076:83): pid=3D2874 =
uid=3D0
>>>>>> auid=3D0 ses=3D1 subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-
>>>>>> s0:c0.c1023 op=3Dappraise_data cause=3Dinvalid-signature =
comm=3D"insmod"
>>>>>> name=3D"/root/keys/modules/foo.ko" dev=3D"dm-0" ino=3D10918365
>>>>>> res=3D0^]UID=3D"root" AUID=3D=E2=80=9Croot"
>>>>>>=20
>>>>>> This is because modsig_verify() will be called from within
>>>>>> ima_appraise_measurement(),=20
>>>>>> since try_modsig is true.  Then modsig_verify() will return
>>>>>> INTEGRITY_FAIL.
>>>>>=20
>>>>> Why is it an "invalid signature"?  For that you need to look at =
the
>>>>> kernel messages.  Most likely it can't find the public key on the =
.ima
>>>>> keyring to verify the signature.
>>>>=20
>>>> It is invalid because the module has not been ima signed.=20
>>>=20
>>> With the IMA policy rule "appraise func=3DMODULE_CHECK
>>> appraise_type=3Dimasig|modsig", IMA first tries to verify the IMA
>>> signature stored as an xattr and on failure then attempts to verify
>>> the appended signatures.
>>>=20
>>> The audit message above indicates that there was a signature, but =
the
>>> signature validation failed.
>>>=20
>>=20
>> I do have  CONFIG_IMA_APPRAISE_MODSIG enabled.  I believe the audit =
message above=20
>> is coming from modsig_verify in =
security/integrity/ima/ima_appraise.c.
>=20
> Right, and it's calling:
>=20
> 	rc =3D integrity_modsig_verify(INTEGRITY_KEYRING_IMA, modsig);
>=20
> It's failing because it is trying to find the public key on the .ima
> keyring.  Make sure that the public needed to validate the kernel
> module is on the IMA keyring (eg. keyctl show %keyring:.ima).
>=20

I know that will validate the module properly, but that is not what =
I=E2=80=99m=20
trying to solve here. I thought the point of adding =E2=80=9C|modsig=E2=80=
=9D to the
ima policy was to tell ima it can either validate against an ima keyring =
OR=20
default back to the kernel keyring.  This is what happens with the =
compressed
module.  There isn=E2=80=99t anything in the ima keyring to validate the =
compressed
modules and it loads when I add =E2=80=9C|modsig=E2=80=9D.

The use case I=E2=80=99m trying to solve is when someone boots with =
ima_policy=3Dsecure_boot.
If their initramfs contains compressed modules with appended signatures =
the
system boots.  If they use the same ima policy with an initramfs that =
contains
uncompressed modules, it doesn't boot.  I thought the point of adding =
=E2=80=9C|modsig=E2=80=9D
was to help with the initramfs problem, since it is difficult to ima =
sign
things within it.

