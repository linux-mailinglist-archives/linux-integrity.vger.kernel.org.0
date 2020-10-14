Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF89128E77C
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Oct 2020 21:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgJNTnp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Oct 2020 15:43:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:2127 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgJNTno (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Oct 2020 15:43:44 -0400
IronPort-SDR: bcT+UP3/N3Pe605gWP6NPZzXFLK9CX/JpZFnJ0DvUhXqRaMEIHEUqlktsf/69vITa7P8lNA6wC
 YQ1lrKL9TpWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="153118028"
X-IronPort-AV: E=Sophos;i="5.77,375,1596524400"; 
   d="scan'208";a="153118028"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 12:43:40 -0700
IronPort-SDR: 7a4//KUnDcAwyYjW3tm83gnkrmo8/cADB9nQ7oj2o1E14RP4kZ+ZjKuCbWz4piess0GoDuYz6Y
 7vfqeXNnkzJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,375,1596524400"; 
   d="scan'208";a="318767798"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga006.jf.intel.com with ESMTP; 14 Oct 2020 12:43:40 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 14 Oct 2020 12:43:40 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 14 Oct 2020 12:43:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 14 Oct 2020 12:43:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqWZIH8to8pM2lF1Qwjf4w4eS/GYCzVjOjE3AvtZh6t8Lz1TXLcbU0juLy2/ihd6sWJ5oPKORgLyr5E5JKSZylRKgwGCGboUdqENUONi+vtVHvJhwMs6DNU9ce4e99FbqYQN0zKRR3QrPNWNcmeAYGK68FWMLhKcbHcSECU2+20RldzQQPuSnujxD99oCJ2mdfq8vtbrpYKUxAUssz1dvKes+8M9f5DRzYEUVU1U6q7JExtTBqEJp04hkSHaLLPlRBEGjMGPf2A38iLl0G0TUbTr0mWBnf/xOQJu0qX58tdg8DN7cObVRia8CXEIWLyq6/7bgVbHNecUYQq0SAvOVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUrUiunb/6SwIDhJp+mk5heR7MTdDr7eG4RkmPoHQGI=;
 b=kIXIcicvZTPNE/gUEZ5Ia+XYPl3q+m5UVqq3yvMt3C3UjYCLgE/VdALBhwRq1WIv/cezzK0rZMbWQpJ9mdg+SdLs3HdxkidZUtgQknJ+d2dK0mPC/PGXH29ZxGfN9bBOwNekSjsraHTmrtlcXE/8ps9GfH/KQKk9tjLtFk4PmbmurfINILZZyOXdIEJm4G7LXSgLTR0SGkpuXzAdWnd95Oa44TP4xzs8RaFhYt5klevukSLSjjO4NUBV4y6pGdp+Ynb1mb03ajAOiQeNjU1Rnwxz7+qirTiRs/v3Qd6wk/nxZd/X5wwZJ9aszWOP5OGuLHTMu1d6IHh8ddrlaHL+ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUrUiunb/6SwIDhJp+mk5heR7MTdDr7eG4RkmPoHQGI=;
 b=cuBveO2lwA8JjIw085fmOXF/68WviC6XQQoCckHTBDSjPNZVqyzwQg//DhSkhFTjJFKy1Uf6iyTlJpyl4bL368lEGezamztmkFw9twzkQMnWZq/2JX/zourbmcqtUfseWhLVmPWU0rrzecSZT228G5x0gV6+rhLyQBiskiocHJg=
Received: from SN6PR11MB3437.namprd11.prod.outlook.com (2603:10b6:805:db::13)
 by SA2PR11MB4843.namprd11.prod.outlook.com (2603:10b6:806:fb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.30; Wed, 14 Oct
 2020 19:43:39 +0000
Received: from SN6PR11MB3437.namprd11.prod.outlook.com
 ([fe80::7d04:a30b:7d9e:d204]) by SN6PR11MB3437.namprd11.prod.outlook.com
 ([fe80::7d04:a30b:7d9e:d204%4]) with mapi id 15.20.3477.020; Wed, 14 Oct 2020
 19:43:38 +0000
From:   "Roberts, William C" <william.c.roberts@intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        "tpm2@lists.01.org" <tpm2@lists.01.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: RE: QUEMU and TPM2 device emulation
Thread-Topic: QUEMU and TPM2 device emulation
Thread-Index: AdaiOXxaeO4KYc6IRQKmBbySOBZp9gADhKsAAAaSe+A=
Date:   Wed, 14 Oct 2020 19:43:38 +0000
Message-ID: <SN6PR11MB3437AF5422ABFC3D20052822B8050@SN6PR11MB3437.namprd11.prod.outlook.com>
References: <SN6PR11MB34372D6EA769E056632095CFB8050@SN6PR11MB3437.namprd11.prod.outlook.com>
 <dfbdf8575aa358864a99a9e51ccd885a943f27e5.camel@HansenPartnership.com>
In-Reply-To: <dfbdf8575aa358864a99a9e51ccd885a943f27e5.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: HansenPartnership.com; dkim=none (message not signed)
 header.d=none;HansenPartnership.com; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [134.134.136.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb58e743-c75e-463b-8f66-08d8707972a1
x-ms-traffictypediagnostic: SA2PR11MB4843:
x-microsoft-antispam-prvs: <SA2PR11MB4843FA521EAA41E11440F51EB8050@SA2PR11MB4843.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RDp5uORmA2WarQWxfUXKyAB7nVsR2JkXwdbjiw+RuiV2xFJzRN1NS4Q1fw9QQnXjQ3+2SmnqZgoRul3BGeMd2D9aZ00drIaFkpjvc94evfdrDqtltjZnfJICLKlDHiegxPFJFHuWGCPmGDByLyiEJo3Ai9kvBbl9bcBPJs/hGkxfSE5JHdYna6+aJR4JfQ/DT6015PlXW28ktcPO8dwR1TGN1PnkiFsLgt3HxN4DRGDuN7hZfFyhr+Zhu8XnLJ9WB4gJmGM+Z9G5U0Z47boii6SEOuWn+0NIUGZmQd/PIymIfrkzs3+dmQKCtQBKz4ESF6RcaaVV1vSc7js9I/VLxZDaI4YK3usjYQM79GK9HxAf6e9U3+UCCiFN0OuRh1jMtYGWh2D3shQs/zOXIFGzdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3437.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(5660300002)(33656002)(966005)(186003)(316002)(4001150100001)(83380400001)(478600001)(66476007)(2906002)(110136005)(9686003)(66556008)(64756008)(66446008)(71200400001)(8936002)(66946007)(86362001)(55016002)(53546011)(76116006)(26005)(7696005)(8676002)(52536014)(83080400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: +4o1KVBMgtm6ydyDHt1VVjJ4is8AuJ4oxoruz71/WJcEV+lZ8+xZsOVR564ia8iB/WCc3V6ROmvoluB4tz3dIjq6i2KEppeoWrpXVX+hYmT2sLMGd0CUZTLdBjEYK00UL5XmaYteqnD78iBUkOIdn25UwYtbRZ1lrT8CWDaHAvszkruw9/9fccukAwAMTbyJHicLTB9Zl+Pr/SyIUwqpyQhpw8t9OT7BfS5NCWqogcgxO7bfWSA1YP/mzMlQ73P5bCnNoMyjRe5Bl8FcmZXOm6NOcCEggCtM1Z9+dh98YM7js0+LHO217n39UntG5T0ZSdFeByyjlhdzA13PFp4WprTnVuZy5XOHe1kznWU9wBYxoZXOqdv8pDSU2jvhoiEaYYkhqgCOlTMt9ENbRg+jHIDhLJPsLdst1D1M6R/bgaaHLMJdqQpYqB7+BSAD1enBmQePKbnCjuq3+IHw2h2ChhWu0lHiCY7m+Ir+2L2XIgVNknqZabIx1UsNSwMTLdd6EilEFofgeU6XKAuZQYU+LvbgCJI7euEuWkiA7kSvCQt9s3l9pFltmxd3bpZbwfvCmhwwBoEsJBfmt2YIyu9yCTqIrsRb4dPubDOAz2YPthp8hazyK0rY+UsLb1clGCNSAG0X+oeqPyjV7raoXi/1/w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3437.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb58e743-c75e-463b-8f66-08d8707972a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2020 19:43:38.8310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6SS7wkPRxiTZPVq7CGpn3BJcZ1Fx2+APwqGL38Ujf4Ukb7y3aEznfij6phMUJR/DVGWhKz6D4KjemH9UPf4TmfioFSpGC3n3wfcKBZ8HG4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4843
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFtZXMgQm90dG9tbGV5
IDxKYW1lcy5Cb3R0b21sZXlASGFuc2VuUGFydG5lcnNoaXAuY29tPg0KPiBTZW50OiBXZWRuZXNk
YXksIE9jdG9iZXIgMTQsIDIwMjAgMTE6MzIgQU0NCj4gVG86IFJvYmVydHMsIFdpbGxpYW0gQyA8
d2lsbGlhbS5jLnJvYmVydHNAaW50ZWwuY29tPjsgdHBtMkBsaXN0cy4wMS5vcmc7IGxpbnV4LQ0K
PiBpbnRlZ3JpdHlAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBRVUVNVSBhbmQgVFBN
MiBkZXZpY2UgZW11bGF0aW9uDQo+IA0KPiBPbiBXZWQsIDIwMjAtMTAtMTQgYXQgMTU6MjcgKzAw
MDAsIFJvYmVydHMsIFdpbGxpYW0gQyB3cm90ZToNCj4gPiBIYXMgYW55b25lIGV2ZXIgc2V0dXAg
YSBRVUVNVSBpbnN0YW5jZSB3aXRoIGEgdmlydHVhbGl6ZWQgVFBNPyBJIG5lZWQNCj4gPiB0byB0
cnkgYW5kIHJlcGxpY2F0ZSBhbiBpc3N1ZSB3aXRoIHRoZSBpbi1rZXJuZWwgUmVzb3VyY2UgbWFu
YWdlci4gTXkNCj4gPiBnb2FsIGlzIHRvIHVzZSB0aGUgaW50ZWdyYXRlZCBRVUVNVSBzdXBwb3J0
IFRvIGJyaW5nIHVwIGFuIGVtdWxhdGVkDQo+ID4gVFBNIGRldmljZSBhbmQgaXQncyBhc3NvY2lh
dGVkIFJNIG5vZGUgQCAvZGV2L3RwbXJtMC4NCj4gPg0KPiA+IEkgYW0gbG9va2luZyBhdDoNCj4g
PiBodHRwczovL2FuZHJvaWQuZ29vZ2xlc291cmNlLmNvbS9wbGF0Zm9ybS9leHRlcm5hbC9xZW11
LysvZW11LW1hc3Rlci1kDQo+ID4gZXYvZG9jcy9zcGVjcy90cG0udHh0DQo+ID4NCj4gPiBXaGlj
aCBzaG93cyB0aGlzIGNvbW1hbmQ6DQo+ID4NCj4gPiBxZW11LXN5c3RlbS14ODZfNjQgLWRpc3Bs
YXkgc2RsIC1lbmFibGUta3ZtIFwNCj4gPiAgIC1tIDEwMjQgLWJvb3QgZCAtYmlvcyBiaW9zLTI1
NmsuYmluIC1ib290IG1lbnU9b24gXA0KPiA+ICAgLWNoYXJkZXYgc29ja2V0LGlkPWNocnRwbSxw
YXRoPS90bXAvbXl0cG0xL3N3dHBtLXNvY2sgXA0KPiA+ICAgLXRwbWRldiBlbXVsYXRvcixpZD10
cG0wLGNoYXJkZXY9Y2hydHBtIFwNCj4gPiAgIC1kZXZpY2UgdHBtLXRpcyx0cG1kZXY9dHBtMCB0
ZXN0LmltZw0KPiA+DQo+ID4gPHNuaXA+DQo+ID4gIz4gZG1lc2cgfCBncmVwIC1pIHRwbQ0KPiA+
IFsgICAgMC43MTEzMTBdIHRwbV90aXMgMDA6MDY6IDEuMiBUUE0gKGRldmljZT1pZCAweDEsIHJl
di1pZCAxKQ0KPiA+DQo+ID4gSSBoYXZlIGEgZmV3IHF1ZXN0aW9ucyBhcm91bmQgdGhpcyB0aGF0
IEkgY2Fubm90IHNlZW0gdG8gZGlnIHVwIGFueQ0KPiA+IGRvY3VtZW50YXRpb24gb246DQo+ID4g
MS4gSG93IHRvIHNwZWNpZnkgVFBNMi4wIGRldmljZT8gVGhlIHByb2plY3QNCj4gPiBodHRwczov
L2dpdGh1Yi5jb20vc3RlZmFuYmVyZ2VyL3N3dHBtL3dpa2kgc2VlbXMgdG8gaW5kaWNhdGUgaXQg
d291bGQNCj4gPiBiZSBzdXBwb3J0ZWQuDQo+IA0KPiBBbGwgUUVNVSBpcyBkb2luZyBpcyBwYXNz
aW5nIHRocm91Z2ggYSBzb2NrZXQgdG8gc29tZXRoaW5nIGFzIGEgVFBNLg0KPiBFaXRoZXIgVFBN
IDEuMiBvciAyLjAgY291bGQgYmUgb24gdGhlIGVuZCBvZiB0aGF0IHNvY2tldCwgc28gd2hhdCBy
ZWFsbHkgbWF0dGVycyBpcw0KPiB3aGF0J3MgYXQgdGhlIG90aGVyIGVuZCBvZiAvdG1wL215dHBt
MS9zd3RwbS1zb2NrLg0KPiBJZiB5b3UgY2hhbmdlIHRoYXQgdG8gYmUgVFBNIDIuMCB0aGVuIFFF
TVUgd2lsbCBzZWUgaXQuDQoNClRoYW5rcyBKYW1lcywgb25jZSBJIHN0YXJ0ZWQgZmlkZGxpbmcg
d2l0aCBpdCwgaXQgc3RhcnRlZCB0byBtYWtlIHNlbnNlLiBZb3UgbmVlZCB0byBzdGFydCB0aGUg
c3d0cG0gY29tcG9uZW50DQp3aXRoIHRoZSBvcHRpb24gLS10cG0yLCB0aGVuIHBhc3MgdGhyb3Vn
aCBldmVyeXRoaW5nIGVsc2UgaW4gcWVtdSB0aGUgc2FtZSB3YXksIGFzIHlvdSBwb2ludCBvdXQu
DQoNCklsbCBwb3N0IG15IGNvbW1hbmRzIGZvciBhbnlvbmUgZWxzZSB3aG8gbWF5IHN0dW1ibGUg
aW50byB0aGlzIG9uIHRoZWlyIHF1ZXN0Og0KDQojIyBTdGFydCBUUE0gRW11bGF0b3INCg0KTm90
ZSB0aGF0IG9uZSBuZWVkcyB0aGUgLS10cG0yIG9wdGlvbiB0byBzdGFydCBhIFRQTTIuMCBlbXVs
YXRvci4NCg0KbWtkaXIgL3RtcC9teXRwbTENCnN3dHBtIHNvY2tldCAtLXRwbXN0YXRlIGRpcj0v
dG1wL215dHBtMSAtLWN0cmwgdHlwZT11bml4aW8scGF0aD0vdG1wL215dHBtMS9zd3RwbS1zb2Nr
IC0tbG9nIGxldmVsPTIwIC0tdHBtMg0KDQojIyBCb290IHRoZSBWTQ0KcWVtdS1zeXN0ZW0teDg2
XzY0IC1oZGEgfi9xZW11LWltYWdlcy91YnVudHUtMjAuMDQtYW1kNjQuaW1nIC1ib290IGQgLW0g
MjA0OCAtZW5hYmxlLWt2bSAtY2hhcmRldiBzb2NrZXQsaWQ9Y2hydHBtLHBhdGg9L3RtcC9teXRw
bTEvc3d0cG0tc29jayAtdHBtZGV2IGVtdWxhdG9yLGlkPXRwbTAsY2hhcmRldj1jaHJ0cG0gLWRl
dmljZSB0cG0tdGlzLHRwbWRldj10cG0wDQoNCg==
