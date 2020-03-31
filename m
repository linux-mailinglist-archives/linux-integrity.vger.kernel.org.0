Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 419C319A0E6
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Mar 2020 23:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgCaVe5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Mar 2020 17:34:57 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:15660 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727955AbgCaVe5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Mar 2020 17:34:57 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02VLY8AI013715;
        Tue, 31 Mar 2020 23:34:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=hogJljl3NSx7SbRBP5t51xt8cHudqMc3OCqtkkmKgFU=;
 b=yASCTbB1xg2nlN9WKX+WEs7JcLif3yHoyl6wHzPaJ4bKHSyCL4XUx5CBtxAp9I2b5iky
 3ZqVA7x0AReUZu5/z4zRtqJg7ubIWtsl6H71432ju/7lzvlMynigy2bNIfcgKpOfC3UH
 QfIDsLrFMS9SX2z3L3UfkZvFfK0/IYgY1P1iKbZYuyyCOf6GVHB3Xt7Iuu38JIC/EK57
 pdkjbNGHkPRsofM2PCj4NKtKxBB6jC1q2Klm4uHkGSZV5vAYWYHwscwcEAy6Gxid6cxv
 f3g880PQFPP3s7BaUx7mC1ImGdGvnnSNYxEyLMOgZKsIE8onq1I0LZRys5DCcggKAZ6f jw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 301vkdsjj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Mar 2020 23:34:33 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E34A810002A;
        Tue, 31 Mar 2020 23:34:28 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C08452067F3;
        Tue, 31 Mar 2020 23:34:28 +0200 (CEST)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 31 Mar
 2020 23:34:28 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Tue, 31 Mar 2020 23:34:28 +0200
From:   Benoit HOUYERE <benoit.houyere@st.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "amirmizi6@gmail.com" <amirmizi6@gmail.com>
CC:     "Eyal.Cohen@nuvoton.com" <Eyal.Cohen@nuvoton.com>,
        "oshrialkoby85@gmail.com" <oshrialkoby85@gmail.com>,
        "alexander.steffen@infineon.com" <alexander.steffen@infineon.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "oshri.alkoby@nuvoton.com" <oshri.alkoby@nuvoton.com>,
        "tmaimon77@gmail.com" <tmaimon77@gmail.com>,
        "gcwilson@us.ibm.com" <gcwilson@us.ibm.com>,
        "kgoldman@us.ibm.com" <kgoldman@us.ibm.com>,
        "Dan.Morav@nuvoton.com" <Dan.Morav@nuvoton.com>,
        "oren.tanami@nuvoton.com" <oren.tanami@nuvoton.com>,
        "shmulik.hager@nuvoton.com" <shmulik.hager@nuvoton.com>,
        "amir.mizinski@nuvoton.com" <amir.mizinski@nuvoton.com>,
        Olivier COLLART <olivier.collart@st.com>,
        Yves MAGNAUD <yves.magnaud@st.com>
Subject: RE: [PATCH v4 4/7] tpm: tpm_tis: Fix expected bit handling and send
 all bytes in one shot without last byte in exception
Thread-Topic: [PATCH v4 4/7] tpm: tpm_tis: Fix expected bit handling and send
 all bytes in one shot without last byte in exception
Thread-Index: AQHWB1ZoDft9Zu6RoU68XNbFk/pAW6hjMfyw
Date:   Tue, 31 Mar 2020 21:34:28 +0000
Message-ID: <19c8ae3023404ae9affcb1ce04b7ee4b@SFHDAG3NODE3.st.com>
References: <20200331113207.107080-1-amirmizi6@gmail.com>
 <20200331113207.107080-5-amirmizi6@gmail.com>
 <20200331121720.GB9284@linux.intel.com>
In-Reply-To: <20200331121720.GB9284@linux.intel.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_07:2020-03-31,2020-03-31 signatures=0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Tue, Mar 31, 2020 at 02:32:04PM +0300, amirmizi6@gmail.com wrote:
> > From: Amir Mizinski <amirmizi6@gmail.com>
> >=20
> > Today, actual implementation for send massage is not correct. We check=
=20
> > and loop only on TPM_STS.stsValid bit and next we single check=20
> > TPM_STS.expect bit value.
> > TPM_STS.expected bit shall be checked in the same time of=20
> > TPM_STS.stsValid, and should be repeated until timeout_A.
> > To aquire that, "wait_for_tpm_stat" function is modified to=20
> > "wait_for_tpm_stat_result". this function read regulary status=20
> > register and check bit defined by "mask" to reach value defined in "mas=
k_result"
> > (that way a bit in mask can be checked if reached 1 or 0).
> >=20
> > Respectively, to send message as defined in=20
> >  TCG_DesignPrinciples_TPM2p0Driver_vp24_pubrev.pdf, all bytes should be=
=20
> > sent in one shot instead of sending last byte in exception.
> >=20
> > This improvment was suggested by Benoit Houyere.

>Use suggested-by tag.

>Also if something is not correct, please provide a fixes tag.

> You are speaking now in theoretical level, which we don't really care tha=
t much. Is this causing you real issues? If the answer is yes, please repor=
t them. If the > >answer is no, we don't need this.

> /Jarkko

I2C TPM specification introduce CRC calculation on TPM command bytes. CRC c=
alculation take place from last byte acquired to  TPM_STS.expected bit rese=
t (=3D0) .It introduces latency and actual incorrect implementation becomes=
 visible now under I2C on the contrary before that's all.=20
The case where TPM keeps TPM_STS.expected bit set  with TPM_STS.stsValid se=
t after last byte reception is possible and is not an issue. It's not theor=
etical level, it's practical level now.


