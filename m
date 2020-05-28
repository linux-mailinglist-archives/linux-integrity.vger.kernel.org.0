Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5271E5269
	for <lists+linux-integrity@lfdr.de>; Thu, 28 May 2020 03:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgE1BAF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 May 2020 21:00:05 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:21224 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725896AbgE1BAF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 May 2020 21:00:05 -0400
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04S0eRbZ025288;
        Wed, 27 May 2020 21:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=+3uSdHvQwkmHL6i8+LhKbMgUCjfZhlvm4doQtcLS8D0=;
 b=GBg3FuEOVEGQ/M9ftgjdPbO6cFYvt8vAhUGaJri1t4DsSn+Lwfjb6vE2Y/mGZeL6ea9f
 NmHrd33l7IehI8EK+oj12TylV8he3qPplzNczjaw+Szp8WltrlP0QTSJ9n15f2WqQNAe
 oAtY47dPI26DDK3Ljfir8zWA/s/7btCo4ZgLm4R/7s/fn2K6qq0D7fKJgmk57IZPwrEb
 QcAyBuHTmcMvtde0k96QIwVC7D2ioUKW+5YXUx9ECG/LKU49yFIlKTP98w9L3wetHpIl
 4NxkgPOzR5ZSRdjciytLDhQFxZpchTxp58D+cufj0hQ1/UdZ8at2qLFS/j3+PjZBGWLX IQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 3170gpwqn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 21:00:03 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04S0bYUV190944;
        Wed, 27 May 2020 21:00:02 -0400
Received: from ausxippc106.us.dell.com (AUSXIPPC106.us.dell.com [143.166.85.156])
        by mx0b-00154901.pphosted.com with ESMTP id 3192pyjsy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 May 2020 21:00:02 -0400
X-LoopCount0: from 10.166.132.130
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="553281693"
From:   <Mario.Limonciello@dell.com>
To:     <jarkko.sakkinen@linux.intel.com>
CC:     <James.Bottomley@HansenPartnership.com>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jeffrin@rajagiritech.edu.in>, <alex@guzman.io>
Subject: RE: [PATCH] tpm: Revert "tpm: fix invalid locking in NONBLOCKING
 mode"
Thread-Topic: [PATCH] tpm: Revert "tpm: fix invalid locking in NONBLOCKING
 mode"
Thread-Index: AQHWM4wIzxc0OpiDwkyMUhr0qx5qZ6i7EGkA//+sw5CAAFoVAIABmusA//+ulgCAAJ4ZgP//r/6A
Date:   Thu, 28 May 2020 00:59:59 +0000
Message-ID: <7072116bf16a45bca62913e7d8a0354e@AUSX13MPC105.AMER.DELL.COM>
References: <20200526183213.20720-1-mario.limonciello@dell.com>
 <1590520454.11810.40.camel@HansenPartnership.com>
 <ccf055cbf1a14f28bc95a6b02e29a2f6@AUSX13MPC105.AMER.DELL.COM>
 <1590521924.15108.1.camel@HansenPartnership.com>
 <37da2695fe6de09d69e27b77f3e29e068596205f.camel@linux.intel.com>
 <4d1a53596af44c7b84f97aa4ce04a53c@AUSX13MPC105.AMER.DELL.COM>
 <20200528004355.GA5877@linux.intel.com>
In-Reply-To: <20200528004355.GA5877@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-05-28T00:59:58.3254510Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=f9ec88c4-bdce-4173-af67-ac7216e71ca5;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.60]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_03:2020-05-27,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 suspectscore=0
 cotscore=-2147483648 malwarescore=0 impostorscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005280001
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005280001
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> > > [EXTERNAL EMAIL]
>=20
> What is this?

Something my employer's mail system automatically tags in external email.

My mistakes in forgetting to remove it on the response.

>=20
> > > On Tue, 2020-05-26 at 12:38 -0700, James Bottomley wrote:
> > > > On Tue, 2020-05-26 at 19:23 +0000, Mario.Limonciello@dell.com wrote=
:
> > > > > > On Tue, 2020-05-26 at 13:32 -0500, Mario Limonciello wrote:
> > > > > > > This reverts commit d23d12484307b40eea549b8a858f5fffad913897.
> > > > > > >
> > > > > > > This commit has caused regressions for the XPS 9560 containin=
g
> > > > > > > a Nuvoton TPM.
> > > > > >
> > > > > > Presumably this is using the tis driver?
> > > > >
> > > > > Correct.
> > > > >
> > > > > > > As mentioned by the reporter all TPM2 commands are failing wi=
th:
> > > > > > >   ERROR:tcti:src/tss2-tcti/tcti-
> > > > > > > device.c:290:tcti_device_receive()
> > > > > > >   Failed to read response from fd 3, got errno 1: Operation n=
ot
> > > > > > > permitted
> > > > > > >
> > > > > > > The reporter bisected this issue back to this commit which wa=
s
> > > > > > > backported to stable as commit 4d6ebc4.
> > > > > >
> > > > > > I think the problem is request_locality ... for some inexplicab=
le
> > > > > > reason a failure there returns -1, which is EPERM to user space=
.
> > > > > >
> > > > > > That seems to be a bug in the async code since everything else
> > > > > > gives a ESPIPE error if tpm_try_get_ops fails ... at least no-o=
ne
> > > > > > assumes it gives back a sensible return code.
> > > > > >
> > > > > > What I think is happening is that with the patch the TPM goes
> > > > > > through a quick sequence of request, relinquish, request,
> > > > > > relinquish and it's the third request which is failing (likely
> > > > > > timing out).  Without the patch, the patch there's only one
> > > > > > request,relinquish cycle because the ops are held while the asy=
nc
> > > > > > work is executed.  I have a vague recollection that there is a
> > > > > > problem with too many locality request in quick succession, but
> > > > > > I'll defer to Jason, who I think understands the intricacies of
> > > > > > localities better than I do.
> > > > >
> > > > > Thanks, I don't pretend to understand the nuances of this particu=
lar
> > > > > code, but I was hoping that the request to revert got some attent=
ion
> > > > > since Alex's kernel Bugzilla and message a few months ago to linu=
x
> > > > > integrity weren't.
> > > > >
> > > > > > If that's the problem, the solution looks simple enough: just m=
ove
> > > > > > the ops get down because the priv state is already protected by=
 the
> > > > > > buffer mutex
> > > > >
> > > > > Yeah, if that works for Alex's situation it certainly sounds like=
 a
> > > > > better solution than reverting this patch as this patch actually =
does
> > > > > fix a problem reported by Jeffrin originally.
> > > > >
> > > > > Could you propose a specific patch that Alex and Jeffrin can perh=
aps
> > > > > both try?
> > > >
> > > > Um, what's wrong with the one I originally attached and which you q=
uote
> > > > below?  It's only compile tested, but I think it will work, if the
> > > > theory is correct.
> > >
> > > Please send a legit patch, thanks.
> > >
> > > /Jarkko
> >
> > Jarkko,
> >
> > After the confirmation from Alex that this patch attached to the end of=
 the
> thread
> > worked, James did send a proper patch that can be accessed here:
> > https://lore.kernel.org/linux-
> integrity/20200527155800.ya43xm2ltuwduwjg@cantor/T/#t
> >
> > Thanks,
>=20
> Hi thanks a lot! I did read the full discussions and agree with the
> conclusions as I get a patch in proper form.
>=20
> Please ping next time a bit earlier. It's not that I don't want to deal
> with the issues quickly as possible. It's probably just that I've forgot
> something or missed.
>=20
> /Jarkko

Thanks!

I completely forgot about it too, it was mentioned to me right after holida=
ys
and I forgot to follow up and see that it got sorted.
