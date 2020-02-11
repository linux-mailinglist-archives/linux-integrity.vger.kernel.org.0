Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9228B15963C
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Feb 2020 18:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgBKRdz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Feb 2020 12:33:55 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:55534 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729669AbgBKRdz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Feb 2020 12:33:55 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01BHWZmD127875;
        Tue, 11 Feb 2020 17:33:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=ZTcGVgHgraMOZBpC35dpCZY9cj88Yni9DaxHSLbn1QI=;
 b=ATvl/L3tQz/8dk9eq9GxVgTQvMIfyGT+39ALanE+ImerkpFi8HDNxocHp+jC+HkpcZuE
 cR5oe3qXPp9yUzXKpTjHvvCPsUwUzRog2VGGbFeIpTQ7bAC/5F3KcOx1gZDnJQoSql/U
 EeV+H742SPicBUvTDaxD4QSMaWrp5KWlgWy8/JLBKjxVwJC2ynOoG49Z0UV+azi47Y+z
 eKEOe8JiEL1Hnzh43/RYiX1gPiERrGlVn3tSa4JHsXjG+Gx77q0Sea+bsgq8nbfmjf8v
 GPZ3Xvvbw6a/nkn/y2KaHZVehmChTaAzNvmX70TvhWHJI0S//7U7g40/8K/83HdoZRJc CQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2y2jx656pm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Feb 2020 17:33:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01BHSDoX010841;
        Tue, 11 Feb 2020 17:33:16 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2y26hvarrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Feb 2020 17:33:15 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01BHX5HL032092;
        Tue, 11 Feb 2020 17:33:05 GMT
Received: from dhcp-10-65-186-145.vpn.oracle.com (/10.65.186.145)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Feb 2020 09:33:05 -0800
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH 0/2] ima: uncompressed module appraisal support
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <1581366829.5585.898.camel@linux.ibm.com>
Date:   Tue, 11 Feb 2020 10:33:25 -0700
Cc:     Nayna <nayna@linux.vnet.ibm.com>, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com, dhowells@redhat.com,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        nayna@linux.ibm.com, tglx@linutronix.de, bauerman@linux.ibm.com,
        mpe@ellerman.id.au, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0842A02F-3166-4E29-9CC5-9E4C5057E270@oracle.com>
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
To:     Mimi Zohar <zohar@linux.ibm.com>
X-Mailer: Apple Mail (2.3273)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9528 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=3 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002110122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9528 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=3 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002110122
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Feb 10, 2020, at 1:33 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> On Mon, 2020-02-10 at 12:24 -0700, Eric Snowberg wrote:
>>> On Feb 10, 2020, at 10:09 AM, Mimi Zohar <zohar@linux.ibm.com> =
wrote:
>=20
>>>>=20
>>>> Ok, understood, =E2=80=9Cmodsig=E2=80=9D refers to strictly kernel =
module appended signatures
>>>> without regard to the keyring that verifies it.  Since there are =
inconsistencies
>>>> here, would you consider something like my first patch?  It will =
verify an=20
>>>> uncompressed kernel module containing an appended signature  when =
the public key
>>>> is contained within the kernel keyring instead of the ima keyring.  =
Why force a=20
>>>> person to add the same keys into the ima keyring for validation?  =
Especially when
>>>> the kernel keyring is now used to verify appended signatures in the =
compressed
>>>> modules.
>>>=20
>>> Different use case scenarios have different requirements.  Suppose =
for
>>> example that the group creating the kernel image is not the same as
>>> using it.  The group using the kernel image could sign all files,
>>> including kernel modules (imasig), with their own private key. Only
>>> files that they signed would be permitted.  Your proposal would =
break
>>> the current expectations, allowing kernel modules signed by someone
>>> else to be loaded.
>>>=20
>>=20
>> All the end user needs to do is compress any module created by the =
group that built
>> the original kernel image to work around the scenario above.  Then =
the appended=20
>> signature in the compressed module will be verified by the kernel =
keyring. Does=20
>> this mean there is a security problem that should be fixed, if this =
is a concern?
>=20
> Again, the issue isn't compressed/uncompressed kernel modules, but the
> syscall used to load the kernel module.  IMA can prevent using the the
> init_module syscall.  Refer to the ima_load_data() LOADING_MODULE
> case.

Within the ima_load_data() LOADING_MODULE case, to prevent IMA from =
using
the init_module syscall, is_module_sig_enforced() must return false. =
Currently
when is_module_sig_enforced() returns true, the kernel keyring is always =
used
for verification.

What if I change this part of my patch from

+       if (rc && func =3D=3D MODULE_CHECK)

to

+       sig_enforce =3D is_module_sig_enforced();
+       if (sig_enforce && rc && func =3D=3D MODULE_CHECK)

Now when the init_module syscall is available, finit_module syscall will =
use
both the ima keyring and kernel keyring for verification.  When the
init_module syscall is blocked from use, the finit_module syscall will =
only use
the ima keyring for validation.  I believe this would satisfy both your =
use
case and mine.

