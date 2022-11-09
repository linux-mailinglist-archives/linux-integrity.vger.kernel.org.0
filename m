Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71527623027
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Nov 2022 17:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiKIQ12 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Nov 2022 11:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiKIQ11 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Nov 2022 11:27:27 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26EC1A3B8;
        Wed,  9 Nov 2022 08:27:25 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9GOG1I016981;
        Wed, 9 Nov 2022 16:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=qmLUnMr4V3ftaCEsf+DH/Bw5Da7OeFfokx58xQuVUSE=;
 b=G3IvTyIV7c8F4zhuVozmB7bfr12DfgrvNpf23T/viUrW49vup1NAddvgbLTThDOcXI3e
 P9N8zxYXA+0VE0stDV69OLr5Dk8WrsEWEUToEPNzd8iQ4if7JNbQMLzzPPfHFcBIVJVI
 okWwp7mK3sWOZwPwfVszzkMwgSyJQ/b7aw6JWl38WLqFPMWFgsHPCLeuHdBk0BpoE583
 wBa+nN9DyhhWN3kkMzY6LNAn1i6f7dAoxqNAJJPbRtI+2hCR2gBYnlgDIjtFriOFW9ye
 sffBdD73tvEh6Z7B9zHbUAzM7R4euLmxvFiFh/oph1tZbcs2AsCnfrqR6gaUc7aZLL7N GQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3krf5mg3e4-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 16:27:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9ELxg0040088;
        Wed, 9 Nov 2022 15:50:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcqhnbdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 15:50:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=As8aahVJV+MUY0eb4aID6vfxHjcrScYyof7rpT6JKKdjuDCfU9JOzS2Aa6SZc6rSqUqMDM0LVqLVY9EcwebmRgHmVLzpU5sjcgK6aXrbE9sRsdKYwolyStBhJsBHzUMTCxzoy30fYYQ8I3ThzRQhuL80T8NHxmbSQ4UAlTRa+16TMF/z2D3j94diN6Ce9YxN5Qhq+cPsyGPKNcam3cJnyRS1XQIhvKiLtjCN81+GBXOctp8ykzDa07ta6oaLHTyJ1qUJ6xHyGkD8+XKvmlEd1zUuVP3nVca2JW2vE+vvY8Q1uIBXkz7PhfkpA1m+/IrhJJDau7HXu3r4DfHn0AYcPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmLUnMr4V3ftaCEsf+DH/Bw5Da7OeFfokx58xQuVUSE=;
 b=ST4Jd1OHVbgQovoMOGtfBtdhVShu435RuNV1Mx0oa2NXi/e2Ao5RVvueHmYCG7g/fvuUrfVDIi/Z3zcnPw2jWfzKt/zetTt6WrozBxbseImf+k/FlaogHkFfJ7sCQtO3l+Y8RlqzFWPUywTq+ie/IsBPVEyy6LsZ9TDkH4SMikU+eaV5ylmuduS+U9xLX+DG+wcj4si1JbtOWWIYlr3+eJsAnUovTY3kokcPXpUFY9EWxeeEcqOBD5q7hPXaglyAntcuKOGR+gbLAX7RhdDJU4ROVNsHgP3BbbcTgL9lbImqMIh7ZHT+S/MLDRSF6FM4QOPrUw13EBCIf5XJr24H4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmLUnMr4V3ftaCEsf+DH/Bw5Da7OeFfokx58xQuVUSE=;
 b=ayVN1n/1FTPXGLrpMnKJdi0nVtg3frXKLSzOszU8rJwjt3QLwWgSsk7RonjLiTkQZeus1tY2wG2dnpcJ8gOYLRMxZ7rL3yqjemPwJ9UUXnto5eAFMTPrDfnZbNKiEtLZ4eDZvvNqlj+HZ0TDxlMxschbiaLhUhkE53mPtzE2Y8Q=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DS0PR10MB6056.namprd10.prod.outlook.com (2603:10b6:8:cb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.25; Wed, 9 Nov 2022 15:50:33 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%5]) with mapi id 15.20.5813.012; Wed, 9 Nov 2022
 15:50:33 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
CC:     =?utf-8?B?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Pearson <markpearson@lenovo.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] certs: Prevent spurious errors on repeated blacklisting
Thread-Topic: [PATCH] certs: Prevent spurious errors on repeated blacklisting
Thread-Index: AQHY8qqUO1KTnXwDZ0K13zlRiLLr1q42wKcA
Date:   Wed, 9 Nov 2022 15:50:33 +0000
Message-ID: <0E877F01-1B42-49A0-A3AF-00405F6CADD7@oracle.com>
References: <20221104014704.3469-1-linux@weissschuh.net>
 <3b997266-067c-975c-911a-da146fe9033a@digikod.net>
In-Reply-To: <3b997266-067c-975c-911a-da146fe9033a@digikod.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|DS0PR10MB6056:EE_
x-ms-office365-filtering-correlation-id: 0653afca-7dd0-4772-c725-08dac26a22c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: prU71yLDJMMGfuDLmHM+Ku6Hcf8OrGiK7esGuaT1HDMv+FTPg8Haj3oapHEaDKYnoND4KQxpX3rHO50QsfG7XnrDS/hyZpz4TP1B5JxZRhrgINTstQONUpFWvuDsU3P1iLqYFPPhjnOvKd6gevJsF7e5jeP/L4f2VQSxLKxdAt4egBLBHfRj7BE1fJ8KJUoelCNzwfyOlBSDmXbEPN+Yz4XxXJpNTlJ+1kxIg7n/9qcgH7tHTmghS1Lj8+4M+4Gv00oAZ5RpNOQa9VeQpfSecnBVCXdWTayW9zI/L0Q+KttwX5DQruHdWblqrNodEVNPa7Es0kR6UNiwTMoIbUYVC/02FUP3OadpAPrth2HDDi7Ais6cTEXRwJYtFVeAywCh6AnXmn9K78KkaYV+Os22e2AY+aVUrI/To7we6fkdF7Trc+KOb4KRWgiwb+7xiYkoficw9Q3OoUdt7I6NHDQIdLgMMJ90l6Ml7yNF+pJgzbjvj1rMLSyOvSBvo4DWmfr1rRRmocBzdZqA53RhU7IK8bEmfO9uVMEqmrOjkIzGlHZAI9sHsYgXeivWB19eWA12SkU72UzvZ2lJCnDptbK+JOtfqLj+snGa61IAUcSUvz3xOGGIQxwa0+qUH+1dWNSsKR9LwKRbuT1GdIa2prukj/5h1masPc+W7qveKBqQJSE9YRTULllGi9kAihGRUkgtWmvAx610CZOSuKH+dfTlE4y9LewaLVsVRGdlMTqofaI+858BZQv96iQWQXuOjc36qumk+MRgdSf3nBr9nolafuCHrfPTJKYS+F/5a8avIGYXHqjWFaHnKyHTyIVuhiQqGoS7WNDTZu1NpQaMGmKIawrC5oil1kxPSW8/gxYPxGWWATX/Uhjg7ci9zRf9c7lV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199015)(66574015)(45080400002)(2616005)(966005)(38070700005)(6486002)(2906002)(38100700002)(316002)(6506007)(6512007)(54906003)(26005)(478600001)(36756003)(6916009)(122000001)(186003)(71200400001)(86362001)(83380400001)(53546011)(76116006)(66946007)(66556008)(33656002)(66446008)(66476007)(64756008)(4326008)(8676002)(5660300002)(44832011)(41300700001)(8936002)(7416002)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFgxSVZZOTJETDAwbTlCUDdmcDRuYk9IbzZSUjhrWDRrOVJ0R3M4QkNpV3JF?=
 =?utf-8?B?c2txVndidlFhTVJ5ZUhZOVVNZDMweTk4L0Fzd21hNkhBam95c3hlNk1uSkE3?=
 =?utf-8?B?cWhYdWVpK2hFMk94bXl6eHVqTUtGVWpXNXQrTUM4TzQ2SGY1NEZCelF5VWdv?=
 =?utf-8?B?NWlYcXpvVzRGZm9yVWFqVUJrdGR3NnVBZjBtZlgrV1dzN0JCdGFuZGhZaXZk?=
 =?utf-8?B?RjkzNm5EVC9PdmRRczRjY1ZOVzBYb2dmQ0NwbGdVVy9JZkdNVGZqclBsNmxU?=
 =?utf-8?B?N0hSc2JKL2V4V3lBOG93ZFJBWmh1V244clVXWkxtL0ZheEpZNkNyYk9nbjNU?=
 =?utf-8?B?blRobnRzNTIrbDRkUHdySmdkNlFyMm5XOFEvUkhDdGQyWXZLSWs1WXJtTE1k?=
 =?utf-8?B?QVhMRWZmOE8vU01zK1ROMHR6WVpHdGZSWWUxWjc5cllGdkM4TktiUm9rVW5h?=
 =?utf-8?B?bWpjYmRUd0pObURaZ1NSenRHNGFtaTFqbkV2TzVuSi94UlFRanFRYlMxaUcy?=
 =?utf-8?B?U0l4UDRFV01jYWRCY1doUmZJUHI1amgxak5janZPd0JQN3ZqMXBxeEFhdHA4?=
 =?utf-8?B?VzJtVGVBRnU0MUNxRnhja0ltbXdiNGRnc2YzSk0xU0E4UnJFRjRZdWpodXds?=
 =?utf-8?B?emtnVWNpY0s0cE1MOUJ6SUZOVThkZ2ZQbEpFS0lMMVI5VExlSEJvM1c1eHJv?=
 =?utf-8?B?dWg0c1pmek5KTUtTV3U3L0ZrSXh6QVgwNW1MOFlvSjhDQTdWVUh0K1RwVDRy?=
 =?utf-8?B?OWxiV2NuRTdJbzFyUlZsdlBhSlBXWmlTNnB5SzJsS3NMSVFoeGUrd2twK01Q?=
 =?utf-8?B?cmV3UVJjU3FUMXdyaE5QdVFCaUE2RzduUzBOZkp4MFk1OE5jTnEraFFHaE5M?=
 =?utf-8?B?YXRvNEtyVTRhSHRrSW1QK2RYSTVybjhXQVBDWk1rZUh0VDIvTGloTVVLcDA3?=
 =?utf-8?B?QzRGRi8vUE9IUkJETll6OGxkdlE2ekt3VFYzR083Qjd2U2V4ZXRhWkZXcm9J?=
 =?utf-8?B?QVVJdlNvK2NMTitTZjBzSitETElHa0FtOVI2Q0tVUXhzL1JsQy8rcnFabjFT?=
 =?utf-8?B?R3N4YllCRStLc29HUW1NKzRsc1dEUUtuSGY2V1Y2alhZMjdwUU5YRjljWjJR?=
 =?utf-8?B?TmJ0d0NDQ3RIZ2tSOEo4bHNuVmZ5bURIb24yaFY1R0xhQ25hTUFtUkt4ZFFQ?=
 =?utf-8?B?ZFlCemNxT3RIcmNVd2VidUtWdHN1ek5xYlNQSmlSREtxR0REdjBiNWwvc1Vh?=
 =?utf-8?B?VmoxSXVGckorQXY4UEZYVW8xTE5uWGhIUW90cVRNdVA4Ymo3VXVWNkx1WUdK?=
 =?utf-8?B?Y1laL2Y3OWVqQ1UvVFhTVThZSUppOWd6cFBsck9WL3phK2lqWGk1VjZEb0pH?=
 =?utf-8?B?UTRWMFVhTmVJcE42VFFJNmdocUVGekZkdk5ocTUrUlFXeXE2RnR1ZDBaaXJQ?=
 =?utf-8?B?VzVBc252Ynd2WFg1WVk0dkx5RGRzL2luWHE3N1VybWZMQklBdjk1R0JFSVRt?=
 =?utf-8?B?VUZaLzVndFdBWXkxZnc3MFdRTlhRSHRmSGVCVWljcVBiRDAwNno2aGNaTmYx?=
 =?utf-8?B?Rkw0TUdYL0wwNldBZ2w2YTIyOWJTTExlR3RPYnZod0V4V0RXSWlVSlplK3Fn?=
 =?utf-8?B?SFlmSzh1VC84RUExOUd3QkRRVmdlWFFRMDBEd2ZxblM5ODhURFdHN3NQZGpn?=
 =?utf-8?B?RTBaVVZXWHFML0hVSTFwNUtHVng0M3o4U3RMREJZMjdGaXllRmw4RWtpVmEw?=
 =?utf-8?B?SWZYdVBNK05QcVlFWVd0cHhzZEV0RG5aUk5vZUQ4SmRITlBGbjF0SWpZWDZu?=
 =?utf-8?B?cjY0WkRRY1RxcDB1ZlRXeXUxRVFFUG9LR0kxN282RXRBUW85dXBCZitGTk03?=
 =?utf-8?B?MmdLZkZJZUdudEZQa0tHRGIwK2J2bHJ3VVVKSHJpNFY2dGlEdG1YRHZvU3FV?=
 =?utf-8?B?bHo2VWdJQlJSN0YvOEVCc0RvLzFmSWMraEJueXMrekZEUzFFZmxObXl0OG1L?=
 =?utf-8?B?MkIxNkt4ZlU4S3NWNVYxNTZBZ2dzMUR6VXB5dGRQOGpLMmxLVmZweGtqNTFn?=
 =?utf-8?B?VFZHcWxQZUZteVRwUWpkbk1Va3Vqb1loRVZlRndGQ2F6S3VtajZZbDNTclU5?=
 =?utf-8?B?YVMzeGRoYWMxTVVaZkNEc3duc2VXazhWNzBrT3NSWjhzYVhwTlpDQ0lCL3pD?=
 =?utf-8?B?RXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81958B5C75673846BD1DBA0823EAD08B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0653afca-7dd0-4772-c725-08dac26a22c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 15:50:33.2161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lf8BEnuByt+NCY0bP5ZoMPOTnwtyx0LAP0pZmdwz4Y3aDjXyXvpzndMN0SoRftEEVviYeseWsrN0NP6pvjJQEi2VP5fv0Avdbi4O0TIeGsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211090120
X-Proofpoint-GUID: NgkDAsSewYc7nmuLtfW4W3ksu7NPB_dA
X-Proofpoint-ORIG-GUID: NgkDAsSewYc7nmuLtfW4W3ksu7NPB_dA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQoNCj4gT24gTm92IDcsIDIwMjIsIGF0IDY6MTIgQU0sIE1pY2thw6tsIFNhbGHDvG4gPG1pY0Bk
aWdpa29kLm5ldD4gd3JvdGU6DQo+IA0KPiBUaGlzIGlzIGEgZm9sbG93LXVwIG9mIGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL3IvYzhjNjU3MTMtNWNkYS00M2FkLTgwMTgtMjBmMmUzMmU0NDMyQHQt
OGNoLmRlDQo+IA0KPiBBZGRlZCBKYXJra28sIE1hcmsgUGVhcnNvbiwgRXJpYyBTbm93YmVyZyBh
bmQgbW9yZSBNTCBpbiBDYy4NCj4gDQo+IA0KPiBPbiAwNC8xMS8yMDIyIDAyOjQ3LCBUaG9tYXMg
V2Vpw59zY2h1aCB3cm90ZToNCj4+IFdoZW4gdGhlIGJsYWNrbGlzdCBrZXlyaW5nIHdhcyBjaGFu
Z2VkIHRvIGFsbG93IHVwZGF0ZXMgZnJvbSB0aGUgcm9vdA0KPj4gdXNlciBpdCBnYWluZWQgYW4g
LT51cGRhdGUoKSBmdW5jdGlvbiB0aGF0IGRpc2FsbG93cyBhbGwgdXBkYXRlcy4NCj4+IFdoZW4g
dGhlIGEgaGFzaCBpcyBibGFja2xpc3RlZCBtdWx0aXBsZSB0aW1lcyBmcm9tIHRoZSBidWlsdGlu
IG9yDQo+PiBmaXJtd2FyZS1wcm92aWRlZCBibGFja2xpc3QgdGhpcyBzcGFtcyBwcm9taW5lbnQg
bG9ncyBkdXJpbmcgYm9vdDoNCj4+IFsgICAgMC44OTA4MTRdIGJsYWNrbGlzdDogUHJvYmxlbSBi
bGFja2xpc3RpbmcgaGFzaCAoLTEzKQ0KPj4gQXMgYWxsIHRoZXNlIHJlcGVhdGVkIGNhbGxzIHRv
IG1hcmtfcmF3X2hhc2hfYmxhY2tsaXN0ZWQoKSB3b3VsZCBjcmVhdGUNCj4+IHRoZSBzYW1lIGtl
eXJpbmcgZW50cnkgYWdhaW4gYW55d2F5cyB0aGVzZSBlcnJvcnMgY2FuIGJlIHNhZmVseSBpZ25v
cmVkLg0KPiANCj4gVGhlc2UgZXJyb3JzIGNhbiBpbmRlZWQgYmUgc2FmZWx5IGlnbm9yZWQsIGhv
d2V2ZXIgdGhleSBoaWdobGlnaHQgaXNzdWVzIHdpdGggc29tZSBmaXJtd2FyZSB2ZW5kb3JzIG5v
dCBjaGVja2luZyBub3Igb3B0aW1pemluZyB0aGVpciBibG9ja2VkIGhhc2hlcy4gVGhpcyByYWlz
ZXMgc2VjdXJpdHkgY29uY2VybnMsIGFuZCBpdCBzaG91bGQgYmUgZml4ZWQgYnkgZmlybXdhcmUg
dmVuZG9ycy4NCg0KSSBoYXZlIHNlZW4gZXJyb3IgcmVwb3J0cyBsaWtlIHRoaXMgaW4gdGhlIHBh
c3QuICBTb21lIG9mIHRoZSBvbGRlciBVRUZJIFJldm9jYXRpb24gTGlzdCANCmZpbGVzIHVwIG9u
IHRoZSBVRUZJLm9yZyBzaXRlIFsxXSBjb250YWluIGR1cGxpY2F0ZXMuICBJZiBhIGZpcm13YXJl
IHZlbmRvciB1c2VzIG9uZSBvZiANCnRoZXNlIG9sZGVyIE1pY3Jvc29mdCBzaWduZWQgZmlsZXMs
IHRoZXkgYXJlIGdvaW5nIHRvIHNlZSB0aGVzZSBlcnJvciBtZXNzYWdlcy4NCg0KMS4gaHR0cHM6
Ly91ZWZpLm9yZy9yZXZvY2F0aW9ubGlzdGZpbGUvYXJjaGl2ZQ0KDQo=
