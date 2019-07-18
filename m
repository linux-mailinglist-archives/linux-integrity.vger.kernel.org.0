Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84F056CE75
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jul 2019 15:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfGRNCY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jul 2019 09:02:24 -0400
Received: from maillog.nuvoton.com ([202.39.227.15]:36746 "EHLO
        maillog.nuvoton.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfGRNCW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jul 2019 09:02:22 -0400
Received: from NTHCCAS01.nuvoton.com (nthccas01.nuvoton.com [10.1.8.28])
        by maillog.nuvoton.com (Postfix) with ESMTP id 5D2E31C80DD5;
        Thu, 18 Jul 2019 20:51:49 +0800 (CST)
Received: from NTILML02.nuvoton.com (10.190.1.46) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (TLS) id 15.0.1130.7; Thu, 18 Jul 2019
 20:51:48 +0800
Received: from NTILML02.nuvoton.com (10.190.1.47) by NTILML02.nuvoton.com
 (10.190.1.47) with Microsoft SMTP Server (TLS) id 15.0.1130.7; Thu, 18 Jul
 2019 15:51:45 +0300
Received: from NTILML02.nuvoton.com ([::1]) by NTILML02.nuvoton.com ([::1])
 with mapi id 15.00.1130.005; Thu, 18 Jul 2019 15:51:45 +0300
From:   <Eyal.Cohen@nuvoton.com>
To:     <jarkko.sakkinen@linux.intel.com>, <tmaimon77@gmail.com>
CC:     <oshrialkoby85@gmail.com>, <Alexander.Steffen@infineon.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <oshri.alkoby@nuvoton.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <gcwilson@us.ibm.com>, <kgoldman@us.ibm.com>,
        <nayna@linux.vnet.ibm.com>, <Dan.Morav@nuvoton.com>,
        <oren.tanami@nuvoton.com>
Subject: RE: [PATCH v2 0/2] char: tpm: add new driver for tpm i2c ptp
Thread-Topic: [PATCH v2 0/2] char: tpm: add new driver for tpm i2c ptp
Thread-Index: AQHVOvIQ+td4FoJtQk2eh+ryXBhwdKbQVkKg
Date:   Thu, 18 Jul 2019 12:51:44 +0000
Message-ID: <9c8e216dbc4f43dbaa1701dc166b05e0@NTILML02.nuvoton.com>
References: <20190628151327.206818-1-oshrialkoby85@gmail.com>
 <8e6ca8796f229c5dc94355437351d7af323f0c56.camel@linux.intel.com>
 <79e8bfd2-2ed1-cf48-499c-5122229beb2e@infineon.com>
 <CAM9mBwJC2QD5-gV1eJUDzC2Fnnugr-oCZCoaH2sT_7ktFDkS-Q@mail.gmail.com>
 <45603af2fc8374a90ef9e81a67083395cc9c7190.camel@linux.intel.com>
 <6e7ff1b958d84f6e8e585fd3273ef295@NTILML02.nuvoton.com>
 <CAP6Zq1hPo9dG71YFyr7z9rjmi-DvoUZJOme4+2uqsfO+7nH+HQ@mail.gmail.com>
 <20190715094541.zjqxainggjuvjxd2@linux.intel.com>
In-Reply-To: <20190715094541.zjqxainggjuvjxd2@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.191.10.160]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jarkko and Alexander,

We have made an additional code review on the TPM TIS core driver, it looks quite good and we can connect our new I2C driver to this layer.
However, there are several differences between the SPI interface and the I2C interface that will require changes to the TIS core.
At a minimum we thought of:
1. Handling TPM Localities in I2C is different
2. Handling I2C CRC - relevant only to I2C bus hence not supported today by TIS core
3. Handling Chip specific issues, since I2C implementation might be slightly different across the various TPM vendors
4. Modify tpm_tis_send_data and tpm_tis_recv_data to work according the TCG Device Driver Guide (optimization on TPM_STS access and send/recv retry)
Besides this, during development we might encounter additional differences between SPI and I2C.

We currently target to allocate an eng. to work on this on the second half of August with a goal to have the driver ready for the next kernel merge window.

Regards,
Eyal.

-----Original Message-----
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Sent: Monday, July 15, 2019 12:46 PM
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: Oshri Alkobi <oshrialkoby85@gmail.com>; Alexander Steffen <Alexander.Steffen@infineon.com>; Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; peterhuewe@gmx.de; jgg@ziepe.ca; Arnd Bergmann <arnd@arndb.de>; Greg KH <gregkh@linuxfoundation.org>; IS20 Oshri Alkoby <oshri.alkoby@nuvoton.com>; devicetree <devicetree@vger.kernel.org>; AP MS30 Linux Kernel community <linux-kernel@vger.kernel.org>; linux-integrity@vger.kernel.org; gcwilson@us.ibm.com; kgoldman@us.ibm.com; nayna@linux.vnet.ibm.com; IS30 Dan Morav <Dan.Morav@nuvoton.com>; IS20 Eyal Cohen <Eyal.Cohen@nuvoton.com>
Subject: Re: [PATCH v2 0/2] char: tpm: add new driver for tpm i2c ptp

On Mon, Jul 15, 2019 at 11:08:47AM +0300, Tomer Maimon wrote:
>    Thanks for your feedback and sorry for the late response.
>
>    Due to the amount of work required to handle this technical feedback and
>    project constraints we need to put this task on hold for the near future.
>
>    In the meantime, anyone from the community is welcome to take over this
>    code and handle the re-design for the benefit of the entire TPM community.

Ok, so there is already driver for this called tpm_tis_core.

So you go and create a new module, whose name given the framework of things that we already have deployed, is destined to be tpm_tis_i2c.

Then you roughly implement a new physical layer by using  a callback interface provided to you by tpm_tis_core.

The so called re-design was already addressed by Alexander [1].

How hard can it be seriously?

[1] https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.org_lkml_2019_7_4_331&d=DwIBAg&c=ue8mO8zgC4VZ4q_aNVKt8G9MC01UFDmisvMR1k-EoDM&r=hjzIxEsS8wf3Ezr__r0ZOjw3kki8jIlQK-SQ5pWhXaM&m=aYs86sTFmxqvlI5rE2AWLGRl0lb9XRuiRKVtsCaXdRM&s=_3MMoq5UISFwMfK4OfgLbA2kMfZVgEfgkaWKqDEUXGw&e=

/Jarkko


===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.
