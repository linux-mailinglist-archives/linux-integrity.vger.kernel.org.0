Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985507D104C
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Oct 2023 15:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377389AbjJTNJ5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Oct 2023 09:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377411AbjJTNJ4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Oct 2023 09:09:56 -0400
Received: from smtp11.infineon.com (smtp11.infineon.com [IPv6:2a00:18f0:1e00:4::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259801A8
        for <linux-integrity@vger.kernel.org>; Fri, 20 Oct 2023 06:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1697807394; x=1729343394;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S6srI/vP3ZWQIWorqRGxU4TXBYdo1LnEBVfSIHZG9Y8=;
  b=oMmhCEnk8CE0TegzsfOWUOwAM/J9l5UpWlK05zJspbwI0Jp17xdsBHnt
   uyDDeIi2Mr8ybYG6jYZgQdl6iOCM1FOtcSW4LS79G5TP9ezkaawSGL4/g
   D+g0c7XGEQLPVU1N8GEHlAllqQ/rON/Q6ueG51fwR1VnYK+9vdzDR/QEd
   s=;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="36415140"
X-IronPort-AV: E=Sophos;i="6.03,238,1694728800"; 
   d="scan'208";a="36415140"
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 15:09:52 +0200
Received: from KLUSE842.infineon.com (172.28.156.183) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Fri, 20 Oct
 2023 15:09:52 +0200
Received: from MUCSE843.infineon.com (172.23.7.72) by KLUSE842.infineon.com
 (172.28.156.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 20 Oct
 2023 15:09:51 +0200
Received: from MUCSE843.infineon.com ([fe80::2199:b8a6:8f2e:48a]) by
 MUCSE843.infineon.com ([fe80::2199:b8a6:8f2e:48a%21]) with mapi id
 15.02.1118.037; Fri, 20 Oct 2023 15:09:51 +0200
From:   <Andreas.Fuchs@infineon.com>
To:     <James.Bottomley@HansenPartnership.com>, <juergen_repp@web.de>,
        <linux-integrity@vger.kernel.org>
CC:     <christian.plappert@sit.fraunhofer.de>
Subject: RE: TPM resource manager returns -1 for TPM2_RC_CONTEXT_GAP
Thread-Topic: TPM resource manager returns -1 for TPM2_RC_CONTEXT_GAP
Thread-Index: AQHaApVfWPhBek5+G0W3af4I73cxULBRFvoAgAAu+SCAAT+cgIAAIgKQ
Date:   Fri, 20 Oct 2023 13:09:51 +0000
Message-ID: <f0d467d1d35e4709abd70c870dc68157@infineon.com>
References: <0a8b84bd-7c79-415c-afac-b3c7d6341805@web.de>
         <48485679a3d66fe802960ea2826885a3456b9180.camel@HansenPartnership.com>
         <23488b27daae488e97323ff07f52db6f@infineon.com>
 <17c803dfb04505e35d4bdd831ef5c63ccb312e32.camel@HansenPartnership.com>
In-Reply-To: <17c803dfb04505e35d4bdd831ef5c63ccb312e32.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogSmFtZXMgQm90dG9tbGV5IDxKYW1lcy5Cb3R0b21sZXlASGFuc2VuUGFydG5lcnNoaXAu
Y29tPiANCj4gT24gVGh1LCAyMDIzLTEwLTE5IGF0IDE2OjE2ICswMDAwLCBBbmRyZWFzLkZ1Y2hz
QGluZmluZW9uLmNvbSB3cm90ZToNCj4gPiA+IEZyb206IEphbWVzIEJvdHRvbWxleSA8SmFtZXMu
Qm90dG9tbGV5QEhhbnNlblBhcnRuZXJzaGlwLmNvbT4NCj4gPiA+IE9uIFRodSwgMjAyMy0xMC0x
OSBhdCAxNjowNSArMDIwMCwgSnVlcmdlbiBSZXBwIHdyb3RlOg0KPiA+ID4gPiBUaGVyZSBpcyBh
biBpc3N1ZSByZWxhdGVkIHRvIHRoaXMgcHJvYmxlbSBvbiBnaXRodWIgZm9yIHRwbTItdHNzOg0K
PiA+ID4gPiBodHRwczovL2dpdGh1Yi5jb20vdHBtMi1zb2Z0d2FyZS90cG0yLXRzcy9pc3N1ZXMv
MjY5MSAoL2Rldi90cG1ybQ0KPiA+ID4gPiAwIHdhcw0KPiA+ID4gPiB1c2VkKSBUaGUgZXJyb3Ig
ZGlkIG9jY3VyIGFmdGVyIGFiYm91dCAyMDAgc2lnbmluZyBvcGVyYXRpb25zIHdoZW4gDQo+ID4g
PiA+IGEgc2Vjb25kIHNlc3Npb24gd2FzIG9wZW5lZCBieSBhIHNlY29uZCBwcm9jZXNzIGF0IHRo
ZSBzYW1lIHRpbWUuDQo+ID4gPiA+IEtlcm5lbCBsb2c6DQo+ID4gPiA+IFsgNDAxLjkyMzgyNl0g
dHBtIHRwbTA6IHRwbTJfc2F2ZV9jb250ZXh0OiBmYWlsZWQgd2l0aCBhIFRQTSBlcnJvciANCj4g
PiA+ID4gMHgwOTAxIFvCoCA0MDEuOTI1MDQ5XSB0cG0gdHBtMDogQSBUUE0gZXJyb3IgKDQ1OSkg
b2NjdXJyZWQgDQo+ID4gPiA+IGZsdXNoaW5nIGNvbnRleHQNCj4gPiA+DQo+ID4gPiBJJ20gYWZy
YWlkIHRoYXQncyBhIGtub3duIHByb2JsZW0gd2l0aCB0aGUgSW50ZWwgVFNTOiBpdCBzYXZlcyB0
aGUgDQo+ID4gPiBjb250ZXh0LCB3aGljaCB3aWxsIGNhdXNlIGEgZ2FwcGluZyBlcnJvciBpZiB5
b3Uga2VlcCBpdCBzYXZlZCB3aGlsZSANCj4gPiA+IGRvaW5nIG90aGVyIGNvbnRleHQgcmVxdWly
aW5nIG9wZXJhdGlvbnMuICBUaGUgc29sdXRpb25zIGFyZSBlaXRoZXIgDQo+ID4gPiB0byBpbXBs
ZW1lbnQgZGVnYXBwaW5nIGluIHRoZSBrZXJuZWwgb3IgcGVyc3VhZGUgdGhlIEludGVsIFRTUyBu
b3QgDQo+ID4gPiB0byBzYXZlIGNvbnRleHRzIHVubmVjZXNzYXJpbHkuDQo+ID4NCj4gPiBUaGlz
IGlzIGluZGVwZW5kZW50IG9mIHRoZSBUU1MgdXNlZC4NCj4gPiBXaGVuIHlvdSBoYXZlIG9uZSBs
b25nIGxhc3Rpbmcgc2Vzc2lvbiBiZWluZyB1c2VkIHNlbGRvbWx5IChpLmUuIGluIA0KPiA+IEFw
cGxpY2F0aW9uIEEpIGFuZCBhbm90aGVyIHNlc3Npb24gb3IgbXVsdGlwbGUgc2Vzc2lvbnMgYmVp
bmcgdXNlZCANCj4gPiBmcmVxdWVudGx5IChpLmUuIGluIEFwcGxpY2F0aW9uIEIpLCB0aGVuIHlv
dSB3aWxsIGhpdCB0aGlzIHByb2JsZW0gYXQgDQo+ID4gc29tZSBwb2ludC4NCj4gPiBBcyBzdWNo
IEFOWSByZXNvdXJjZSBtYW5hZ2VyIChpbiBrZXJuZWwgb3Igb3V0c2lkZSkgbmVlZHMgdG8gaW1w
bGVtZW50IA0KPiA+IHNlc3Npb24gdW5nYXBpbmcsIG90aGVyd2lzZSBpdCB3aWxsIGZhaWwgc3Vj
aCBzY2VuYXJpb3MuDQo+DQo+IFRoYXQncyB0cnVlLCBidXQgaW4gcmVhbCBsaWZlIHRoZSB1c2Ug
b2Ygc2Vzc2lvbnMgdGVuZHMgdG8gYmUgc2hvcnQgbGl2ZWQgYW5kIG5vdCBjb250ZXh0IHNhdmVk
ICh1c3VhbGx5IHNob3J0IGVub3VnaCB0aGF0IHRoaXMgZG9lc24ndCBldmVuIGNhdXNlIGEgY29u
dGV4dCBzYXZlIGluc2lkZSB0aGUga2VybmVsIHJtKS4gIFlvdSBjYW4gc2VlIHRoaXMgaW4gdGhl
IFRQTSBjb2RlIGluIGdudXBnLCBvciBhbnkgb2YgdGhlIGVuZ2luZXMvcHJvdmlkZXJzLiBUaGF0
J3Mgbm90IHRvIHNheSB3ZSBzaG91bGRuJ3QgZG8gZGVnYXBwaW5nIGJ1dCwgYmVjYXVzZSBtb3N0
IGNvbW1vbiB1c2VzIGluIHRoZSBmaWVsZCBkb24ndCBuZWVkIGl0LCB0aGVyZSdzIGJlZW4gbGl0
dGxlIHByZXNzdXJlIG9uIGFueW9uZSB0byBhY3R1YWxseSB3cml0ZSB0aGUgY29kZS4NCj4NCj4g
PiBKYW1lczsgb24gYSBkaWZmZXJlbnQgbm90ZToNCj4gPiBBbnkgY29udGV4dFNhdmVzIGJ5IGFu
IGFwcGxpY2F0aW9uIG9yIG1pZGRsZXdhcmUgd2lsbCBqdXN0IG1ha2UgdGhpcyANCj4gPiBwcm9i
bGVtIGFwcGVhciBlYXJsaWVyIGJ1dCB0aGUgS2VybmVsJ3MgUk0gd2lsbCBkbyB0aGUgY29udGV4
dFNhdmUgb2YgDQo+ID4gQSdzIHNlc3Npb25zIGFueXdheXMuDQo+ID4gWW91IGNhbiBlYXNpbHkg
bWFrZSB0aGUgc2FtZSBwcm9ibGVtIGFwcGVhciBpbiBBTlkgVFNTIGFuZCB5b3Uga25vdyANCj4g
PiB0aGlzIHZlcnkgd2VsbC4NCj4gPiBTbywgcGxlYXNlIHN0b3AgYmFkIG1vdXRoaW5nICJub3Qg
eW91ciBUU1MiZXMuDQo+DQo+IFdlbGwsIE9LLCBob3cgYWJvdXQgdGhpczogdGhlcmUgaXMgYSB1
bmlxdWUgZmVhdHVyZSBvZiB0aGUgdHBtIHRvb2xzIGFsbGllZCB3aXRoIHRoZSBJbnRlbCBUU1Mg
aW4gdGhhdCB0aGV5IGFueSB1c2Ugb2Ygc2Vzc2lvbnMgYWx3YXlzIHNlZW0gdG8gaW5kdWNlIGEg
c2Vzc2lvbiBjb250ZXh0IHNhdmUgd2hpY2ggY2FuIGxlYWQgdG8gYSBnYXBwaW5nIHByb2JsZW0u
DQoNClNvIGluIHRoZSBpc3N1ZSBsaW5rZWQgYWJvdmUsIHRoZSB0cG0yLXRvb2xzIGFyZSBub3Qg
dXNlZCBhdCBhbGwuIEFuZCB0aGUgdHBtMi10c3MgbGlicmFyaWVzIGRvIG5vdCBkbyBhbnkgQ29u
dGV4dFNhdmVzIG9uIHRoZWlyIG93bi4NCg0KU28gaGVyZSB3ZSBhcmUgaGl0dGluZyB0aGUgaXNz
dWUgZnJvbSBwdXJlIGFwcGxpY2F0aW9uIHdvcmtsb2FkLg0KU28gSSBhbSBnbGFkIHRoYXQgd2Ug
YWdyZWUgdGhhdCB0aGUga2VybmVsIG5lZWRzIHRvIGxlYXJuIGhvdyB0byB1bmdhcCBzZXNzaW9u
cy4NCg0KDQo=
