Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CFB3ECF7E
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Aug 2021 09:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbhHPHje (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Aug 2021 03:39:34 -0400
Received: from mail-eopbgr30106.outbound.protection.outlook.com ([40.107.3.106]:24836
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234294AbhHPHje (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Aug 2021 03:39:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l417NElpWSTYQ8Ki1C/rCvHqdLv7hDIyotFT30NjezvUF3GgZxwFEHJLYFidgO+grUK8GstyNoVxXEtmJukpjyjIgvHKrzoPjNUq2oEp34yI5cgHv37c7KjqBwsKl0ZCCHGqRfC2VWyOUL+846n3tI3BXykazDeaCdXJJOMdK9bU1xjd0jd4P8/4uuqUzQW5D+Ynaw2fGVLNsgLstiYLCGucs8O7mkyoRLJJl1q+SrSO8demTEYTT7KrX69duLnzeH45D6SPH24kp4iillVPwZyhElHSyFGNIvd2t/pj99PLX2aVT7OvtnnBvpcpqebp7OCTp9XqLq5pc0UBhPlLyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDSlZ6WgDKoi5YYqNUBumwK7LVy1Wg9gMEazUebNOlg=;
 b=cZ4kt/7OVnLfvJe63pSABfMapf4cgjyrwJYiPO9ppvb8yIAyhQ+8QdCzKuy0KdFJxRRGMTa4ie5YJl5nEqp1pTbSCSt1GwwVSuz7ImBGPyFrBrCsSm0XlUXbXaF21yOfjgLK/i7Dvc3Xcr8Vn7q2wrC8JdvWe+Eu5urpX1u6VggPqfvxEDXBRO/nqQbfcgeorhVKOV+ZVLex+gA5XFmBaKyOZKjvTG5QHCdVIrbYm0mipKmlTnmDFpELL2XavWaTSDE0dFlj2FxFsc8qMZcUWupGoEhkcpWBN1nnHJAiTi4vryTrbwIbHZ/K2ljSzlZR8NGxbZ+fOx3ip1VyPQxqVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDSlZ6WgDKoi5YYqNUBumwK7LVy1Wg9gMEazUebNOlg=;
 b=ClmP/MONjaF/S8I3UA3Ga20m82eq99bsKMHxFI8z09gPGRLpFoe4kp59jjx72ea/ZgwklKn33S1iCqy229fIyAPdsh2d1o/oPFxIpQ5NhciMOzHBSRU55QtRPlvVZ0vqX+MZdv76YUb0+pzk0PiukMWQ2rYnU/VA16x5F8Pr1ZI=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB2691.eurprd09.prod.outlook.com
 (2603:10a6:208:d5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Mon, 16 Aug
 2021 07:39:00 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 07:39:00 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     Igor Zhbanov <izh1979@gmail.com>
CC:     Igor Zhbanov <i.zhbanov@omp.ru>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH 1/1] NAX LSM: Add initial support support
Thread-Topic: [PATCH 1/1] NAX LSM: Add initial support support
Thread-Index: AQHXg5n/AqeKwEHmDUiYDh8DD+AiWqtwKxAAgAECiQCAAe7ggIACv+EA
Date:   Mon, 16 Aug 2021 07:39:00 +0000
Message-ID: <b1f3650c-df42-c5d4-45c0-c77946759926@viveris.fr>
References: <db1c1de0-3672-4bae-ef45-c554379f36f4@omp.ru>
 <d97d7fdb-1676-9670-6cf5-2427f780ec6f@viveris.fr>
 <CAEUiM9ObZD=miina1NsP8Ohtv=byO=33Kp2XaeF8_RB_R_uC1Q@mail.gmail.com>
 <a41a0116-8d05-3aea-d979-090cdbb1d52f@viveris.fr>
 <CAEUiM9N-ELgr2bPvn=5P4NR8wQAKwkZ6tGFZAE8wjH16sWPZVg@mail.gmail.com>
In-Reply-To: <CAEUiM9N-ELgr2bPvn=5P4NR8wQAKwkZ6tGFZAE8wjH16sWPZVg@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb76dc0f-4174-4207-ef9c-08d96088ea0b
x-ms-traffictypediagnostic: AM0PR09MB2691:
x-microsoft-antispam-prvs: <AM0PR09MB26919C1C80EA1B0A0613189D94FD9@AM0PR09MB2691.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C14rt+9UQB59DFLoNmHBB7WkmGo3zH/1hlklFTsF5/ib3VDBpge8PVJyegd73i2wHYG5dkBFCqM3/UIvobeeO8C6DZCXuSsNkftQioDlAI/nGWmRCDIcfUZKFD23t7Nk+TNMSniO8ZGd5ca50xS7wUB/7d+04yrr9nL/XQDx95hB3TNf18WU2gr2P5MWr/PGq6eVIvSWi3TMAzaNIexctqt8V0+b+xO0UwKSlctUmdPdPTbdDrkGJ59868Dj99GM+4YRsnLtbj7HMUmdOK8bfaxiZAxkW/HKz9CrENO5tZIoJIcDrfX4PsXFffH53GP60fd5lwfwWfbZJgTgw36TRaNQrhmrZFT9n1T0BrniS0VhfH1zowKlUGdhTLJjviJhQXkjDFqMKGvzj7PVncSTZU8EkGOFtV5XaK1eCsS5OFn0okU+eZjoRdOi6b2XV1rTZ5+OmifwJbbqdFNw5uTfNlsZTrA9N/BGHfIcvF8xWuEUDO8cUb0frjSMHE9cYl7n6I28e3GHMzuS4+9ynKB7IUbqxBcpM837srsBjer9Cy4eOz6414+ole5t+HpQ81PX6JN+HN+lyPw2EGX+42PI24SgbDRHhSBg2zkFwfKyRRDbPbN6zRVJ/CGJWQA+PLLCFiq65uwsX2gX7PkgtsTJsxohu/7dGJz/Hoc25L16XvMpc8lLaMLp9fqHH+mh06W9v6O0Y6nbvXGWdwx9bzo9rz9VlAFaLTb6Gm5fZlzViKJBm+WHr+tL6KVOgRqDR8me
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(38070700005)(186003)(6512007)(6916009)(508600001)(83380400001)(36756003)(53546011)(6486002)(4326008)(54906003)(6506007)(8936002)(71200400001)(316002)(66446008)(64756008)(31696002)(26005)(38100700002)(86362001)(2906002)(31686004)(122000001)(66476007)(2616005)(66946007)(66556008)(76116006)(91956017)(5660300002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkZ3UnZzajRaalVYaElvUE92T0dScW5tbC9JdURFZjVtU3pHOWFRSnBOVkZV?=
 =?utf-8?B?dmxjYktKeG9lSVpaeTZuWTd1OTNLa3ZYa0hjWFdpS0gwbFlVd2kyWjdJVzJu?=
 =?utf-8?B?WTdDY1RVcUpQTTR2ZWNNeExrbjlqVVlseEZYMjFxdzU5V3RqYW1KajYrQWl2?=
 =?utf-8?B?OEdHaFVkL0g1YW1OZGcyMWVyTDc3OU4yb3BQMmdUdlBsZ3c0aUp4U0JwZ0Nr?=
 =?utf-8?B?MjQxTnc0Tm1VVDlYa2FzTTcybXVhc3pIdEQyNm5hSkpSM3NQbkFUNmNtSUJo?=
 =?utf-8?B?YUtDNnN0djdLeHhzUGx2cEJyTndJME1JVDJwekhsaTRucThzMWFmWndZcmV3?=
 =?utf-8?B?Q3hSQk9QNkZvZEpnb3hzcWJMZDNpekZTOXhrbTNHS0tBUHY2M0dkenh0S3BE?=
 =?utf-8?B?dDRweDR4UXlPT1J6VkMxaXh1ZmlxR2RJQ0dZdk85UFp6Z1JScmdrVUJFVmNO?=
 =?utf-8?B?Si8xai9COGZzUmpjaVUyUVJkNGxEVE9KdmQ2WGpJaDMrYjVQUlBsZnBKNGlO?=
 =?utf-8?B?ZWhZYnJCTlFBKzNRN01UL2dYUFVvcmVHSnBzQjRGS2JSa0sybm1RQ2gvK05X?=
 =?utf-8?B?ZjNSYk4zK2pHZjhvNTB6dFZHYlhNbEx4dHEvaTRKWlFFaUlKUVEyY1R0RDhu?=
 =?utf-8?B?RmhnamZVYUJvcGNvWHVwZlpqTUFZNmRPUWdlaloyWEduT0NsZk5ic1djdkhO?=
 =?utf-8?B?N0lGTXF5eGtQQnUrdG1CbEtYTG5uL0J4WXNNVTNpd2NCRGMrTjAwaGFHZW1m?=
 =?utf-8?B?MHdBQjRjUDYxemF0TmpYZlhwaHFtQ0JiVlVxQXB5Ykl0a1ZFM2lVQU0vMmNa?=
 =?utf-8?B?em44eXhJeFVUU3V2QXNNSUIrVnFPVndZSXNrM0JRU3dHdWZQNmpoUzhYQzFi?=
 =?utf-8?B?SmRkWVVlYXIwc25yOEZZd3FmbjJ0MnBnd1BYQlBwc2l3YUVlNzJpZE5iSEtu?=
 =?utf-8?B?UTYyWEg5UzhRWUtsUG5TNTJ4enNGYno3YlRtOVVIRVYwTUtQUUc3ZDRUeG9q?=
 =?utf-8?B?VHpieFpJQ2ZaTXpQc2MwOWVhbWVBbmx6ZFNIaVltdHNXazNnMktRVDBYcUNk?=
 =?utf-8?B?TnpXNFBCUnhwQzRJK2twZjZSalZxZG10WnJiSFB6OXBKb0dRVndPRTZMWGZx?=
 =?utf-8?B?R2tQQzBQQm5STkIxU09kSkUyeUJXYTJKSkNJZ0dPYUNydmJ0bFd6aVlmdm9V?=
 =?utf-8?B?dGdqcnhaeFhqK3ZZWitOYnBkVCt4V3V1MitaVXB3VUp6b09GVE1ZWFRFb2NJ?=
 =?utf-8?B?TEhLU01zUzh0SDVWVjBtWEliMzJhTE16SlpnUFlvUVJlaENuRmxTT2dEZk12?=
 =?utf-8?B?M0o0UHh4NmN3M0FGdTZMT1dVNG5BNGxqZ2Q5dHJhaVlnVXNkVWROc2NJeGhy?=
 =?utf-8?B?Mm9XRjEyeEVJSHlBMlRpZGRuSW9BOFlSR0czQ2ZPSlpqRTZQdW5oc0ovY1hz?=
 =?utf-8?B?SER0SjBsMTN1d202dmdaNkdpNXlTbjV6TVNaUE92MEdCQ3gzcGpPZVdqa29m?=
 =?utf-8?B?UEJPQ3YyMllZZnduNEJEWHJQOExoOU5FRG5oaHJLTHdRZGdtZUpXZnZaSnNH?=
 =?utf-8?B?Zk9zZFZCajFoM1o0NE1XS2pQVzJBQ1JCYWNjZkpWYThyWXNJRWFneXJqZ0tL?=
 =?utf-8?B?emgvalF1RVZWNkljWlI4ejdNVFFEQnBkVDZFWTB3TVZKTm1uKzdvQktBb0RH?=
 =?utf-8?B?UTVycmRUZXBIYmxuYm8zOUtVS29wdC9LaTJhWmpucG9SM0dLai9xbHUxcG9R?=
 =?utf-8?Q?TWEXv65Ku8EEdlh/vNQzMj0klfUKov5fwysYdve?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CE284B5976C10419E13C27337E8A630@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb76dc0f-4174-4207-ef9c-08d96088ea0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 07:39:00.7085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jVsz/5TiAvAceGzFN7TnB+hFl1p3BKduI8zUwh9J8/Xi60SrnyfcdfvJHCGREFYCdr6XGZ4URKdYBhoTnxUEPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB2691
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SGkgSWdvciwNCg0KT24gOC8xNC8yMSAzOjM5IFBNLCBJZ29yIFpoYmFub3Ygd3JvdGU6DQo+IEhp
IFNpbW9uLA0KPiANCj4g0L/RgiwgMTMg0LDQstCzLiAyMDIxINCzLiDQsiAxMTowOCwgVEhPQlkg
U2ltb24gPFNpbW9uLlRIT0JZQHZpdmVyaXMuZnI+Og0KPj4gRm9yIHRoZSBtYXR0ZXIgb2YgaGF2
ZSBhIGtlcm5lbCBjb21tYW5kbGluZSBiZWluZyB0aGUgcmVzdWx0IG9mIGNvbmNhdGVuYXRpb25z
IGZyb20gbXVsdGlwbGUNCj4+IHNvdXJjZXMsIEkgdGhpbmsgdGhhdCBpZiBhbnkgYXR0YWNrZXIg
aXMgYWJsZSB0byBhbHRlciBwYXJ0IG9mIHRoZSBjb21tYW5kIGxpbmUsIHRoZXkgY2FuDQo+PiBh
bHJlYWR5IHdyaXRlICdsc209JyB0byBpdCBhbmQgY29tcGxldGVseSBkaXNhYmxlIE5BWCwgdGh1
cyBJJ20gbm90IHN1cmUgJ25heF9sb2NrZWQnIHNob3VsZA0KPj4gaW1wYWN0IG90aGVyIHNldHVw
XyogZnVuY3Rpb25zLg0KPj4NCj4+IEkgYmVsaWV2ZSBrZWVwaW5nIHRoZSBuYXhfbG9ja2VkIHBh
cmFtZXRlciwgYnV0IG5vdCBjaGVja2luZyBmb3IgdGhlICdsb2NrZWQnIHN0YXR1cyBpbiB0aGUg
b3RoZXIgc2V0dXBfKg0KPj4gZnVuY3Rpb25zIHNob3VsZCBiZSBlbm91Z2h0LCBhcyBzeXNjdGxz
IHdyaXRlcyB3aWxsIHN0aWxsIGJlIHByb3RlY3RlZCBieSB0aGUgJ2xvY2tlZCcgdmFyaWFibGUu
DQo+IA0KPiBJIHRob3VnaHQgYWdhaW4gYWJvdXQgaXQuIEN1cnJlbnRseSBpdCBpcyBwb3NzaWJs
ZSB0byBzZXQgcGFyYW1ldGVycw0KPiB2YWx1ZSBpbiBLY29uZmlnLCBpbmNsdWRpbmcgImxvY2tl
ZCIuDQo+IFNvLCBpZiBvbmUgbmVlZGVkIHNvbWUgc3RhdGljIGNvbmZpZ3VyYXRpb24sIHRoYXQg
Y2Fubm90IGJlIGFsdGVyZWQgYnkNCj4gYW55IG1lYW5zLCB0aGV5IGNhbiBzZXQNCj4gdGhlIGRl
c2lyZWQgdmFsdWVzIGF0IGNvbXBpbGF0aW9uIHRpbWUgaW4gS2NvbmZpZyBhbmQgaXQgd2lsbCBi
ZQ0KPiBpbXBvc3NpYmxlIHRvIGNoYW5nZSBpdCwgbm9yIGJ5IHN5c2N0bCwNCj4gbm9yIGJ5IGNv
bW1hbmQtbGluZS4NCj4gDQo+IEJ1dCBpZiBJIHJlbW92ZSB0aGF0ICghbG9ja2VkKSBjaGVjaywg
dGhlbiB0aGUgY29tbWFuZC1saW5lIG9wdGlvbnMNCj4gd291bGQgYWx3YXkgYmUgYWJsZSB0byBv
dmVycmlkZQ0KPiB0aGUgY29tcGlsZS10aW1lIGNvbmZpZ3VyYXRpb24sIGluY2x1ZGluZyB1bmxv
Y2tpbmcgdGhlIGxvY2tlZCBzdGF0ZS4NCg0KVGhhdCdzIGEgZmFpciBwb2ludCwgb25lIHdheSB3
b3VsZCBwcm9iYWJseSBiZSB0byByZXBsYWNlICIhbG9ja2VkIiBieQ0KIiFJU19FTkFCTEVEKENP
TkZJR19TRUNVUklUWV9OQVhfTE9DS0VEKSIgaW4gdGhlIHNldHVwXyooKSBmdW5jdGlvbnMsIGtl
ZXBpbmcNCnRoZSBjb21waWxlLXRpbWUgb3ZlcnJpZGUgd2hpbGUgcHJldmVudGluZyB0aGUgY29t
bWFuZGxpbmUgcGFyYW1ldGVyIG9yZGVyaW5nDQppc3N1ZSB3ZSBkaXNjdXNzZWQuDQoNCkhvd2V2
ZXIgYXQgdGhpcyBwb2ludCBJIHVuZGVyc3RhbmQgdGhhdCB5b3UgbWF5IGZpbmQgdGhlIGN1cnJl
bnQgJ2xvY2tlZCcgdXNhZ2UgZWFzaWVyLA0KYW5kIHRoaXMgd2hvbGUgZGlzY3Vzc2lvbiBpcyBw
cm9iYWJseSBuaXRwaWNraW5nIG9uIG15IHBhcnQuDQoNCj4gDQo+IFRoYW5rIHlvdS4NCj4gDQoN
ClRoYW5rcywNClNpbW9u
