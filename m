Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52F7F155D2C
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2020 18:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgBGRt4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Feb 2020 12:49:56 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59658 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgBGRt4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Feb 2020 12:49:56 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 017HmkZp050252;
        Fri, 7 Feb 2020 17:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=RTs6EzkQyZpY9uI3sYju+2g7EaxL/jymBSz4p3QRn+g=;
 b=QLAhs+QM4h3xQ4+TRIhScSfY7nsbYuTsAnIeSfGr9Rp87rlrksP1QLjQM+dYc5PU8CrV
 odphPHMgiYb875ko6B7+msUmnba8Ldj/3zJuREb65+yEpJP9AvetxMsVTTzmcXY4Qu/V
 3xmQeGLHtxhWhR4Eh6je6hOlZwBviyE9dfNfA3/Z/GnR+qqmPjhIux97zjkFBbXVcnsj
 D58+VlOI3UPpkfJoz9J3fP+7bHVeRV52+d/Vf9f3LlwLmi4rzlwCkNrbpcAT2m6WMqgB
 iky28MlnynQIv5hcV7+/F1L0kwmOHgbDbw8DtLee1XF+apCT4tN8jWRNrpfP35lagIFU ig== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2xykbphecx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Feb 2020 17:49:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 017Hn5RH177502;
        Fri, 7 Feb 2020 17:49:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2y0mk2y4tw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Feb 2020 17:49:23 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 017HnLnq013730;
        Fri, 7 Feb 2020 17:49:21 GMT
Received: from dhcp-10-65-154-58.vpn.oracle.com (/10.65.154.58)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Feb 2020 09:49:21 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RFC PATCH 0/2] ima: uncompressed module appraisal support
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <1581097201.5585.613.camel@linux.ibm.com>
Date:   Fri, 7 Feb 2020 10:49:19 -0700
Cc:     Nayna <nayna@linux.vnet.ibm.com>, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com, dhowells@redhat.com,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        nayna@linux.ibm.com, tglx@linutronix.de, bauerman@linux.ibm.com,
        mpe@ellerman.id.au, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <764C5FC8-DF0C-4B7A-8B5B-FD8B83F31568@oracle.com>
References: <20200206164226.24875-1-eric.snowberg@oracle.com>
 <5c246616-9a3a-3ed2-c1f9-f634cef511c9@linux.vnet.ibm.com>
 <09D68C13-75E2-4BD6-B4E6-F765B175C7FD@oracle.com>
 <1581087096.5585.597.camel@linux.ibm.com>
 <330BDFAC-E778-4E9D-A2D2-DD81B745F6AB@oracle.com>
 <1581097201.5585.613.camel@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002070132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002070132
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



> On Feb 7, 2020, at 10:40 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> On Fri, 2020-02-07 at 09:57 -0700, Eric Snowberg wrote:
>>> On Feb 7, 2020, at 7:51 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>>>=20
>>> On Thu, 2020-02-06 at 14:40 -0700, Eric Snowberg wrote:
>>>=20
>>> <snip>
>>>=20
>>>> Currently the upstream code will fail if the module is =
uncompressed.
>>>> If you compress the same module it will load with the current
>>>> upstream code.
>>>>=20
>>>>> Lastly, there is nothing in these patches that indicate that the
>>>> kernel modules being compressed/uncompressed is related to the
>>>> signature verification.
>>>>>=20
>>>>=20
>>>> Basically if you have the following setup:
>>>>=20
>>>> Kernel built with CONFIG_IMA_ARCH_POLICY or kernel booted with
>>>> module.sig_enforce=3D1 along with the following ima policy:
>>>>=20
>>>> appraise func=3DMODULE_CHECK appraise_type=3Dimasig|modsig
>>>=20
>>> Enabling CONFIG_IMA_ARCH_POLICY or module.sig_enforce=3D1 behave =
totally
>>> differently.  CONFIG_IMA_ARCH_POLICY coordinates between the IMA
>>> signature verification and the original module_sig_check()
>>> verification.  Either one signature verification method is enabled =
or
>>> the other, but not both.
>>>=20
>>> The existing IMA x86 arch policy has not been updated to support
>>> appended signatures.
>>=20
>> That is not what I=E2=80=99m seeing.  Appended signatures mostly =
work.  They just
>> don=E2=80=99t work thru the finit_module system call.
>>=20
>>> To understand what is happening, we need to analyze each scenario
>>> separately.
>>>=20
>>> - If CONFIG_MODULE_SIG is configured or enabled on the boot command
>>> line ("module.sig_enforce =3D 1"), then the IMA arch x86 policy WILL =
NOT
>>> require an IMA signature.
>>=20
>> All tests below are without my change
>> x86 booted with module.sig_enforce=3D1
>>=20
>> empty ima policy
>=20
> Sure, in this example the IMA arch x86 policy is not configured and
> there is no custom IMA policy - no IMA.
>=20
>> $ cat /sys/kernel/security/ima/policy
>=20
> On a real system, you would want to require a signed IMA policy.
>=20
>> $ insmod ./foo.ko.xz   <=E2=80=94 loads ok
>> $ rmmod foo
>> $ unxz ./foo.ko.xz
>> $ insmod ./foo.ko      <=E2=80=94 loads ok
>> $ rmmod foo
>>=20
>> add in module appraisal=20
>=20
> Sure, the current system=20
>=20
>> $ echo "appraise func=3DMODULE_CHECK appraise_type=3Dimasig|modsig" >
>> /sys/kernel/security/ima/policy
>>=20
>> $ insmod ./foo.ko.xz   <=E2=80=94 loads ok
>> $ rmmod foo
>=20
> Sure, CONFIG_MODULE_SIG is configured or enabled on the boot command
> line ("module.sig_enforce =3D 1").  IMA won't prevent the =
init_module()
> syscall.
>=20
>>=20
>> $ insmod ./foo.ko
>> insmod: ERROR: could not insert module ./foo.ko: Permission denied
>>=20
>> last entry from audit log:
>> type=3DINTEGRITY_DATA msg=3Daudit(1581089373.076:83): pid=3D2874 =
uid=3D0
>> auid=3D0 ses=3D1 subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-
>> s0:c0.c1023 op=3Dappraise_data cause=3Dinvalid-signature =
comm=3D"insmod"
>> name=3D"/root/keys/modules/foo.ko" dev=3D"dm-0" ino=3D10918365
>> res=3D0^]UID=3D"root" AUID=3D=E2=80=9Croot"
>>=20
>> This is because modsig_verify() will be called from within
>> ima_appraise_measurement(),=20
>> since try_modsig is true.  Then modsig_verify() will return
>> INTEGRITY_FAIL.
>=20
> Why is it an "invalid signature"?  For that you need to look at the
> kernel messages.  Most likely it can't find the public key on the .ima
> keyring to verify the signature.

It is invalid because the module has not been ima signed.=20

