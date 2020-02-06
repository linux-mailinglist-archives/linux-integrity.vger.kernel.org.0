Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D341154E2F
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Feb 2020 22:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbgBFVlQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Feb 2020 16:41:16 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45068 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727661AbgBFVlQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Feb 2020 16:41:16 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 016LchfD110848;
        Thu, 6 Feb 2020 21:40:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=RVw98UuA753CD7zWY4l2J2dJK4NDnsK13hhkc8QW+gI=;
 b=MUQOEJuuVTrXF3LMpiKU6vj27rvvoPw1slXWyVSXzsda5JTkJlbvr20z8xWZR0oqN3vM
 bo6SwICvci4S9Z10VcU1AVr9UAVyqqrY1b9Yu8nQGDdy2iV0dvIhLGrnRIHe/Iz2QGd5
 vc9AzRrEaTA7CRSk4ej4OAhhABnzia8vPWD+zSAOyQCCEeBV6ppaJPhGO5voVPfMwXi7
 Os9V1vRXT898/0223hmqC+8zRBIcInshsUHFMiX2oNmX3eBE2GeGL6WahuEn66GXXLfw
 PTPniqFdbZBhkEpkPAJ01OG/3gyCW5bP7FfqJs5yz2ObU6GsTWTuzvJp9ooVikeEs8x4 8w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=RVw98UuA753CD7zWY4l2J2dJK4NDnsK13hhkc8QW+gI=;
 b=CyPAlgYFQb63uLSwARflxnQGU8oQBBtpPjXbqFAuPyvvKCjlbB/Z3IMf6xUJDXCBV+M8
 i9BCErB1DsuiPgLz5EFzjowWK2cap3pedpjm/hCwS6qHXbfuZlATzHwYGYER0n/qZB0f
 ZkT3wkTyaf2g5xyBp+23b6ktdh0lIUYK8awpa2l4hN+8+mEszriNFAN6kfE42E/2wTNz
 mcyk20ZHSsD/GkM4ZyRDWbAe04xMiNuaT6jtOrxDGHcFAG6T641+zS1SM0UOXBEo+vSB
 rlC+zuYGBE5eKbcisvQgiNZTUnBgCZ9yeblwnhYE7wD86aPc7vzwFKVjcYNEVaDtr0gF iQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2xykbpch43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 21:40:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 016Ld8ek098311;
        Thu, 6 Feb 2020 21:40:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2y0mjvxjdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 21:40:47 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 016LefZk024879;
        Thu, 6 Feb 2020 21:40:41 GMT
Received: from dhcp-10-65-154-237.vpn.oracle.com (/10.65.154.237)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Feb 2020 13:40:41 -0800
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH 0/2] ima: uncompressed module appraisal support
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <5c246616-9a3a-3ed2-c1f9-f634cef511c9@linux.vnet.ibm.com>
Date:   Thu, 6 Feb 2020 14:40:40 -0700
Cc:     dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        nayna@linux.ibm.com, tglx@linutronix.de, bauerman@linux.ibm.com,
        mpe@ellerman.id.au, linux-integrity@vger.kernel.org,
        Eric Snowberg <eric.snowberg@oracle.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <09D68C13-75E2-4BD6-B4E6-F765B175C7FD@oracle.com>
References: <20200206164226.24875-1-eric.snowberg@oracle.com>
 <5c246616-9a3a-3ed2-c1f9-f634cef511c9@linux.vnet.ibm.com>
To:     Nayna <nayna@linux.vnet.ibm.com>
X-Mailer: Apple Mail (2.3273)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002060158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002060158
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Feb 6, 2020, at 1:22 PM, Nayna <nayna@linux.vnet.ibm.com> wrote:
>=20
>=20
> On 2/6/20 11:42 AM, Eric Snowberg wrote:
>> When booting with either "ima_policy=3Dsecure_boot =
module.sig_enforce=3D1"
>> or building a kernel with CONFIG_IMA_ARCH_POLICY and booting with
>> "ima_policy=3Dsecure_boot", module loading behaves differently based =
on if
>> the module is compressed or not.  Originally when appraising a module
>> with ima it had to be uncompressed and ima signed.  Recent changes in =
5.4
>> have allowed internally signed modules to load [1].  But this only =
works
>> if the internally signed module is compressed.  The uncompressed =
module
>> that is internally signed must still be ima signed. This patch series
>> tries to bring the two in line.
>=20
> We (Mimi and I) have been trying to understand the cover letter. It =
seems "by internally signed" you are referring to modules signed with =
build time generated keys.

I am referring to any module that includes an appended signature.  They =
could be signed at build time or anytime afterwards using =
/usr/src/kernels/$(uname -r)/scripts/sign-file.  As long as the public =
key is contained in the builtin kernel trusted keyring.


> Our interpretation of the cover letter is that IMA originally did not =
support appended signatures and now does.

Correct, before the changes added to 5.4 [1], it was not possible to =
have a digital signature based appraisal policy that worked with a =
compressed module.  This is because you can=E2=80=99t ima sign a =
compressed module, since the signature would be lost by the time it gets =
to the init_module syscall.  With the changes in [1] you can, if you =
include =E2=80=9Cmodsig=E2=80=9D to your policy, which allows the =
appended module to be checked instead.


> Since the modules are signed with build time generated keys, the =
signature verification still fails, as the keys are only available on =
the .builtin keyring and not the .ima keyring.

Currently the upstream code will fail if the module is uncompressed.  If =
you compress the same module it will load with the current upstream =
code.

> Lastly, there is nothing in these patches that indicate that the =
kernel modules being compressed/uncompressed is related to the signature =
verification.
>=20

Basically if you have the following setup:

Kernel built with CONFIG_IMA_ARCH_POLICY or kernel booted with =
module.sig_enforce=3D1 along with the following ima policy:

appraise func=3DMODULE_CHECK appraise_type=3Dimasig|modsig

If you have a module foo.ko that contains a valid appended signature but =
is not ima signed, it will fail to load.  Now if the enduser simply =
compresses the same foo.ko, making it foo.ko.xz.  The module will load.

Modules can be loaded thru two different syscalls, finit_module and =
init_module.  The changes added in [1] work if you use the init_module =
syscall.  My change adds support when the finit_module syscall gets used =
instead.


[1] https://patchwork.kernel.org/cover/10986023

