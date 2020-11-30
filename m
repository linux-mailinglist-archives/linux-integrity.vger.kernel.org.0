Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1752C9186
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Nov 2020 23:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgK3Wuw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Nov 2020 17:50:52 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:24016 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728157AbgK3Wuw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Nov 2020 17:50:52 -0500
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AUMfv7J025500;
        Mon, 30 Nov 2020 22:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=wHXBgiHhAP2ONeA9jVhvA28uQG7VyR3BGw4t5M/YVGk=;
 b=AzwPKPoaG99EfrY2MRg0X9xhWIkWKaUY78O1Z6rlRSdlIUIYC0w1DN9Dnwp4LzhGlqrV
 ssmwtpjVPCaR/oZJkM0iSNZ6ja9mUEUz36S7o7jcy1PkL36TdpjDn0hHY7fxvBuau0Ng
 9IUi6f1I+45UaV3NVKaqa8fmuwDoONeJV50Ad9w0zJU14egCoQOXR0trZWiSzrF7c4VL
 7P3JDkto+KsfJ+CUPQY3+OYSGjNOP3ggKmL9v6bpg2irwfv/xS9GesNGXBoWHSkk0Ksc
 oZyklgVGy0HA3MPPxFY3koxHHc8q//8jPVOwIKYC/ATyBeSnG8fyxjDkhttovDIYA1gU uQ== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com with ESMTP id 353ywwwae0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Nov 2020 22:50:09 +0000
Received: from G9W8456.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.216.161.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3425.houston.hpe.com (Postfix) with ESMTPS id A19F28D;
        Mon, 30 Nov 2020 22:50:08 +0000 (UTC)
Received: from G9W8456.americas.hpqcorp.net (2002:10d8:a15f::10d8:a15f) by
 G9W8456.americas.hpqcorp.net (2002:10d8:a15f::10d8:a15f) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 30 Nov 2020 22:50:08 +0000
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (15.241.52.11) by
 G9W8456.americas.hpqcorp.net (16.216.161.95) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 30 Nov 2020 22:50:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcgGYB++lUmu00lDiOPSAsPgW3rkHJ07Ot9onqWj+bCnnEhIFJtZdkqh5qUWhQ2O+9HmwSHYqXdEyIiAJ7pTcggrH2x6jbXcTOu/rwRHaTKLauI9sKiocwP0Y3lmQ872bANml5x2Hnv2g9CUfiApE28a2wYiphG6KTk591sVeW9ONnwuYxhdlVlCz6Zgh1rXSDpm4643e5e5gu9549Ee+o1WPt8g/BjlHkrUm/L9O1w6z5oZCqCDujH5Em71cv/RHBmb++zSCBp5GEadXmntoBPVQV9yakBAF1Jld/ICIiJAidM2aSLx2AtVsLYXiuy/qyKXSVyRyXOOE9eqQTAEqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHXBgiHhAP2ONeA9jVhvA28uQG7VyR3BGw4t5M/YVGk=;
 b=c+CTSR7JBQy1t7sRow3wN7z0iep09uWfpPomKX2nbJ3P1sbAZfqmHGCU6auwh7vxyyFKNyfWkm23gNbffvlE+kufSUCSOOvY0zcajTteKnKuf4tviPExs8oxMaNI4fiAM7si9n1ixZzFdB2NQDGkBPiSmr7N4GHcHbRgA9vYlszztNG8onxCFuosR78JTO0mc2RnS0HOHoZDumfHGNZht3qjG/mYBVGW6NXxeimWIW6b+vJOVCViAJ2/Wilii4+R3bCzo9Qhcvir0jWjJOlmqnrlNJWNvldwwC5TGi+rfvMQckwgbyloj+txONO9bPa3KswkeK4bZ+6zH3jVhec73g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7712::15) by TU4PR8401MB1248.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7715::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Mon, 30 Nov
 2020 22:50:04 +0000
Received: from TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::19ba:3192:911e:431f]) by TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::19ba:3192:911e:431f%12]) with mapi id 15.20.3611.031; Mon, 30 Nov
 2020 22:50:04 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: RE: [PATCH RESEND v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Thread-Topic: [PATCH RESEND v4 1/1] tpm: add sysfs exports for all banks of
 PCR registers
Thread-Index: AQHWxp+HLLKJZ3u700mE70YfYEXLaKng/H3AgAAbPYCAACWLMA==
Date:   Mon, 30 Nov 2020 22:50:04 +0000
Message-ID: <TU4PR8401MB10556D3CE22216CC6B15B57EABF50@TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM>
References: <20201129223022.5153-1-James.Bottomley@HansenPartnership.com>
         <20201129223022.5153-2-James.Bottomley@HansenPartnership.com>
         <TU4PR8401MB105585A7FD1E1EB317FD13F7ABF50@TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM>
 <d1775d709b3b88b494e95fff6dbdbda72e1e3b61.camel@HansenPartnership.com>
In-Reply-To: <d1775d709b3b88b494e95fff6dbdbda72e1e3b61.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: HansenPartnership.com; dkim=none (message not signed)
 header.d=none;HansenPartnership.com; dmarc=none action=none
 header.from=hpe.com;
x-originating-ip: [2601:2c3:877f:3f20:656a:e649:499f:e4d0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c8604d9f-712d-4282-7d0b-08d89582474d
x-ms-traffictypediagnostic: TU4PR8401MB1248:
x-microsoft-antispam-prvs: <TU4PR8401MB124816DF02F673C73CB3784DABF50@TU4PR8401MB1248.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z4lRTTLVyWzsgLHmIThVXLGk75BXvQQterjOwBb3jcUKIJ2E9Tlg4xCnCYW4yYNqxjQfHAi2svAilr8qI4UJ/2NuAmwN41FtODRYiX7GXuWJD4l+O2qcbv6i9ZUVYvAr1PhI4mn1gZCun7yyEKmsgNyOwPFxQzWstiHkhfg5IJWlzz6Oi3uBXIL7IdwYalxEQ3Hcp+3Ti55nm8p982FafIu6sXeWUZ73JqzjC6c464NOahXhjWm6Bo018Qwcl0bwVVvTpkV6KW2WzpDJtcZsADk+tUjtgopzR2A6qVE+48JOw3U3zwmI7MQMNxecNQQAE3oRfLf+rc6v6gxRddg3/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(366004)(346002)(396003)(110136005)(33656002)(4001150100001)(4326008)(7696005)(53546011)(316002)(71200400001)(478600001)(186003)(6506007)(54906003)(15650500001)(52536014)(55016002)(9686003)(2906002)(8676002)(5660300002)(83380400001)(64756008)(8936002)(66946007)(66446008)(76116006)(66556008)(86362001)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aC9aMFpLS3FXSjZ4eDcwQXA4dVFtL3AzRk9QcER1bjNlU0craGdGa2drQTQ5?=
 =?utf-8?B?cHR5Mk9FK25wMHZpT3pnV1dRUmxaZGY2Wm5jNW5nU0JGZTVjeE1wZzZTMzZj?=
 =?utf-8?B?RnMwa0lXaEFESms0WGNxQmJBWXQ3QW5FOCtmTjdqRVYyRkhINmhSSEpsY0hF?=
 =?utf-8?B?UndIc2pkcm9YYnB4YVJrV3V5V0JJQUVpR3pkMGxtT2J0Q0ZXWWgrNzQwVXBo?=
 =?utf-8?B?VE5HaWZqV2pXVHdYQVZuRGYyT01GYkFSczNRUzNOUTJ5Q2dJRFdLKy9GeEQy?=
 =?utf-8?B?V1M5Tmh4dkUvZnRkazB1RTA2NmNRWDVjNnhkNDBoYzhiazV0Q09yaFJJaDBF?=
 =?utf-8?B?ZGU5OEFsYUxLV216c1E5RmxZUzh2OW42YzRFVDczRkN3U0VkTUVCdWdjd2tz?=
 =?utf-8?B?QzFQdkVIK1pzeXU2SGVidkJpUXpPV1dRcEQwL0FnMnNYOWNteDB1U3N6cWwx?=
 =?utf-8?B?ME5rVGFDT0V3NEpHWFdsNDJ1bFNLV0VQL1U0R1pPelZmOU9ScFJYeVMxTkV3?=
 =?utf-8?B?OEJLaktRamFmREFHb0g5MEZMS08yeGxYanY5WlBJWUtPM0VUSFFVeXdhMlBE?=
 =?utf-8?B?Mi9hTGR5NHRIYkQ1NEliNS85Y1lHU2ZvQ3BGQk1reHY5T2huNFhRanFVY0RV?=
 =?utf-8?B?VkRJSzZUWUNWaEEzZk4vRWVJekU4ZWQ4WWVZcFJndmUxUXNqZmgrN1duYTh1?=
 =?utf-8?B?SDlDRENoaXNsNlpzZFRPNWp4clNkZ1Y3ZWhNZTg5NWJ3SXpLcGpZNjZuTmM4?=
 =?utf-8?B?R2ovcy81Z1ZIZk5nejlHMUxaM1B0c1dhK09kS21UcS9GN01MaHNHVVd5UEVI?=
 =?utf-8?B?bVhxOE8zTW1qWGVJbmt5akpBWURWSEN6eUNxbzB1N0tRVFM3RkN5aHFJRENp?=
 =?utf-8?B?ZXVvM0o0b3B2WmVFT1NJaVpIOStBaE01THgyUHFYSGhqb2twS2s0N0F1QXFO?=
 =?utf-8?B?K1R5WS9vRXF0cks3UDhQRWpDQ01JZWFQeHFiZ2xjWTZmOEZ6Mk5QeTI1NzNW?=
 =?utf-8?B?cklFK095M3pWek1RZVdrUDBIWFV4NSttc1ZWWDc3ZDYzSDM1bmg5TWZRYWh4?=
 =?utf-8?B?TktOejErMUtqOWxSM25yYVNHN1RUdkplcWZnOE5RV1JOeXFZZUkwSHcwUmx6?=
 =?utf-8?B?alliQXBCS0FPUHQ2Mzk3ZW1XV3pPZ0VOSFJuYlhVMjBWUUU0ZjZxdUNBM0k3?=
 =?utf-8?B?RWhwRU5KbkpOQmxFUUN5dkJRYUpsdEZuYm55SERQam1DTzZEVmJmaVdnWGJK?=
 =?utf-8?B?ek5xcmhPQThYeXBVNzg4bjR4a0o2T1ZLbDFjY25oV3k4T0NRbDdpRXVOUXFS?=
 =?utf-8?B?d2FsS29YclNvajNEdXpldE95cUZRR0xyUk1SQ1V5SVBSK3FRcEVQdUREamFU?=
 =?utf-8?Q?zG10Y/BBTvs/PMQ0+ohbew8eBZAUGt5E=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c8604d9f-712d-4282-7d0b-08d89582474d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 22:50:04.6113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7yB/L3AT5MnLRdyuin0JMcJfU9dZwTwnfFsQWU5YTuV6hrkpYucIueOFGTLyZYLl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB1248
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_12:2020-11-30,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300141
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFtZXMgQm90dG9tbGV5
IDxKYW1lcy5Cb3R0b21sZXlASGFuc2VuUGFydG5lcnNoaXAuY29tPg0KPiBTZW50OiBNb25kYXks
IE5vdmVtYmVyIDMwLCAyMDIwIDE6NTQgUE0NCj4gVG86IEVsbGlvdHQsIFJvYmVydCAoU2VydmVy
cykgPGVsbGlvdHRAaHBlLmNvbT47IGxpbnV4LQ0KPiBpbnRlZ3JpdHlAdmdlci5rZXJuZWwub3Jn
DQo+IENjOiBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPjsgSmFya2tvIFNha2tpbmVu
DQo+IDxqYXJra28uc2Fra2luZW5AbGludXguaW50ZWwuY29tPjsgbGludXgtYXBpQHZnZXIua2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFJFU0VORCB2NCAxLzFdIHRwbTogYWRkIHN5
c2ZzIGV4cG9ydHMgZm9yIGFsbA0KPiBiYW5rcyBvZiBQQ1IgcmVnaXN0ZXJzDQo+IA0KPiBPbiBN
b24sIDIwMjAtMTEtMzAgYXQgMTk6MDAgKzAwMDAsIEVsbGlvdHQsIFJvYmVydCAoU2VydmVycykg
d3JvdGU6DQo+ID4gLi4uDQo+ID4gPiArICogVGhlIGZpcnN0IGFyZ3VtZW50IGlzIHRoZSBUUE0g
YWxnb3JpdGhtIGlkIGFuZCB0aGUgc2Vjb25kIGlzDQo+ID4gPiB0aGUNCj4gPiA+ICsgKiBoYXNo
IHVzZWQgYXMgYm90aCB0aGUgc3VmZml4IGFuZCB0aGUgZ3JvdXAgbmFtZS4gIE5vdGU6IHRoZQ0K
PiA+ID4gZ3JvdXANCj4gPiA+ICsgKiBuYW1lIGlzIGEgZGlyZWN0b3J5IGluIHRoZSB0b3AgbGV2
ZWwgdHBtIGNsYXNzIHdpdGggdGhlIG5hbWUNCj4gPiA+ICsgKiBwY3ItPGhhc2g+LCBzbyBpdCBt
dXN0IG5vdCBjbGFzaCB3aXRoIGFueSBvdGhlciBuYW1lcyBhbHJlYWR5DQo+ID4gPiArICogaW4g
dGhlIHN5c2ZzIGRpcmVjdG9yeS4NCj4gPiA+ICsgKi8NCj4gPiA+ICtQQ1JfQVRUUl9CVUlMRChU
UE1fQUxHX1NIQTEsIHNoYTEpOw0KPiA+ID4gK1BDUl9BVFRSX0JVSUxEKFRQTV9BTEdfU0hBMjU2
LCBzaGEyNTYpOw0KPiA+ID4gK1BDUl9BVFRSX0JVSUxEKFRQTV9BTEdfU0hBMzg0LCBzaGEzODQp
Ow0KPiA+ID4gK1BDUl9BVFRSX0JVSUxEKFRQTV9BTEdfU0hBNTEyLCBzaGE1MTIpOw0KPiA+ID4g
K1BDUl9BVFRSX0JVSUxEKFRQTV9BTEdfU00zXzI1Niwgc20zKTsNCj4gPg0KPiA+IFRoZSBsYXRl
c3QgUEMgQ2xpZW50IFBsYXRmb3JtIFRQTSBQcm9maWxlIGFuZCBUUE0gMi4wIFBhcnQgMg0KPiA+
IFN0cnVjdHVyZXMgc3BlY3MgYWxzbyBkZWZpbmUgY29kZXMgZm9yIHRocmVlIFNIQS0zIGhhc2gg
YWxnb3JpdGhtczoNCj4gPiAgIFRQTV9BTEdfU0hBM18yNTYNCj4gPiAgIFRQTV9BTEdfU0hBM18z
ODQNCj4gPiAgIFRQTV9BTEdfU0hBM181MTINCj4gDQo+IHRoaXMgaXMgUFRQIDEuMDUgd2hpY2gg
d2FzIHB1Ymxpc2hlZCB0aGlzIFNlcHRlbWJlcj8gIFRoZSBiYXNpYw0KPiByZWFzb24NCj4gaXMg
aXQgd2Fzbid0IHRoZXJlIHdoZW4gdGhpcyBwYXRjaCB3YXMgZmlyc3QgcHVibGlzaGVkLCBidXQg
dGhleSBjYW4NCj4gYWx3YXlzIGJlIGFkZGVkIC4uLiB0aGUgd2hvbGUgaWRlYSBpcyB0byBiZSBl
eHRlbnNpYmxlLg0KDQpZZXMsIHRoZXkgYXJlIGluDQoqIFRDRyBQQyBDbGllbnQgUGxhdGZvcm0g
VFBNIFByb2ZpbGUgU3BlY2lmaWNhdGlvbiBmb3IgVFBNIDIuMA0KICBWZXJzaW9uIDEuMDUsIFJl
dmlzaW9uIDE0LCA0IFNlcHRlbWJlciAyMDIwDQoqIFRydXN0ZWQgUGxhdGZvcm0gTW9kdWxlIExp
YnJhcnkgUGFydCAyOiBTdHJ1Y3R1cmVzDQogIEZhbWlseSAyLjAsIExldmVsIDAwIFJldmlzaW9u
IDEuNTksIDggTm92ZW1iZXIgMjAxOQ0KDQpJIGRvbid0IGtub3cgaWYgYW55b25lIGhhcyBzdGFy
dGVkIGltcGxlbWVudGluZyBTSEEtMyBmb3IgUENScy4NCg0KPiANCj4gPiAuLi4NCj4gPiA+ICsN
Cj4gPiA+ICsJLyogYWRkIG9uZSBncm91cCBmb3IgZWFjaCBiYW5rIGhhc2ggKi8NCj4gPiA+ICsJ
Zm9yIChpID0gMDsgaSA8IGNoaXAtPm5yX2FsbG9jYXRlZF9iYW5rczsgaSsrKSB7DQo+ID4gPiAr
CQlzd2l0Y2ggKGNoaXAtPmFsbG9jYXRlZF9iYW5rc1tpXS5hbGdfaWQpIHsNCj4gPiA+ICsJCWNh
c2UgVFBNX0FMR19TSEExOg0KPiA+ID4gKwkJCWNoaXAtPmdyb3Vwc1tjaGlwLT5ncm91cHNfY250
KytdID0NCj4gPiA+ICZwY3JfZ3JvdXBfc2hhMTsNCj4gPiA+ICsJCQlicmVhazsNCj4gPiA+ICsJ
CWNhc2UgVFBNX0FMR19TSEEyNTY6DQo+ID4gPiArCQkJY2hpcC0+Z3JvdXBzW2NoaXAtPmdyb3Vw
c19jbnQrK10gPQ0KPiA+ID4gJnBjcl9ncm91cF9zaGEyNTY7DQo+ID4gPiArCQkJYnJlYWs7DQo+
ID4gPiArCQljYXNlIFRQTV9BTEdfU0hBMzg0Og0KPiA+ID4gKwkJCWNoaXAtPmdyb3Vwc1tjaGlw
LT5ncm91cHNfY250KytdID0NCj4gPiA+ICZwY3JfZ3JvdXBfc2hhMzg0Ow0KPiA+ID4gKwkJCWJy
ZWFrOw0KPiA+ID4gKwkJY2FzZSBUUE1fQUxHX1NIQTUxMjoNCj4gPiA+ICsJCQljaGlwLT5ncm91
cHNbY2hpcC0+Z3JvdXBzX2NudCsrXSA9DQo+ID4gPiAmcGNyX2dyb3VwX3NoYTUxMjsNCj4gPiA+
ICsJCQlicmVhazsNCj4gPiA+ICsJCWNhc2UgVFBNX0FMR19TTTNfMjU2Og0KPiA+ID4gKwkJCWNo
aXAtPmdyb3Vwc1tjaGlwLT5ncm91cHNfY250KytdID0NCj4gPiA+ICZwY3JfZ3JvdXBfc20zOw0K
PiA+ID4gKwkJCWJyZWFrOw0KPiA+ID4gKwkJZGVmYXVsdDoNCj4gPiA+ICsJCQkvKg0KPiA+ID4g
KwkJCSAqIElmIHRoaXMgd2FybmluZyB0cmlnZ2Vycywgc2VuZCBhIHBhdGNoIHRvDQo+ID4gPiAr
CQkJICogYWRkIGJvdGggYSBQQ1JfQVRUUl9CVUlMRCgpIG1hY3JvIGFib3ZlIGZvcg0KPiA+ID4g
KwkJCSAqIHRoZSBtaXNzaW5nIGFsZ29yaXRobSBhcyB3ZWxsIGFzIGFuDQo+ID4gPiArCQkJICog
YWRkaXRpb25hbCBjYXNlIGluIHRoaXMgc3dpdGNoIHN0YXRlbWVudC4NCj4gPiA+ICsJCQkgKi8N
Cj4gPiA+ICsJCQlXQVJOKDEsICJUUE0gd2l0aCB1bnN1cHBvcnRlZCBiYW5rIGFsZ29ydGhtDQo+
ID4gPiAweCUwNHgiLA0KPiA+ID4gKwkJCSAgICAgY2hpcC0+YWxsb2NhdGVkX2JhbmtzW2ldLmFs
Z19pZCk7DQo+ID4NCj4gPiBhbGdvcml0aG0gaXMgbWlzc2luZyB0aGUgbGV0dGVyIGkuDQo+IA0K
PiBZZXMsIEknbGwgZml4IHRoYXQuDQo+IA0KPiA+IEl0IG1pZ2h0IGhlbHAgdG8gcHJpbnQgdGhl
IGJhbmsgaWQgKHZhcmlhYmxlIGkpIGFzIHdlbGwuDQo+IA0KPiBJJ20gbm90IHN1cmUgaG93IGl0
IGhlbHBzIHRoZSB1c2VyLiAgV2UgZGVsaWJlcmF0ZWx5IGhpZGUgdGhlIGJhbmsNCj4gbnVtYmVy
cyBiZWNhdXNlIGFsbCBiYW5rcyBpbiBzeXNmcyBhcmUgcmVmZXJyZWQgdG8gYnkgaGFzaCAuLi4g
aG93DQo+IHdvdWxkIGV4cG9zaW5nIHRoZSBiYW5rIG51bWJlciBoZXJlIGhlbHA/DQoNCkkganVz
dCBub3RpY2VkIHRoZSBXQVJOIGluc2lkZSB0aGUgZm9yIGxvb3AgYW5kIHdvcnJpZWQgYWJvdXQN
CnNwZXdpbmcgYSBsb3Qgb2Ygc2ltaWxhciBtZXNzYWdlcywgZWFjaCB3aXRoIGxvbmcgc3RhY2sg
dHJhY2VzLg0KDQpucl9hbGxvY2F0ZWRfYmFua3Mgc2hvdWxkbid0IGJlIHZlcnkgbGFyZ2UsIHRo
b3VnaCwgc28gdGhlcmUncw0KcHJvYmFibHkgbm90aGluZyB0byBiZSBjb25jZXJuZWQgYWJvdXQu
DQoNCk1heWJlIGNvbnNpZGVyIGRldl93YXJuIGluc3RlYWQgb2YgV0FSTj8gVGhhdCB3b3VsZCBp
bmRpY2F0ZSB3aGljaA0KVFBNIGhhcyB0aGUgdW5zdXBwb3J0ZWQgYWxnb3JpdGhtLCB3aGljaCBj
b3VsZCBiZSB1c2VmdWwsIGJ1dCBhdm9pZA0KdGhlIHN0YWNrIGR1bXAsIHdoaWNoIG1pZ2h0IG5v
dCBiZSB1c2VmdWwgKGV4Y2VwdCB0aGF0IGl0IGlzIG1vcmUNCmxpa2VseSB0byBiZSByZXBvcnRl
ZCBiYWNrIHRvIGtlcm5lbCBkZXZlbG9wZXJzKS4NCg0KDQo=
