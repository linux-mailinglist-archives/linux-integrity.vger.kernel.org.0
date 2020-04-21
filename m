Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50BCE1B3295
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Apr 2020 00:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgDUWW7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Apr 2020 18:22:59 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:32220 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbgDUWW7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Apr 2020 18:22:59 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03LMJ3JC025250;
        Wed, 22 Apr 2020 00:22:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=dZJTlWIIHeyrkFVNdA42HBD5FKoXjONJpYRa6ljj15E=;
 b=gF1ZBaLNrbSVnicucQosBG5LnD+4Z6hIdbgqmNMqEbiP5ipsQIxYqfdXfsMBHCVbhiQB
 LSUeQRizPJHT2iBID8Pwprv2CffMaMbO32dylZoeYHuDCRBeAOO3GEJavjRqiiKKJQ9Y
 dffhPg1XWF+vSH3j91pfTVQnARUUQ793aqHxoiOPyd9HV9cddseji051qR0PkMlNrdCU
 no3Va+T4kwgceaWVWuvgtTKynPqh2dS1DM4B0BBVrkROPq4Kg3Ea3elG1bgRMLDTkUEU
 3BWZCwoqLJdURDQcJrNOkJGvPMiv3OAcoq0AX8NeuEhN2WWn7dkx/N80eIUFhYhFTuZ2 kw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30fqawag0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Apr 2020 00:22:31 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 54670100034;
        Wed, 22 Apr 2020 00:22:30 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2D137207495;
        Wed, 22 Apr 2020 00:22:30 +0200 (CEST)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 22 Apr
 2020 00:22:29 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Wed, 22 Apr 2020 00:22:29 +0200
From:   Benoit HOUYERE <benoit.houyere@st.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Omar Sandoval <osandov@osandov.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Amir Mizinski <amirmizi6@gmail.com>
CC:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "James Bottomley" <James.Bottomley@hansenpartnership.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: RE: [PATCH v2] tpm_tis: work around status register bug in
 STMicroelectronics TPM
Thread-Topic: [PATCH v2] tpm_tis: work around status register bug in
 STMicroelectronics TPM
Thread-Index: AQHWGCqZKczi/o3brkCk2ElxkuJuPKiEJXBA
Date:   Tue, 21 Apr 2020 22:22:29 +0000
Message-ID: <35489c2c876b483fbe5a0283391e8e65@SFHDAG3NODE3.st.com>
References: <c0ba1e2931ca7c46a21a43f2b9a6add2e188d6c8.1586996553.git.osandov@fb.com>
         <19d930ef-4090-3339-1088-c3579e8a080f@molgen.mpg.de>
         <20200416190249.GC701157@vader> <1587476664.5149.14.camel@linux.ibm.com>
         <3766ead79aa4415198bc5a8324f02f6e@SFHDAG3NODE3.st.com>
 <1587507430.5053.16.camel@linux.ibm.com>
In-Reply-To: <1587507430.5053.16.camel@linux.ibm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-21_09:2020-04-21,2020-04-21 signatures=0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQpPbiBUdWUsIDIwMjAtMDQtMjEgYXQgMjA6NTYgKzAwMDAsIEJlbm9pdCBIT1VZRVJFIHdyb3Rl
Og0KDQo+PiBJc3N1ZSBvY2N1cnMgb24gc2V2ZXJhbCBsZWdhY3kgbW9kZWxzIGFuZCBjb3JyZWN0
ZWQgb24gbGF0ZXN0IFRQTSANCj4+IHZlcnNpb25zLiBTZXZlcmFsIGNvcnJlY3Rpb25zIGFyZSBw
b3NzaWJsZS4gT21hcidzIHByb3Bvc2FsIGlzIHF1aXRlIA0KPj4gc2ltcGxlLCBzaG9ydCBhbmQg
ZWZmaWNpZW50LiBQZW5hbHR5IHRpbWUgaXMgb25seSBjb25kaXRpb24gY2hlY2sgYnV0IA0KPj4g
Zm9yIGFsbCBUUE1fc3RhdHVzIGFjY2Vzcy4NCj4+IA0KPj4gT3RoZXIgcG9zc2liaWxpdHkgIGlz
IHRvIGNoZWNrIHN0YXR1cyByZWdpc3RlciB2YWxpZGl0eSAoYml0IDUgaXMgDQo+PiBhbHdheXMg
YXQgMCkgYXQgdGhlIGZpcnN0IHJlYWRpbmcgYW5kIG1vZGlmeSB3YWl0X2Zvcl9zdGF0IGZ1bmN0
aW9uIA0KPj4gKGFscmVhZHkgaW5zZXJ0ZWQgZm9yIEkyQyBwYXRjaCkuDQoNCj5CZW5vaXQsIHRo
YW5rIHlvdSBmb3IgdGhlIGV4cGxhbmF0aW9uLg0KDQo+SXQgc291bmRzIGxpa2UgYnkgImFscmVh
ZHkgaW5zZXJ0ZWQgZm9yIEkyQyBwYXRjaCIsIHlvdSBtZWFuIHRoYXQgdGhpcyBwcm9wb3NlZCBz
b2x1dGlvbiBpcyBwYXJ0IG9mIHRoZSBpMmMgcGF0Y2ggc2V0LiDCoElmIHRoYXQgaXMgdGhlIGNh
c2UsIHRvIHNpbXBsaWZ5IGJhY2twb3J0aW5nLCB0aGUgZml4IHNob3VsZCBiZSB0aGUgZmlyc3Qg
cGF0Y2ggaW4gdGhlIGkyYyBwYXRjaCBzZXQuDQoNCj5NaW1pDQpPaywgSSB3aWxsIGNoZWNrIHdp
dGggQW1pciBiZWZvcmUuDQoNCg==
