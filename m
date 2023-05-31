Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB247717894
	for <lists+linux-integrity@lfdr.de>; Wed, 31 May 2023 09:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbjEaHrl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 31 May 2023 03:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbjEaHrj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 31 May 2023 03:47:39 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9079BA0
        for <linux-integrity@vger.kernel.org>; Wed, 31 May 2023 00:47:36 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-237-yPrT6zgJNVmBX2UU9Li6GA-1; Wed, 31 May 2023 08:47:33 +0100
X-MC-Unique: yPrT6zgJNVmBX2UU9Li6GA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 31 May
 2023 08:47:30 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 31 May 2023 08:47:30 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Stefan Berger' <stefanb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Alejandro Cabrera <alejandro.cabreraaldaya@tuni.fi>,
        Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC v2] tpm: tpm_vtpm_proxy: do not reference kernel
 memory as user memory
Thread-Topic: [PATCH RFC v2] tpm: tpm_vtpm_proxy: do not reference kernel
 memory as user memory
Thread-Index: AQHZkx6c4+KBdklbTEOBEhyozKww7690AQlg
Date:   Wed, 31 May 2023 07:47:30 +0000
Message-ID: <26ee6ae4411645b99c351917b38d9b83@AcuMS.aculab.com>
References: <20230530020133.235765-1-jarkko@kernel.org>
 <b2657b55-355d-80cb-23cc-d11825f64ad1@linux.ibm.com>
In-Reply-To: <b2657b55-355d-80cb-23cc-d11825f64ad1@linux.ibm.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogU3RlZmFuIEJlcmdlcg0KPiBTZW50OiAzMCBNYXkgMjAyMyAxODo0Ng0KPiANCj4gT24g
NS8yOS8yMyAyMjowMSwgSmFya2tvIFNha2tpbmVuIHdyb3RlOg0KPiA+IEZyb206IEphcmtrbyBT
YWtraW5lbiA8amFya2tvLnNha2tpbmVuQHR1bmkuZmk+DQo+ID4NCj4gDQo+ID4gLQlyYyA9IGNv
cHlfdG9fdXNlcihidWYsIHByb3h5X2Rldi0+YnVmZmVyLCBsZW4pOw0KPiA+ICsJaWYgKGJ1ZikN
Cj4gPiArCQlyYyA9IGNvcHlfdG9fdXNlcihidWYsIHByb3h5X2Rldi0+YnVmZmVyLCBsZW4pOw0K
PiA+ICsNCj4gDQo+IExvb2tpbmcgdGhyb3VnaCBvdGhlciBkcml2ZXJzIGl0IHNlZW1zIGJ1ZiBp
cyBhbHdheXMgZXhwZWN0ZWQgdG8gYmUgYSB2YWxpZCBub24tTlVMTCBwb2ludGVyIG9uDQo+IGZp
bGVfb3BlcmF0aW9ucy5yZWFkKCkuDQoNCklmIHRoZSB1c2VyIHBhc3NlcyBOVUxMIHRoZSBjb3B5
X3RvL2Zyb21fdXNlcigpIGZhaWxzIGFuZA0KLUVGQVVMVCBpcyByZXR1cm5lZC4NCg0KQWRkaW5n
IHRoZSBOVUxMIGNoZWNrIG1ha2VzIHRoZSByZXF1ZXN0IHNpbGVudGx5IHN1Y2NlZWQuDQpJIGRv
dWJ0IHRoYXQgaXMgYW55d2hlcmUgbmVhciByaWdodCB3aGVuIHlvdSBpZ25vcmUgY29weV9mcm9t
X3VzZXIoKS4NCg0KSSdtIG5vdCBzdXJlIHdoYXQgdGhlIHJhdGlvbmFsL3N1YmplY3QgaXMgYWJv
dXQgZWl0aGVyLg0KY29weV90by9mcm9tX3VzZXIoKSBjYWxscyBhY2Nlc3Nfb2soKSBhbmQgd2ls
bCBmYWlsIG9uDQphIGtlcm5lbCBhZGRyZXNzLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBB
ZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMs
IE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

