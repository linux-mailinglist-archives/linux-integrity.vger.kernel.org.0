Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752F625712F
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Aug 2020 02:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgHaAXo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 30 Aug 2020 20:23:44 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:62256 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726179AbgHaAXm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 30 Aug 2020 20:23:42 -0400
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07V0I50m000528
        for <linux-integrity@vger.kernel.org>; Mon, 31 Aug 2020 00:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=I2D0wtrvCrsdgSM+BRC3dERvYP1eKUxTB37MwW4kL5s=;
 b=dLXG3i2DSiqJeIw5u6sSfNp3zQ7cGYGjoQAhbo1Y5EPvYh5LxGuSIIkNih0t8Sn5OfTH
 MSCJIjcw/iP7RjCLfCr24IH+w0vuPKJwn8M28RWKLnftabRm2m9NQaIKVTZ1WBgwZUCf
 VISOQBnQ0/89FeWssFY0us3tNVAlR1lcU2y/yRXav3ViSVj36PVlz6QuSQJpWA9Eq7eX
 KHfIzAT8Dl7WskYeXBlTZS9+6jf25s2x9X+pKi2bYvvQHKTZSbLRmBC3JabT7eyxqN/b
 YmJCbKM/i2uefBfaeQzMFRT6Ki7MWJ/mO9pvvJ60tRv34FREzlW0bCe4R+Dq1mCH7RK+ gA== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 337cd38pmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 31 Aug 2020 00:23:42 +0000
Received: from G4W9119.americas.hpqcorp.net (g4w9119.houston.hp.com [16.210.20.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3427.houston.hpe.com (Postfix) with ESMTPS id 5C84883
        for <linux-integrity@vger.kernel.org>; Mon, 31 Aug 2020 00:23:41 +0000 (UTC)
Received: from G4W9119.americas.hpqcorp.net (2002:10d2:14d6::10d2:14d6) by
 G4W9119.americas.hpqcorp.net (2002:10d2:14d6::10d2:14d6) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 31 Aug 2020 00:23:41 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (15.241.52.12) by
 G4W9119.americas.hpqcorp.net (16.210.20.214) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 31 Aug 2020 00:23:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lltsbUzMCN76ANYjl7qf8suS/KSb9t93M0vtfsffix3uH6Qon4UzgOASC9wMdI6rnKApNfNL9J+qsdcslzqzBB0xVHoHlw97C7LCWHdiToxNZzqPz2zQO1qvNlnkTWSGdqrq9wrEGKHMNK1rsQ4e3g+q9eUgfwiLX6Y30Yvd5OsG6ZHbW4kdacGG+TeOHiGZYg7I7xYsdxnfF4Z5FyysQP32fGiK6Oz0ArXW0ZX6/PVvUr8eSPaLnc4+FHbX+u17QXFWKL2qvOrkMOmCSKQHgTroz+rMTOZ+hirg0a+lnuY45MropVVLR8+14uNpiq8VvGtctHkdqc+zQWShhrYmOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2D0wtrvCrsdgSM+BRC3dERvYP1eKUxTB37MwW4kL5s=;
 b=J1W9fT9hVXRmVDPmwSkukUjNVGXy3c2PUvM0r/lvqT8wLvuZbg11B1I5R9VKKcijD/85lMQVI/LQVGI/H77L8kGy6g4GQLjeopcDJxHxzUZPqRqiFNLqXW9bRZhcRCa/8zvRsjI+3nm8rdsNEvyFXbXAT2XmR4WUJtfnW70Il3d/gpnny3NEdhvz1FK/mzTzGKibkJK8hNHffowNMy4SrvjHr/chl9DXJv3PI5DhjBtRvibffXGTBFpD7mf70srVyYpGuMKvDo13W4rHXQhopIln7WXbseZMk4M4RSf/l8XTWlHULOBhtxsYr9O4FNUgvRTnZGunNdI4IF5d0Kt7Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DF4PR8401MB0393.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7605::23) by DF4PR8401MB0956.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:760e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Mon, 31 Aug
 2020 00:23:40 +0000
Received: from DF4PR8401MB0393.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::580b:c5e9:b6e7:4876]) by DF4PR8401MB0393.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::580b:c5e9:b6e7:4876%12]) with mapi id 15.20.3326.025; Mon, 31 Aug
 2020 00:23:39 +0000
From:   "Magalhaes, Guilherme (Brazil R&D-CL)" <guilherme.magalhaes@hpe.com>
To:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: RE: IMA policy based on AppArmor profiles
Thread-Topic: IMA policy based on AppArmor profiles
Thread-Index: AdZ/J1UavSV4+3nUSOSsL9j3KG3BCgABX6Wg
Date:   Mon, 31 Aug 2020 00:23:39 +0000
Message-ID: <DF4PR8401MB0393C5429790FA59DC21F0B1FF510@DF4PR8401MB0393.NAMPRD84.PROD.OUTLOOK.COM>
References: <DF4PR8401MB0393C6155D20A343CC171048FF500@DF4PR8401MB0393.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <DF4PR8401MB0393C6155D20A343CC171048FF500@DF4PR8401MB0393.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [189.6.247.44]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 522fd99e-3401-404a-e40a-08d84d441c3d
x-ms-traffictypediagnostic: DF4PR8401MB0956:
x-microsoft-antispam-prvs: <DF4PR8401MB09560C6DCF8B963A4DCE3AA2FF510@DF4PR8401MB0956.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JF4BXNVNtrpOiWOtRniKdo+LRVv1Pn8o6TnJHZ+aoGoKYDDfJ6ldtigBIyYhvqUnNRkR0B0ChoWkxthhfLTNdLZTmRVPiWh/VwlGebI0s1tNvjb9XH4gbJ/mBxDd9n9KYP1vt969CYf5iv+u/3xAeDfTw/K9RyV2+7OJOeCZrDOOl7lL1W3Yh9x+pfmBDFCJ6MQpIAFlNJkd5Dlk09dQEXZx517BqDEHGET+2J3GX2Y4jzt+g3q+g3qDRqZWuIajXLMbgtOgXn8Y9A2WA/VaanjCZWHJa9nM5BtJJnMJB4wPrlYCgay5DVQmz9BzDi53PwSpTYbxtyq6w4pjCUwNWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DF4PR8401MB0393.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(136003)(376002)(396003)(6916009)(33656002)(26005)(6506007)(8936002)(52536014)(76116006)(71200400001)(7696005)(5660300002)(2906002)(558084003)(9686003)(55016002)(478600001)(66476007)(64756008)(66556008)(66946007)(186003)(316002)(8676002)(86362001)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 62Zexi9RskvL03NBqfNpi3g1Rg6dtA/3eHkTKjzW61Q4px8/f0gSjA1Ij5qNNzFN36RFcXjSXudSHYY3VAtSO0+7CAaCLVDzcY91KgxIWbP4xoFSNZpVmAq22n46opaBleA35LrHa2GbSGyiVO9fCVYBXdjFxHYzlo1Q0O1SFwjNyaHI/Ey0ubLHrADag0OumOzqR5Ch+3YfLIOe0RcxxjiZZPNRhNzSRFx5w92DSsf/eXw1Hrf6yuaixF5wZzul3tsfUj6ESBaWOzF8KJOSbEnYZMTWPy+KKHbf9EC9Zo+IyF7CmhQoFYNILZRfqs+hno15gbDTT7P4If8AnpQJ9EJ7EU8w5UClGeJzGi8nIpa9TTvykhGO6p0SkpG7EmFAsWTKrKgiq6v5mlfCfL0eXozxZ5iB/dL62UJjmDIRi1duP0NHBDKbf3Vbnd3vndaUqrTplfjm7l295ThwzaI2WH4J6HzMNxdbipuMn11zNQCLd9OvnXolbWsMn3r3BXbJlLgu/UkeyrhyrG9RptZ2f0iPT8aOl7A8BoJPTTtbAQHthEc/ClQZHVfBvFywpowYocPw6wjkOalsnjaVVuST8Tkxqkae1RLDs88xh5DSniGDHKVYGuAa5+ZoQQqgB5O7Gr8Dx1WWp2rt3kWOE3ayCw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DF4PR8401MB0393.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 522fd99e-3401-404a-e40a-08d84d441c3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2020 00:23:39.8069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: swsNXaFWYMK2VsWJWmHQE/2mLaB6qt1kYJbpxDGLxXO2yhdtjFJyBHZe/6aqCRqX1HftTlxipu4zt9L5EinGWm+8+OLzehQmVBYSyZ6tEM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DF4PR8401MB0956
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-30_10:2020-08-28,2020-08-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=707
 impostorscore=0 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008310000
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,
As an alternative to SELinux roles/types, is it possible to use AppArmor=20
profiles to define measure/appraise policy rules?

Thank you.

--
Guilherme

