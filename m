Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E82455C20
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jun 2019 01:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbfFYXOU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Jun 2019 19:14:20 -0400
Received: from mx0b-00273201.pphosted.com ([67.231.152.164]:4886 "EHLO
        mx0b-00273201.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725914AbfFYXOU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Jun 2019 19:14:20 -0400
X-Greylist: delayed 5916 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jun 2019 19:14:19 EDT
Received: from pps.filterd (m0108161.ppops.net [127.0.0.1])
        by mx0b-00273201.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5PLXpO4026214;
        Tue, 25 Jun 2019 14:35:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=from : to : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=PPS1017;
 bh=ovwvliNHkcROWSz4q+Ks2pywYjUcJiSx1V88H0JV1BY=;
 b=xbrzQuWYfMziaQNksw1d5Cj28KWOgnIGCLBtacErTtJNnta4SexJIkF2aBXrDCz5fnu+
 s6IjxDW7UE4pliF4vkKJ3yJlCjHzmMArHVrk7V4Dkroj90szxktOmvkrgIYD27BDox3W
 Aao+SCgFgkf1HY93TLT0zGwoQcKYZusL7MbbA+gumVtrBygIW97ElsMVMOit6icAAxNx
 QS+kbSTWLMl/yOpF8B/PtBlFkRF3NbjIjL41DPsQWUOUUPSKA6GSXPRG9FHxTCAIScSR
 Zuv1DA+cZMnhqNnOChDBqYl0CReUyzJxu62dpZmzSPPskmjSSR8movylFsNbcoFc/U9q cQ== 
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2055.outbound.protection.outlook.com [104.47.41.55])
        by mx0b-00273201.pphosted.com with ESMTP id 2tbtwsg2cx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 25 Jun 2019 14:35:41 -0700
Received: from BYAPR05MB3975.namprd05.prod.outlook.com (52.135.196.21) by
 BYAPR05MB6039.namprd05.prod.outlook.com (20.178.53.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.12; Tue, 25 Jun 2019 21:35:38 +0000
Received: from BYAPR05MB3975.namprd05.prod.outlook.com
 ([fe80::74bc:efb6:42dd:277c]) by BYAPR05MB3975.namprd05.prod.outlook.com
 ([fe80::74bc:efb6:42dd:277c%3]) with mapi id 15.20.2032.012; Tue, 25 Jun 2019
 21:35:38 +0000
From:   Kavitha Sivagnanam <kavi@juniper.net>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: Can we enforce "IMA Policy" based on file type
Thread-Topic: Can we enforce "IMA Policy" based on file type
Thread-Index: AdT2+ZPYS9gcleWrTmSmlo578nvD1wEZKpiADAFAjQA=
Date:   Tue, 25 Jun 2019 21:35:37 +0000
Message-ID: <41610A39-BB93-4D64-8821-B59DCE72EE8D@juniper.net>
References: <BYAPR05MB39753CB3CA47513EEADC134CC1270@BYAPR05MB3975.namprd05.prod.outlook.com>
 <1556193529.3894.94.camel@linux.ibm.com>
In-Reply-To: <1556193529.3894.94.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1a.0.190609
x-originating-ip: [66.129.239.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22db9acf-c91d-4fe5-a0e1-08d6f9b510b3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR05MB6039;
x-ms-traffictypediagnostic: BYAPR05MB6039:
x-microsoft-antispam-prvs: <BYAPR05MB60393E4FD7B7E90726803010C1E30@BYAPR05MB6039.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(136003)(366004)(396003)(199004)(189003)(76116006)(66476007)(14454004)(73956011)(66556008)(4744005)(5660300002)(36756003)(64756008)(66946007)(33656002)(66446008)(99286004)(76176011)(256004)(14444005)(2501003)(8676002)(229853002)(486006)(6486002)(476003)(6506007)(186003)(58126008)(11346002)(478600001)(446003)(102836004)(2616005)(81156014)(6436002)(3846002)(6116002)(86362001)(8936002)(81166006)(66066001)(110136005)(316002)(2906002)(25786009)(53936002)(6246003)(7736002)(68736007)(305945005)(71200400001)(71190400001)(6512007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR05MB6039;H:BYAPR05MB3975.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: juniper.net does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: S65QPJSaLqhYlSovoAwF3FHA37rftuoxOKvKxd7BBVGRogdAJOzHLg+m/nF2Qh1KRRHqQ3/ulwChlDwikS6ztyBH7SYVGoYZIMky3zNtznxcNbQSF7zGhtas0cCYyGAULYROn5UfhYLBhTaL4UcvMJpoUEzp1Iv0cm+0I9GgUT2t+X3qtqtWXCNCBzZDGvwIeRyZhW4JBy+JG3D1kmpksFng4J1QGJRvEqkIwmD5M/zh/b4P4sY+x1t6SDb9atqe9YW/XePo+ge0h5dbBD9hjmjtdsJLz84NZcvP3V1ZZf+dAaOksar+bR2FlnLWq0M+G/gFUnsiymhUBuKKXHIJEMBCwCpH60YMRgASmvrBpF/7Lms5yYL7WgXzuDrIN/iJRgWTGcV8jLkP/37MIYpDCgkczpkIRNZZd86Eadd2Vtw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD580C98CE19DC4F8FAE0DA1CEC25788@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 22db9acf-c91d-4fe5-a0e1-08d6f9b510b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 21:35:38.2109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kavi@juniper.net
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6039
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250166
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQoNCu+7v09uIDQvMjUvMTksIDQ6NTkgQU0sICJNaW1pIFpvaGFyIiA8em9oYXJAbGludXguaWJt
LmNvbT4gd3JvdGU6DQoNCj4gICAgQXMgTWF0dGhldyBpbmRpY2F0ZWQsIHlvdSBjb3VsZCBkZWZp
bmUgTFNNIGxhYmVscyBvbiB0aGUgc3F1YXNoZnMgZmlsZQ0KPiAgIGltYWdlcy4gIEFub3RoZXIg
b3B0aW9uIHdvdWxkIGJlIHRvIGV4dGVuZCBJTUEgYnkgaW1wbGVtZW50aW5nIHRoZSBMU00NCj4g
ICAgc2VjdXJpdHlfc2JfbW91bnQgaG9vay4gIFRoZSBJTUEgcG9saWN5IHJ1bGUgd291bGQgcHJv
YmFibHkgbG9vaw0KPiAgIHNvbWV0aGluZyBsaWtlOg0KDQpXZSBsb29rZWQgaW4gdG8gdGhlIHNl
Y3VyaXR5X3NiX21vdW50IGZ1bmN0aW9uLiBJdCByZWNlaXZlcyB0aGUgZGV2aWNlIG5hbWUgYXMg
c3RyaW5nICJjb25zdCBjaGFyICpkZXZfbmFtZSIuDQpXZSBuZWVkIHRvIGRvIHRoZSBJTUEgYXBw
cmFpc2FsIG9uIHRoZSBiYWNraW5nIGZpbGUgKHNxdWFzaGZzIGZpbGUpIGFzc29jaWF0ZWQgd2l0
aCB0aGlzIGRldmljZS4NCkhvd2V2ZXIsIGJhc2VkIG9uIHRoaXMgZGV2aWNlIG5hbWUgd2Ugd2Vy
ZSB1bmFibGUgdG8gZ2V0IHRoZSBiYWNraW5nX2ZpbGUgYXNzb2NpYXRlZCB3aXRoIGl0IGluIGtl
cm5lbCBzcGFjZS4NCkNhbiB5b3UgZ2l2ZSBzb21lIHBvaW50ZXJzPyANCg0KQWxzbywgd2UgbmVl
ZCB0byBrbm93IGlmIGF0IHRoZSB0aW1lIHdoZW4gdGhpcyBmdW5jdGlvbiBpcyBjYWxsZWQsIGlm
IHRoZSBiYWNraW5nIGZpbGUgaXMgYXNzb2NpYXRlZCB3aXRoIHRoaXMgZGV2aWNlLg0KDQo+ICAg
IGFwcHJhaXNlIGZ1bmM9TU9VTlRfQ0hFQ0sgZnNuYW1lPXNxdWFzaGZzIGFwcHJhaXNlX3R5cGU9
aW1hc2lnDQogIA0KICANCiAgICANCg0K
