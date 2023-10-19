Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2067CFF43
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Oct 2023 18:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjJSQRt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Oct 2023 12:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJSQRs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Oct 2023 12:17:48 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 Oct 2023 09:17:46 PDT
Received: from smtp11.infineon.com (smtp11.infineon.com [IPv6:2a00:18f0:1e00:4::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A53412A
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2023 09:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1697732267; x=1729268267;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1aK78rGlkrVx/wBgFMJ+X891RE795OFRMRnR3Og0eTI=;
  b=kkBVgyKCQvfPRDRFsajXEb20kO28HIEwpYEXEJLYkNInbDiK63Ap0o6C
   gUIdH1Iq4TAnifta0eriob6nDDZOmzydmrbwgtlFZx1mnLdH33euMCKwk
   xtyPSYR/S/p9B+xvSqDyyqmJIak1Ob0Mfb749fNtqNsGZvojd2yjQpDCw
   8=;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="36301965"
X-IronPort-AV: E=Sophos;i="6.03,237,1694728800"; 
   d="scan'208";a="36301965"
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 18:16:42 +0200
Received: from MUCSE843.infineon.com (172.23.7.72) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 19 Oct
 2023 18:16:41 +0200
Received: from MUCSE843.infineon.com (172.23.7.72) by MUCSE843.infineon.com
 (172.23.7.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 19 Oct
 2023 18:16:40 +0200
Received: from MUCSE843.infineon.com ([fe80::2199:b8a6:8f2e:48a]) by
 MUCSE843.infineon.com ([fe80::2199:b8a6:8f2e:48a%21]) with mapi id
 15.02.1118.037; Thu, 19 Oct 2023 18:16:40 +0200
From:   <Andreas.Fuchs@infineon.com>
To:     <James.Bottomley@HansenPartnership.com>, <juergen_repp@web.de>,
        <linux-integrity@vger.kernel.org>
CC:     <christian.plappert@sit.fraunhofer.de>
Subject: RE: TPM resource manager returns -1 for TPM2_RC_CONTEXT_GAP
Thread-Topic: TPM resource manager returns -1 for TPM2_RC_CONTEXT_GAP
Thread-Index: AQHaApVfWPhBek5+G0W3af4I73cxULBRFvoAgAAu+SA=
Date:   Thu, 19 Oct 2023 16:16:40 +0000
Message-ID: <23488b27daae488e97323ff07f52db6f@infineon.com>
References: <0a8b84bd-7c79-415c-afac-b3c7d6341805@web.de>
 <48485679a3d66fe802960ea2826885a3456b9180.camel@HansenPartnership.com>
In-Reply-To: <48485679a3d66fe802960ea2826885a3456b9180.camel@HansenPartnership.com>
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
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

PiBGcm9tOiBKYW1lcyBCb3R0b21sZXkgPEphbWVzLkJvdHRvbWxleUBIYW5zZW5QYXJ0bmVyc2hp
cC5jb20+IA0KPiBPbiBUaHUsIDIwMjMtMTAtMTkgYXQgMTY6MDUgKzAyMDAsIEp1ZXJnZW4gUmVw
cCB3cm90ZToNCj4gPiBUaGVyZSBpcyBhbiBpc3N1ZSByZWxhdGVkIHRvIHRoaXMgcHJvYmxlbSBv
biBnaXRodWIgZm9yIHRwbTItdHNzOg0KPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS90cG0yLXNvZnR3
YXJlL3RwbTItdHNzL2lzc3Vlcy8yNjkxICgvZGV2L3RwbXJtMCB3YXMgDQo+ID4gdXNlZCkgVGhl
IGVycm9yIGRpZCBvY2N1ciBhZnRlciBhYmJvdXQgMjAwIHNpZ25pbmcgb3BlcmF0aW9ucyB3aGVu
IGEgDQo+ID4gc2Vjb25kIHNlc3Npb24gd2FzIG9wZW5lZCBieSBhIHNlY29uZCBwcm9jZXNzIGF0
IHRoZSBzYW1lIHRpbWUuDQo+ID4gS2VybmVsIGxvZzoNCj4gPiBbIDQwMS45MjM4MjZdIHRwbSB0
cG0wOiB0cG0yX3NhdmVfY29udGV4dDogZmFpbGVkIHdpdGggYSBUUE0gZXJyb3INCj4gPiAweDA5
MDENCj4gPiBbwqAgNDAxLjkyNTA0OV0gdHBtIHRwbTA6IEEgVFBNIGVycm9yICg0NTkpIG9jY3Vy
cmVkIGZsdXNoaW5nIGNvbnRleHQNCj4NCj4gSSdtIGFmcmFpZCB0aGF0J3MgYSBrbm93biBwcm9i
bGVtIHdpdGggdGhlIEludGVsIFRTUzogaXQgc2F2ZXMgdGhlIGNvbnRleHQsIHdoaWNoIHdpbGwg
Y2F1c2UgYSBnYXBwaW5nIGVycm9yIGlmIHlvdSBrZWVwIGl0IHNhdmVkIHdoaWxlIGRvaW5nIG90
aGVyIGNvbnRleHQgcmVxdWlyaW5nIG9wZXJhdGlvbnMuICBUaGUgc29sdXRpb25zIGFyZSBlaXRo
ZXIgdG8gaW1wbGVtZW50IGRlZ2FwcGluZyBpbiB0aGUga2VybmVsIG9yIHBlcnN1YWRlIHRoZSBJ
bnRlbCBUU1Mgbm90IHRvIHNhdmUgY29udGV4dHMgdW5uZWNlc3NhcmlseS4NCg0KVGhpcyBpcyBp
bmRlcGVuZGVudCBvZiB0aGUgVFNTIHVzZWQuDQpXaGVuIHlvdSBoYXZlIG9uZSBsb25nIGxhc3Rp
bmcgc2Vzc2lvbiBiZWluZyB1c2VkIHNlbGRvbWx5IChpLmUuIGluIEFwcGxpY2F0aW9uIEEpIGFu
ZCBhbm90aGVyIHNlc3Npb24gb3IgbXVsdGlwbGUgc2Vzc2lvbnMgYmVpbmcgdXNlZCBmcmVxdWVu
dGx5IChpLmUuIGluIEFwcGxpY2F0aW9uIEIpLCB0aGVuIHlvdSB3aWxsIGhpdCB0aGlzIHByb2Js
ZW0gYXQgc29tZSBwb2ludC4NCkFzIHN1Y2ggQU5ZIHJlc291cmNlIG1hbmFnZXIgKGluIGtlcm5l
bCBvciBvdXRzaWRlKSBuZWVkcyB0byBpbXBsZW1lbnQgc2Vzc2lvbiB1bmdhcGluZywgb3RoZXJ3
aXNlIGl0IHdpbGwgZmFpbCBzdWNoIHNjZW5hcmlvcy4NCg0KDQpKYW1lczsgb24gYSBkaWZmZXJl
bnQgbm90ZToNCkFueSBjb250ZXh0U2F2ZXMgYnkgYW4gYXBwbGljYXRpb24gb3IgbWlkZGxld2Fy
ZSB3aWxsIGp1c3QgbWFrZSB0aGlzIHByb2JsZW0gYXBwZWFyIGVhcmxpZXIgYnV0IHRoZSBLZXJu
ZWwncyBSTSB3aWxsIGRvIHRoZSBjb250ZXh0U2F2ZSBvZiBBJ3Mgc2Vzc2lvbnMgYW55d2F5cy4N
CllvdSBjYW4gZWFzaWx5IG1ha2UgdGhlIHNhbWUgcHJvYmxlbSBhcHBlYXIgaW4gQU5ZIFRTUyBh
bmQgeW91IGtub3cgdGhpcyB2ZXJ5IHdlbGwuDQpTbywgcGxlYXNlIHN0b3AgYmFkIG1vdXRoaW5n
ICJub3QgeW91ciBUU1MiZXMuDQo=
