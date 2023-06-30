Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54BB7432C2
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jun 2023 04:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjF3Cbp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Jun 2023 22:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjF3Cbo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Jun 2023 22:31:44 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FDE199B;
        Thu, 29 Jun 2023 19:31:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzd8NSMDd8RP/McVJVDTe56rNfcxMNVFXP8r6e4Blkgv8wwxMlsY7ASARp5iiMbj909zQjcxFPhVAIFg55Rs2fImc53HzuNFfDG7czT43jQCFUy7eACahJ1s3WIw6fIFIiwjhHlVvKihEuFs+FMO9JdDL5zoynI8glkE5wDqgB+i/BCCVC4sqwr/DlKuigtQc3sIe8RSwBNP+HJcLZXoCc/ZHNTe1/n1ZAsD54+VUUVFLJ9EImrtc/6OZ1J/NxrMQXGMbvyvehrDn+h2zg7OMGGmsvKo2rHyzq9YaZGD3ZwUaSNntzLnyuVN1W3slhekuQJ2T8KlhLQB3oB5OlOZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXx98DwmbiSKECWE9OIc5TKI7/716UcyPgrpAHadFMc=;
 b=NTr1rUHyG5oSCJW+ReuaZjQQDeHbRNV6/+og3ROu+KmNbanFcwHu+D8lIb5NBOn3fD8SVt11m7hD7kzjch3KDcjW2NW0T3lpEE7N9G7dct/GqlIGhq80SzvE8izcc4wvvf9gcTNMfLCCVaYltPhblEOePo+v9pVL0VfsyBqd+ycdC4E6U6KVryxoHXE4E0T0meupQYOAvra4y5xH7DmPUY5uWe9BpcS0K5s9HHCtC2iZ0RYmV2Kw5ztgKH/RCHwqT5C2CIjenH2F9pKLngrAIxtx9G9C1/CLDtpLl+F0axZjgl8yQeNngGxty5xXXiCYBSlHONS8oOsFhNRk56j/tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXx98DwmbiSKECWE9OIc5TKI7/716UcyPgrpAHadFMc=;
 b=rWreIfRdFHC1tI2cL6kVNXrFIJov0bHNhUNb2+89UkqWrexc2IYwWxDUxAVWCfjEFzttupcaLy5DVKPXcKQyWTpeAVR9/wGZ49RUocFydsGqvxQTon9brinO6iyAxLXIwQ4/hP7Oknf5JmBOPUnx3O4Kq8hwZoayslhqaQyMD48=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 30 Jun
 2023 02:31:41 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6521.026; Fri, 30 Jun 2023
 02:31:41 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Sachin Sant <sachinp@linux.ibm.com>
Subject: RE: [PATCH] tpm: Ensure that tpm chip has ops to check if it's
 defective
Thread-Topic: [PATCH] tpm: Ensure that tpm chip has ops to check if it's
 defective
Thread-Index: AQHZpX94aXc251l3KE2zG8dxKynyya+X50qAgAB+uQCACj6mAIAABkbA
Date:   Fri, 30 Jun 2023 02:31:41 +0000
Message-ID: <MN0PR12MB6101C213BA60798559E2C1DFE22AA@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230623030427.908-1-mario.limonciello@amd.com>
 <2023062317-daytime-angles-3c5a@gregkh>
 <4d3c4b8a-1788-08af-97ef-a1466a8cda5c@amd.com>
 <CTPMANARFO9J.1FXO8N3EI5Q2S@suppilovahvero>
In-Reply-To: <CTPMANARFO9J.1FXO8N3EI5Q2S@suppilovahvero>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=433891b6-f42c-4ccd-b7fc-126efd917a6e;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-30T02:31:37Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|IA1PR12MB6484:EE_
x-ms-office365-filtering-correlation-id: 903c2646-5aa7-40fa-ef54-08db79122340
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k2N6NN/5KZxNieG/ho3ye/hxwpWTaP8ER6l8laN3TIfn5vBhehxAtdNFjGWzYp2xd7V4gHaYv4YacXSnZBISkrLQl9ENbU/ZWj/X+SK648mwodOOBhQlfxp6E3OsNIGDw97Kn6/VkfYSmp0W0/dkqEwe9afk5pfEMwVxDiHC2qo2AEGiEDl8VA1b2xXlwf9cW8dzEZ3OlZYIq5MpHYqsTnOkK9N9aqi+D3jPI2ci/iibiqdukfBrtOOSYacIt/sGsx3BD+RG+9njOjzxykZKHFNT5G4KXIMph0Qt6DslFwwFlqLcveETWQkP2YzprpJ4rqcKOFisXjovUwbq/okzKXgFYItKXONYlqHBN5pJV4Qpm6J9LaMqzNlOvi8JrUJZRAP9VPZDIKfnQ9uBt1efwYsY6W2mTPZWz+ybkD6TN5dnKU/JWG3CT4GgmB8xXpYr2vqMJHqE9Vb7o6NKEFF0FQGrYXfFpvfBgVVdSiLUpNaP8SmqLx0FaJJa4DVP24HbwgicZEunWH+JiFtQ3Wf/qFYEm8TTcwxsB1abiGjP5qLqGX18jVqRyYGP9XgqT7z6hrKFrnIpf5BOvUIiR0Kg0d9fssqmvoWaW34u8N4Ijd4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199021)(38070700005)(38100700002)(122000001)(33656002)(86362001)(966005)(110136005)(54906003)(9686003)(71200400001)(53546011)(66946007)(316002)(83380400001)(66556008)(55016003)(8936002)(8676002)(76116006)(66446008)(26005)(4326008)(7696005)(6506007)(186003)(41300700001)(64756008)(66476007)(2906002)(52536014)(478600001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3pjYTdNWVFoVlFPVUJXTXA5eitpQnNnc3IxU3cyNzNIQVQ4SU96cjIvN3Uv?=
 =?utf-8?B?WWpmeXo4YXlIR3lWa0JEN0hsR1dQUnU2VGczZVYzUkNOb0tVU1pjeUxHbTNn?=
 =?utf-8?B?K2RkTW9WVzZZaGE4VDEyUHpBYzhIRTVFNDQyNTA4R2tjRzdHS0NwYnFWdDFU?=
 =?utf-8?B?aGJHZG9FK0U4NE5XTUo1d0JPVHpTKzlJcXVMUm1xaHdaOXlFWmNFOGtjaldp?=
 =?utf-8?B?RDUrN3owK2c2ZDgySjFNMjNKLzBUOFB2cmZ3ZkZHWGR6dFg1TWRKdEZhMnlT?=
 =?utf-8?B?U3JkWUdKUTZjSlRqMlNEdkc2aUR3a2o0VGhHM3pCSTd1Qm4xbGVHMVJLcHdN?=
 =?utf-8?B?bm5LTGMxeTBZa3NFdXVsRXlWNTFoVFNXQmgzczBNcU5xMi9aeHNxN2FYOXR2?=
 =?utf-8?B?U2ZwRmpqMjJzRnB6RDZQMU1SWGd0NEVwZXBteVVCU0FFM2hFOHBpcVhIbGdi?=
 =?utf-8?B?dmdHQU55Q2FrRG83L2Y0Wk1RODBGdXM3KzJrM3dNZ3JkTEZLN3Znd1JmYU1a?=
 =?utf-8?B?MG55VERiTWl5RVV2dkEwbDQvZ3lSZ2Z1amhlUGZvTTByV09wcElJS0lLY0ZR?=
 =?utf-8?B?ZkVPT1BodmUwT2xGRFFZOVY4OGI3UWI4ejNvTW14UXhwbjkyaDFOU1hnczJ6?=
 =?utf-8?B?cURFMmp2RGg5NFdCMFVjQTlhaFlGN2F5WldBUkd1dk9jc3haTWJDb3BaMzVL?=
 =?utf-8?B?ZU9kUjE1RXhDMFRDNGM1V0VRYjl1cUFBbmlRYXFzSXpHR3h2WExDcThxN2Nk?=
 =?utf-8?B?V1kvbHpwQk5UdjBEc3pBbFdmVHBKV0RIQmpiaVFTU1NTTURrejN3eHQyRmF6?=
 =?utf-8?B?Qm82cnovK1BRcENRZ3V1MWhmNTB2L2FCVUVDSzQxaFp2b3RGaXQxYVBJckli?=
 =?utf-8?B?MkMvYkJFMVpkdy9tU0tMZEh4dTZibXNzTDIvTmZhZHl5TkdZT3o1bjk3dTZu?=
 =?utf-8?B?SmtGUS9uaGRwWmR5ZVhyc1lzSzVGSmhueDAvTmpRSk9Fc2ozZWpMcE1CUFBa?=
 =?utf-8?B?aVI1bERyWXoyektQdzNpK0dtaUNib0JRNVdEZDdnczV6SEpvWlBJQ2x2d1JJ?=
 =?utf-8?B?TS80dC9vZjNVa3hNRzFMSUlaSk1OdlNKSkMvd0hCVjBpdmF1SXFwejBlVmta?=
 =?utf-8?B?YTgrZ29jQlRVaUJjdWtqSzhQSHRZZEt3Z2haRkVkbFp0eC9NYVV6M25GanJ5?=
 =?utf-8?B?ZnlnTnB2cmNUbjRKMk1Yc01pWCtEcDhIdVR1QlhLTFZybGU5NVlZTTJKZXNR?=
 =?utf-8?B?T0FzdUs4ZnhLZVZkUHdDdlB6OTJGUWE4c085bkwwQjVCcVpneGR3QXdHb2JP?=
 =?utf-8?B?Q0FzbTU3eG1MMHVpTnVBZ2tNNmJIcXBNT2p2Wit0emkwTVRRRHZvTTJ4ZVlR?=
 =?utf-8?B?WjhSNVB4OVZKSlUydFFBQloxT1dJR0R0WnViaWd5U2RqbFdKWUhBK3QzYzJT?=
 =?utf-8?B?QTQ3UGFPdlRPUXZzVWVtL21SbThTMW9FWithbmYzZzVFRUNOMnVDdzZTWFdI?=
 =?utf-8?B?KzQ2WkFISGZETnhzZmdjWEN6RkQwWnhyTU1Tc3RxcS9ESTZJbUFMNnZVbzhS?=
 =?utf-8?B?NmFudHJ4REZ1N1lHUEorZ0VmT1hZVEF2ZlpDb0hLTHM4WVlFS1l5ak1VdzBU?=
 =?utf-8?B?ZW5YVjNIb1VSM1pFWUtyRmYwU1d5OE5CWndsa3VWRFdCYVRTVkhtR2ZvcCtz?=
 =?utf-8?B?aWxlZlB3YWwweURFZHBaNVErOGlxeFFLdzFBczJPTC9xRVc0bFppb0VRMloy?=
 =?utf-8?B?MU01UGU0OGdaNnBJRUIvMlBYMzNKb2M1K1lONzRKL09nOHlQSDdkYXQzeFRq?=
 =?utf-8?B?STJEUHpYVDRsL1BYQngzVHVQakRTSkNxOEMzS3JWVmJOVi84dDFid0pCZ0F1?=
 =?utf-8?B?R3JGdkRXbEJJTUxsS0pLZ2MvMnBISkFXeU5xVDRQbldjbUxYSlc3ZU1FODUx?=
 =?utf-8?B?K2NsNWU1T2tmbXFuZkFQWHBRSXhEOU4rZ2prVDhVZjQ2d29SL1Y0aTBMamtS?=
 =?utf-8?B?L0hkUkRCcWN2YWNUVG0vY0lPeE0yRDlqMUVOMGc0d3krSUExMXdxOTdIMnJr?=
 =?utf-8?B?b0F1Vk9FeXhZWnBleFBqL3FRWElUS24vM2lWSkpzc3lNSTB0eVQxRk9oTFZu?=
 =?utf-8?Q?HL54=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 903c2646-5aa7-40fa-ef54-08db79122340
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 02:31:41.0577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Ua9ijAjJF0PCwEQtBBsArbhNi0KxLy+ozlSeBEUqOVSKSI04Ty4/rEvbZCfo+ETYld4RSdJCBP6td0o7zvufw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6484
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYXJra28g
U2Fra2luZW4gPGphcmtrb0BrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgSnVuZSAyOSwg
MjAyMyA5OjA5IFBNDQo+IFRvOiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxv
QGFtZC5jb20+OyBHcmVnIEtIDQo+IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gQ2M6
IHBldGVyaHVld2VAZ214LmRlOyBqZ2dAemllcGUuY2E7IGxpbnV4LWludGVncml0eUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBMaW51eCByZWdyZXNz
aW9ucyBtYWlsaW5nIGxpc3QNCj4gPHJlZ3Jlc3Npb25zQGxpc3RzLmxpbnV4LmRldj47IEFuZWVz
aCBLdW1hciBLIC4gVg0KPiA8YW5lZXNoLmt1bWFyQGxpbnV4LmlibS5jb20+OyBTYWNoaW4gU2Fu
dCA8c2FjaGlucEBsaW51eC5pYm0uY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSB0cG06IEVu
c3VyZSB0aGF0IHRwbSBjaGlwIGhhcyBvcHMgdG8gY2hlY2sgaWYgaXQncw0KPiBkZWZlY3RpdmUN
Cj4NCj4gT24gRnJpIEp1biAyMywgMjAyMyBhdCA0OjQyIFBNIEVFU1QsIExpbW9uY2llbGxvLCBN
YXJpbyB3cm90ZToNCj4gPg0KPiA+IE9uIDYvMjMvMjAyMyAxOjA4IEFNLCBHcmVnIEtIIHdyb3Rl
Og0KPiA+ID4gT24gVGh1LCBKdW4gMjIsIDIwMjMgYXQgMTA6MDQ6MjdQTSAtMDUwMCwgTWFyaW8g
TGltb25jaWVsbG8gd3JvdGU6DQo+ID4gPj4gVGhlIGlibXZ0cG0gZG9lc24ndCBoYXZlIGBjaGlw
LT5vcHNgIHNldCwgYW5kIHNvIHRyeWluZyB0byBjaGVjaw0KPiA+ID4+IGlmIGl0J3MgYSBkZWZl
Y3RpdmUgQU1EIGZUUE0gZG9lc24ndCB3b3JrLg0KPiA+ID4+DQo+ID4gPj4gQWRkIGFuIGV4dHJh
IGNoZWNrIHRvIHRwbV9hbWRfaXNfcm5nX2RlZmVjdGl2ZSgpIHRvIGVuc3VyZSB0aGUNCj4gPiA+
PiBUUE0gYmVpbmcgY2hlY2tlZCBoYXMgYGNoaXAtPm9wc2AuDQo+ID4gPj4NCj4gPiA+PiBDYzog
TGludXggcmVncmVzc2lvbnMgbWFpbGluZyBsaXN0IDxyZWdyZXNzaW9uc0BsaXN0cy5saW51eC5k
ZXY+DQo+ID4gPj4gUmVwb3J0ZWQtYnk6IEFuZWVzaCBLdW1hciBLLiBWIDxhbmVlc2gua3VtYXJA
bGludXguaWJtLmNvbT4NCj4gPiA+PiBSZXBvcnRlZC1ieTogU2FjaGluIFNhbnQgPHNhY2hpbnBA
bGludXguaWJtLmNvbT4NCj4gPiA+PiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21s
Lzk5QjgxNDAxLURCNDYtNDlCOS1CMzIxLQ0KPiBDRjgzMkI1MENBQzNAbGludXguaWJtLmNvbS8N
Cj4gPiA+PiBUZXN0ZWQtYnk6IFNhY2hpbiBTYW50IDxzYWNoaW5wQGxpbnV4LmlibS5jb20+DQo+
ID4gPj4gRml4ZXM6IGJkODYyMWNhMTUxMCAoInRwbTogQWRkICF0cG1fYW1kX2lzX3JuZ19kZWZl
Y3RpdmUoKSB0byB0aGUNCj4gaHdybmdfdW5yZWdpc3RlcigpIGNhbGwgc2l0ZSIpDQo+ID4gPj4g
Rml4ZXM6IGYxMzI0YmJjNDAxMSAoInRwbTogZGlzYWJsZSBod3JuZyBmb3IgZlRQTSBvbiBzb21l
IEFNRA0KPiBkZXNpZ25zIikNCj4gPiA+PiBTaWduZWQtb2ZmLWJ5OiBNYXJpbyBMaW1vbmNpZWxs
byA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCj4gPiA+PiAtLS0NCj4gPiA+PiAgIGRyaXZl
cnMvY2hhci90cG0vdHBtLWNoaXAuYyB8IDMgKysrDQo+ID4gPj4gICAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspDQo+ID4gPiBObyBjYzogc3RhYmxlIG9uIHRoYXQgbGlzdCBhYm92ZT8N
Cj4gPg0KPiA+IEdvb2QgcG9pbnQsIG15IG1pc3Rha2Ugb24gdGhhdCBtaXNzLg0KPiA+DQo+ID4g
SWYgSmFya2tvIGFncmVlcyB3aXRoIHRoZSBkaXJlY3Rpb24gb2YgdGhpcyBwYXRjaCwgSSB0aGlu
aw0KPiA+IGl0IGNhbiBiZSBhZGRlZCB3aGlsZSBjb21taXR0aW5nLg0KPg0KPiBIbW0uLi4gc29y
cnkgTWlkc3VtbWVyIHdlZWtlbmQsIHdoaWNoIGlzIGtpbmQgb2YgYmlnIHRoaW5nIGluIEZpbmxh
bmQsDQo+IGFuZCBhbHNvIGhlbHBpbmcgdG9lIGV4cG9zZSBuZW8tbmF6aSBhZmZpbGlhdGVkIG1p
bmlzdGVyIChzb3VuZHMgY3JhenkNCj4gYnV0IGl0IGlzIGxpdGVyYWxseSB0cnVlKSBoYXZlIG1h
ZGUgbWUgbGFnIGEgYml0IHdpdGggTEtNTC4NCj4NCj4gSSdtIHByZXN1bWluZyB0aGF0IHdlIGFy
ZSBnb2luZyBpbiB0aGUgZGlyZWN0aW9uIG9mIEplcnJ5J3MgcGF0Y2gsDQo+IHJpZ2h0Pw0KPg0K
PiBCUiwgSmFya2tvDQoNClllczsgbGV0J3MgZ28gd2l0aCBKZXJyeSdzIHBhdGNoIGluc3RlYWQu
DQoNCg==
