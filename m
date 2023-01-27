Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D9B67DFA4
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Jan 2023 10:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjA0JFn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Jan 2023 04:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjA0JFm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Jan 2023 04:05:42 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E871CF51
        for <linux-integrity@vger.kernel.org>; Fri, 27 Jan 2023 01:05:40 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-207-p-8H2nnBPfSw_AWgsS6nQg-1; Fri, 27 Jan 2023 09:05:38 +0000
X-MC-Unique: p-8H2nnBPfSw_AWgsS6nQg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Fri, 27 Jan
 2023 09:05:37 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Fri, 27 Jan 2023 09:05:37 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andrew Donnellan' <ajd@linux.ibm.com>,
        'Segher Boessenkool' <segher@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
CC:     "gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>,
        "erichte@linux.ibm.com" <erichte@linux.ibm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "sudhakar@linux.ibm.com" <sudhakar@linux.ibm.com>,
        "ruscur@russell.cc" <ruscur@russell.cc>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "bgray@linux.ibm.com" <bgray@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "gcwilson@linux.ibm.com" <gcwilson@linux.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v4 02/24] powerpc/pseries: Fix alignment of PLPKS
 structures and buffers
Thread-Topic: [PATCH v4 02/24] powerpc/pseries: Fix alignment of PLPKS
 structures and buffers
Thread-Index: AQHZMarbHHGSrma/kEeRKp/dNdgk5K6w84EwgAClz4CAAF8Y4A==
Date:   Fri, 27 Jan 2023 09:05:37 +0000
Message-ID: <b016aefff9514ed1ad40620cea6d3b9f@AcuMS.aculab.com>
References: <20230120074306.1326298-1-ajd@linux.ibm.com>
         <20230120074306.1326298-3-ajd@linux.ibm.com>
         <87pmb2pxpa.fsf@mpe.ellerman.id.au>
         <20230126171925.GN25951@gate.crashing.org>
         <5118edd7f1f445afa1812d2b9b62dd4f@AcuMS.aculab.com>
 <2de207dadb936f25db123ae2d02aea91a9841656.camel@linux.ibm.com>
In-Reply-To: <2de207dadb936f25db123ae2d02aea91a9841656.camel@linux.ibm.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogQW5kcmV3IERvbm5lbGxhbg0KPiBTZW50OiAyNyBKYW51YXJ5IDIwMjMgMDM6MjENCj4g
DQo+IE9uIFRodSwgMjAyMy0wMS0yNiBhdCAxNzozMSArMDAwMCwgRGF2aWQgTGFpZ2h0IHdyb3Rl
Og0KPiA+IENoYW5naW5nIHRoZSBzaXplIHRvIGt6YWxsb2MoKSBkb2Vzbid0IGhlbHAuDQo+ID4g
VGhlIGFsaWdubWVudCBkZXBlbmRzIG9uIHRoZSBhbGxvY2F0b3IgYW5kIGlzIG9ubHkgcmVxdWly
ZWQgdG8gaGF2ZQ0KPiA+IGEgcmVsYXRpdmVseSBzbWFsbCBhbGlnbm1lbnQgKEFSQ0hfTUlOQUxJ
R04/KSByZWdhcmRsZXNzIG9mIHRoZSBzaXplLg0KPiA+DQo+ID4gSUlSQyBvbmUgb2YgdGhlIGFs
bG9jYXRvcnMgYWRkcyBhIHNtYWxsIGhlYWRlciB0byBldmVyeSBpdGVtLg0KPiA+IEl0IHdvbid0
IHJldHVybiAxNiBieXRlIGFsaWduZWQgaXRlbXMgYXQgYWxsLg0KPiANCj4gSSdtIHJlbHlpbmcg
b24gdGhlIGJlaGF2aW91ciBkZXNjcmliZWQgaW4gRG9jdW1lbnRhdGlvbi9jb3JlLQ0KPiBhcGkv
bWVtb3J5LWFsbG9jYXRpb24ucnN0Og0KPiANCj4gICAgIFRoZSBhZGRyZXNzIG9mIGEgY2h1bmsg
YWxsb2NhdGVkIHdpdGgga21hbGxvYyBpcyBhbGlnbmVkIHRvIGF0DQo+ICAgICBsZWFzdCBBUkNI
X0tNQUxMT0NfTUlOQUxJR04gYnl0ZXMuIEZvciBzaXplcyB3aGljaCBhcmUgYSBwb3dlciBvZg0K
PiAgICAgdHdvLCB0aGUgYWxpZ25tZW50IGlzIGFsc28gZ3VhcmFudGVlZCB0byBiZSBhdCBsZWFz
dCB0aGUgcmVzcGVjdGl2ZQ0KPiAgICAgc2l6ZS4NCj4gDQo+IElzIHRoaXMgd3Jvbmc/DQoNClRo
ZSBhbGlnbm1lbnQgZm9yIHBvd2VyIG9mIHR3byBkb2Vzbid0IG1hdGNoIHdoYXQgSSd2ZSBpbmZl
cnJlZA0KZnJvbSByZWFkaW5nIGNvbW1lbnRzIG9uIG90aGVyIHBhdGNoZXMuDQoNCkl0IGlzIHRy
dWUgZm9yIGRtYV9tYWxsb2NfY29oZXJlbnQoKSAtIHRoYXQgZG9lcyBndWFyYW50ZWUgdGhhdCBh
DQoxNmsgYWxsb2NhdGUgd2lsbCBiZSBhbGlnbmVkIG9uIGEgMTZrIHBoeXNpY2FsIGFkZHJlc3Mg
Ym91bmRhcnkuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJy
YW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lz
dHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

