Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67773155C3F
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2020 17:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgBGQ6C (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Feb 2020 11:58:02 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54422 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgBGQ6C (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Feb 2020 11:58:02 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 017GmxMF175776;
        Fri, 7 Feb 2020 16:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=UJrzqAOtHN3EPMrQQMuVrehYxabXNBBPbGEiRjT9SJ8=;
 b=NAUHt0m7u67sMSZ3BHq2rwFZGSqm8x8SS7t5+YXTs+swCGWEO7pwLzyCuMqC6QQi8Cki
 pHTrDlGvPHDtPdoBAnS2SQXD5UYC6EPZVTlmQ3eUArKWf5PesTrL4uwkljjtmRk+fG15
 xseeUB/Ghm2ys0ZFOyfhHttP8Qic+ousu1DudnfWGCw4oXRVPtVX0K5UnR4VNd0tTZ3U
 vxFE0WPsAayysyoAH81WOTctgLQkZjZZBulbj0e0CJ+PkwaVVUILmIcaWTFUAeHAscwX
 qgMa3HWT3cVYQP6oUKLwwQxUg3DnFJYzU5CtA7EnOUEFc9bR3AVWJx2JMv/4xpgzuj5n fg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2xykbph627-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Feb 2020 16:57:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 017Gorps001194;
        Fri, 7 Feb 2020 16:57:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2y0jg1vb2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Feb 2020 16:57:29 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 017GvKSh003888;
        Fri, 7 Feb 2020 16:57:20 GMT
Received: from dhcp-10-65-179-106.vpn.oracle.com (/10.65.179.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Feb 2020 08:57:20 -0800
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH 0/2] ima: uncompressed module appraisal support
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <1581087096.5585.597.camel@linux.ibm.com>
Date:   Fri, 7 Feb 2020 09:57:18 -0700
Cc:     Nayna <nayna@linux.vnet.ibm.com>, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com, dhowells@redhat.com,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        nayna@linux.ibm.com, tglx@linutronix.de, bauerman@linux.ibm.com,
        mpe@ellerman.id.au, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <330BDFAC-E778-4E9D-A2D2-DD81B745F6AB@oracle.com>
References: <20200206164226.24875-1-eric.snowberg@oracle.com>
 <5c246616-9a3a-3ed2-c1f9-f634cef511c9@linux.vnet.ibm.com>
 <09D68C13-75E2-4BD6-B4E6-F765B175C7FD@oracle.com>
 <1581087096.5585.597.camel@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
X-Mailer: Apple Mail (2.3273)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002070124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002070124
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Feb 7, 2020, at 7:51 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> On Thu, 2020-02-06 at 14:40 -0700, Eric Snowberg wrote:
>=20
> <snip>
>=20
>> Currently the upstream code will fail if the module is uncompressed.
>> If you compress the same module it will load with the current
>> upstream code.
>>=20
>>> Lastly, there is nothing in these patches that indicate that the
>> kernel modules being compressed/uncompressed is related to the
>> signature verification.
>>> =20
>>=20
>> Basically if you have the following setup:
>>=20
>> Kernel built with CONFIG_IMA_ARCH_POLICY or kernel booted with
>> module.sig_enforce=3D1 along with the following ima policy:
>>=20
>> appraise func=3DMODULE_CHECK appraise_type=3Dimasig|modsig
>=20
> Enabling CONFIG_IMA_ARCH_POLICY or module.sig_enforce=3D1 behave =
totally
> differently.  CONFIG_IMA_ARCH_POLICY coordinates between the IMA
> signature verification and the original module_sig_check()
> verification.  Either one signature verification method is enabled or
> the other, but not both.
>=20
> The existing IMA x86 arch policy has not been updated to support
> appended signatures.

That is not what I=E2=80=99m seeing.  Appended signatures mostly work.  =
They just
don=E2=80=99t work thru the finit_module system call.

> To understand what is happening, we need to analyze each scenario
> separately.
>=20
> - If CONFIG_MODULE_SIG is configured or enabled on the boot command
> line ("module.sig_enforce =3D 1"), then the IMA arch x86 policy WILL =
NOT
> require an IMA signature.

All tests below are without my change
x86 booted with module.sig_enforce=3D1

empty ima policy
$ cat /sys/kernel/security/ima/policy
$ insmod ./foo.ko.xz   <=E2=80=94 loads ok
$ rmmod foo
$ unxz ./foo.ko.xz
$ insmod ./foo.ko      <=E2=80=94 loads ok
$ rmmod foo

add in module appraisal=20
$ echo "appraise func=3DMODULE_CHECK appraise_type=3Dimasig|modsig" > =
/sys/kernel/security/ima/policy

$ insmod ./foo.ko.xz   <=E2=80=94 loads ok
$ rmmod foo

$ insmod ./foo.ko
insmod: ERROR: could not insert module ./foo.ko: Permission denied

last entry from audit log:
type=3DINTEGRITY_DATA msg=3Daudit(1581089373.076:83): pid=3D2874 uid=3D0 =
auid=3D0 ses=3D1 =
subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 =
op=3Dappraise_data cause=3Dinvalid-signature comm=3D"insmod" =
name=3D"/root/keys/modules/foo.ko" dev=3D"dm-0" ino=3D10918365 =
res=3D0^]UID=3D"root" AUID=3D=E2=80=9Croot"

This is because modsig_verify() will be called from within =
ima_appraise_measurement(),=20
since try_modsig is true.  Then modsig_verify() will return =
INTEGRITY_FAIL.

If I build with CONFIG_IMA_ARCH_POLICY & CONFIG_MODULE_SIG all tests =
work the same above,
I just don=E2=80=99t have to add module.sig_enforce=3D1 when I boot.

Adding my change will allow foo.ko to load above when =E2=80=9C|modsig=E2=80=
=9D is added, since it will now evaluate=20
the module. Without my change the =E2=80=9Cimsig|modsig=E2=80=9D is true =
for compressed, but the policy is really=20
=E2=80=9Cimasig&modsig=E2=80=9D for uncompressed.


> - If CONFIG_MODULE_SIG is NOT configured or enabled on the boot
> command line, then the IMA arch x86 policy WILL require an IMA
> signature.

Agreed

> - If CONFIG_MODULE_SIG is configured or enabled on the boot command
> line, the IMA arch x86 policy is not configured, and the above policy
> rule is defined, an appended signature will be verified by both IMA
> and module_sig_check().

I think this is the same as what I have done above?


>> If you have a module foo.ko that contains a valid appended signature
>> but is not ima signed, it will fail to load.
>=20
> That would only happen in the second scenario or in the last scenario
> if the key is not found.
>=20
>> Now if the end user simply compresses the same foo.ko, making it
>> foo.ko.xz.  The module will load.
>=20
> This implies that CONFIG_MODULE_SIG is configured or enabled on the
> boot command line, like the first scenario described above, or in the
> last scenario and the key is found.
>> Modules can be loaded thru two different syscalls, finit_module and
>> init_module.  The changes added in [1] work if you use the
>> init_module syscall.  My change adds support when the finit_module
>> syscall gets used instead.
>=20
> With the IMA arch x86 policy, without CONFIG_MODULE_SIG configured or
> enabled on the boot command line, IMA will prevent the init_module()
> syscall.  This is intentional.

Agreed

> Your second patch (2/2) changes the arch x86 policy rule to allow
> appended signatures.  The reason for any other changes needs to be
> clearer.  I suggest you look at the audit log and kernel messages, as
> well as the kexec selftests, to better understand what is happening.
>=20

I can add more details.  I=E2=80=99m just trying to make it so the end =
user has the same=20
experience when using the default secure_boot ima policy. I don=E2=80=99t =
see a point in
forcing someone to compress a module to get around security, especially =
when they
have a policy that contains =E2=80=9C|modsig=E2=80=9D. =20

Let me know how you would like me to move forward.  Are you ok with the =
actual code in=20
my patches, assuming I add a lot more details? Or do you want more =
analysis here first? =20

