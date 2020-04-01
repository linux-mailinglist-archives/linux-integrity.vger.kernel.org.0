Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D60F19B6E2
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Apr 2020 22:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbgDAUTq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Apr 2020 16:19:46 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:11694 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727178AbgDAUTq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Apr 2020 16:19:46 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 031KC3Rm001505;
        Wed, 1 Apr 2020 22:18:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=5QlwJKLZCLk0nG0qWaS9k+T/qOC3AEsVlVtoxtMgP4U=;
 b=lrGWypf31O2KG3VrMaRQ5OnJUUP98evJkXxvPmgOvTq2dxnWQxL3tQhOqkpvHoTIYJd1
 t6ItmGFZKHI6HMM8vzTSxsONzHDx+E3QUqIpup4qDOIUFuKOZRjzB21s2ESbFZmjmTyI
 cDkKH2/XLJ+HKNE2mKy+VSDsAkSHsz2Brufl3UUIc1E0jEAwj9B3xsLfQnxaey28WAt3
 5Wdx4beNpC5iYahdQbuSdwzuEp4aNkQ4hCAsFnYZKCEbnBHG79JFKhX3mYLK3cNjC2zo
 6wNrUmgRHvQVPpz6rASZd4hw2HOOVGJ5k2jTdDpjxfgR6I4mPfPPMoWZGBeXqC3JSkga tg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 301w81751c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Apr 2020 22:18:22 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3569010002A;
        Wed,  1 Apr 2020 22:18:15 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E3680206292;
        Wed,  1 Apr 2020 22:18:14 +0200 (CEST)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 1 Apr
 2020 22:18:14 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Wed, 1 Apr 2020 22:18:14 +0200
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
        Christophe Richard <hristophe-h.ricard@st.com>
Subject: RE: [PATCH v4 2/7] tpm: tpm_tis: Add check_data handle to
 tpm_tis_phy_ops in order to check data integrity
Thread-Topic: [PATCH v4 2/7] tpm: tpm_tis: Add check_data handle to
 tpm_tis_phy_ops in order to check data integrity
Thread-Index: AQHWB/5sTOWTIuzRBUKbjmfl723Xlqhks7pQ
Date:   Wed, 1 Apr 2020 20:18:14 +0000
Message-ID: <173e4e392b9648b7afeb09680d8073b5@SFHDAG3NODE3.st.com>
References: <20200331113207.107080-1-amirmizi6@gmail.com>
 <20200331113207.107080-3-amirmizi6@gmail.com>
 <20200401082019.GB17325@linux.intel.com>
In-Reply-To: <20200401082019.GB17325@linux.intel.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-01_04:2020-03-31,2020-04-01 signatures=0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

>>On Tue, Mar 31, 2020 at 02:32:02PM +0300, amirmizi6@gmail.com wrote:
>> From: Amir Mizinski <amirmizi6@gmail.com>
>>=20
>> In order to compute the crc over the data sent in lower layer  (I2C=20
>> for instance), tpm_tis_check_data() calls an operation (if available) =20
>> to check data integrity. If data integrity cannot be verified, a retry =
=20
>> attempt to save the sent/received data is implemented.
>>=20
>> The current steps are done when sending a command:
>>     1. Host writes to TPM_STS.commandReady.
>>     2. Host writes command.
>>     3. Host checks that TPM received data is valid.
>>     4. If data is currupted go to step 1.
>>=20
>> When receiving data:
>>     1. Host checks that TPM_STS.dataAvail is set.
>>     2. Host saves received data.
>>     3. Host checks that received data is correct.
>>     4. If data is currupted Host writes to TPM_STS.responseRetry and go =
to
>>         step 1.
>>=20
>> Co-developed-by: Christophe Richard <hristophe-h.ricard@st.com>
>> Signed-off-by: Christophe Richard <hristophe-h.ricard@st.com>
>> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>

>The email is malformed.

>So.. How did Christophe participate on writing this patch? I haven't seen =
him shouting anything about the subject and still his SOB is there.

>/Jarkko

Christophe sent patch to support I2C TCG TPM driver tpm_tis_i2c (https://pa=
tchwork.kernel.org/patch/8628681/) in the same time that tpm_tis_spi. This =
function was named tpm_tis_i2c_check_data.

Best Regards,
