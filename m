Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807826A5148
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Feb 2023 03:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjB1CiK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Feb 2023 21:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjB1CiJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Feb 2023 21:38:09 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771A716ACE;
        Mon, 27 Feb 2023 18:38:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUmm4tXHxxEDTg5KQKYduKk+sHuKBFU2IW9o9UZNsPJOjkQipuuwq5grj3goFfc8UW2ltvhzZsN+yT6mO/zTPnXGhavv4zgYCo790Ns2h/87R5sXgodgJXRpIBrnZ2BdY2x1NvWI/0kG57vzwtmNAMEp+0093a+ymwuPF2OL+iUMTd6dnQeKfpzf1/CRUlTl3ftL9UWRQBkZU8r5oAXzGDIS+U/uaE7wVLuCsTAe2yxoRkImGtAISz6oXN3hS1pfoWnlBAj/r6t1hDtMrD3P1sITRhZkJLtXP8C6ziERnifqIh+V4TQT5m5Nl9LQWH9gSEZyNLFx9Z9IV6rTpcQpcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiWb5l4tBMZebiR57sLP4agFsU6Uxh+nuFxSxKuRndE=;
 b=aZhyo3JxEG8yMFUbtJjs4/d7BKanSA3MNq1/uagtAOnQUHXHxzkVGH95b/QrVcO0RQbrMD+c5bYtZjTACQMJ1LjZzUZzgddQx/tuIz0OW7nRYOWh7i504EeW+fkGOzkKBpsSn8e6g6ae81n6pmJaj7/30+x7XxvWfHgcU7nJKVGkLWGa3FN4wqsW7UxXOAOrYxDGYJkZGLP63Y4XfvQzQvw4SoU0H23p/BPNgorvvE5wHT/nZ1WCd2ibV78z73NjWjx864xtTZKYG0egkTY2ej3ihI4XJFsXHcDd3qMvc0RkXNcpWDR3qU3EQLjuT54q3+R2i420imz0FK8QkYbbYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiWb5l4tBMZebiR57sLP4agFsU6Uxh+nuFxSxKuRndE=;
 b=q2ROl5mkKRfSGhuwjZ/vi7K9eW9fv1Fce0KU68gWFSIZnk5AprSz4qfJwWYfXw3MuDJaLXdeO44ZoUR1Mx0vXbWkeFw5CDNL7WI59NCRd547+++SPxJek7d/Q9sobHrJ1He6697h8kHcZQdw1dF5pZMwjcuXrLo2VvgL2pU8vtI=
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.29; Tue, 28 Feb 2023 02:38:00 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::154c:5f14:c6d7:1029]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::154c:5f14:c6d7:1029%8]) with mapi id 15.20.6134.029; Tue, 28 Feb 2023
 02:37:59 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] tpm: disable hwrng for fTPM on some AMD designs
Thread-Topic: [PATCH v2] tpm: disable hwrng for fTPM on some AMD designs
Thread-Index: AQHZRVZE2QMm6pyAmEyQgEhtBaidea7i64kAgADE+tA=
Date:   Tue, 28 Feb 2023 02:37:59 +0000
Message-ID: <DS7PR12MB60953294CDD3F198ACD3E567E2AC9@DS7PR12MB6095.namprd12.prod.outlook.com>
References: <20230220180729.23862-1-mario.limonciello@amd.com>
 <915571f8-d055-90b9-3048-f629befd9a13@amd.com>
In-Reply-To: <915571f8-d055-90b9-3048-f629befd9a13@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-02-28T02:37:57Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=abcd3d68-decd-4f51-9ab6-44bcedc96115;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-02-28T02:37:57Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: e2df55f4-e3be-45a6-9b2e-595d098d36ca
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6095:EE_|MW3PR12MB4396:EE_
x-ms-office365-filtering-correlation-id: 76a86f69-4091-4c3a-a5d7-08db1934ce64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nul5P1u5fYH6Q9K49ihhXYMEhC2EVBEVOA0SgjhMOVpxFCVo5ITqoOwydyHev6SLswQ9vgZ3gNrZB5LPu+uyCyMX5Zd54mBkql7l9Wc3z29cUkJem2dCpoEWZ9WMqCx7w/QsZA7v+3KWjxDClZsqQKMr7+YoY+UjY3ILPdYrIVB0Ln2q7Y6zlSfx9s7KO3qjVSGvsHRjERuI3KPUY9coVVwHHhWHwxt5EVd6ZumNswGpje4BTNR+Gh6LeuVrPWimj0RyVCXP5WuuEkia4cjr5zeL1AqKUAREgYUKcNGL045xERkOJB+xuHv6wbswZJyuYZnxbzmbImKsjgZZgM77DX4jB8KHw69zalYbJc2XVMmMSvrjXQ6gr/koJLgWMKU1bImfyn2U2vntMprfiGo+0LbBva1HAe2vbM8WnnsaU61mpdenLTs0vQW3kQOeR2RaopxARsNd03T52xwttXqAIJYyNInoUjRDNliw5tgIIGGfRJkFNPhuV3UXl5YvRzhGtOWzxffU7G7TO8gmefsY2CpUwErItunRkdfSNk50HqBArTi6Ns+kQQvpyFfYNHLozc5hrQmAuZibgwBkJ+GURbiBXavwnWKo/q8FVFHrEZSZRtwZK4knB0WFKe1iGfrfMcHChF1SGaau+0DILDO5+nfq4OW5m6k9K/wPtZdtm1IAbKDRN2AW42ckWDs4RJ2yMySJjjA4xAbnNV22xEk0pzsNqFXeRUnmpLFYnSIvK5I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199018)(86362001)(316002)(33656002)(110136005)(54906003)(966005)(9686003)(186003)(7416002)(4326008)(5660300002)(66446008)(66476007)(41300700001)(8676002)(2906002)(66946007)(76116006)(66556008)(8936002)(6506007)(478600001)(53546011)(71200400001)(26005)(64756008)(55016003)(7696005)(38100700002)(52536014)(122000001)(83380400001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OU5YZndKMTBwMUh4cFducEFTR2R2ek4yOWZpam1QWEJVL3NkQnNkWVVFdk8w?=
 =?utf-8?B?dWFjWUMwak9vSUpGMjg5VTRkSytvNmV5ZmNCazNpM2xXcjZzd3h3cnR3TFpH?=
 =?utf-8?B?YTlvSHQ5aGc4eTVNdjZtL3R2TndoY3JiWVZxR2NVWlo4WURaL0dMSi9YUGE5?=
 =?utf-8?B?OXV3WkdZaE8yZ0dEeTNDR2FnUzY0MHQwOFNxdVhxaHFVWnpZYS95NWZWdUlX?=
 =?utf-8?B?Zjk3RURwU2FiMXBBYmZkUEQvRDYxV1FHK2pieW9vMjFJSmFPODFlU041Tjhr?=
 =?utf-8?B?MzdycjYvSHZrT210cW9BUVk5TmduNmtvdTJyNHJJL0hacGw5cHFKOVRqbkRZ?=
 =?utf-8?B?R1gzT2FBZW1FSmUyM0lTK2JQdm5CTHJIUXowNUdZSmo5QTlLOU0yY3ZXZHFj?=
 =?utf-8?B?UkNQQXIzM0xMWFpVZXA5UFdtUGpob1RLU2JCMncvMnlGajJ5R2hBOVllQnJX?=
 =?utf-8?B?dnc0QnlpK01aaDRTV3BRUUxMZHF6YjR5V09UVlZKb0sxYzFPUUY1Zms2WmtO?=
 =?utf-8?B?a08zS3pJL0ZsTFhmanp6VXZzMWhMMUcxSzkvQmxoREpLMEtGZ0MzTVhxQzdS?=
 =?utf-8?B?Ulh0VUwzS2YzSHB4dm85MmJOWFhrV3FZTms0dmRPWDlqMjdUc1hBOHIwdmdy?=
 =?utf-8?B?SVlhNWMySHZwNjNGeDBuQUp6ZHhHZDA0dFl4WEIvVE1POHZlMExxLzEzbjZS?=
 =?utf-8?B?ampXRmJjYTc4YmQ3b2RxYTZQNUU2S044RWRaWmNiajBXTytja1hJeXBxd096?=
 =?utf-8?B?OGpQY1JRV1NFdHRucHd1dmQrZEJUK1c2dElSNFROL3RPNWpiRXRvOHJxQ1dp?=
 =?utf-8?B?eGlEaWdWVHBhWVpodUNpbTlxZFN0VlZPbWRqeHdkQXh4VmIyclBqZ0Z2MXky?=
 =?utf-8?B?b2VZVWZodzlVVjFqcGgyYXd3N0lqYS9wUXJFcVA5bXpoazdEbXE0RjBQVGps?=
 =?utf-8?B?d1FOVDZVeXhsYUtJNXA2VG1iK01oOGRsdUFVa2djZmtvK1dmdW9iVFF6Rzhr?=
 =?utf-8?B?Qm5sTll0M09lMnZhVll6RXZwdnQvUlNIc0JuQWs4TnBsK1d0eEV5QnEzd3Fu?=
 =?utf-8?B?NFM5YXZDYzdFakJxM3J0ZTE2MmdvcHFhc2dVdlVYbFpuV1UxT3ZlTkh5dzJw?=
 =?utf-8?B?Zm1BN0hoVVUwUEU5dzYzUmtuS2VmTkwwNGpqSTZWNHVLWk90Q1RURUwzTjll?=
 =?utf-8?B?QlI2TjN6V3VuUGtaemFQN29xS09pcHVReGZsWFdMZVQwRGN6bTUxdUhZVytS?=
 =?utf-8?B?VzFMQk1LNU53NlpScDRndzhLTFBUcllmYVByallvRjIyQVlIYk90ODhQZFhK?=
 =?utf-8?B?TFN5WUlLSWpTcDhVVnNJWk5td08rVVkwZ3A0NWFYU3VDNGkxakl6ODZyR3VV?=
 =?utf-8?B?MTl0VFJER1huUmY4V2RYeDhTdzFvZ0hYWmdldTJOSkpVbzhkUUNjdzd4a0xO?=
 =?utf-8?B?MmtkcmpiYWdOUnp6azJ0dzA3bWZJWWM1N29IK0tIWnpWdWRSamFMNkN6Y2pL?=
 =?utf-8?B?RTlzaU9obFNmSlQwSklUU0tEUWhHaFFMRUhoTCtmQjJ3QVBEUUZwZ1BTZkIw?=
 =?utf-8?B?aTFCOUFVanh6UkZIY3YxQUEzV3h3cUFNanJVdjhyQk9qMWlSakpjencwYzNH?=
 =?utf-8?B?MlNoU1R1VjczbVcybkFXdWJWVXh0MjVnaUxNTnU0Zm9ObUNiU1JUcGdPaFg2?=
 =?utf-8?B?K3F4Z083cGpHUlRwY2dtdmRsanVRejBzQVl1Snh1dVRoQzFzcUJyZ3JONnRk?=
 =?utf-8?B?eGkwYXBJSXFWVzI0TS9YWW9WZExTZXpWZmV3UmdZRWF1cnhpQ3l5OWYxRjBF?=
 =?utf-8?B?bVpxaHJhTVF1Z2YycUZWWlZOTURWQjNiTVZJRlNPZFNXV1pmTTRxVUJmcFRW?=
 =?utf-8?B?WGRmRWZxTnBGcGR2VnoyUFdjZmFYYXVFQ0QyTVNjcDNzNXpKbkJqNWszWGFk?=
 =?utf-8?B?b0NudDloNVVpOG1EdzJJdHpRNmh2VW9zWlRmODBGcWM3OFNQTXdvaCtFdUVJ?=
 =?utf-8?B?Kzk2SEI3QU9FRzZBZ29oV2NRWVpYRHQ5MnVEUkQzdUIrVUk4d1g1YnJ5blF4?=
 =?utf-8?B?MGE1Ni9xbVI4bTA4c080ZFVtaDNyUXJYWWhCbGxiRy8yZTZCNmlCaHU1MFN2?=
 =?utf-8?Q?qcnc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a86f69-4091-4c3a-a5d7-08db1934ce64
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 02:37:59.4597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9qToVjXHvm/X54v6GGwfyDGd5Rgph+KfTipABxqrerl+rzrmP5hiYApwr+1vCYy44al0b76mmcYx6tg0uHgRmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGlt
b25jaWVsbG8sIE1hcmlvDQo+IFNlbnQ6IE1vbmRheSwgRmVicnVhcnkgMjcsIDIwMjMgMDg6NTMN
Cj4gVG86IFBldGVyIEh1ZXdlIDxwZXRlcmh1ZXdlQGdteC5kZT47IEphcmtrbyBTYWtraW5lbg0K
PiA8amFya2tvQGtlcm5lbC5vcmc+OyBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVwZS5jYT47IERv
bWluaWsgQnJvZG93c2tpDQo+IDxsaW51eEBkb21pbmlrYnJvZG93c2tpLm5ldD47IEhlcmJlcnQg
WHUNCj4gPGhlcmJlcnRAZ29uZG9yLmFwYW5hLm9yZy5hdT4NCj4gQ2M6IHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmc7IFRob3JzdGVuIExlZW1odWlzDQo+IDxyZWdyZXNzaW9uc0BsZWVtaHVpcy5pbmZv
PjsgSmFtZXMgQm90dG9tbGV5DQo+IDxKYW1lcy5Cb3R0b21sZXlAaGFuc2VucGFydG5lcnNoaXAu
Y29tPjsgSmFzb24gQSAuIERvbmVuZmVsZA0KPiA8SmFzb25AengyYzQuY29tPjsgbGludXgtaW50
ZWdyaXR5QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gdHBtOiBkaXNhYmxlIGh3cm5nIGZvciBmVFBNIG9u
IHNvbWUgQU1EIGRlc2lnbnMNCj4gDQo+IE9uIDIvMjAvMjMgMTI6MDcsIE1hcmlvIExpbW9uY2ll
bGxvIHdyb3RlOg0KPiA+IEFNRCBoYXMgaXNzdWVkIGFuIGFkdmlzb3J5IGluZGljYXRpbmcgdGhh
dCBoYXZpbmcgZlRQTSBlbmFibGVkIGluDQo+ID4gQklPUyBjYW4gY2F1c2UgInN0dXR0ZXJpbmci
IGluIHRoZSBPUy4gIFRoaXMgaXNzdWUgaGFzIGJlZW4gZml4ZWQNCj4gPiBpbiBuZXdlciB2ZXJz
aW9ucyBvZiB0aGUgZlRQTSBmaXJtd2FyZSwgYnV0IGl0J3MgdXAgdG8gc3lzdGVtDQo+ID4gZGVz
aWduZXJzIHRvIGRlY2lkZSB3aGV0aGVyIHRvIGRpc3RyaWJ1dGUgaXQuDQo+ID4NCj4gPiBUaGlz
IGlzc3VlIGhhcyBleGlzdGVkIGZvciBhIHdoaWxlLCBidXQgaXMgbW9yZSBwcmV2YWxlbnQgc3Rh
cnRpbmcNCj4gPiB3aXRoIGtlcm5lbCA2LjEgYmVjYXVzZSBjb21taXQgYjAwNmM0MzlkNThkYiAo
Imh3cm5nOiBjb3JlIC0gc3RhcnQNCj4gPiBod3JuZyBrdGhyZWFkIGFsc28gZm9yIHVudHJ1c3Rl
ZCBzb3VyY2VzIikgc3RhcnRlZCB0byB1c2UgdGhlIGZUUE0NCj4gPiBmb3IgaHdybmcgYnkgZGVm
YXVsdC4gSG93ZXZlciwgYWxsIHVzZXMgb2YgL2Rldi9od3JuZyByZXN1bHQgaW4NCj4gPiB1bmFj
Y2VwdGFibGUgc3R1dHRlcmluZy4NCj4gPg0KPiA+IFNvLCBzaW1wbHkgZGlzYWJsZSByZWdpc3Ry
YXRpb24gb2YgdGhlIGRlZmVjdGl2ZSBod3JuZyB3aGVuIGRldGVjdGluZw0KPiA+IHRoZXNlIGZh
dWx0eSBmVFBNIHZlcnNpb25zLiAgQXMgdGhpcyBpcyBjYXVzZWQgYnkgZmF1bHR5IGZpcm13YXJl
LCBpdA0KPiA+IGlzIHBsYXVzaWJsZSB0aGF0IHN1Y2ggYSBwcm9ibGVtIGNvdWxkIGFsc28gYmUg
cmVwcm9kdWNlZCBieSBvdGhlciBUUE0NCj4gPiBpbnRlcmFjdGlvbnMsIGJ1dCB0aGlzIGhhc24n
dCBiZWVuIHNob3duIGJ5IGFueSB1c2VyJ3MgdGVzdGluZyBvciByZXBvcnRzLg0KPiA+DQo+ID4g
SXQgaXMgaHlwb3RoZXNpemVkIHRvIGJlIHRyaWdnZXJlZCBtb3JlIGZyZXF1ZW50bHkgYnkgdGhl
IHVzZSBvZiB0aGUgUk5HDQo+ID4gYmVjYXVzZSB1c2Vyc3BhY2Ugc29mdHdhcmUgd2lsbCBmZXRj
aCByYW5kb20gbnVtYmVycyByZWd1bGFybHkuDQo+ID4NCj4gPiBJbnRlbnRpb25hbGx5IGNvbnRp
bnVlIHRvIHJlZ2lzdGVyIG90aGVyIFRQTSBmdW5jdGlvbmFsaXR5IHNvIHRoYXQgdXNlcnMNCj4g
PiB0aGF0IHJlbHkgdXBvbiBQQ1IgbWVhc3VyZW1lbnRzIG9yIGFueSBzdG9yYWdlIG9mIGRhdGEg
d2lsbCBzdGlsbCBoYXZlDQo+ID4gYWNjZXNzIHRvIGl0LiAgSWYgaXQncyBmb3VuZCBsYXRlciB0
aGF0IGFub3RoZXIgVFBNIGZ1bmN0aW9uYWxpdHkgaXMNCj4gPiBleGFjZXJiYXRpbmcgdGhpcyBw
cm9ibGVtIGEgbW9kdWxlIHBhcmFtZXRlciBpdCBjYW4gYmUgdHVybmVkIG9mZiBlbnRpcmVseQ0K
PiA+IGFuZCBhIG1vZHVsZSBwYXJhbWV0ZXIgY2FuIGJlIGludHJvZHVjZWQgdG8gYWxsb3cgdXNl
cnMgd2hvIHJlbHkgdXBvbg0KPiA+IGZUUE0gZnVuY3Rpb25hbGl0eSB0byB0dXJuIGl0IG9uIGV2
ZW4gdGhvdWdoIHRoaXMgcHJvYmxlbSBpcyBwcmVzZW50Lg0KPiA+DQo+ID4gTGluazogaHR0cHM6
Ly93d3cuYW1kLmNvbS9lbi9zdXBwb3J0L2tiL2ZhcS9wYS00MTANCj4gPiBMaW5rOiBodHRwczov
L2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIxNjk4OQ0KPiA+IExpbms6IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDIwOTE1MzEyMC4yNjE5MDQtMS0NCj4gSmFz
b25AengyYzQuY29tLw0KPiA+IEZpeGVzOiBiMDA2YzQzOWQ1OGQgKCJod3JuZzogY29yZSAtIHN0
YXJ0IGh3cm5nIGt0aHJlYWQgYWxzbyBmb3IgdW50cnVzdGVkDQo+IHNvdXJjZXMiKQ0KPiA+IENj
OiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gQ2M6IEphcmtrbyBTYWtraW5lbiA8amFya2tv
QGtlcm5lbC5vcmc+DQo+ID4gQ2M6IFRob3JzdGVuIExlZW1odWlzIDxyZWdyZXNzaW9uc0BsZWVt
aHVpcy5pbmZvPg0KPiA+IENjOiBKYW1lcyBCb3R0b21sZXkgPEphbWVzLkJvdHRvbWxleUBoYW5z
ZW5wYXJ0bmVyc2hpcC5jb20+DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBKYXNvbiBBLiBEb25lbmZl
bGQgPEphc29uQHp4MmM0LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBBLiBEb25lbmZl
bGQgPEphc29uQHp4MmM0LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXJpbyBMaW1vbmNpZWxs
byA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiB2MS0+djI6DQo+ID4g
ICAqIE1pbm9yIHN0eWxlIGZyb20gSmFya2tvJ3MgZmVlZGJhY2sNCj4gPiAgICogTW92ZSBjb21t
ZW50IGFib3ZlIGZ1bmN0aW9uDQo+ID4gICAqIEV4cGxhaW4gZnVydGhlciBpbiBjb21taXQgbWVz
c2FnZQ0KPiANCj4gT25lIG9mIHRoZSByZXBvcnRlcnMgb24gdGhlIGtlcm5lbCBidWd6aWxsYSBk
aWQgY29uZmlybSB0aGUgdjIgcGF0Y2gsDQo+IGZvcndhcmRpbmcgdGhlaXIgdGFnLg0KPiANCj4g
VGVzdGVkLWJ5OiBCZWxsIDwxMTM4MjY3NjQzQHFxLmNvbT4NCg0KSGVyZSdzIGFub3RoZXIgdGFn
Lg0KDQpUZXN0ZWQtYnk6IHJlYWNoNjIyQG1haWxjdWsuY29tIA0KDQo+ID4gLS0tDQo+ID4gICBk
cml2ZXJzL2NoYXIvdHBtL3RwbS1jaGlwLmMgfCA2MSArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystDQo+ID4gICBkcml2ZXJzL2NoYXIvdHBtL3RwbS5oICAgICAgfCA3Mw0KPiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDEz
MyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9jaGFyL3RwbS90cG0tY2hpcC5jIGIvZHJpdmVycy9jaGFyL3RwbS90cG0tY2hpcC5jDQo+
ID4gaW5kZXggNzQxZDhmM2U4ZmIzLi4xYjA2NmQ3YTZlMjEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9jaGFyL3RwbS90cG0tY2hpcC5jDQo+ID4gKysrIGIvZHJpdmVycy9jaGFyL3RwbS90cG0t
Y2hpcC5jDQo+ID4gQEAgLTUxMiw2ICs1MTIsNjQgQEAgc3RhdGljIGludCB0cG1fYWRkX2xlZ2Fj
eV9zeXNmcyhzdHJ1Y3QgdHBtX2NoaXANCj4gKmNoaXApDQo+ID4gICAJcmV0dXJuIDA7DQo+ID4g
ICB9DQo+ID4NCj4gPiArLyoNCj4gPiArICogU29tZSBBTUQgZlRQTSB2ZXJzaW9ucyBtYXkgY2F1
c2Ugc3R1dHRlcg0KPiA+ICsgKiBodHRwczovL3d3dy5hbWQuY29tL2VuL3N1cHBvcnQva2IvZmFx
L3BhLTQxMA0KPiA+ICsgKg0KPiA+ICsgKiBGaXhlcyBhcmUgYXZhaWxhYmxlIGluIHR3byBzZXJp
ZXMgb2YgZlRQTSBmaXJtd2FyZToNCj4gPiArICogNi54LnkueiBzZXJpZXM6IDYuMC4xOC42ICsN
Cj4gPiArICogMy54LnkueiBzZXJpZXM6IDMuNTcueS41ICsNCj4gPiArICovDQo+ID4gK3N0YXRp
YyBib29sIHRwbV9hbWRfaXNfcm5nX2RlZmVjdGl2ZShzdHJ1Y3QgdHBtX2NoaXAgKmNoaXApDQo+
ID4gK3sNCj4gPiArCXUzMiB2YWwxLCB2YWwyOw0KPiA+ICsJdTY0IHZlcnNpb247DQo+ID4gKwlp
bnQgcmV0Ow0KPiA+ICsNCj4gPiArCWlmICghKGNoaXAtPmZsYWdzICYgVFBNX0NISVBfRkxBR19U
UE0yKSkNCj4gPiArCQlyZXR1cm4gZmFsc2U7DQo+ID4gKw0KPiA+ICsJcmV0ID0gdHBtX3JlcXVl
c3RfbG9jYWxpdHkoY2hpcCk7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldHVybiBmYWxzZTsN
Cj4gPiArDQo+ID4gKwlyZXQgPSB0cG0yX2dldF90cG1fcHQoY2hpcCwgVFBNMl9QVF9NQU5VRkFD
VFVSRVIsICZ2YWwxLA0KPiBOVUxMKTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJZ290byByZWxl
YXNlOw0KPiA+ICsJaWYgKHZhbDEgIT0gMHg0MTRENDQwMFUgLyogQU1EICovKSB7DQo+ID4gKwkJ
cmV0ID0gLUVOT0RFVjsNCj4gPiArCQlnb3RvIHJlbGVhc2U7DQo+ID4gKwl9DQo+ID4gKwlyZXQg
PSB0cG0yX2dldF90cG1fcHQoY2hpcCwgVFBNMl9QVF9GSVJNV0FSRV9WRVJTSU9OXzEsDQo+ICZ2
YWwxLCBOVUxMKTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJZ290byByZWxlYXNlOw0KPiA+ICsJ
cmV0ID0gdHBtMl9nZXRfdHBtX3B0KGNoaXAsIFRQTTJfUFRfRklSTVdBUkVfVkVSU0lPTl8yLA0K
PiAmdmFsMiwgTlVMTCk7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCWdvdG8gcmVsZWFzZTsNCj4g
PiArDQo+ID4gK3JlbGVhc2U6DQo+ID4gKwl0cG1fcmVsaW5xdWlzaF9sb2NhbGl0eShjaGlwKTsN
Cj4gPiArDQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldHVybiBmYWxzZTsNCj4gPiArDQo+ID4g
Kwl2ZXJzaW9uID0gKCh1NjQpdmFsMSA8PCAzMikgfCB2YWwyOw0KPiA+ICsJaWYgKCh2ZXJzaW9u
ID4+IDQ4KSA9PSA2KSB7DQo+ID4gKwkJaWYgKHZlcnNpb24gPj0gMHgwMDA2MDAwMDAwMTgwMDA2
VUxMKQ0KPiA+ICsJCQlyZXR1cm4gZmFsc2U7DQo+ID4gKwl9IGVsc2UgaWYgKCh2ZXJzaW9uID4+
IDQ4KSA9PSAzKSB7DQo+ID4gKwkJaWYgKHZlcnNpb24gPj0gMHgwMDAzMDA1NzAwMDAwMDA1VUxM
KQ0KPiA+ICsJCQlyZXR1cm4gZmFsc2U7DQo+ID4gKwl9IGVsc2UNCj4gPiArCQlyZXR1cm4gZmFs
c2U7DQo+ID4gKw0KPiA+ICsJZGV2X3dhcm4oJmNoaXAtPmRldiwNCj4gPiArCQkgIkFNRCBmVFBN
IHZlcnNpb24gMHglbGx4IGNhdXNlcyBzeXN0ZW0gc3R1dHRlcjsgaHdybmcNCj4gZGlzYWJsZWRc
biIsDQo+ID4gKwkJIHZlcnNpb24pOw0KPiA+ICsNCj4gPiArCXJldHVybiB0cnVlOw0KPiA+ICt9
DQo+ID4gKw0KPiA+ICAgc3RhdGljIGludCB0cG1faHdybmdfcmVhZChzdHJ1Y3QgaHdybmcgKnJu
Zywgdm9pZCAqZGF0YSwgc2l6ZV90IG1heCwgYm9vbA0KPiB3YWl0KQ0KPiA+ICAgew0KPiA+ICAg
CXN0cnVjdCB0cG1fY2hpcCAqY2hpcCA9IGNvbnRhaW5lcl9vZihybmcsIHN0cnVjdCB0cG1fY2hp
cCwgaHdybmcpOw0KPiA+IEBAIC01MjEsNyArNTc5LDggQEAgc3RhdGljIGludCB0cG1faHdybmdf
cmVhZChzdHJ1Y3QgaHdybmcgKnJuZywgdm9pZA0KPiAqZGF0YSwgc2l6ZV90IG1heCwgYm9vbCB3
YWl0KQ0KPiA+DQo+ID4gICBzdGF0aWMgaW50IHRwbV9hZGRfaHdybmcoc3RydWN0IHRwbV9jaGlw
ICpjaGlwKQ0KPiA+ICAgew0KPiA+IC0JaWYgKCFJU19FTkFCTEVEKENPTkZJR19IV19SQU5ET01f
VFBNKSB8fA0KPiB0cG1faXNfZmlybXdhcmVfdXBncmFkZShjaGlwKSkNCj4gPiArCWlmICghSVNf
RU5BQkxFRChDT05GSUdfSFdfUkFORE9NX1RQTSkgfHwNCj4gdHBtX2lzX2Zpcm13YXJlX3VwZ3Jh
ZGUoY2hpcCkgfHwNCj4gPiArCSAgICB0cG1fYW1kX2lzX3JuZ19kZWZlY3RpdmUoY2hpcCkpDQo+
ID4gICAJCXJldHVybiAwOw0KPiA+DQo+ID4gICAJc25wcmludGYoY2hpcC0+aHdybmdfbmFtZSwg
c2l6ZW9mKGNoaXAtPmh3cm5nX25hbWUpLA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIv
dHBtL3RwbS5oIGIvZHJpdmVycy9jaGFyL3RwbS90cG0uaA0KPiA+IGluZGV4IDI0ZWU0ZTFjYzQ1
Mi4uODMwMDE0YTI2NjA5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2hhci90cG0vdHBtLmgN
Cj4gPiArKysgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbS5oDQo+ID4gQEAgLTE1MCw2ICsxNTAsNzkg
QEAgZW51bSB0cG1fc3ViX2NhcGFiaWxpdGllcyB7DQo+ID4gICAJVFBNX0NBUF9QUk9QX1RJU19E
VVJBVElPTiA9IDB4MTIwLA0KPiA+ICAgfTsNCj4gPg0KPiA+ICtlbnVtIHRwbTJfcHRfcHJvcHMg
ew0KPiA+ICsJVFBNMl9QVF9OT05FID0gMHgwMDAwMDAwMCwNCj4gPiArCVRQTTJfUFRfR1JPVVAg
PSAweDAwMDAwMTAwLA0KPiA+ICsJVFBNMl9QVF9GSVhFRCA9IFRQTTJfUFRfR1JPVVAgKiAxLA0K
PiA+ICsJVFBNMl9QVF9GQU1JTFlfSU5ESUNBVE9SID0gVFBNMl9QVF9GSVhFRCArIDAsDQo+ID4g
KwlUUE0yX1BUX0xFVkVMID0gVFBNMl9QVF9GSVhFRCArIDEsDQo+ID4gKwlUUE0yX1BUX1JFVklT
SU9OID0gVFBNMl9QVF9GSVhFRCArIDIsDQo+ID4gKwlUUE0yX1BUX0RBWV9PRl9ZRUFSID0gVFBN
Ml9QVF9GSVhFRCArIDMsDQo+ID4gKwlUUE0yX1BUX1lFQVIgPSBUUE0yX1BUX0ZJWEVEICsgNCwN
Cj4gPiArCVRQTTJfUFRfTUFOVUZBQ1RVUkVSID0gVFBNMl9QVF9GSVhFRCArIDUsDQo+ID4gKwlU
UE0yX1BUX1ZFTkRPUl9TVFJJTkdfMSA9IFRQTTJfUFRfRklYRUQgKyA2LA0KPiA+ICsJVFBNMl9Q
VF9WRU5ET1JfU1RSSU5HXzIgPSBUUE0yX1BUX0ZJWEVEICsgNywNCj4gPiArCVRQTTJfUFRfVkVO
RE9SX1NUUklOR18zID0gVFBNMl9QVF9GSVhFRCArIDgsDQo+ID4gKwlUUE0yX1BUX1ZFTkRPUl9T
VFJJTkdfNCA9IFRQTTJfUFRfRklYRUQgKyA5LA0KPiA+ICsJVFBNMl9QVF9WRU5ET1JfVFBNX1RZ
UEUgPSBUUE0yX1BUX0ZJWEVEICsgMTAsDQo+ID4gKwlUUE0yX1BUX0ZJUk1XQVJFX1ZFUlNJT05f
MSA9IFRQTTJfUFRfRklYRUQgKyAxMSwNCj4gPiArCVRQTTJfUFRfRklSTVdBUkVfVkVSU0lPTl8y
ID0gVFBNMl9QVF9GSVhFRCArIDEyLA0KPiA+ICsJVFBNMl9QVF9JTlBVVF9CVUZGRVIgPSBUUE0y
X1BUX0ZJWEVEICsgMTMsDQo+ID4gKwlUUE0yX1BUX0hSX1RSQU5TSUVOVF9NSU4gPSBUUE0yX1BU
X0ZJWEVEICsgMTQsDQo+ID4gKwlUUE0yX1BUX0hSX1BFUlNJU1RFTlRfTUlOID0gVFBNMl9QVF9G
SVhFRCArIDE1LA0KPiA+ICsJVFBNMl9QVF9IUl9MT0FERURfTUlOID0gVFBNMl9QVF9GSVhFRCAr
IDE2LA0KPiA+ICsJVFBNMl9QVF9BQ1RJVkVfU0VTU0lPTlNfTUFYID0gVFBNMl9QVF9GSVhFRCAr
IDE3LA0KPiA+ICsJVFBNMl9QVF9QQ1JfQ09VTlQgPSBUUE0yX1BUX0ZJWEVEICsgMTgsDQo+ID4g
KwlUUE0yX1BUX1BDUl9TRUxFQ1RfTUlOID0gVFBNMl9QVF9GSVhFRCArIDE5LA0KPiA+ICsJVFBN
Ml9QVF9DT05URVhUX0dBUF9NQVggPSBUUE0yX1BUX0ZJWEVEICsgMjAsDQo+ID4gKwlUUE0yX1BU
X05WX0NPVU5URVJTX01BWCA9IFRQTTJfUFRfRklYRUQgKyAyMiwNCj4gPiArCVRQTTJfUFRfTlZf
SU5ERVhfTUFYID0gVFBNMl9QVF9GSVhFRCArIDIzLA0KPiA+ICsJVFBNMl9QVF9NRU1PUlkgPSBU
UE0yX1BUX0ZJWEVEICsgMjQsDQo+ID4gKwlUUE0yX1BUX0NMT0NLX1VQREFURSA9IFRQTTJfUFRf
RklYRUQgKyAyNSwNCj4gPiArCVRQTTJfUFRfQ09OVEVYVF9IQVNIID0gVFBNMl9QVF9GSVhFRCAr
IDI2LA0KPiA+ICsJVFBNMl9QVF9DT05URVhUX1NZTSA9IFRQTTJfUFRfRklYRUQgKyAyNywNCj4g
PiArCVRQTTJfUFRfQ09OVEVYVF9TWU1fU0laRSA9IFRQTTJfUFRfRklYRUQgKyAyOCwNCj4gPiAr
CVRQTTJfUFRfT1JERVJMWV9DT1VOVCA9IFRQTTJfUFRfRklYRUQgKyAyOSwNCj4gPiArCVRQTTJf
UFRfTUFYX0NPTU1BTkRfU0laRSA9IFRQTTJfUFRfRklYRUQgKyAzMCwNCj4gPiArCVRQTTJfUFRf
TUFYX1JFU1BPTlNFX1NJWkUgPSBUUE0yX1BUX0ZJWEVEICsgMzEsDQo+ID4gKwlUUE0yX1BUX01B
WF9ESUdFU1QgPSBUUE0yX1BUX0ZJWEVEICsgMzIsDQo+ID4gKwlUUE0yX1BUX01BWF9PQkpFQ1Rf
Q09OVEVYVCA9IFRQTTJfUFRfRklYRUQgKyAzMywNCj4gPiArCVRQTTJfUFRfTUFYX1NFU1NJT05f
Q09OVEVYVCA9IFRQTTJfUFRfRklYRUQgKyAzNCwNCj4gPiArCVRQTTJfUFRfUFNfRkFNSUxZX0lO
RElDQVRPUiA9IFRQTTJfUFRfRklYRUQgKyAzNSwNCj4gPiArCVRQTTJfUFRfUFNfTEVWRUwgPSBU
UE0yX1BUX0ZJWEVEICsgMzYsDQo+ID4gKwlUUE0yX1BUX1BTX1JFVklTSU9OID0gVFBNMl9QVF9G
SVhFRCArIDM3LA0KPiA+ICsJVFBNMl9QVF9QU19EQVlfT0ZfWUVBUiA9IFRQTTJfUFRfRklYRUQg
KyAzOCwNCj4gPiArCVRQTTJfUFRfUFNfWUVBUiA9IFRQTTJfUFRfRklYRUQgKyAzOSwNCj4gPiAr
CVRQTTJfUFRfU1BMSVRfTUFYID0gVFBNMl9QVF9GSVhFRCArIDQwLA0KPiA+ICsJVFBNMl9QVF9U
T1RBTF9DT01NQU5EUyA9IFRQTTJfUFRfRklYRUQgKyA0MSwNCj4gPiArCVRQTTJfUFRfTElCUkFS
WV9DT01NQU5EUyA9IFRQTTJfUFRfRklYRUQgKyA0MiwNCj4gPiArCVRQTTJfUFRfVkVORE9SX0NP
TU1BTkRTID0gVFBNMl9QVF9GSVhFRCArIDQzLA0KPiA+ICsJVFBNMl9QVF9OVl9CVUZGRVJfTUFY
ID0gVFBNMl9QVF9GSVhFRCArIDQ0LA0KPiA+ICsJVFBNMl9QVF9NT0RFUyA9IFRQTTJfUFRfRklY
RUQgKyA0NSwNCj4gPiArCVRQTTJfUFRfTUFYX0NBUF9CVUZGRVIgPSBUUE0yX1BUX0ZJWEVEICsg
NDYsDQo+ID4gKwlUUE0yX1BUX1ZBUiA9IFRQTTJfUFRfR1JPVVAgKiAyLA0KPiA+ICsJVFBNMl9Q
VF9QRVJNQU5FTlQgPSBUUE0yX1BUX1ZBUiArIDAsDQo+ID4gKwlUUE0yX1BUX1NUQVJUVVBfQ0xF
QVIgPSBUUE0yX1BUX1ZBUiArIDEsDQo+ID4gKwlUUE0yX1BUX0hSX05WX0lOREVYID0gVFBNMl9Q
VF9WQVIgKyAyLA0KPiA+ICsJVFBNMl9QVF9IUl9MT0FERUQgPSBUUE0yX1BUX1ZBUiArIDMsDQo+
ID4gKwlUUE0yX1BUX0hSX0xPQURFRF9BVkFJTCA9IFRQTTJfUFRfVkFSICsgNCwNCj4gPiArCVRQ
TTJfUFRfSFJfQUNUSVZFID0gVFBNMl9QVF9WQVIgKyA1LA0KPiA+ICsJVFBNMl9QVF9IUl9BQ1RJ
VkVfQVZBSUwgPSBUUE0yX1BUX1ZBUiArIDYsDQo+ID4gKwlUUE0yX1BUX0hSX1RSQU5TSUVOVF9B
VkFJTCA9IFRQTTJfUFRfVkFSICsgNywNCj4gPiArCVRQTTJfUFRfSFJfUEVSU0lTVEVOVCA9IFRQ
TTJfUFRfVkFSICsgOCwNCj4gPiArCVRQTTJfUFRfSFJfUEVSU0lTVEVOVF9BVkFJTCA9IFRQTTJf
UFRfVkFSICsgOSwNCj4gPiArCVRQTTJfUFRfTlZfQ09VTlRFUlMgPSBUUE0yX1BUX1ZBUiArIDEw
LA0KPiA+ICsJVFBNMl9QVF9OVl9DT1VOVEVSU19BVkFJTCA9IFRQTTJfUFRfVkFSICsgMTEsDQo+
ID4gKwlUUE0yX1BUX0FMR09SSVRITV9TRVQgPSBUUE0yX1BUX1ZBUiArIDEyLA0KPiA+ICsJVFBN
Ml9QVF9MT0FERURfQ1VSVkVTID0gVFBNMl9QVF9WQVIgKyAxMywNCj4gPiArCVRQTTJfUFRfTE9D
S09VVF9DT1VOVEVSID0gVFBNMl9QVF9WQVIgKyAxNCwNCj4gPiArCVRQTTJfUFRfTUFYX0FVVEhf
RkFJTCA9IFRQTTJfUFRfVkFSICsgMTUsDQo+ID4gKwlUUE0yX1BUX0xPQ0tPVVRfSU5URVJWQUwg
PSBUUE0yX1BUX1ZBUiArIDE2LA0KPiA+ICsJVFBNMl9QVF9MT0NLT1VUX1JFQ09WRVJZID0gVFBN
Ml9QVF9WQVIgKyAxNywNCj4gPiArCVRQTTJfUFRfTlZfV1JJVEVfUkVDT1ZFUlkgPSBUUE0yX1BU
X1ZBUiArIDE4LA0KPiA+ICsJVFBNMl9QVF9BVURJVF9DT1VOVEVSXzAgPSBUUE0yX1BUX1ZBUiAr
IDE5LA0KPiA+ICsJVFBNMl9QVF9BVURJVF9DT1VOVEVSXzEgPSBUUE0yX1BUX1ZBUiArIDIwLA0K
PiA+ICt9Ow0KPiA+DQo+ID4gICAvKiAxMjggYnl0ZXMgaXMgYW4gYXJiaXRyYXJ5IGNhcC4gVGhp
cyBjb3VsZCBiZSBhcyBsYXJnZSBhcyBUUE1fQlVGU0laRSAtIDE4DQo+ID4gICAgKiBieXRlcywg
YnV0IDEyOCBpcyBzdGlsbCBhIHJlbGF0aXZlbHkgbGFyZ2UgbnVtYmVyIG9mIHJhbmRvbSBieXRl
cyBhbmQNCg==
