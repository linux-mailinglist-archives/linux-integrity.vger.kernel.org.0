Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0941FB4AA
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jun 2020 16:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbgFPOlk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 10:41:40 -0400
Received: from mga12.intel.com ([192.55.52.136]:9766 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbgFPOli (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 10:41:38 -0400
IronPort-SDR: sNfv+pD7Y/yZ8CfyI8oISdoUaawoVVbUbM9dUZy6bnwJT6C130G/GrL1KKi7yQZAHwUY39D5vi
 HChtkpoo033Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 07:41:37 -0700
IronPort-SDR: g/OsKLJymTggqELw1zclcd2caGgYQJUvEYCR4q6L0j4bwy1dCq4nUqdenbyav1b+OEFIK3R4jG
 DZISc/Xf/EjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,518,1583222400"; 
   d="scan'208";a="309130605"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga002.fm.intel.com with ESMTP; 16 Jun 2020 07:41:36 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 16 Jun 2020 07:41:36 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 16 Jun 2020 07:41:35 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 16 Jun 2020 07:41:35 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 16 Jun 2020 07:41:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSjsWmi3c4UlrWUpiITw9OlVjNKGqRaPyhQog8nhkBtO5DRi6kKLCKwoIjKBfDjXTYPhpaT6K6lr2gFI1cib0DWbLJAEuPcq2I1XWSkzn7jxtrRaYcCn2rEn5CsW6Iem1my4zkgEIbVdJUyyNOyPvq8CoyFz7FH6Hzk8Q+0pTHT+0CEJO0yeCA16V/24EsBSfpIfhX6TErH61JnhMd7oT64+VSOGQXALg0wj8TVwynsKHL1nDx/UHpUlTxkEykcBfqgpoAmbSkL6RSMnkiDuyTBisQ4AlULNZDZfAGEl1rcLNA+kC3EmtXBwklT1sRteHR4vQ8p9DAMTlZAvg9XwSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQDa0GO6mxgVLUSaUULEZQcmK1BOqZvaCj6Pv7Hd5vg=;
 b=R2FhAusXsyiFIHuwXiepC4kw3+GsAiWsT6H63SUXGvRg6sVm0QVmyp8/m3CfxGYnZtcVMlGCabcURr0QKqv8udAgnBmx2QxS5v5rtD68gNYR9a59w9FdEPtU1ArzfAz+C79XEMATRQOnJnqWK/twlN/NG3Xrpdl0bDAX+b+h5v5+9a0ThIAtyJP5IeNJ1mkBVnfd61T0fdylM2g8Sj1P01Z1qkM/RkrMdcwNknmbh/pAhec895zbm79ayw0ROoB8Ac3IOgRcdMF+ZDaQXLE1IQ3BhdajIuNUNJFamYMDB3uKjHtUFJiNHin+dnhdAKRRf6/CjNJj9MmpQZJHKCpb6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQDa0GO6mxgVLUSaUULEZQcmK1BOqZvaCj6Pv7Hd5vg=;
 b=YDTJVCT5jGUJ72kA1uNv2JEJUVigldhuY/Ly3wUffdJxTIXD7eA5iArH7a67V4NkE153wrvYLiNN/eVYhdMpSer5otJdmVNx5Bm7ffzLtn9anOUj4KzcWvcrupLK+nwGQKC/5qaAJEMN3tkWDdJ6An7VSXuRUDwntrr0/etX634=
Received: from BL0PR11MB3252.namprd11.prod.outlook.com (2603:10b6:208:6e::18)
 by BL0PR11MB3411.namprd11.prod.outlook.com (2603:10b6:208:32::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Tue, 16 Jun
 2020 14:41:33 +0000
Received: from BL0PR11MB3252.namprd11.prod.outlook.com
 ([fe80::7d75:5039:3841:943d]) by BL0PR11MB3252.namprd11.prod.outlook.com
 ([fe80::7d75:5039:3841:943d%3]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 14:41:33 +0000
From:   "Zhao, Shirley" <shirley.zhao@intel.com>
To:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "LSM List" <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Two questions about IMA
Thread-Topic: Two questions about IMA
Thread-Index: AdZD7Cuj8qgPLpy/Qw2vOJwAmSsd8Q==
Date:   Tue, 16 Jun 2020 14:41:33 +0000
Message-ID: <BL0PR11MB3252AC76F135A7546554BDF88D9D0@BL0PR11MB3252.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDAyOGIxYzEtYmRhZi00NzM2LTg2YmUtYjk4MTRkZDRhZjdiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoickJ2eVhraDFvVVNUaGVjWnZiSXpIMlwvck5xcWRveVRDQ2I5OGFLcWNNVDZoXC9XQllVZXgrUEVtajhqemNndURZIn0=
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.218]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfe07939-83d1-48d1-cc62-08d812035d80
x-ms-traffictypediagnostic: BL0PR11MB3411:
x-microsoft-antispam-prvs: <BL0PR11MB3411C527A1BD80379C154E7F8D9D0@BL0PR11MB3411.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qBBdeI5a0G2c+rdeaSUGW+jGO67/SwS3+JN6X9bHW37rFbkEy615xMEjy02aIEc8/01P4rzGryssfrbqj37zbiY1rqueIutRZyROGJe7lZ49u2pFdTcMYLR7MgPEobobBiDucQWgURz/3niSac0YgdFnXP0moYni2bqoukGE5E9QpIvM6uvBrE10h5cHCogPbNnv6EQIUzArxhbZz0OjhQbPmLeSyX+icVpBtTpN1NEkT3HDdNggEZsx3Fmsr8KxwAiDYvKxtAn9bsuLzyYVMXc3u/Txhr+2MOy2Ss5BdEz5Aes8I2z4EpbbzoPvm8Y6ZA4ZKoAx2M/3TSopnrpd9ITYwMTTUqW6ZV0sDfBzWLEyAELW7Zj39SjrJrhRWvQTzfjMpZXmNHt7ilMGvSdsGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3252.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(64756008)(66476007)(33656002)(66556008)(66446008)(7696005)(76116006)(55016002)(8676002)(66946007)(9686003)(6506007)(71200400001)(4744005)(450100002)(966005)(8936002)(110136005)(2906002)(52536014)(83380400001)(3480700007)(26005)(86362001)(5660300002)(478600001)(316002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: HHo0HJ2XkhkxxFVm96khPVI3hWtxEY8Gu0TC17YTbsP8brx194dW6gWDs+ObpTOnJB+mJIbNQz+5M5Za31FbklGkp8I7n5v4Dej/hRvwtkjN2DxUJWuFKzLAqpz2PJHtM/OeABoXzlR6VtRIAgK9DORRQFPUgjhcjsGD5EP6qUIJZXI8QbuU1BWMNPikoN/lP9Nv4uJjX6eK33Xuat2+kc0/0CECPPHGgjI/c9oey9NY3AhtzqfbArd+VtdYnOtD9/pcaeQJMy2IwKd4r8YZ/6qaPgadAWoIcWGIxzhbuwNXMnh4YBKCAetNUsbUm3w32xXvNHRzK7v2p0MMjIlSw/rZh1jPPm6u9at+TqTD6q3XEwUUudl1zTLC0PhhJr6zo0D5L/HHytuVtFEpLSWzRMpmXJoJxrrAIvQlUJJE7VmkqjM39KtnhxBrhx/rUeQP3BncGkkRkcylMAZaH6IaY2lCbSwWjUwdLtS6VDAPe8lvZ1CCCM7hlxto5syFvxD9
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe07939-83d1-48d1-cc62-08d812035d80
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 14:41:33.4080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YlM7o18kj1WEqu508s8x1ZUzO5pdNWn5rb5LrTW11gGa7o3DmsFzZjYjmxf85XdWYMfxT19Zudy8wwdBOAZZTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3411
X-OriginatorOrg: intel.com
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SGksIGFsbCwgDQoNClRoaXMgaXMgU2hpcmxleSBmcm9tLCBJIGFtIGEgbmV3ZXIgb2YgSU1BLiAN
CkkgaGF2ZSBzb21lIHF1ZXN0aW9ucy4gQ2FuIHlvdSBoZWxwPw0KDQpBY2NvcmRpbmcgdG8gdGhl
IGd1aWRlOiBodHRwczovL3NvdXJjZWZvcmdlLm5ldC9wL2xpbnV4LWltYS93aWtpL0hvbWUvI2xp
bnV4LWV4dGVuZGVkLXZlcmlmaWNhdGlvbi1tb2R1bGUtZXZtLiANCjEuCUhvdyB0byBjYWxjdWxh
dGUgdGhlIHRlbXBsYXRlIGhhc2ggaW4gL3N5cy9rZXJuZWwvc2VjdXJpdHkvaW1hL2FzY2lpX3J1
bnRpbWVfbWVhc3VyZW1lbnRzPyBMaWtlIGJlbG93Og0KUENSICAgICB0ZW1wbGF0ZS1oYXNoICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZmlsZWRhdGEtaGFzaCAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGZpbGVuYW1lLWhpbnQNCjEwIDkxZjM0YjVjNjcxZDczNTA0YjI3NGE5MTk2NjFjZjgw
ZGFiMWUxMjcgaW1hLW5nIHNoYTE6MTgwMWUxYmUzZTY1ZWYxZWFhNWMxNjYxN2JlYzhmMTI3NGVh
ZjZiMyBib290X2FnZ3JlZ2F0ZSANCjEwIDhiMTY4MzI4N2Y2MWY5NmU1NDQ4ZjQwYmRlZjZkZjMy
YmU4NjQ4NmEgaW1hLW5nIHNoYTI1NjplZmRkMjQ5ZWRlYzk3Y2FmOTMyOGE0YTAxYmFhOTliN2Q2
NjBkMWFmYzJlMTE4YjY5MTM3MDgxYzliNjg5OTU0IC9pbml0IA0KMi4JVWJ1bnR1IDIwLjA0IGlz
IGluc3RhbGxlZCBvbiBteSBtYWNoaW5lLCBidXQgYXNjaWlfYmlvc19tZWFzdXJlbWVudHMgY2Fu
4oCZdCBiZSBmb3VuZCB1bmRlciAvc3lzL2tlcm5lbC9zZWN1cml0eS90cG0wLy4gDQpUaGVyZSBp
cyBvbmx5IGJpbmFyeV9iaW9zX21lYXN1cmVtZW50cyB1bmRlciB0cG0wLy4gDQpTbyB3aGVyZSB0
byBmaW5kIHRoZSBiaW9zIG1lYXN1cmUgbGlzdCBvbiBVYnVudHUgMjAuMDQ/DQoNClRoYW5rcy4g
DQoNCi0JU2hpcmxleSAgDQo=
