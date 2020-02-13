Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42C9B15C25D
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2020 16:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387726AbgBMPc4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Feb 2020 10:32:56 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48444 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729110AbgBMPcz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Feb 2020 10:32:55 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01DFVL2u087216;
        Thu, 13 Feb 2020 15:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=nLC1XhZL5VR2V0P2gKcFuXLzPZi3XK6RyGdvcBrsv9w=;
 b=DiI/7neUr9RKyLP6yEfLdkG8PapQNmmiHJ0BNCUviMgsNgpKlq7xze5jUrGxI5lvMwgV
 J86upwxKsEsBmNBvCxeMqbb7ryU/5esZXXAwcgqr0TNB+xJFhw7Ts/1d48xRI3CK9mas
 xfGGikCd9Gsna5kl4VUZcva1T7s8W1KNHLjNwW/HI61h5sF0aeIGTNaPqD73GLJnBLRI
 4raRctGYvUAuOvaVb5qT6+8uuuMp92bB+wU41otQNPcGTmwFr64bEa0bzy5e2/i+ou2f
 wOCEzsPu6h7rtzbyFxY3SidoUcbcgzjHTglhZH2Oi4bLrVSgVicV49pKLttyjyuB6v5M kw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2y2p3stmem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Feb 2020 15:32:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01DFTqtC059633;
        Thu, 13 Feb 2020 15:32:06 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2y4k36ujgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 15:32:06 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01DFVtos031481;
        Thu, 13 Feb 2020 15:31:55 GMT
Received: from dhcp-10-65-188-99.vpn.oracle.com (/10.65.188.99)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Feb 2020 07:31:55 -0800
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH 0/2] ima: uncompressed module appraisal support
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <eae8aa2d-1874-ba72-0452-a55bc811bd3d@linux.vnet.ibm.com>
Date:   Thu, 13 Feb 2020 08:32:33 -0700
Cc:     Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com, dhowells@redhat.com,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        nayna@linux.ibm.com, tglx@linutronix.de, bauerman@linux.ibm.com,
        mpe@ellerman.id.au, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A0B7848D-519A-4A81-BFC2-DC86CA995CFD@oracle.com>
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
 <0F13CB66-6962-44AC-A20D-CCBD82B43625@oracle.com>
 <1581354556.5585.827.camel@linux.ibm.com>
 <90E53A33-530B-40FB-9982-2818FFD78D73@oracle.com>
 <1581366829.5585.898.camel@linux.ibm.com>
 <0842A02F-3166-4E29-9CC5-9E4C5057E270@oracle.com>
 <eae8aa2d-1874-ba72-0452-a55bc811bd3d@linux.vnet.ibm.com>
To:     Nayna <nayna@linux.vnet.ibm.com>
X-Mailer: Apple Mail (2.3273)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9530 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=3 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002130120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9530 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 suspectscore=3 mlxlogscore=999 priorityscore=1501 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002130120
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Feb 12, 2020, at 7:04 AM, Nayna <nayna@linux.vnet.ibm.com> wrote:
>=20
>=20
> On 2/11/20 12:33 PM, Eric Snowberg wrote:
>>> On Feb 10, 2020, at 1:33 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>>>=20
>>> On Mon, 2020-02-10 at 12:24 -0700, Eric Snowberg wrote:
>>>>> On Feb 10, 2020, at 10:09 AM, Mimi Zohar <zohar@linux.ibm.com> =
wrote:
>>>>>> Ok, understood, =E2=80=9Cmodsig=E2=80=9D refers to strictly =
kernel module appended signatures
>>>>>> without regard to the keyring that verifies it.  Since there are =
inconsistencies
>>>>>> here, would you consider something like my first patch?  It will =
verify an
>>>>>> uncompressed kernel module containing an appended signature  when =
the public key
>>>>>> is contained within the kernel keyring instead of the ima =
keyring.  Why force a
>>>>>> person to add the same keys into the ima keyring for validation?  =
Especially when
>>>>>> the kernel keyring is now used to verify appended signatures in =
the compressed
>>>>>> modules.
>>>>> Different use case scenarios have different requirements.  Suppose =
for
>>>>> example that the group creating the kernel image is not the same =
as
>>>>> using it.  The group using the kernel image could sign all files,
>>>>> including kernel modules (imasig), with their own private key. =
Only
>>>>> files that they signed would be permitted.  Your proposal would =
break
>>>>> the current expectations, allowing kernel modules signed by =
someone
>>>>> else to be loaded.
>>>>>=20
>>>> All the end user needs to do is compress any module created by the =
group that built
>>>> the original kernel image to work around the scenario above.  Then =
the appended
>>>> signature in the compressed module will be verified by the kernel =
keyring. Does
>>>> this mean there is a security problem that should be fixed, if this =
is a concern?
>>> Again, the issue isn't compressed/uncompressed kernel modules, but =
the
>>> syscall used to load the kernel module.  IMA can prevent using the =
the
>>> init_module syscall.  Refer to the ima_load_data() LOADING_MODULE
>>> case.
>> Within the ima_load_data() LOADING_MODULE case, to prevent IMA from =
using
>> the init_module syscall, is_module_sig_enforced() must return false. =
Currently
>> when is_module_sig_enforced() returns true, the kernel keyring is =
always used
>> for verification.
>>=20
>> What if I change this part of my patch from
>>=20
>> +       if (rc && func =3D=3D MODULE_CHECK)
>>=20
>> to
>>=20
>> +       sig_enforce =3D is_module_sig_enforced();
>> +       if (sig_enforce && rc && func =3D=3D MODULE_CHECK)
>>=20
>> Now when the init_module syscall is available, finit_module syscall =
will use
>> both the ima keyring and kernel keyring for verification.  When the
>> init_module syscall is blocked from use, the finit_module syscall =
will only use
>> the ima keyring for validation.  I believe this would satisfy both =
your use
>> case and mine.
>>=20
> There are two syscalls - init_module, finit_module - and two signature =
verification methods. The problem you are trying to address is the =
finit_module syscall, using both signature verification methods. Why =
enable both signature verification methods ?

I am enabling both in my patch since a person can turn around and use =
the other syscall by=20
simply compressing their module.  Now their module is verified by a =
different keyring.=20
Other than completely disabling the init_module syscall, which we =
don=E2=80=99t do, there is nothing=20
preventing them from doing that.  We have one kernel config per =
architecture. We build
and sign the modules with an appended signature.

I can not predict all the ways someone will use a kernel built from this =
single config. =20
I do believe if someone has IMA working with module verification and =
appended signatures,
some are not going to understand why their module that was compressed =
and loading=20
(via syscall init_module) suddenly fails to load (via syscall =
finit_module) once they=20
uncompress it. =20


