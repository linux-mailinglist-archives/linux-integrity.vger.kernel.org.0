Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A81F2157FDE
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Feb 2020 17:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgBJQf2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Feb 2020 11:35:28 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57422 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbgBJQf2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Feb 2020 11:35:28 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01AGVDEo001662;
        Mon, 10 Feb 2020 16:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=RQ9pZTvjplqFvoHbEpCs+ULgWdcDD96P3hsrSHF9z2s=;
 b=H15vc6CdU8G0Sc0IOKSoIjGAoXbXa2Re+0eDwUTScjgS/2lQENdW9qX8RI4nCgKHpAtP
 hBHSfFnWqnykB++RSkU2sBDcRyhIIa/Lm+hFcVPq9HrV3lZO9/JyW0JF4lVQ0bA5V/gp
 bnQH6vQjME0N6r9QTV7pqYxCjRklPp6iZZbBewzo/vHHxaaYvm/+98OSjvg5+pW6F/U5
 oe7SATs4G6bu6b8tuL3Y6xj/RJ3wTRlIhNL5FPssp/mFoapMvbQyr7/9Q73M3m1SwbmB
 ltFwycW12gF/qz2dZ6I2WWlPmfT9vZTrpSTSb6O5ICV+GMopNMt4pM51FgaPvwfa3eZ8 BA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2y2p3s5j68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Feb 2020 16:34:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01AGS7v8191174;
        Mon, 10 Feb 2020 16:34:44 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2y26ht9auh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Feb 2020 16:34:44 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01AGYW92004956;
        Mon, 10 Feb 2020 16:34:32 GMT
Received: from dhcp-10-65-187-216.vpn.oracle.com (/10.65.187.216)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Feb 2020 08:34:32 -0800
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH 0/2] ima: uncompressed module appraisal support
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <1581205431.5585.645.camel@linux.ibm.com>
Date:   Mon, 10 Feb 2020 09:34:42 -0700
Cc:     Nayna <nayna@linux.vnet.ibm.com>, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com, dhowells@redhat.com,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        nayna@linux.ibm.com, tglx@linutronix.de, bauerman@linux.ibm.com,
        mpe@ellerman.id.au, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0F13CB66-6962-44AC-A20D-CCBD82B43625@oracle.com>
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
 <C25E5885-F00B-48C0-AEF1-FA3014B2FDA6@oracle.com>
 <1581205431.5585.645.camel@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
X-Mailer: Apple Mail (2.3273)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9527 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=3 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9527 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 suspectscore=3 mlxlogscore=999 priorityscore=1501 clxscore=1011
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002100123
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Feb 8, 2020, at 4:43 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> On Fri, 2020-02-07 at 14:38 -0700, Eric Snowberg wrote:
>>> On Feb 7, 2020, at 11:54 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>>>=20
>>> On Fri, 2020-02-07 at 11:45 -0700, Eric Snowberg wrote:
>>>>=20
>>>>> On Feb 7, 2020, at 11:28 AM, Mimi Zohar <zohar@linux.ibm.com> =
wrote:
>>>>>=20
>>>>> On Fri, 2020-02-07 at 10:49 -0700, Eric Snowberg wrote:
>>>>>>=20
>>>>>>> On Feb 7, 2020, at 10:40 AM, Mimi Zohar <zohar@linux.ibm.com> =
wrote:
>>>>>>>=20
>>>>>>>> $ insmod ./foo.ko
>>>>>>>> insmod: ERROR: could not insert module ./foo.ko: Permission =
denied
>>>>>>>>=20
>>>>>>>> last entry from audit log:
>>>>>>>> type=3DINTEGRITY_DATA msg=3Daudit(1581089373.076:83): pid=3D2874 =
uid=3D0
>>>>>>>> auid=3D0 ses=3D1 =
subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-
>>>>>>>> s0:c0.c1023 op=3Dappraise_data cause=3Dinvalid-signature =
comm=3D"insmod"
>>>>>>>> name=3D"/root/keys/modules/foo.ko" dev=3D"dm-0" ino=3D10918365
>>>>>>>> res=3D0^]UID=3D"root" AUID=3D=E2=80=9Croot"
>>>>>>>>=20
>>>>>>>> This is because modsig_verify() will be called from within
>>>>>>>> ima_appraise_measurement(),=20
>>>>>>>> since try_modsig is true.  Then modsig_verify() will return
>>>>>>>> INTEGRITY_FAIL.
>>>>>>>=20
>>>>>>> Why is it an "invalid signature"?  For that you need to look at =
the
>>>>>>> kernel messages.  Most likely it can't find the public key on =
the .ima
>>>>>>> keyring to verify the signature.
>>>>>>=20
>>>>>> It is invalid because the module has not been ima signed.=20
>>>>>=20
>>>>> With the IMA policy rule "appraise func=3DMODULE_CHECK
>>>>> appraise_type=3Dimasig|modsig", IMA first tries to verify the IMA
>>>>> signature stored as an xattr and on failure then attempts to =
verify
>>>>> the appended signatures.
>>>>>=20
>>>>> The audit message above indicates that there was a signature, but =
the
>>>>> signature validation failed.
>>>>>=20
>>>>=20
>>>> I do have  CONFIG_IMA_APPRAISE_MODSIG enabled.  I believe the audit =
message above=20
>>>> is coming from modsig_verify in =
security/integrity/ima/ima_appraise.c.
>>>=20
>>> Right, and it's calling:
>>>=20
>>> 	rc =3D integrity_modsig_verify(INTEGRITY_KEYRING_IMA, modsig);
>>>=20
>>> It's failing because it is trying to find the public key on the .ima
>>> keyring.  Make sure that the public needed to validate the kernel
>>> module is on the IMA keyring (eg. keyctl show %keyring:.ima).
>>>=20
>>=20
>> I know that will validate the module properly, but that is not what =
I=E2=80=99m=20
>> trying to solve here. I thought the point of adding =E2=80=9C|modsig=E2=
=80=9D to the
>> ima policy was to tell ima it can either validate against an ima =
keyring OR=20
>> default back to the kernel keyring.  This is what happens with the =
compressed
>> module.  There isn=E2=80=99t anything in the ima keyring to validate =
the compressed
>> modules and it loads when I add =E2=80=9C|modsig=E2=80=9D.
>=20
> "modsig" has nothing to do with keyrings.  The term "modsig" is
> juxtaposed to "imasig".  "modsig" refers to kernel module appended
> signature.=20

Ok, understood, =E2=80=9Cmodsig=E2=80=9D refers to strictly kernel =
module appended signatures
without regard to the keyring that verifies it.  Since there are =
inconsistencies
here, would you consider something like my first patch?  It will verify =
an=20
uncompressed kernel module containing an appended signature  when the =
public key
is contained within the kernel keyring instead of the ima keyring.  Why =
force a=20
person to add the same keys into the ima keyring for validation?  =
Especially when
the kernel keyring is now used to verify appended signatures in the =
compressed
modules.

>=20
>>=20
>> The use case I=E2=80=99m trying to solve is when someone boots with =
ima_policy=3Dsecure_boot.
>=20
> As the secure_boot policy rules are replaced once a custom policy is
> loaded, the "secure_boot" policy should probably be deprecated.  I
> highly recommend using the more recent build time and architecture
> specific run time policy rules, which persist after loading a custom
> policy.=20

I found the secure_boot policy useful, until a custom policy got loaded. =
 But if it
is targeted to be deprecated, I=E2=80=99ll drop my second patch.  I will =
look at the run
time policy rules instead. Thanks.

