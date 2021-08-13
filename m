Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B303EB291
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Aug 2021 10:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238671AbhHMIYj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Aug 2021 04:24:39 -0400
Received: from mail-eopbgr70103.outbound.protection.outlook.com ([40.107.7.103]:27973
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239361AbhHMIY1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Aug 2021 04:24:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddeyQT8bPaz/FE3ToIBSqCl0OolJccr8CJAqdCOvtVbG5vseusCfB2ZeK8KJtz58R+8svl1mxmJcsh7jXFaxcbSpB9EAl7t0CMqojEA34971izym97Hb5tnYXTkQDsYCF4DwMtOElRQy0ePnFZEQcbt3psqcIyf3Jm/94IgHJu7NrMDqSlNdnjSu6yb7AlBGXdqSJsTyliYKDF0UrxU1yMay9C2TwsfFOrcqqU8OBkPUePeliEZLzT+IcuDi26bTJtfJ5RC3uTxJbCX4He8HmP5IQObKyTVGvjWaUb179/jgGdzQ5X9O/LXdmv1gaF8sTj2/M5iVQmTujvMXT71evA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CycSqpfk7J5NLP59PjAf63uTkkZjiBEzfEQfVSdElSk=;
 b=TVq9KhU60yyWY5aZCgU0ZKPsMvsN9Si12h93VPLEY8IAsOwNT24lEhCJvClq0fg46cKv0eE1MZEPk3EH+1OyU2OQTGcOf9P7SUPO2vmjq49JGvQ6iyGdla0fOfLDhXyGNEPBK7Zdfk3jyIaFWlf3I7nfSyZwK/liHVKS7bL33MtjvpM/PEg3DAjHyJlB0TAWj6i6THUQJILlHc1nIh7Q9bYVY03JDCyNfRXOPFlcztoyAaO+7NU+Fz5h6SuLnPo9MnsD4StheA5TWdQ/HWPc1wThfY+fi+EtaN8ld7NlrH85UTVS7xIigruJAxFwaCfQ584xxAcIO8H7TfAgpgMkxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CycSqpfk7J5NLP59PjAf63uTkkZjiBEzfEQfVSdElSk=;
 b=oTyRWvn+TsC3PcecTBf5wVzah+8ba2hsaXvEKQhtSzA7/9zlRUeFPwabl5O0fBxlUhb8J966uLlfD0C2bGE6iWWPrvhA5R4objLcIvfmcbPtlkMKrH3bIAcjp3z/nV7gWcwkTunAbdaO6OY5iRdl9MsCvju+oHu7WdxU3uGvIlg=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB3714.eurprd09.prod.outlook.com
 (2603:10a6:208:185::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Fri, 13 Aug
 2021 08:23:58 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4415.017; Fri, 13 Aug 2021
 08:23:58 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     Igor Zhbanov <izh1979@gmail.com>
CC:     Igor Zhbanov <i.zhbanov@omp.ru>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH 1/1] NAX LSM: Add initial support support
Thread-Topic: [PATCH 1/1] NAX LSM: Add initial support support
Thread-Index: AQHXg5n/AqeKwEHmDUiYDh8DD+AiWqtwaOcAgAC+6ICAAATRgIAABUsA
Date:   Fri, 13 Aug 2021 08:23:58 +0000
Message-ID: <2762ad58-85c1-f286-070c-b8ee07f2bc51@viveris.fr>
References: <db1c1de0-3672-4bae-ef45-c554379f36f4@omp.ru>
 <d97d7fdb-1676-9670-6cf5-2427f780ec6f@viveris.fr>
 <CAEUiM9PRv+WhALQb-1im2_oZzAOvWzrMFrgn5xX9sU1K6DJ6+w@mail.gmail.com>
 <7642c670-55d9-9c30-40a9-15aba27503da@viveris.fr>
 <CAEUiM9MCWyRTZyuV1KGDamib34Z0r_vJUWasVGb8wLFH04ynqQ@mail.gmail.com>
In-Reply-To: <CAEUiM9MCWyRTZyuV1KGDamib34Z0r_vJUWasVGb8wLFH04ynqQ@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4ec89c6-817a-4e80-3ceb-08d95e33b303
x-ms-traffictypediagnostic: AM0PR09MB3714:
x-microsoft-antispam-prvs: <AM0PR09MB37141EEF1ABC5808E9CD6C3294FA9@AM0PR09MB3714.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1hbeeMGGf50fAobQynKCQ0nSGgbkavYtocMSqDX0SNL1DdqiMguOkWZmaX7jvcaZLt8c6wZrwlQyxKD0bdzN3cIooy6ogETaCHQETvC3L3AO1mFCBmzyBHa1lbJe//sCxD5DMEPN9cq7zH4iYQDz74k5CSE/WC6Y6zRL2GkN4anR8bXmWAcui6+I9RIsXe7gAbzAVuApDZ4wkg32MnIBtuJQ/OYIvDobulHT4/LmI5FOvw583jPTC9mc2qRMzre6uGlr1ysh/+h8twelKXHQzj6JZQG+d4msbV0vlswBdpJEw+vJ2MmmGlrHF1rSRlFCyGdt3exHqoCzsb6oDDm+vM2/05kgU3KjJCCd/04+zqShU0F1Pw9JSwmeawBjsXZ7MWlp1MhfxA1ruQNSCznKU0orDIJIx25Cz0GmsMUXhqocVzJG57MF5o7j8+4+JD9T307Rkw8VRYvQO5KwHoGUaw2OtJM+fk2y2BiA4dpB+aUg8bKtBPQW3Har8E2zTCFAxSDTbwmxFCdgg0rPxznGKbs3OcVTt/fLNKsa9cBIqBcyvIomDLFUQuofxoByu+zu53bGnKqZdGE+i3Dyeqi+yY/er/a0bTKs6oi7hDrS5QlsXX41+UU2rTb1ju0quohHCiL/EDFGHcSDAuOizTiFHC/WnWMJruS/c+H3FY3qTyXRhhOHDW5v0DK6vvlBHff+7Z/XyjKhlvzQUmdF9Q6YAQxqU+vPcmAz+5Lp+1xboudQrZG/1IZU+ZxFqlkyN2eL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(122000001)(2906002)(71200400001)(54906003)(508600001)(66946007)(38100700002)(31696002)(91956017)(66446008)(64756008)(6916009)(36756003)(38070700005)(26005)(76116006)(66476007)(66556008)(31686004)(6512007)(5660300002)(8936002)(6506007)(53546011)(83380400001)(8676002)(4326008)(6486002)(86362001)(186003)(2616005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXBqYmI0eUN5c3F3WGwrbzNZVDNoV1lwbWRocER5bHgyZW9PSHR3NGlPQ29z?=
 =?utf-8?B?QVBEZnFvNStkWFpxbTB4a1BTSnZiMUQ4SXp5aXA4Y0NiK3ora1FsRzRzd0pQ?=
 =?utf-8?B?YUJCU21vWFJ3ZC8xVEZXcmVNU3phYW1aV1FDb0F0ZzRnQTRVcVBtZ0JXclBk?=
 =?utf-8?B?RitnUjdwb1FhSUVsbXpwK0F0cFlwKytuS0hRQ2NrR29xTG1rMlI1WWZpK3Ba?=
 =?utf-8?B?RzFibDM0K1ZZcnhsZTlDWEhUNFVpVDZvZGpaWHlvRERjd2J4SnV6SURoZUYy?=
 =?utf-8?B?bVlXcDUwUzc0b1RMQm9ZU1c1UDBjSjFmR0pIaWkvQzIvcGJVdjhBWEprdDBI?=
 =?utf-8?B?SDl4Wm9MRW5sQzNadGg2eksycU5wL0ZjbzArWDdVbDl3V1pkcENaMkxIeFlU?=
 =?utf-8?B?azhUWGtXZGJEOUhUcnRoaXZ4eWtqU2N3ODBLYklFenA5a1B2KzN4YnpqZVZG?=
 =?utf-8?B?T3dFOGczeDN5TGZiMTNwUFZ6Vnl2QmZXRWt6Z2lRNmRmWlZra1ptZEJuVlh1?=
 =?utf-8?B?VDhKWXNYM1cvWXQ1VTVSQ2E0NGZmdmNOZFNEL0hSK2ZXcTZOdlpyRUNvc2h0?=
 =?utf-8?B?MWZUMzNDWW5wS0pmYmEzZ1VWVkRtMEdweFFHWUlyZGNtbXR6TkZjTFRUbzF5?=
 =?utf-8?B?bVRxQTB1YzBpdWpoVW1FSlg1UExsY1U3R3VLZjZVa2NtUUZOazk5ZmRpT0FY?=
 =?utf-8?B?T1lCUkZ0YWpYZnFtblFWdzdjeTBlRmFmN2dJT1dMZytPdUxhL3pHNDlRcWJ0?=
 =?utf-8?B?TUZabGZKK1JhZHFlZlBVUE9GK0NXNnFMd0tjV3dlTzdJWjVFbXRpbzlpc1Q2?=
 =?utf-8?B?YlJ4Smk2ZVN3cC9EYzhpNjk1RDQrN1N0S0hRajBxUHR1MlZYRE1ud0hNVTlo?=
 =?utf-8?B?akpqaUQrSEM1bVM3NlJHamdweWdLN0QyNi84bERIRXZpSmtGR21PSURvVlZM?=
 =?utf-8?B?OU90akNiVmlaLzN0TGJvSW1jdnB5cE90eHVocHBjY3JIZ1ZyRVZXdTJRWCt1?=
 =?utf-8?B?LzI0SW1aSGZDdENHMXVIdC9Ra0NWVzlGU1h4bDFELzJYaGpaZGgxVnBpa0tv?=
 =?utf-8?B?bldQSUVYYlErUXRiNm55dWRhTzFoUCtTeFZoZUNCZ0lkUFVjZ0lzTkJUT3Mz?=
 =?utf-8?B?RHNWZmdNOG9IOUlnRmpoTG5yelBIQjZpYzRxSDdoR1grWEptbnBlbm9qMk03?=
 =?utf-8?B?Qk5pWjRsM0FYUFVFYjR5OW0xMTV6Y2d2L2JHZWtncU9ITVBoeXhlWS95ZDdu?=
 =?utf-8?B?cDFGMjA2cnlXR0hmNVA5dmpXNWFEZkNOL0Q0bnlPQzh6SnVONk5JVVEwTmFF?=
 =?utf-8?B?aXkvWGpkZzU2K0k3TEtJZU8zblFIRXluMU1rYVV0NnRXRURzK2U0amZmcGc2?=
 =?utf-8?B?QUhoaTlUVzN3MWgxYWRLVU1iMURtSEZYQWMwbG1iMnRkMkI3UDVRZUtzL281?=
 =?utf-8?B?RVVEL0ZqdTR2NS9PMDc4OHFDV2pVRWhBaUNGdUVYdlZsSUVaR0tCQ2FwUElQ?=
 =?utf-8?B?b09OM3JHM1FkbXFSVkhvOVpKWUV3RFRmUWxHN0FNcG05ZE1PMDdlaFJRMGtR?=
 =?utf-8?B?aUI5Y0FjUC9qN1hXS3RtYmFhMDZ4UWJtZzJINUkrMG5PZ3ZiMjI3aHl3Mmt4?=
 =?utf-8?B?VmpVZHdWemNLV1VqV0RvR3ZnVUVKNFY1NmhkMUU4Y2dOaU1weXBUa3Rrdk9o?=
 =?utf-8?B?L29sMTVhWVZicytpOGRZZkJLUUZPTldIWGJEem5XRG1FZEdxWks3UXhiZ1o3?=
 =?utf-8?Q?6+S88ZBnCSIMeBs+Cg4vrTIhwYYgbAt2UPZGmfl?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB5477FD3B59D14589A537ED9D0A815B@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ec89c6-817a-4e80-3ceb-08d95e33b303
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2021 08:23:58.8753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hZ3Mf/LJYsfk7rU5x0gjwaXSNkO7ZkfQuJK7AsutPakwo/dc4vz/T99OjoRIpP2xSn7Vet+OirkLOKfhFz6lmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3714
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SGkgSWdvciwNCg0KT24gOC8xMy8yMSAxMDowNSBBTSwgSWdvciBaaGJhbm92IHdyb3RlOg0KPiBI
aSBTaW1vbiwNCj4gDQo+PiBZZXMsIHdoYXQgSSBtZWFudCB3YXMgdGhhdCBtYXliZSB5b3UgY291
bGQganVzdCBkZWNsYXJlIGl0IGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhlIGZ1bmN0aW9uLA0KPj4g
YW5kIG5vdCB1c2UgaXQgYXQgYWxsIGluIHRoZSBzeXNjdGwgdGFibGUuIEJlY2F1c2UgYXMgSSBz
ZWUgaXQsIHlvdSBvbmx5IHVzZSBhbGxvd2VkX2NhcHNfaGV4IGluIHRoZSBzeXNjdGwNCj4+IHRh
YmxlIHRvIGNvcHkgdGhlIHN0cmluZyB0byB0aGF0IHRlbXBvcmFyeSAodmFyaWFibGUpLCBhbmQg
aXRzIHVzZSBpcyBsaW1pdGVkIHRvIHRoYXQgb25lIGZ1bmN0aW9uLg0KPj4NCj4+IEluc3RlYWQg
b2Y6DQo+Pg0KPj4gKyAgICAgICAgICAgICAgIGlmICgoZXJyb3IgPSBwcm9jX2Rvc3RyaW5nKHRh
YmxlLCB3cml0ZSwgYnVmZmVyLCBsZW5wLCBwcG9zKSkpDQo+PiArICAgICAgICAgICAgICAgICAg
ICAgICByZXR1cm4gZXJyb3I7DQo+IC4uLg0KPj4gWW91IGNvdWxkIHByb2JhYmx5IGdldCBhd2F5
IHdpdGggc29tZXRoaW5nIGxpa2U6DQo+IC4uLg0KPj4gKyAgICAgICBzdHJuY3B5KGFsbG93ZWRf
Y2Fwc19oZXgsIGJ1ZmZlciwgQUxMT1dFRF9DQVBTX0hFWF9MRU4gKyAxKTsNCj4gDQo+IHByb2Nf
ZG9zdHJpbmcoKSBpcyBtb3JlIHRoYW4gc2ltcGxlIHN0cm5jcHkoKS4gSXQgaXMgaGFuZGxpbmcg
b2Zmc2V0cyB0b28uDQo+IEkuZS4gaWYgYSB1c2VyIHdpbGwgdHJ5IHRvIHdyaXRlIG5vdCBmcm9t
IHRoZSBzdGFydGluZyBwb3NpdGlvbi4gQnV0DQo+IEkndmUgc2VlbiB0aGF0IHNvbWUNCj4gZnVu
Y3Rpb25zIHNpbXBseSBjcmVhdGUgYW4gaW5zdGFuY2Ugb2Ygc3RydWN0IGN0bF90YWJsZSwgZmls
bCBpdCBhbmQNCj4gY2FsbCBuZWVkZWQgZnVuY3Rpb24uDQoNCk9oIHlvdSdyZSByaWdodCwgSSBh
c3N1bWVkIHRoZSBzeXNjdGxzIHdyaXRlIGFsd2F5cyBoYWQgdG8gYmUgd3JpdHRlbiBmcm9tIHBv
c2l0aW9uIHplcm8sDQpidXQgSSBqdXN0IGxlYXJuZWQgb2YgJ3N5c2N0bF93cml0ZXNfc3RyaWN0
JzogZXZlbiB0aG91Z2ggYnkgZGVmYXVsdCB0aGUga2VybmVsIGZvcmJpZA0Kd3JpdGVzIGF0IGFu
b3RoZXIgb2Zmc2V0IHRoYW4gemVybyBvciBwYXJ0aWFsIHdyaXRlcyBvbiBzeXNjdGwgZmlsZXMs
IHVzZXJzIGNhbiBlbmFibGUNCmEgbW9yZSBwZXJtaXNzaXZlIGJlaGF2aW9yIGxpa2UgJ1NZU0NU
TF9XUklURVNfTEVHQUNZJy4NClNvcnJ5IGFib3V0IHRoYXQuDQoNCj4gDQo+IFRoYW5rcy4NCj4g
DQoNClRoYW5rcywNClNpbW9u
